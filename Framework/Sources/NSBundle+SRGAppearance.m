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
    static NSBundle *s_bundle;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        NSString *bundlePath = [[NSBundle bundleForClass:[SRGAppearanceBundle class]].bundlePath stringByAppendingPathComponent:@"SRGAppearance.bundle"];
        s_bundle = [NSBundle bundleWithPath:bundlePath];
        NSAssert(s_bundle, @"Please add SRGAppearance.bundle to your project resources");
    });
    return s_bundle;
}

@end
