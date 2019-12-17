//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "UIFont+SRGAppearance.h"

#import "UIFontDescriptor+SRGAppearance.h"
#import "NSBundle+SRGAppearance.h"

#import <CoreText/CoreText.h>

SRGAppearanceFontTextStyle const SRGAppearanceFontTextStyleCaption = @"SRGAppearanceFontTextStyleCaption";
SRGAppearanceFontTextStyle const SRGAppearanceFontTextStyleSubtitle = @"SRGAppearanceFontTextStyleSubtitle";
SRGAppearanceFontTextStyle const SRGAppearanceFontTextStyleBody = @"SRGAppearanceFontTextStyleBody";
SRGAppearanceFontTextStyle const SRGAppearanceFontTextStyleHeadline = @"SRGAppearanceFontTextStyleHeadline";
SRGAppearanceFontTextStyle const SRGAppearanceFontTextStyleTitle = @"SRGAppearanceFontTextStyleTitle";

BOOL SRGAppearanceRegisterFont(NSString *filePath)
{
    NSData *fontFileData = [NSData dataWithContentsOfFile:filePath];
    if (! fontFileData) {
        return NO;
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontFileData);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    
    BOOL success = NO;
    if (font) {
        success = CTFontManagerRegisterGraphicsFont(font, NULL);
        CFRelease(font);
    }
    CFRelease(provider);
    return success;
}

NSComparisonResult SRGAppearanceCompareContentSizeCategories(NSString *contentSizeCategory1, NSString *contentSizeCategory2)
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
        SRGAppearanceRegisterFont(fontFilePath);
    }
}

@implementation UIFont (SRGAppearance)

+ (NSNumber *)pointSizeForCustomFontTextStyle:(NSString *)textStyle
{
#if TARGET_OS_TV
    static NSDictionary<NSString *, NSNumber *> *s_customTextStylesMap;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_customTextStylesMap = @{ SRGAppearanceFontTextStyleCaption : @20,
                                   SRGAppearanceFontTextStyleSubtitle : @29,
                                   SRGAppearanceFontTextStyleBody : @26,
                                   SRGAppearanceFontTextStyleHeadline : @31,
                                   SRGAppearanceFontTextStyleTitle : @48 };
    });
    
    // There are no content size category specialization on tvOS (the only one is `UIContentSizeCategoryLarge`).
    return s_customTextStylesMap[textStyle];
#else
    // We introduce custom SRG text styles for which we can choose the exact behavior we want
    static NSDictionary<NSString *, NSDictionary<NSString *, NSNumber *> *> *s_customTextStylesMap;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_customTextStylesMap = @{ SRGAppearanceFontTextStyleCaption : @{
                                           UIContentSizeCategoryExtraSmall : @11,
                                           UIContentSizeCategorySmall : @11,
                                           UIContentSizeCategoryMedium : @11,
                                           UIContentSizeCategoryLarge : @11,
                                           UIContentSizeCategoryExtraLarge : @13,
                                           UIContentSizeCategoryExtraExtraLarge : @15,
                                           UIContentSizeCategoryExtraExtraExtraLarge : @17,
                                           UIContentSizeCategoryAccessibilityMedium : @17,
                                           UIContentSizeCategoryAccessibilityLarge : @17,
                                           UIContentSizeCategoryAccessibilityExtraLarge : @17,
                                           UIContentSizeCategoryAccessibilityExtraExtraLarge : @17,
                                           UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @17 },
                                   SRGAppearanceFontTextStyleSubtitle : @{
                                           UIContentSizeCategoryExtraSmall : @12,
                                           UIContentSizeCategorySmall : @12,
                                           UIContentSizeCategoryMedium : @12,
                                           UIContentSizeCategoryLarge : @13,
                                           UIContentSizeCategoryExtraLarge : @15,
                                           UIContentSizeCategoryExtraExtraLarge : @17,
                                           UIContentSizeCategoryExtraExtraExtraLarge : @19,
                                           UIContentSizeCategoryAccessibilityMedium : @19,
                                           UIContentSizeCategoryAccessibilityLarge : @19,
                                           UIContentSizeCategoryAccessibilityExtraLarge : @19,
                                           UIContentSizeCategoryAccessibilityExtraExtraLarge : @19,
                                           UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @19 },
                                   SRGAppearanceFontTextStyleBody : @{
                                           UIContentSizeCategoryExtraSmall : @12,
                                           UIContentSizeCategorySmall : @13,
                                           UIContentSizeCategoryMedium : @14,
                                           UIContentSizeCategoryLarge : @15,
                                           UIContentSizeCategoryExtraLarge : @17,
                                           UIContentSizeCategoryExtraExtraLarge : @19,
                                           UIContentSizeCategoryExtraExtraExtraLarge : @21,
                                           UIContentSizeCategoryAccessibilityMedium : @21,
                                           UIContentSizeCategoryAccessibilityLarge : @21,
                                           UIContentSizeCategoryAccessibilityExtraLarge : @21,
                                           UIContentSizeCategoryAccessibilityExtraExtraLarge : @21,
                                           UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @21 },
                                   SRGAppearanceFontTextStyleHeadline : @{
                                           UIContentSizeCategoryExtraSmall : @14,
                                           UIContentSizeCategorySmall : @15,
                                           UIContentSizeCategoryMedium : @16,
                                           UIContentSizeCategoryLarge : @17,
                                           UIContentSizeCategoryExtraLarge : @19,
                                           UIContentSizeCategoryExtraExtraLarge : @21,
                                           UIContentSizeCategoryExtraExtraExtraLarge : @23,
                                           UIContentSizeCategoryAccessibilityMedium : @23,
                                           UIContentSizeCategoryAccessibilityLarge : @23,
                                           UIContentSizeCategoryAccessibilityExtraLarge : @23,
                                           UIContentSizeCategoryAccessibilityExtraExtraLarge : @23,
                                           UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @23 },
                                   SRGAppearanceFontTextStyleTitle : @{
                                           UIContentSizeCategoryExtraSmall : @17,
                                           UIContentSizeCategorySmall : @18,
                                           UIContentSizeCategoryMedium : @19,
                                           UIContentSizeCategoryLarge : @20,
                                           UIContentSizeCategoryExtraLarge : @22,
                                           UIContentSizeCategoryExtraExtraLarge : @24,
                                           UIContentSizeCategoryExtraExtraExtraLarge : @26,
                                           UIContentSizeCategoryAccessibilityMedium : @26,
                                           UIContentSizeCategoryAccessibilityLarge : @26,
                                           UIContentSizeCategoryAccessibilityExtraLarge : @26,
                                           UIContentSizeCategoryAccessibilityExtraExtraLarge : @26,
                                           UIContentSizeCategoryAccessibilityExtraExtraExtraLarge : @26 } };
    });
    
    // The default content size category of an iOS device is `UIContentSizeCategoryLarge`.
    UIContentSizeCategory contentSizeCategory = [UIApplication sharedApplication].preferredContentSizeCategory ?: UIContentSizeCategoryLarge;
    return s_customTextStylesMap[textStyle][contentSizeCategory];
#endif
}

+ (UIFont *)srg_fontWithName:(NSString *)name textStyle:(NSString *)textStyle
{
    NSNumber *pointSize = [self pointSizeForCustomFontTextStyle:textStyle];
    if (pointSize) {
        return [UIFont fontWithName:name size:pointSize.floatValue] ?: [UIFont fontWithName:@"Helvetica" size:pointSize.floatValue];
    }
    else {
        UIFontDescriptor *fontDescriptor = [UIFontDescriptor srg_preferredFontDescriptorWithName:name textStyle:textStyle];
        return [UIFont fontWithDescriptor:fontDescriptor size:0.f];
    }
}

+ (UIFont *)srg_fontWithName:(NSString *)name size:(CGFloat)size
{
    return [UIFont fontWithName:name size:size] ?: [UIFont fontWithName:@"Helvetica" size:size];
}

+ (UIFont *)srg_regularFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeTextApp-Regular" textStyle:textStyle];
}

+ (UIFont *)srg_boldFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeTextApp-Bold" textStyle:textStyle];
}

+ (UIFont *)srg_heavyFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeTextApp-Heavy" textStyle:textStyle];
}

+ (UIFont *)srg_lightFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeTextApp-Light" textStyle:textStyle];
}

+ (UIFont *)srg_mediumFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeTextApp-Medium" textStyle:textStyle];
}

+ (UIFont *)srg_italicFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeTextApp-Italic" textStyle:textStyle];
}

+ (UIFont *)srg_boldItalicFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeTextApp-BoldItalic" textStyle:textStyle];
}

+ (UIFont *)srg_regularSerifFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeSerifTextApp-Regular" textStyle:textStyle];
}

+ (UIFont *)srg_lightSerifFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeSerifTextApp-Light" textStyle:textStyle];
}

+ (UIFont *)srg_mediumSerifFontWithTextStyle:(NSString *)textStyle
{
    return [self srg_fontWithName:@"SRGSSRTypeSerifTextApp-Medium" textStyle:textStyle];
}

+ (UIFont *)srg_regularFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeTextApp-Regular" size:size];
}

+ (UIFont *)srg_boldFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeTextApp-Bold" size:size];
}

+ (UIFont *)srg_heavyFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeTextApp-Heavy" size:size];
}

+ (UIFont *)srg_lightFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeTextApp-Light" size:size];
}

+ (UIFont *)srg_mediumFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeTextApp-Medium" size:size];
}

+ (UIFont *)srg_italicFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeTextApp-Italic" size:size];
}

+ (UIFont *)srg_boldItalicFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeTextApp-BoldItalic" size:size];
}

+ (UIFont *)srg_regularSerifFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeSerifTextApp-Regular" size:size];
}

+ (UIFont *)srg_lightSerifFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeSerifTextApp-Light" size:size];
}

+ (UIFont *)srg_mediumSerifFontWithSize:(CGFloat)size
{
    return [UIFont srg_fontWithName:@"SRGSSRTypeSerifTextApp-Medium" size:size];
}

@end
