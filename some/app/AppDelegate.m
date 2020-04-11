//
//  AppDelegate.m
//  some
//
//  Created by a.kurganova on 03.04.2020.
//  Copyright © 2020 a.kurganova. All rights reserved.
//

#import "AppDelegate.h"
#import "MainView.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
UIWindow *window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainView *main = [MainView alloc];
    window.rootViewController = main;
    [window makeKeyAndVisible];
    return YES;
}
@end
