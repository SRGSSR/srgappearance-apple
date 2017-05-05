//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SRGAppearance)

/**
 *  Return a resized vector image generated from a vector image of the specified bundle.
 *
 *  @param imageName The name of the PDF vector image to resize (without extension).
 *  @param bundle    The bundle in which the image must be located (the main bundle if `nil`),
 *  @param size      The size of the image to create.
 *
 *  @return The resized image, `nil` if not found or if resizing failed.
 */
+ (nullable UIImage *)srg_vectorImageNamed:(NSString *)imageName inBundle:(nullable NSBundle *)bundle withSize:(CGSize)size;

/**
 *  Return a vector image from the specified bundle, for a given size.
 *
 *  @discussion Images are stored in the `/Library/Caches` directory.
 */
+ (nullable NSURL *)srg_fileURLForVectorImageNamed:(NSString *)imageName inBundle:(nullable NSBundle *)bundle withSize:(CGSize)size;

/**
 *  Clears the cache of vector images.
 */
+ (void)srg_clearVectorImageCache;

/**
 *  Return the receiver, tinted with the specified color (if the color is `nil`, the image is returned as is).
 */
- (UIImage *)srg_imageTintedWithColor:(nullable UIColor *)color;

@end

NS_ASSUME_NONNULL_END
