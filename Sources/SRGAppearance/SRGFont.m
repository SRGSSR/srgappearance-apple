//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "SRGFont.h"

#import "SRGVariationAxis.h"

@import CoreText;

// Variable font weight range: 300 to 900. The values below are calculated from the official absolute weights in
// this range.
const UIFontWeight SRGFontWeightLight = -1.f;               // 300 = 300 + (900 - 300) * (-1 + 1) / 2
const UIFontWeight SRGFontWeightRegular = -2.f / 3.f;       // 400 = 300 + (900 - 300) * (-2/3 + 1) / 2
const UIFontWeight SRGFontWeightMedium = -1.f / 3.f;        // 500 = 300 + (900 - 300) * (-1/3 + 1) / 2
const UIFontWeight SRGFontWeightBold = 1.f / 3.f;           // 700 = 300 + (900 - 300) * (1/3 + 1) / 2
const UIFontWeight SRGFontWeightHeavy = 1.f;                // 900 = 300 + (900 - 300) * (1 + 1) / 2

BOOL SRGAppearanceRegisterFont(NSString *filePath)
{
    NSData *fontFileData = [NSData dataWithContentsOfFile:filePath];
    if (! fontFileData) {
        return NO;
    }
    
    CGDataProviderRef providerRef = CGDataProviderCreateWithCFData((CFDataRef)fontFileData);
    CGFontRef fontRef = CGFontCreateWithDataProvider(providerRef);
    
    BOOL success = NO;
    if (fontRef) {
        success = CTFontManagerRegisterGraphicsFont(fontRef, NULL);
        CFRelease(fontRef);
    }
    CFRelease(providerRef);
    return success;
}

NSComparisonResult SRGAppearanceCompareContentSizeCategories(UIContentSizeCategory contentSizeCategory1, UIContentSizeCategory contentSizeCategory2)
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

static NSString *SRGFontNameForFamily(SRGFontFamily family)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, NSString *> *s_names;
    dispatch_once(&s_onceToken, ^{
        // Postscript names
        s_names = @{ @(SRGFontFamilyText) : @"SRGSSRTypeTextVFApp-Medium",
                     @(SRGFontFamilyDisplay) : @"SRGSSRTypeDisplayVFApp-Medium" };
    });
    NSString *fontName = s_names[@(family)];
    NSCAssert(fontName != nil, @"Font name is missing for some name");
    return fontName;
}

static SRGVariationAxis *SRGVariationAxisWithName(SRGFontFamily family, NSString *axisName)
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(SRGVariationAxis * _Nullable variationAxis, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [variationAxis.name isEqualToString:axisName];
    }];
    return [[SRGVariationAxis variationAxesForFontWithName:SRGFontNameForFamily(family)] filteredArrayUsingPredicate:predicate].firstObject;
}

static SRGFontFamily SRGFamilyForStyle(SRGFontStyle style)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, NSNumber *> *s_families;
    dispatch_once(&s_onceToken, ^{
        s_families = @{ @(SRGFontStyleH1) : @(SRGFontFamilyDisplay),
                        @(SRGFontStyleH2) : @(SRGFontFamilyDisplay),
                        @(SRGFontStyleH3) : @(SRGFontFamilyText),
                        @(SRGFontStyleH4) : @(SRGFontFamilyText),
                        @(SRGFontStyleSubtitle1) : @(SRGFontFamilyText),
                        @(SRGFontStyleSubtitle2) : @(SRGFontFamilyText),
                        @(SRGFontStyleBody) : @(SRGFontFamilyText),
                        @(SRGFontStyleButton) : @(SRGFontFamilyText),
                        @(SRGFontStyleCaption) : @(SRGFontFamilyText),
                        @(SRGFontStyleLabel) : @(SRGFontFamilyText) };
    });
    NSNumber *family = s_families[@(style)];
    NSCAssert(family != nil, @"Family is missing for some font style");
    return family.integerValue;
}

static CGFloat SRGSizeForStyle(SRGFontStyle style)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, NSNumber *> *s_sizes;
    dispatch_once(&s_onceToken, ^{
#if TARGET_OS_TV
        s_sizes = @{ @(SRGFontStyleH1) : @48,
                     @(SRGFontStyleH2) : @42,
                     @(SRGFontStyleH3) : @32,
                     @(SRGFontStyleH4) : @30,
                     @(SRGFontStyleSubtitle1) : @32,
                     @(SRGFontStyleSubtitle2) : @26,
                     @(SRGFontStyleBody) : @30,
                     @(SRGFontStyleButton) : @32,
                     @(SRGFontStyleCaption) : @18,
                     @(SRGFontStyleLabel) : @20 };
#else
        s_sizes = @{ @(SRGFontStyleH1) : @26,
                     @(SRGFontStyleH2) : @22,
                     @(SRGFontStyleH3) : @18,
                     @(SRGFontStyleH4) : @16,
                     @(SRGFontStyleSubtitle1) : @14,
                     @(SRGFontStyleSubtitle2) : @14,
                     @(SRGFontStyleBody) : @16,
                     @(SRGFontStyleButton) : @14,
                     @(SRGFontStyleCaption) : @12,
                     @(SRGFontStyleLabel) : @12 };
#endif
    });
    NSNumber *size = s_sizes[@(style)];
    NSCAssert(size != nil, @"Size is missing for some font style");
    return size.floatValue;
}

static UIFontWeight SRGWeightForStyle(SRGFontStyle style)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, NSNumber *> *s_weights;
    dispatch_once(&s_onceToken, ^{
#if TARGET_OS_TV
        s_weights = @{ @(SRGFontStyleH1) : @(SRGFontWeightBold),
                       @(SRGFontStyleH2) : @(SRGFontWeightMedium),
                       @(SRGFontStyleH3) : @(SRGFontWeightRegular),
                       @(SRGFontStyleH4) : @(SRGFontWeightMedium),
                       @(SRGFontStyleSubtitle1) : @(SRGFontWeightLight),
                       @(SRGFontStyleSubtitle2) : @(SRGFontWeightRegular),
                       @(SRGFontStyleBody) : @(SRGFontWeightRegular),
                       @(SRGFontStyleButton) : @(SRGFontWeightMedium),
                       @(SRGFontStyleCaption) : @(SRGFontWeightMedium),
                       @(SRGFontStyleLabel) : @(SRGFontWeightBold) };
#else
        s_weights = @{ @(SRGFontStyleH1) : @(SRGFontWeightBold),
                       @(SRGFontStyleH2) : @(SRGFontWeightBold),
                       @(SRGFontStyleH3) : @(SRGFontWeightBold),
                       @(SRGFontStyleH4) : @(SRGFontWeightMedium),
                       @(SRGFontStyleSubtitle1) : @(SRGFontWeightLight),
                       @(SRGFontStyleSubtitle2) : @(SRGFontWeightMedium),
                       @(SRGFontStyleBody) : @(SRGFontWeightRegular),
                       @(SRGFontStyleButton) : @(SRGFontWeightRegular),
                       @(SRGFontStyleCaption) : @(SRGFontWeightRegular),
                       @(SRGFontStyleLabel) : @(SRGFontWeightBold) };
#endif
    });
    NSNumber *weight = s_weights[@(style)];
    NSCAssert(weight != nil, @"Weight is missing for some font style");
    return weight.floatValue;
}

static UIFontTextStyle SRGTextStyleForStyle(SRGFontStyle style)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, UIFontTextStyle> *s_textStyles;
    dispatch_once(&s_onceToken, ^{
        s_textStyles = @{ @(SRGFontStyleH1) : UIFontTextStyleTitle1,
                          @(SRGFontStyleH2) : UIFontTextStyleTitle2,
                          @(SRGFontStyleH3) : UIFontTextStyleTitle3,
                          @(SRGFontStyleH4) : UIFontTextStyleHeadline,
                          @(SRGFontStyleSubtitle1) : UIFontTextStyleSubheadline,
                          @(SRGFontStyleSubtitle2) : UIFontTextStyleSubheadline,
                          @(SRGFontStyleBody) : UIFontTextStyleBody,
                          @(SRGFontStyleButton) : UIFontTextStyleBody,
                          @(SRGFontStyleCaption) : UIFontTextStyleCaption1,
                          @(SRGFontStyleLabel) : UIFontTextStyleCaption2 };
    });
    UIFontTextStyle textStyle = s_textStyles[@(style)];
    NSCAssert(textStyle != nil, @"Text style is missing for some font style");
    return textStyle;
}

__attribute__((constructor)) static void SRGAppearanceRegisterFonts(void)
{
    NSArray<NSString *> *fontFilePaths = [SWIFTPM_MODULE_BUNDLE pathsForResourcesOfType:@"ttf" inDirectory:nil];
    for (NSString *fontFilePath in fontFilePaths) {
        SRGAppearanceRegisterFont(fontFilePath);
    }
}

@implementation SRGFont

#pragma mark Helpers

+ (UIFont *)unscaledfontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight size:(CGFloat)size
{
    UIFontDescriptor *fontDescriptor = [self fontDescriptorForFontWithFamily:family weight:weight];
    return [UIFont fontWithDescriptor:fontDescriptor size:size];
}

+ (UIFont *)unscaledfontWithStyle:(SRGFontStyle)style
{
    return [self unscaledfontWithFamily:SRGFamilyForStyle(style) weight:SRGWeightForStyle(style) size:SRGSizeForStyle(style)];
}

#pragma mark Public API

+ (UIFont *)fontWithStyle:(SRGFontStyle)style
{
    UIFont *font = [self unscaledfontWithStyle:style];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:SRGTextStyleForStyle(style)];
    return [fontMetrics scaledFontForFont:font];
}

+ (UIFont *)fontWithStyle:(SRGFontStyle)style maximumSize:(CGFloat)maximumSize
{
    UIFont *font = [self unscaledfontWithStyle:style];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:SRGTextStyleForStyle(style)];
    return [fontMetrics scaledFontForFont:font maximumPointSize:maximumSize];
}

+ (UIFont *)fontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight size:(CGFloat)size relativeToTextStyle:(UIFontTextStyle)textStyle
{
    UIFont *font = [self unscaledfontWithFamily:family weight:weight size:size];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
    return [fontMetrics scaledFontForFont:font];
}

+ (UIFont *)fontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight size:(CGFloat)size maximumSize:(CGFloat)maximumSize relativeToTextStyle:(UIFontTextStyle)textStyle
{
    UIFont *font = [self unscaledfontWithFamily:family weight:weight size:size];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
    return [fontMetrics scaledFontForFont:font maximumPointSize:maximumSize];
}

+ (UIFont *)fontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight fixedSize:(CGFloat)fixedSize
{
    return [self unscaledfontWithFamily:family weight:weight size:fixedSize];
}

#pragma mark Font descriptors

+ (UIFontDescriptor *)fontDescriptorForFontWithStyle:(SRGFontStyle)style
{
    return [self fontDescriptorForFontWithFamily:SRGFamilyForStyle(style) weight:SRGWeightForStyle(style)];
}

+ (UIFontDescriptor *)fontDescriptorForFontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight
{
    NSMutableDictionary<UIFontDescriptorAttributeName, id> *variationAttributes = [NSMutableDictionary dictionary];
    
    SRGVariationAxis *variationAxis = SRGVariationAxisWithName(family, @"Weight");
    if (variationAxis) {
        // UIFont weight is a value between -1 and 1, which must be translated to the axis supported range
        CGFloat absoluteWeight = variationAxis.minimumValue + (variationAxis.maximumValue - variationAxis.minimumValue) * (weight + 1.f) / 2.f;
        variationAttributes[variationAxis.attribute] = @(absoluteWeight);
    }
    
    return [UIFontDescriptor fontDescriptorWithFontAttributes:@{ UIFontDescriptorNameAttribute : SRGFontNameForFamily(family),
                                                                 (UIFontDescriptorAttributeName)kCTFontVariationAttribute : variationAttributes.copy }];
}

+ (UIFontMetrics *)metricsForFontWithStyle:(SRGFontStyle)style
{
    return [UIFontMetrics metricsForTextStyle:SRGTextStyleForStyle(style)];
}

#pragma mark Properties

+ (SRGFontFamily)familyForFontStyle:(SRGFontStyle)style
{
    return SRGFamilyForStyle(style);
}

+ (UIFontWeight)weightForFontStyle:(SRGFontStyle)style
{
    return SRGWeightForStyle(style);
}

+ (CGFloat)sizeForFontStyle:(SRGFontStyle)style
{
    return SRGSizeForStyle(style);
}

+ (UIFontTextStyle)textStyleForFontStyle:(SRGFontStyle)style
{
    return SRGTextStyleForStyle(style);
}

@end
