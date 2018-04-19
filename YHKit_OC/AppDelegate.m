//
//  AppDelegate.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"

#import "YHKit_OC.h"

#import "ViewController.h"

#import "CustomNaviVC.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    #import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //self.window.backgroundColor = [UIColor orangeColor];
    [self.window makeKeyAndVisible];
    
//    TestViewController *t = [[TestViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:t];
//    [navi setNavigationBarHidden:YES];
//    self.window.rootViewController = navi;
    
//    ViewController *vc = [[ViewController alloc] init];
//    self.window.rootViewController = vc;
    
    CustomNaviVC *vc = [[CustomNaviVC alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
//    [navi setNavigationBarHidden:YES];
//    self.window.rootViewController = vc;
    
    YHDrawerVC *drawer = [YHDrawerVC sharedDrawer];
    drawer.mainVC = vc;
    self.window.rootViewController = [YHDrawerVC getAppDelegateRootVCWith:drawer];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    if (@available(iOS 10_0, *)) {
        [YHNotification yh_registerNotificationWithDelegate:self];
    }
#else
    [YHNotification yh_registerNotification];
#endif
    [YHNotification yh_rigsterAPNs];
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"%@",deviceToken);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
