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
@property (class, nonatomic, readonly) UIColor *srg_redColor NS_REFINED_FOR_SWIFT;               // Brand color
@property (class, nonatomic, readonly) UIColor *srg_lightRedColor NS_REFINED_FOR_SWIFT;
@property (class, nonatomic, readonly) UIColor *srg_darkRedColor NS_REFINED_FOR_SWIFT;
@property (class, nonatomic, readonly) UIColor *srg_blueColor NS_REFINED_FOR_SWIFT;

/**
 *  Standard grays.
 */
@property (class, nonatomic, readonly) UIColor *srg_gray16Color NS_REFINED_FOR_SWIFT;
@property (class, nonatomic, readonly) UIColor *srg_gray23Color NS_REFINED_FOR_SWIFT;
@property (class, nonatomic, readonly) UIColor *srg_gray33Color NS_REFINED_FOR_SWIFT;
@property (class, nonatomic, readonly) UIColor *srg_gray4AColor NS_REFINED_FOR_SWIFT;
@property (class, nonatomic, readonly) UIColor *srg_gray96Color NS_REFINED_FOR_SWIFT;
@property (class, nonatomic, readonly) UIColor *srg_grayC7Color NS_REFINED_FOR_SWIFT;

/**
 *  Returns the color matching a hexadecimal #rrggbbaa or #rrggbb string representation (the leading wildcard is optional),
 *  or `nil` if the string does not correspond to a color. Supports uppercase or lowercase digits.
 */
+ (nullable UIColor *)srg_colorFromHexadecimalString:(NSString *)hexadecimalString NS_REFINED_FOR_SWIFT;

/**
 *  Returns the color as a hexadecimal #rrggbbaa (#rrggbb if the alpha channel is 1) string representation. Always return
 *  lowercase digits with a leading wildcard.
 */
@property (nonatomic, readonly, copy) NSString *srg_hexadecimalString NS_REFINED_FOR_SWIFT;

@end

NS_ASSUME_NONNULL_END
