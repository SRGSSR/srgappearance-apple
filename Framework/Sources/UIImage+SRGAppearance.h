//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Standard images

@interface UIImage (SRGAppearance)

/**
 *  Return an image generated from the vector image at the specified path.
 *
 *  @param filePath The path of the vector image to use.
 *  @param size     The size of the image to create.
 *
 *  @return The generated image, `nil` if generation failed.
 */
+ (nullable UIImage *)srg_vectorImageAtPath:(NSString *)filePath withSize:(CGSize)size;

/**
 *  Return the file URL of an image generated from the vector image at the specified path.
 *
 *  @param filePath The path of the vector image to use.
 *  @param size     The size of the image to create.
 *
 *  @return The generated image, `nil` if generation failed.
 *
 *  @discussion Images are stored in the `/Library/Caches` directory.
 */
+ (nullable NSURL *)srg_URLForVectorImageAtPath:(NSString *)filePath withSize:(CGSize)size;

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
