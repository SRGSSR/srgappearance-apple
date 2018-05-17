//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Transformer between hexadecimal strings and colors. Convert valid hexadecimal strings with or without leading
 *  wildcards to colors. Conversely, produces hexadecimal strings from colors (always with leading wildcard):
 */
OBJC_EXPORT NSValueTransformer *SRGHexadecimalColorTransformer(void);

@interface UIColor (SRGAppearance)

/**
 *  The official SRG SSR red color.
 */
+ (UIColor *)srg_redColor;

/**
 *  The official SRG SSR blue color.
 */
+ (UIColor *)srg_blueColor;

/**
 *  Return the color matching a hexadecimal string (with or without leading wildcard), `nil` if the string does
 *  not correspond to a color.
 */
+ (nullable UIColor *)srg_colorFromHexadecimalString:(NSString *)hexadecimalString;

@end

NS_ASSUME_NONNULL_END
