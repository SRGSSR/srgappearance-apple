//
//  Copyright (c) SRG. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Register a font from the specified file. Returns `YES` iff successful.
 */
OBJC_EXPORT BOOL SRGAppearanceRegisterFont(NSString *filePath);

/**
 *  Compare font size categories (@see `UIContentSizeCategory.h`).
 *
 *  @dicussion In debug builds, this method throws if the content size category is not an official one.
 */
OBJC_EXPORT NSComparisonResult SRGAppearanceCompareContentSizeCategories(NSString *contentSizeCategory1, NSString *contentSizeCategory2);

@interface UIFont (SRGAppearance)

/**
 *  SRG SSR official fonts with size set in the system settings.
 */
+ (UIFont *)srg_regularFontWithTextStyle:(NSString *)textStyle;
+ (UIFont *)srg_boldFontWithTextStyle:(NSString *)textStyle;
+ (UIFont *)srg_heavyFontWithTextStyle:(NSString *)textStyle;
+ (UIFont *)srg_lightFontWithTextStyle:(NSString *)textStyle;
+ (UIFont *)srg_mediumFontWithTextStyle:(NSString *)textStyle;
+ (UIFont *)srg_italicFontWithTextStyle:(NSString *)textStyle;
+ (UIFont *)srg_boldItalicFontWithTextStyle:(NSString *)textStyle;
+ (UIFont *)srg_regularSerifFontWithTextStyle:(NSString *)textStyle;

/**
 *  SRG SSR official fonts with fixed sizes.
 */
+ (UIFont *)srg_regularFontWithSize:(CGFloat)size;
+ (UIFont *)srg_boldFontWithSize:(CGFloat)size;
+ (UIFont *)srg_heavyFontWithSize:(CGFloat)size;
+ (UIFont *)srg_lightFontWithSize:(CGFloat)size;
+ (UIFont *)srg_mediumFontWithSize:(CGFloat)size;
+ (UIFont *)srg_italicFontWithSize:(CGFloat)size;
+ (UIFont *)srg_boldItalicFontWithSize:(CGFloat)size;
+ (UIFont *)srg_regularSerifFontWithSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
