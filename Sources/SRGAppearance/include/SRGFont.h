//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Available SRG font types.
 */
typedef NS_CLOSED_ENUM(NSInteger, SRGFontType) {
    /**
     *  Font optimized for text readability.
     */
    SRGFontTypeText = 1,
    /**
     *  Font emphasizing branding at the expense of readability for small sizes.
     */
    SRGFontTypeDisplay
} NS_SWIFT_NAME(SRGFont.Type);

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
// TODO: Check API method calls in Swift (SRG vs. UIKit constants with same prototype)
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
OBJC_EXPORT NSComparisonResult SRGAppearanceCompareContentSizeCategories(NSString *contentSizeCategory1, NSString *contentSizeCategory2);

/**
 *  Official SRG SSR font.
 */
@interface SRGFont: NSObject

/**
 *  Font with a given type and predefined style. The font scales according to an internally associated matching text style
 *  and the current accessibility settings.
 */
+ (UIFont *)fontWithType:(SRGFontType)type style:(SRGFontStyle)style NS_REFINED_FOR_SWIFT;

/**
 *  Font with a given type, weight and size. The font scales relative to the provided text style and the current
 *  accessibility settings, starting from the specified size. A maximum size can optionally be provided.
 *
 *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategoryLarge` default accessibility
 *              setting.
 */
+ (UIFont *)fontWithType:(SRGFontType)type weight:(UIFontWeight)weight size:(CGFloat)size relativeToTextStyle:(UIFontTextStyle)textStyle NS_REFINED_FOR_SWIFT;
+ (UIFont *)fontWithType:(SRGFontType)type weight:(UIFontWeight)weight size:(CGFloat)size maximumSize:(CGFloat)maximumSize relativeToTextStyle:(UIFontTextStyle)textStyle NS_REFINED_FOR_SWIFT;

/**
 *  Font with a given type, weight and fixed size. Does not scale with accessibility settings.
 */
+ (UIFont *)fontWithType:(SRGFontType)type weight:(UIFontWeight)weight fixedSize:(CGFloat)fixedSize NS_REFINED_FOR_SWIFT;

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
 *  Font descriptor for a font with the given type and style. Can be used for advanced purposes like applying traits for
 *  tight or loose leading, for example.
 *
 *  Use a `UIFontMetrics` returned by `-metricsForFontWithStyle:` to scale the font according to its associated text style,
 *  or `+[UIFont fontWithDescriptor:size:]` to create a font with fixed size.
 */
+ (UIFontDescriptor *)fontDescriptorForFontWithType:(SRGFontType)type style:(SRGFontStyle)style;

/**
 *  Font descriptor for a font with the given type and weight. Can be used for advanced purposes like applying traits for
 *  tight or loose leading, for example.
 *
 *  Use a `UIFontMetrics` returned by `-metricsForTextStyle:` to scale the font according to a system text style,
 *  or `+[UIFont fontWithDescriptor:size:]` to create a font with fixed size.
 */
+ (UIFontDescriptor *)fontDescriptorForFontWithType:(SRGFontType)type weight:(UIFontWeight)weight;

/**
 *  Metrics associated with an SRG font type. Can be used to scale arbitrary values where SRG font styles are used
 *  (e.g. margins).
 */
+ (UIFontMetrics *)metricsForFontWithStyle:(SRGFontStyle)style;

@end

NS_ASSUME_NONNULL_END
