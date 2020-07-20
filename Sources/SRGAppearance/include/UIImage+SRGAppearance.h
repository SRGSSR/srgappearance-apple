//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SRGAppearance)

/**
*  Return an image generated from the vector image at the specified path. The image is fitted to the specified size
*  and remaining space is filled with the provided color.
*
*  @param filePath  The path of the vector image to use.
*  @param size      The size of the image to create. Components set to 0 are calculated automatically based on the
*                   resource aspect ratio (or its intrinsic size if both are 0).
*  @param fillColor The color to use for filling, transparent if `nil`.
*
*  @return The generated image, `nil` if generation failed.
*/
+ (nullable UIImage *)srg_vectorImageAtPath:(NSString *)filePath withSize:(CGSize)size fillColor:(nullable UIColor *)fillColor;

/**
 *  Same as `-srg_vectorImageAtPath:withSize:fillColor:` without fill color.
 */
+ (nullable UIImage *)srg_vectorImageAtPath:(NSString *)filePath withSize:(CGSize)size;

/**
 *  Same as `-srg_vectorImageAtPath:withSize:fillColor:`, calculating the other dimension based on the image aspect ratio.
 */
+ (nullable UIImage *)srg_vectorImageAtPath:(NSString *)filePath withWidth:(CGFloat)width;
+ (nullable UIImage *)srg_vectorImageAtPath:(NSString *)filePath withHeight:(CGFloat)height;

/**
 *  Same as `-srg_vectorImageAtPath:withSize:fillColor:`, returning the image with its intrinsic size.
 */
+ (nullable UIImage *)srg_vectorImageAtPath:(NSString *)filePath;

/**
*  Return the file URL of an image generated from the vector image at the specified path. The image is fitted to the
*  specified size and remaining space is filled with the provided color.
*
*  @param filePath  The path of the vector image to use.
*  @param size      The size of the image to create. Components set to 0 are calculated automatically based on the
*                   resource aspect ratio (or its intrinsic size if both are 0).
*  @param fillColor The color to use for filling, transparent if `nil`.
*
*  @return The generated image, `nil` if generation failed.
*
*  @discussion Images are stored in the `/Library/Caches` directory.
*/
+ (nullable NSURL *)srg_URLForVectorImageAtPath:(NSString *)filePath withSize:(CGSize)size fillColor:(nullable UIColor *)fillColor;

/**
 *  Same as `-srg_URLForVectorImageAtPath:withSize:fillColor:` without fill color.
 */
+ (nullable NSURL *)srg_URLForVectorImageAtPath:(NSString *)filePath withSize:(CGSize)size;

/**
 *  Same as `-srg_URLForVectorImageAtPath:withSize:fillColor:`, calculating the other dimension based on the image
 *  aspect ratio.
 */
+ (nullable NSURL *)srg_URLForVectorImageAtPath:(NSString *)filePath withWidth:(CGFloat)width;
+ (nullable NSURL *)srg_URLForVectorImageAtPath:(NSString *)filePath withHeight:(CGFloat)height;

/**
 *  Same as `-srg_URLForVectorImageAtPath:withSize:fillColor:`, returning the image with its intrinsic size.
 */
+ (nullable NSURL *)srg_URLForVectorImageAtPath:(NSString *)filePath;

/**
 *  Clears the vector image cache.
 */
+ (void)srg_clearVectorImageCache;

/**
 *  Return the receiver, tinted with the specified color (if the color is `nil`, the image is returned as is).
 */
- (UIImage *)srg_imageTintedWithColor:(nullable UIColor *)color;

@end

NS_ASSUME_NONNULL_END
