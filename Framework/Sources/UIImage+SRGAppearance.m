//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "UIImage+SRGAppearance.h"

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

static void SRGAppearanceImageDrawPDFPageInRect(CGPDFPageRef pageRef, CGRect rect)
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

// Implementation borrowed from https://github.com/erica/useful-things
+ (UIImage *)srg_vectorImageNamed:(NSString *)imageName inBundle:(nullable NSBundle *)bundle withSize:(CGSize)size
{
    NSURL *fileURL = [self srg_fileURLForVectorImageNamed:imageName inBundle:bundle withSize:size];
    if (! fileURL) {
        return nil;
    }
    
    return [UIImage imageWithContentsOfFile:fileURL.path];
}

+ (NSURL *)srg_fileURLForVectorImageNamed:(NSString *)imageName inBundle:(NSBundle *)bundle withSize:(CGSize)size
{
    if (! bundle) {
        bundle = [NSBundle mainBundle];
    }
    
    // Check cached image existence at the very beginning, and return it if available
    NSString *fileName = [NSString stringWithFormat:@"%@_%@_%@_%@.pdf", imageName, @(size.width), @(size.height), bundle.bundleIdentifier];
    NSString *cachesDirectory = SRGAppearanceVectorImageCachesDirectory();
    NSString *filePath = [cachesDirectory stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSURL fileURLWithPath:filePath];
    }
    
    // Check cache directory existence, since the cache might be cleared anytime
    if (! [[NSFileManager defaultManager] fileExistsAtPath:cachesDirectory]) {
        if (! [[NSFileManager defaultManager] createDirectoryAtPath:cachesDirectory withIntermediateDirectories:YES attributes:nil error:NULL]) {
            return nil;
        }
    }
    
    NSURL *fileURL = [bundle URLForResource:imageName withExtension:@"pdf"];
    CGPDFDocumentRef pdfDocumentRef = CGPDFDocumentCreateWithURL((__bridge CFURLRef)fileURL);
    if (! pdfDocumentRef) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(pdfDocumentRef, 1);
    SRGAppearanceImageDrawPDFPageInRect(pageRef, CGRectMake(0.f, 0.f, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGPDFDocumentRelease(pdfDocumentRef);
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (! imageData) {
        return nil;
    }
    
    if (! [[NSFileManager defaultManager] createFileAtPath:filePath contents:imageData attributes:nil]) {
        return nil;
    }
    
    return [NSURL fileURLWithPath:filePath];
}

+ (void)srg_clearVectorImageCache
{
    NSString *cachesDirectory = SRGAppearanceVectorImageCachesDirectory();
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesDirectory]) {
        [[NSFileManager defaultManager] removeItemAtPath:cachesDirectory error:nil];
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
