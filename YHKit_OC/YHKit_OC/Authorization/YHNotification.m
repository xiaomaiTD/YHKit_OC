//
//  YHNotification.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/19.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHNotification.h"
#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    #import <UserNotifications/UserNotifications.h>
#endif


@interface YHNotification()

@end

@implementation YHNotification

+ (void)yh_registerNotification{
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}
+ (void)yh_registerNotificationWithDelegate:(id<UNUserNotificationCenterDelegate>)delegate{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = delegate;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"注册通知error:%@",error);
            } else {
                if (granted) {
                    NSLog(@"允许注册通知");
                } else {
                    NSLog(@"不允许注册通知");
                }
            }
        }];
    }
}



+ (void)yh_checkNotificationAuthorizationWithResultBlock:(void (^)(YHNotificationAuthorizationType))resultBlock{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            switch (settings.authorizationStatus) {
                case UNAuthorizationStatusAuthorized:
                {
                    resultBlock ? resultBlock(YHNotificationAuthorization) : nil;
                }
                    break;
                case UNAuthorizationStatusDenied:
                {
                    resultBlock ? resultBlock(YHNotificationDenied) : nil;
                }
                    break;
                case UNAuthorizationStatusNotDetermined:
                {
                    resultBlock ? resultBlock(YHNotificationNotDetermined) : nil;
                }
                    break;
                default:
                    break;
            }
        }];
    }
#else
    UIUserNotificationSettings *settings = [UIApplication sharedApplication].currentUserNotificationSettings;
    if (settings.types == UIUserNotificationTypeNone) {
        resultBlock ? resultBlock(YHNotificationDenied) : nil;
    } else {
        resultBlock ? resultBlock(YHNotificationAuthorization) : nil;
    }
#endif
}


+ (void)yh_rigsterAPNs{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}



@end















