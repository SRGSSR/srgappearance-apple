//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "SRGFont.h"

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/**
 *  Font metrics applying behavior matching SRG SSR font styles (scaling behavior for accessibility, maximum
 *  value).
 */
@interface SRGFontMetrics : UIFontMetrics

/**
 *  Metrics for an SRG font style.
 */
+ (SRGFontMetrics *)metricsForFontStyle:(SRGFontStyle *)style;

/**
 *  Initialies metrics for an SRG font style.
 */
- (instancetype)initForFontStyle:(SRGFontStyle)style;

@end

NS_ASSUME_NONNULL_END
