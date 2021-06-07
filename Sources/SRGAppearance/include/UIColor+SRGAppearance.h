//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Transformer between hexadecimal strings and colors. Convert valid hexadecimal strings with or without leading
 *  wildcards to colors. Conversely, produces hexadecimal strings from colors (always with leading wildcard):
 */
OBJC_EXPORT NSValueTransformer *SRGHexadecimalColorTransformer(void);

@interface UIColor (SRGAppearance)

/**
 *  Standard colors.
 */
@property (class, nonatomic, readonly) UIColor *srg_redColor;               // Brand color
@property (class, nonatomic, readonly) UIColor *srg_lightRedColor;
@property (class, nonatomic, readonly) UIColor *srg_darkRedColor;
@property (class, nonatomic, readonly) UIColor *srg_blueColor;

/**
 *  Standard grays.
 */
@property (class, nonatomic, readonly) UIColor *srg_gray1Color;
@property (class, nonatomic, readonly) UIColor *srg_gray2Color;
@property (class, nonatomic, readonly) UIColor *srg_gray3Color;
@property (class, nonatomic, readonly) UIColor *srg_gray4Color;
@property (class, nonatomic, readonly) UIColor *srg_gray5Color;

/**
 *  Return the color matching a hexadecimal #rrggbbaa or #rrggbb string representation (the leading wildcard is optional),
 *  or `nil` if the string does not correspond to a color. Supports uppercase or lowercase digits.
 */
+ (nullable UIColor *)srg_colorFromHexadecimalString:(NSString *)hexadecimalString;

/**
 *  Return the color as a hexadecimal #rrggbbaa (#rrggbb if the alpha channel is 1) string representation. Always return
 *  lowercase digits with a leading wildcard.
 */
@property (nonatomic, readonly, copy) NSString *srg_hexadecimalString;

@end

NS_ASSUME_NONNULL_END
