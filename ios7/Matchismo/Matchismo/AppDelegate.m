//
//  AppDelegate.m
//  Matchismo
//
//  Created by Davis Koh on 12/1/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "AppDelegate.h"
#import "PlayingCardGameViewController.h"
#import "SetCardGameViewController.h"
// REALLY FUCKING GHETTO APPLE
#import "Matchismo-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:bounds];

    PlayingCardGameViewController *playingCardGameViewCtrl = [[PlayingCardGameViewController alloc] init];
    UINavigationController *playingCardNavCtrl = [[UINavigationController alloc] initWithRootViewController:playingCardGameViewCtrl];
    playingCardNavCtrl.title = @"Playing Card Game";

    SetCardGameViewController *setCardGameViewCtrl = [[SetCardGameViewController alloc] init];
    UINavigationController *setCardNavCtrl = [[UINavigationController alloc] initWithRootViewController:setCardGameViewCtrl];
    setCardNavCtrl.title = @"Set Card Game";

    HighScoresViewController *highScoresViewCtrl = [[HighScoresViewController alloc] init];
    highScoresViewCtrl.title = @"High Scores";

    UITabBarController *tabBarCtrl = [[UITabBarController alloc] init];
    tabBarCtrl.viewControllers = @[playingCardNavCtrl, setCardNavCtrl, highScoresViewCtrl];
    self.window.rootViewController = tabBarCtrl;

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
