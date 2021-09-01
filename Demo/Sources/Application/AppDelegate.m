//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "AppDelegate.h"

#import "FontsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (@available(iOS 13, tvOS 13, *)) {}
    else {
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        [self.window makeKeyAndVisible];
        
        FontsViewController *fontsViewController = [[FontsViewController alloc] init];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:fontsViewController];
    }
    return YES;
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0))
{
    return [[UISceneConfiguration alloc] initWithName:@"Default" sessionRole:connectingSceneSession.role];
}

@end
