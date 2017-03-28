//
//  Copyright (c) SRG. All rights reserved.
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
        bundle = [NSBundle bundleForClass:[SRGAppearanceBundle class]];
    });
    return bundle;
}

@end
