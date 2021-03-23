//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import CoreGraphics;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Variation axis for variable fonts (e.g. weight, italic, etc.).
 */
@interface SRGVariationAxis : NSObject

/**
 *  Return the variation axes of a given font with the specified name, or `nil` if the specified font is not found.
 */
+ (nullable NSArray<SRGVariationAxis *> *)variationAxesForFontWithName:(NSString *)fontName;

/**
 *  Attribute to specify in font descriptor construction.
 */
@property (nonatomic, readonly, copy) NSString *attribute;

/**
 *  Identifier of the axis.
 */
@property (nonatomic, readonly, copy) NSString *identifier;

/**
 *  Name of the axis.
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
 *  Minimum supported value.
 */
@property (nonatomic, readonly) CGFloat minimumValue;

/**
 *  Maximum supported value.
 */
@property (nonatomic, readonly) CGFloat maximumValue;

/**
 *  Default value.
 */
@property (nonatomic, readonly) CGFloat defaultValue; 

@end

NS_ASSUME_NONNULL_END
