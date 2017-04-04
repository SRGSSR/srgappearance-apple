//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "SRGAppearance.h"

#import "NSBundle+SRGAppearance.h"

NSString *SRGAppearanceMarketingVersion(void)
{
    return [NSBundle srg_appearanceBundle].infoDictionary[@"CFBundleShortVersionString"];
}
