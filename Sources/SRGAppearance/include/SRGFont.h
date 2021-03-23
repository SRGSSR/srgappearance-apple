//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Available SRG fonts.
 */
typedef NS_ENUM(NSInteger, SRGFontName) {
    /**
     *  Font optimized for readability.
     */
    SRGFontNameText = 1,
    /**
     *  Font emphasizing branding at the expense of readability for small sizes.
     */
    SRGFontNameDisplay
};

/**
 *  Standard semantic styles which define both a size and a weight.
 */
// TODO: Document Large sizes for iOS and tvOS
typedef NS_ENUM(NSInteger, SRGFontStyle) {
    SRGFontStyleTitle1 = 1,             // Bold
    SRGFontStyleTitle2,                 // Medium
    SRGFontStyleHeadline1,              // Regular
    SRGFontStyleHeadline2,              // Medium
    SRGFontStyleSubtitle,               // Light
    SRGFontStyleBody,                   // Regular
    SRGFontStyleButton1,                // Medium
    SRGFontStyleButton2,                // Regular
    SRGFontStyleOverline,               // Regular
    SRGFontStyleLabel,                  // Bold
    SRGFontStyleCaption                 // Medium
};

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
 *  Font with a given name and predefined style, scaling like the provided system text style (with an optional maximum size).
 */
+ (UIFont *)fontWithName:(SRGFontName)name style:(SRGFontStyle)style textStyle:(UIFontTextStyle)textStyle;
+ (UIFont *)fontWithName:(SRGFontName)name style:(SRGFontStyle)style textStyle:(UIFontTextStyle)textStyle maximumPointSize:(CGFloat)maximumPointSize;

/**
 *  Font with a given name, weight and size, scaling like the provided system text style (with an optional maximum size).
 */
+ (UIFont *)fontWithName:(SRGFontName)name weight:(UIFontWeight)weight size:(CGFloat)size textStyle:(UIFontTextStyle)textStyle;
+ (UIFont *)fontWithName:(SRGFontName)name weight:(UIFontWeight)weight size:(CGFloat)size textStyle:(UIFontTextStyle)textStyle maximumPointSize:(CGFloat)maximumPointSize;

/**
 *  Font with a given name, weight and fixed size.
 */
+ (UIFont *)fontWithName:(SRGFontName)name weight:(UIFontWeight)weight fixedSize:(CGFloat)fixedSize;

/**
 *  Font descriptor for a font with the given name, scaling like the provided system text style. Can be used for more
 *  advanced purposes like applying traits fort tight or loose leading, for example.
 */
+ (UIFontDescriptor *)fontDescriptorForFontWithName:(SRGFontName)name textStyle:(UIFontTextStyle)textStyle;

@end

NS_ASSUME_NONNULL_END
