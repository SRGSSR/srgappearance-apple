//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Available SRG font families.
 */
typedef NS_CLOSED_ENUM(NSInteger, SRGFontFamily) {
    /**
     *  Font optimized for text readability. Recommended for most cases.
     */
    SRGFontFamilyText = 1,
    /**
     *  Font emphasizing branding on some capital letters. Should be avoided for text blocks.
     */
    SRGFontFamilyDisplay
} NS_SWIFT_NAME(SRGFont.Family);

/**
 *  Standard semantic styles which define both a size and a weight (and a text style if the font needs to be scaled).
 */
typedef NS_CLOSED_ENUM(NSInteger, SRGFontStyle) {
    SRGFontStyleTitle1 = 1,
    SRGFontStyleTitle2,
    SRGFontStyleHeadline1,
    SRGFontStyleHeadline2,
    SRGFontStyleSubtitle,
    SRGFontStyleBody,
    SRGFontStyleButton1,
    SRGFontStyleButton2,
    SRGFontStyleOverline,
    SRGFontStyleLabel,
    SRGFontStyleCaption
} NS_SWIFT_NAME(SRGFont.Style);

/**
 *  Standard SRG SSR font weights.
 */
OBJC_EXPORT const UIFontWeight SRGFontWeightLight NS_SWIFT_NAME(srg_light);
OBJC_EXPORT const UIFontWeight SRGFontWeightRegular NS_SWIFT_NAME(srg_regular);
OBJC_EXPORT const UIFontWeight SRGFontWeightMedium NS_SWIFT_NAME(srg_medium);
OBJC_EXPORT const UIFontWeight SRGFontWeightBold NS_SWIFT_NAME(srg_bold);
OBJC_EXPORT const UIFontWeight SRGFontWeightHeavy NS_SWIFT_NAME(srg_heavy);

/**
 *  Register a font from the specified file. Returns `YES` iff successful.
 *
 *  @discussion The method returns `NO` if the font has already been registered.
 */
OBJC_EXPORT BOOL SRGAppearanceRegisterFont(NSString *filePath);

/**
 *  Compare font size categories (@see `UIContentSizeCategory.h`).
 *
 *  @dicussion In debug builds, this method throws if the content size category is not an official one.
 */
OBJC_EXPORT NSComparisonResult SRGAppearanceCompareContentSizeCategories(UIContentSizeCategory contentSizeCategory1, UIContentSizeCategory contentSizeCategory2);

/**
 *  Official SRG SSR font.
 */
@interface SRGFont: NSObject

/**
 *  Font with a given family and predefined style. The font scales according to an internally associated matching text style
 *  and the current accessibility settings. A maximum size can optionally be provided.
 */
+ (UIFont *)fontWithFamily:(SRGFontFamily)family style:(SRGFontStyle)style NS_REFINED_FOR_SWIFT;
+ (UIFont *)fontWithFamily:(SRGFontFamily)family style:(SRGFontStyle)style maximumSize:(CGFloat)maximumSize NS_REFINED_FOR_SWIFT;

/**
 *  Font with a given family, weight and size. The font scales relative to the provided text style and the current
 *  accessibility settings, starting from the specified size. A maximum size can optionally be provided.
 *
 *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategoryLarge` default accessibility setting.
 */
+ (UIFont *)fontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight size:(CGFloat)size relativeToTextStyle:(UIFontTextStyle)textStyle NS_REFINED_FOR_SWIFT;
+ (UIFont *)fontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight size:(CGFloat)size maximumSize:(CGFloat)maximumSize relativeToTextStyle:(UIFontTextStyle)textStyle NS_REFINED_FOR_SWIFT;

/**
 *  Font with a given family, weight and fixed size. Does not scale with accessibility settings.
 */
+ (UIFont *)fontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight fixedSize:(CGFloat)fixedSize NS_REFINED_FOR_SWIFT;

@end

/**
 *  Convenience methods for the recommended font family (text).
 */
@interface SRGFont (Default)

/**
 *  Font with the text family and a predefined style. The font scales according to an internally associated matching text style
 *  and the current accessibility settings. A maximum size can optionally be provided.
 */
+ (UIFont *)fontWithStyle:(SRGFontStyle)style NS_REFINED_FOR_SWIFT;
+ (UIFont *)fontWithStyle:(SRGFontStyle)style maximumSize:(CGFloat)maximumSize NS_REFINED_FOR_SWIFT;

/**
 *  Font with the text family, a weight and a size. The font scales relative to the provided text style and the current
 *  accessibility settings, starting from the specified size. A maximum size can optionally be provided.
 *
 *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategoryLarge` default accessibility setting.
 */
+ (UIFont *)fontWithWeight:(UIFontWeight)weight size:(CGFloat)size relativeToTextStyle:(UIFontTextStyle)textStyle NS_REFINED_FOR_SWIFT;
+ (UIFont *)fontWithWeight:(UIFontWeight)weight size:(CGFloat)size maximumSize:(CGFloat)maximumSize relativeToTextStyle:(UIFontTextStyle)textStyle NS_REFINED_FOR_SWIFT;

/**
 *  Font with the text family, a weight and a fixed size. Does not scale with accessibility settings.
 */
+ (UIFont *)fontWithWeight:(UIFontWeight)weight fixedSize:(CGFloat)fixedSize NS_REFINED_FOR_SWIFT;

@end

/**
 *  Advanced APIs.
 */
@interface SRGFont (Advanced)

/**
 *  Return the recommended text style according to which the font of the specified style should be scaled.
 */
+ (UIFontTextStyle)recommendedTextStyleForScalingFontWithStyle:(SRGFontStyle)style;

/**
 *  Font descriptor for a font with the given family and style. Can be used for advanced purposes like applying traits for
 *  tight or loose leading, for example.
 *
 *  Use a `UIFontMetrics` returned by `-metricsForFontWithStyle:` to scale the font according to its associated text style,
 *  or `+[UIFont fontWithDescriptor:size:]` to create a font with fixed size.
 */
+ (UIFontDescriptor *)fontDescriptorForFontWithFamily:(SRGFontFamily)family style:(SRGFontStyle)style;

/**
 *  Font descriptor for a font with the given family and weight. Can be used for advanced purposes like applying traits for
 *  tight or loose leading, for example.
 *
 *  Use a `UIFontMetrics` returned by `-metricsForTextStyle:` to scale the font according to a system text style,
 *  or `+[UIFont fontWithDescriptor:size:]` to create a font with fixed size.
 */
+ (UIFontDescriptor *)fontDescriptorForFontWithFamily:(SRGFontFamily)family weight:(UIFontWeight)weight;

/**
 *  Metrics associated with an SRG font style. Can be used to scale arbitrary values where SRG font styles are used
 *  (e.g. margins).
 */
+ (UIFontMetrics *)metricsForFontWithStyle:(SRGFontStyle)style;

@end

NS_ASSUME_NONNULL_END
