//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Font descriptor extensions
 */
@interface UIFontDescriptor (SRGAppearance)

/**
 *  Return the preferred font descriptor for a font with the specified name and text style. Only supports official
 *  iOS text styles (@see `UIFontDescriptor.h`).
 *
 *  @discussion Also works with unknown font names (though fonts generated from such a descriptor will fallback on
 *              Helvetica).
 */
+ (UIFontDescriptor *)srg_preferredFontDescriptorWithName:(NSString *)name textStyle:(NSString *)style;

@end

NS_ASSUME_NONNULL_END
