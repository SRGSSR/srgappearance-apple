//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "SRGFont.h"

#import "SRGVariationAxis.h"

@import CoreText;

const UIFontWeight SRGFontWeightLight = -1.f;
const UIFontWeight SRGFontWeightRegular = -2.f / 3.f;
const UIFontWeight SRGFontWeightMedium = -1.f / 3.f;
const UIFontWeight SRGFontWeightBold = 1.f / 3.f;
const UIFontWeight SRGFontWeightHeavy = 1.f;

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

static CGFloat SRGFontSizeForStyle(SRGFontStyle style)
{
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, NSNumber *> *s_sizes;
    dispatch_once(&s_onceToken, ^{
#if TARGET_OS_TV
        s_sizes = @{ @(SRGFontStyleH1) : @48,
                     @(SRGFontStyleH2) : @42,
                     @(SRGFontStyleH3) : @32,
                     @(SRGFontStyleH4) : @30,
                     @(SRGFontStyleSubtitle) : @32,
                     @(SRGFontStyleBody) : @30,
                     @(SRGFontStyleButton1) : @32,
                     @(SRGFontStyleButton2) : @26,
                     @(SRGFontStyleOverline) : @24,
                     @(SRGFontStyleLabel) : @20,
                     @(SRGFontStyleCaption) : @18 };
#else
        // TODO: Use official values, for the moment these are only guesses based on what we previously had
        s_sizes = @{ @(SRGFontStyleH1) : @22,
                     @(SRGFontStyleH2) : @20,
                     @(SRGFontStyleH3) : @18,
                     @(SRGFontStyleH4) : @17,
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
        s_weights = @{ @(SRGFontStyleH1) : @(SRGFontWeightBold),
                       @(SRGFontStyleH2) : @(SRGFontWeightMedium),
                       @(SRGFontStyleH3) : @(SRGFontWeightRegular),
                       @(SRGFontStyleH4) : @(SRGFontWeightMedium),
                       @(SRGFontStyleSubtitle) : @(SRGFontWeightLight),
                       @(SRGFontStyleBody) : @(SRGFontWeightRegular),
                       @(SRGFontStyleButton1) : @(SRGFontWeightMedium),
                       @(SRGFontStyleButton2) : @(SRGFontWeightRegular),
                       @(SRGFontStyleOverline) : @(SRGFontWeightRegular),
                       @(SRGFontStyleLabel) : @(SRGFontWeightBold),
                       @(SRGFontStyleCaption) : @(SRGFontWeightMedium) };
    });
    NSNumber *weight = s_weights[@(style)];
    NSCAssert(weight != nil, @"Weight is missing for some font style");
    return weight.floatValue;
}

static UIFontTextStyle SRGTextStyleForStyle(SRGFontStyle style)
{
    // TODO: Decide correct text styles to apply
    static dispatch_once_t s_onceToken;
    static NSDictionary<NSNumber *, UIFontTextStyle> *s_textStyles;
    dispatch_once(&s_onceToken, ^{
        s_textStyles = @{ @(SRGFontStyleH1) : UIFontTextStyleTitle1,
                          @(SRGFontStyleH2) : UIFontTextStyleTitle2,
                          @(SRGFontStyleH3) : UIFontTextStyleTitle3,
                          @(SRGFontStyleH4) : UIFontTextStyleTitle3,
                          @(SRGFontStyleSubtitle) : UIFontTextStyleBody,
                          @(SRGFontStyleBody) : UIFontTextStyleBody,
                          @(SRGFontStyleButton1) : UIFontTextStyleBody,
                          @(SRGFontStyleButton2) : UIFontTextStyleBody,
                          @(SRGFontStyleOverline) : UIFontTextStyleCallout,
                          @(SRGFontStyleLabel) : UIFontTextStyleCallout,
                          @(SRGFontStyleCaption) : UIFontTextStyleCaption1 };
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

+ (UIFont *)unscaledfontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight size:(CGFloat)size
{
    UIFontDescriptor *fontDescriptor = [self fontDescriptorForFontWithFamily:family weight:weight];
    return [UIFont fontWithDescriptor:fontDescriptor size:size];
}

+ (UIFont *)unscaledfontWithFamily:(SRGFontFamily)family style:(SRGFontStyle)style
{
    return [self unscaledfontWithFamily:family weight:SRGFontWeightForStyle(style) size:SRGFontSizeForStyle(style)];
}

+ (UIFont *)fontWithFamily:(SRGFontFamily)family style:(SRGFontStyle)style
{
    UIFont *font = [self unscaledfontWithFamily:family style:style];
    UIFontMetrics *fontMetrics = [UIFontMetrics metricsForTextStyle:SRGTextStyleForStyle(style)];
    return [fontMetrics scaledFontForFont:font];
}

+ (UIFont *)fontWithFamily:(SRGFontFamily)family style:(SRGFontStyle)style maximumSize:(CGFloat)maximumSize
{
    UIFont *font = [self unscaledfontWithFamily:family style:style];
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

+ (UIFont *)fontWithStyle:(SRGFontStyle)style
{
    return [self fontWithFamily:SRGFontFamilyText style:style];
}

+ (UIFont *)fontWithStyle:(SRGFontStyle)style maximumSize:(CGFloat)maximumSize
{
    return [self fontWithFamily:SRGFontFamilyText style:style maximumSize:maximumSize];
}

+ (UIFont *)fontWithWeight:(UIFontWeight)weight size:(CGFloat)size relativeToTextStyle:(UIFontTextStyle)textStyle
{
    return [self fontWithFamily:SRGFontFamilyText weight:weight size:size relativeToTextStyle:textStyle];
}

+ (UIFont *)fontWithWeight:(UIFontWeight)weight size:(CGFloat)size maximumSize:(CGFloat)maximumSize relativeToTextStyle:(UIFontTextStyle)textStyle
{
    return [self fontWithWeight:SRGFontFamilyText size:size maximumSize:maximumSize relativeToTextStyle:textStyle];
}

+ (UIFont *)fontWithWeight:(UIFontWeight)weight fixedSize:(CGFloat)fixedSize
{
    return [self fontWithFamily:SRGFontFamilyText weight:weight fixedSize:fixedSize];
}

+ (UIFontDescriptor *)fontDescriptorForFontWithFamily:(SRGFontFamily)family style:(SRGFontStyle)style
{
    return [self fontDescriptorForFontWithFamily:family weight:SRGFontWeightForStyle(style)];
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

+ (UIFontTextStyle)textStyleForScalingFontWithStyle:(SRGFontStyle)style
{
    return SRGTextStyleForStyle(style);
}

+ (CGFloat)sizeFontWithStyle:(SRGFontStyle)style
{
    return SRGFontSizeForStyle(style);
}

@end
