//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "NSBundle+SRGAppearance.h"

@interface SRGAppearanceBundle : NSObject

@end

@implementation SRGAppearanceBundle

@end

@implementation NSBundle (SRGAppearance)

+ (NSBundle *)srg_appearanceBundle
{
    static NSBundle *bundle;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSString *bundlePath = [[NSBundle bundleForClass:[SRGAppearanceBundle class]].bundlePath stringByAppendingPathComponent:@"SRGAppearance.bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
        NSAssert(bundle, @"Please add SRGAppearance.bundle to your project resources");
    });
    return bundle;
}

@end
