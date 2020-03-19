//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "UIImage+SRGAppearance.h"

#import "UIColor+SRGAppearance.h"

// Implementation borrowed from https://github.com/erica/useful-things

static CGFloat SRGAppearanceImageAspectScaleFit(CGSize sourceSize, CGRect destRect)
{
    CGSize destSize = destRect.size;
    CGFloat scaleW = destSize.width / sourceSize.width;
    CGFloat scaleH = destSize.height / sourceSize.height;
    return fmin(scaleW, scaleH);
}

static CGRect SRGAppearanceImageRectAroundCenter(CGPoint center, CGSize size)
{
    return CGRectMake(center.x - size.width / 2.f, center.y - size.height / 2.f, size.width, size.height);
}

static CGRect SRGAppearanceImageRectByFittingRect(CGRect sourceRect, CGRect destinationRect)
{
    CGFloat aspect = SRGAppearanceImageAspectScaleFit(sourceRect.size, destinationRect);
    CGSize targetSize = CGSizeMake(sourceRect.size.width * aspect, sourceRect.size.height * aspect);
    CGPoint center = CGPointMake(CGRectGetMidX(destinationRect), CGRectGetMidY(destinationRect));
    return SRGAppearanceImageRectAroundCenter(center, targetSize);
}

static void SRGAppearanceImageDrawPDFPageInRect(CGPDFPageRef pageRef, CGRect rect, CGColorRef fillColor)
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Flip the context to Quartz space
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    transform = CGAffineTransformTranslate(transform, 0.f, -image.size.height);
    CGContextConcatCTM(context, transform);
    
    // Flip the rect, which remains in UIKit space
    CGRect d = CGRectApplyAffineTransform(rect, transform);
    
    if (fillColor) {
        CGContextSetFillColorWithColor(context, fillColor);
        CGContextFillRect(context, d);
    }
    
    // Calculate a rectangle to draw to
    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);
    CGFloat drawingAspect = SRGAppearanceImageAspectScaleFit(pageRect.size, d);
    CGRect drawingRect = SRGAppearanceImageRectByFittingRect(pageRect, d);
    
    // Adjust the context
    CGContextTranslateCTM(context, drawingRect.origin.x, drawingRect.origin.y);
    CGContextScaleCTM(context, drawingAspect, drawingAspect);
    
    // Draw the page
    CGContextDrawPDFPage(context, pageRef);
    CGContextRestoreGState(context);
}

static NSString *SRGAppearanceVectorImageCachesDirectory(void)
{
    static dispatch_once_t s_onceToken;
    static NSString *s_imageCachesDirectory;
    dispatch_once(&s_onceToken, ^{
        NSString *cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        s_imageCachesDirectory = [cachesDirectory stringByAppendingPathComponent:@"SRGAppearance/VectorImages"];
    });
    return s_imageCachesDirectory;
}

@implementation UIImage (SRGAppearance)

+ (UIImage *)srg_vectorImageAtPath:(NSString *)filePath withSize:(CGSize)size fillColor:(UIColor *)fillColor
{
    NSURL *fileURL = [self srg_URLForVectorImageAtPath:filePath withSize:size fillColor:fillColor];
    return fileURL ? [UIImage imageWithContentsOfFile:fileURL.path] : nil;
}

+ (UIImage *)srg_vectorImageAtPath:(NSString *)filePath withSize:(CGSize)size
{
    return [self srg_vectorImageAtPath:filePath withSize:size fillColor:nil];
}

+ (NSURL *)srg_URLForVectorImageAtPath:(NSString *)filePath withSize:(CGSize)size fillColor:(UIColor *)fillColor
{
    // Check cached image existence at the very beginning, and return it if available
    NSString *cachedFileName = [NSString stringWithFormat:@"%@_%@_%@_%@.png", @(filePath.hash), @(size.width), @(size.height), fillColor.srg_hexadecimalString ?: @"none"];
    NSString *cachesDirectory = SRGAppearanceVectorImageCachesDirectory();
    NSString *cachedFilePath = [cachesDirectory stringByAppendingPathComponent:cachedFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachedFilePath]) {
        return [NSURL fileURLWithPath:cachedFilePath];
    }
    
    // Check cache directory existence, since the cache might be cleared anytime
    if (! [[NSFileManager defaultManager] fileExistsAtPath:cachesDirectory]) {
        if (! [[NSFileManager defaultManager] createDirectoryAtPath:cachesDirectory withIntermediateDirectories:YES attributes:nil error:NULL]) {
            return nil;
        }
    }
    
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    CGPDFDocumentRef pdfDocumentRef = CGPDFDocumentCreateWithURL((__bridge CFURLRef)fileURL);
    if (! pdfDocumentRef) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 1. /* Force scale to 1 (0 would use device scale) */);
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(pdfDocumentRef, 1);
    SRGAppearanceImageDrawPDFPageInRect(pageRef, CGRectMake(0.f, 0.f, size.width, size.height), fillColor.CGColor);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGPDFDocumentRelease(pdfDocumentRef);
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (! imageData) {
        return nil;
    }
    
    if (! [[NSFileManager defaultManager] createFileAtPath:cachedFilePath contents:imageData attributes:nil]) {
        return nil;
    }
    
    return [NSURL fileURLWithPath:cachedFilePath];
}

+ (NSURL *)srg_URLForVectorImageAtPath:(NSString *)filePath withSize:(CGSize)size
{
    return [self srg_URLForVectorImageAtPath:filePath withSize:size fillColor:nil];
}

+ (void)srg_clearVectorImageCache
{
    NSString *cachesDirectory = SRGAppearanceVectorImageCachesDirectory();
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesDirectory]) {
        [[NSFileManager defaultManager] removeItemAtPath:cachesDirectory error:NULL];
    }
}

- (UIImage *)srg_imageTintedWithColor:(UIColor *)color
{
    if (! color) {
        return self;
    }
    
    CGRect rect = CGRectMake(0.f, 0.f, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.f, self.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGContextDrawImage(context, rect, self.CGImage);
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
