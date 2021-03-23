//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "SRGFont.h"

@import CoreText;

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
    
    static NSArray<UIContentSizeCategory> *s_contentSizeCategories;
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

static NSString *SRGFontNameForName(SRGFontName name)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, NSString *> *s_names;
    dispatch_once(&s_onceToken, ^{
        s_names = @{ @(SRGFontNameText) : @"SRG SSR Type Text VF App",
                     @(SRGFontNameDisplay) : @"SRG SSR Type Display VF App" };
    });
    NSString *fontName = s_names[@(name)];
    NSCAssert(fontName != nil, @"Font name is missing for some name");
    return fontName;
}

static CGFloat SRGFontSizeForStyle(SRGFontStyle style)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, NSNumber *> *s_sizes;
    dispatch_once(&s_onceToken, ^{
#if TARGET_OS_TV
        s_sizes = @{ @(SRGFontStyleTitle1) : @48,
                     @(SRGFontStyleTitle2) : @42,
                     @(SRGFontStyleHeadline1) : @32,
                     @(SRGFontStyleHeadline2) : @30,
                     @(SRGFontStyleSubtitle) : @32,
                     @(SRGFontStyleBody) : @30,
                     @(SRGFontStyleButton1) : @32,
                     @(SRGFontStyleButton2) : @26,
                     @(SRGFontStyleOverline) : @24,
                     @(SRGFontStyleLabel) : @20,
                     @(SRGFontStyleCaption) : @18 };
#else
        // TODO: Use official values, for the moment these are only guesses based on what we previously had
        s_sizes = @{ @(SRGFontStyleTitle1) : @22,
                     @(SRGFontStyleTitle2) : @20,
                     @(SRGFontStyleHeadline1) : @18,
                     @(SRGFontStyleHeadline2) : @17,
                     @(SRGFontStyleSubtitle) : @13,
                     @(SRGFontStyleBody) : @15,
                     @(SRGFontStyleButton1) : @13,
                     @(SRGFontStyleButton2) : @11,
                     @(SRGFontStyleOverline) : @11,
                     @(SRGFontStyleLabel) : @11,
                     @(SRGFontStyleCaption) : @11 };
#endif
    });
    NSNumber *size = s_sizes[@(style)];
    NSCAssert(size != nil, @"Size is missing for some font style");
    return size.floatValue;
}

static UIFontWeight SRGFontWeightForStyle(SRGFontStyle style)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, NSNumber *> *s_weights;
    dispatch_once(&s_onceToken, ^{
        s_weights = @{ @(SRGFontStyleTitle1) : @(UIFontWeightBold),
                       @(SRGFontStyleTitle2) : @(UIFontWeightMedium),
                       @(SRGFontStyleHeadline1) : @(UIFontWeightRegular),
                       @(SRGFontStyleHeadline2) : @(UIFontWeightMedium),
                       @(SRGFontStyleSubtitle) : @(UIFontWeightLight),
                       @(SRGFontStyleBody) : @(UIFontWeightRegular),
                       @(SRGFontStyleButton1) : @(UIFontWeightMedium),
                       @(SRGFontStyleButton2) : @(UIFontWeightRegular),
                       @(SRGFontStyleOverline) : @(UIFontWeightRegular),
                       @(SRGFontStyleLabel) : @(UIFontWeightBold),
                       @(SRGFontStyleCaption) : @(UIFontWeightMedium) };
    });
    NSNumber *weight = s_weights[@(style)];
    NSCAssert(weight != nil, @"Weight is missing for some font style");
    return weight.floatValue;
}

__attribute__((constructor)) static void SRGAppearanceRegisterFonts(void)
{
    NSArray<NSString *> *fontFilePaths = [SWIFTPM_MODULE_BUNDLE pathsForResourcesOfType:@"ttf" inDirectory:nil];
    for (NSString *fontFilePath in fontFilePaths) {
        SRGAppearanceRegisterFont(fontFilePath);
    }
}

@implementation SRGFont

+ (UIFont *)unscaledFontWithName:(SRGFontName)name style:(SRGFontStyle)style
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:@{ UIFontDescriptorNameAttribute : SRGFontNameForName(name),
                                                                                             UIFontWeightTrait : @(SRGFontWeightForStyle(style)) }];
    return [UIFont fontWithDescriptor:fontDescriptor size:SRGFontSizeForStyle(style)];
}

+ (UIFont *)unscaledFontWithName:(SRGFontName)name weight:(UIFontWeight)weight size:(CGFloat)size
{
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:@{ UIFontDescriptorNameAttribute : SRGFontNameForName(name),
                                                                                             UIFontWeightTrait : @(weight) }];
    return [UIFont fontWithDescriptor:fontDescriptor size:size];
}

+ (UIFont *)fontWithName:(SRGFontName)name style:(SRGFontStyle)style textStyle:(UIFontTextStyle)textStyle
{
    UIFont *font = [self unscaledFontWithName:name style:style];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
    return [fontMetrics scaledFontForFont:font];
}

+ (UIFont *)fontWithName:(SRGFontName)name style:(SRGFontStyle)style textStyle:(UIFontTextStyle)textStyle maximumPointSize:(CGFloat)maximumPointSize
{
    UIFont *font = [self unscaledFontWithName:name style:style];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
    return [fontMetrics scaledFontForFont:font maximumPointSize:maximumPointSize];
}

+ (UIFont *)fontWithName:(SRGFontName)name weight:(UIFontWeight)weight size:(CGFloat)size textStyle:(UIFontTextStyle)textStyle
{
    UIFont *font = [self unscaledFontWithName:name weight:weight size:size];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
    return [fontMetrics scaledFontForFont:font];
}

+ (UIFont *)fontWithName:(SRGFontName)name weight:(UIFontWeight)weight size:(CGFloat)size textStyle:(UIFontTextStyle)textStyle maximumPointSize:(CGFloat)maximumPointSize
{
    UIFont *font = [self unscaledFontWithName:name weight:weight size:size];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
    return [fontMetrics scaledFontForFont:font maximumPointSize:maximumPointSize];
}

+ (UIFont *)fontWithName:(SRGFontName)name weight:(UIFontWeight)weight fixedSize:(CGFloat)fixedSize
{
    return [self unscaledFontWithName:name weight:weight size:fixedSize];
}

+ (UIFontDescriptor *)fontDescriptorForFontWithName:(SRGFontName)name textStyle:(UIFontTextStyle)textStyle
{
    return [UIFontDescriptor fontDescriptorWithFontAttributes:@{ UIFontDescriptorNameAttribute : SRGFontNameForName(name),
                                                                 UIFontDescriptorTextStyleAttribute : textStyle }];
}

@end
