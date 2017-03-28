//
//  Copyright (c) SRG. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "UIFont+SRGAppearance.h"

#import "UIFontDescriptor+SRGAppearance.h"
#import "NSBundle+SRGAppearance.h"

#import <CoreText/CoreText.h>

BOOL SRGRegisterFont(NSString *filePath)
{
    NSData *fontFileData = [NSData dataWithContentsOfFile:filePath];
    if (! fontFileData) {
        return NO;
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontFileData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    BOOL success = CTFontManagerRegisterGraphicsFont(font, NULL);
    CFRelease(font);
    CFRelease(provider);
    return success;
}

NSComparisonResult SRGCompareContentSizeCategories(NSString *contentSizeCategory1, NSString *contentSizeCategory2)
{
    if ([contentSizeCategory1 isEqualToString:contentSizeCategory2]) {
        return NSOrderedSame;
    }
    
    static NSArray *s_contentSizeCategories;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_contentSizeCategories = @[ UIContentSizeCategoryExtraSmall,
                                     UIContentSizeCategorySmall,
                                     UIContentSizeCategoryMedium,
                                     UIContentSizeCategoryLarge,
                                     UIContentSizeCategoryExtraLarge,
                                     UIContentSizeCategoryExtraExtraLarge,
                                     UIContentSizeCategoryExtraExtraExtraLarge,
                                     UIContentSizeCategoryAccessibilityMedium,
                                     UIContentSizeCategoryAccessibilityLarge,
                                     UIContentSizeCategoryAccessibilityExtraLarge,
                                     UIContentSizeCategoryAccessibilityExtraExtraLarge,
                                     UIContentSizeCategoryAccessibilityExtraExtraExtraLarge ];
    });
    
    NSUInteger index1 = [s_contentSizeCategories indexOfObject:contentSizeCategory1];
    NSCAssert(index1 != NSNotFound, @"Invalid content size");
    
    NSUInteger index2 = [s_contentSizeCategories indexOfObject:contentSizeCategory2];
    NSCAssert(index2 != NSNotFound, @"Invalid content size");
    
    if (index1 < index2) {
        return NSOrderedAscending;
    }
    else {
        return NSOrderedDescending;
    }
}

__attribute__((constructor)) static void SRGAppearanceRegisterFonts(void)
{
    NSString *fontsDirectory = [[NSBundle srg_appearanceBundle] pathForResource:@"Fonts" ofType:nil];
    NSArray<NSString *> *fontFileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:fontsDirectory error:NULL];
    for (NSString *fontFileName in fontFileNames) {
        NSString *fontFilePath = [fontsDirectory stringByAppendingPathComponent:fontFileName];
        SRGRegisterFont(fontFilePath);
    }
}

@implementation UIFont (SRGAppearance)

+ (UIFont *)srg_regularFontWithTextStyle:(NSString *)textStyle
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:@"SRGSSRType-Regular" textStyle:textStyle];
    return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
}

+ (UIFont *)srg_boldFontWithTextStyle:(NSString *)textStyle
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:@"SRGSSRType-Bold" textStyle:textStyle];
    return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
}

+ (UIFont *)srg_heavyFontWithTextStyle:(NSString *)textStyle
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:@"SRGSSRType-Heavy" textStyle:textStyle];
    return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
}

+ (UIFont *)srg_lightFontWithTextStyle:(NSString *)textStyle
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:@"SRGSSRType-Light" textStyle:textStyle];
    return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
}

+ (UIFont *)srg_mediumFontWithTextStyle:(NSString *)textStyle
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:@"SRGSSRType-Medium" textStyle:textStyle];
    return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
}

+ (UIFont *)srg_italicFontWithTextStyle:(NSString *)textStyle
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:@"SRGSSRType-Italic" textStyle:textStyle];
    return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
}

+ (UIFont *)srg_boldItalicFontWithTextStyle:(NSString *)textStyle
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:@"SRGSSRType-BoldItalic" textStyle:textStyle];
    return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
}

+ (UIFont *)srg_regularSerifFontWithTextStyle:(NSString *)textStyle
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:@"SRGSSRTypeSerif-Regular" textStyle:textStyle];
    return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
}

+ (UIFont *)srg_regularFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SRGSSRType-Regular" size:size];
}

+ (UIFont *)srg_boldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SRGSSRType-Bold" size:size];
}

+ (UIFont *)srg_heavyFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SRGSSRType-Heavy" size:size];
}

+ (UIFont *)srg_lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SRGSSRType-Light" size:size];
}

+ (UIFont *)srg_mediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SRGSSRType-Medium" size:size];
}

+ (UIFont *)srg_italicFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SRGSSRType-Italic" size:size];
}

+ (UIFont *)srg_boldItalicFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SRGSSRType-BoldItalic" size:size];
}

+ (UIFont *)srg_regularSerifFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SRGSSRTypeSerif-Regular" size:size];
}

@end
