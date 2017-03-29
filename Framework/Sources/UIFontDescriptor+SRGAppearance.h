//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Font descriptor extensions
 */
@interface UIFontDescriptor (SRGAppearance)

/**
 *  Return the preferred font descriptor for a font with the specified name and text style.
 */
+ (UIFontDescriptor *)srg_preferredFontDescriptorWithName:(NSString *)name textStyle:(NSString *)style;

@end

NS_ASSUME_NONNULL_END
