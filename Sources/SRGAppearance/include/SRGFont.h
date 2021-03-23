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
};

/**
 *  Standard semantic styles which define both a size and a weight.
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
};

/**
 *  Standard SRG SSR font weights.
 */
// TODO: Check API method calls in Swift (SRG vs. UIKit constants with same prototype)
OBJC_EXPORT const UIFontWeight SRGFontWeightLight;
OBJC_EXPORT const UIFontWeight SRGFontWeightRegular;
OBJC_EXPORT const UIFontWeight SRGFontWeightMedium;
OBJC_EXPORT const UIFontWeight SRGFontWeightBold;
OBJC_EXPORT const UIFontWeight SRGFontWeightHeavy;

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
+ (UIFont *)fontWithType:(SRGFontType)type style:(SRGFontStyle)style;

/**
 *  Font with a given type, weight and size. The font scales relative to the provided text style and the current
 *  accessibility settings, starting from the specified size. A maximum size can optionally be provided.
 *
 *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategoryLarge` default accessibility
 *              setting.
 */
+ (UIFont *)fontWithType:(SRGFontType)type weight:(UIFontWeight)weight size:(CGFloat)size relativeToTextStyle:(UIFontTextStyle)textStyle;
+ (UIFont *)fontWithType:(SRGFontType)type weight:(UIFontWeight)weight size:(CGFloat)size maximumSize:(CGFloat)maximumSize relativeToTextStyle:(UIFontTextStyle)textStyle;

/**
 *  Font with a given type, weight and fixed size. Does not scale with accessibility settings.
 */
+ (UIFont *)fontWithType:(SRGFontType)type weight:(UIFontWeight)weight fixedSize:(CGFloat)fixedSize;

/**
 *  Font descriptor for a font with the given name, scaling relative to the provided text style. Can be used for
 *  advanced purposes like applying traits for tight or loose leading, for example.
 */
// TODO: Try to display something to check this works correctly
+ (UIFontDescriptor *)fontDescriptorForFontWithType:(SRGFontType)type textStyle:(UIFontTextStyle)textStyle;

/**
 *  Metrics associated with an SRG font type. Can be used to scale arbitrary values where SRG font styles are used
 *  (e.g. margins).
 */
+ (UIFontMetrics *)metricsForFontWithStyle:(SRGFontStyle)style;

@end

NS_ASSUME_NONNULL_END
