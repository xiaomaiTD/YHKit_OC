//
//  YHNotification.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/19.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UNUserNotificationCenterDelegate;

NS_ASSUME_NONNULL_BEGIN

/** 通知授权状态 */
typedef NS_ENUM(NSUInteger, YHNotificationAuthorizationType) {
    YHNotificationAuthorization,// 允许通知
    YHNotificationDenied,// 拒绝通知
    YHNotificationNotDetermined,// 还没有做决定(iOS 10之后才有)
};

/** 该类是对系统通知的封装
 调用方式：(需要把以下代码写在 application:didFinishLaunchingWithOptions: 里面)
 
 #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    if (@available(iOS 10_0, *)) {
        [YHNotification yh_registerNotificationWithDelegate:self];
    }
 #else
    [YHNotification yh_registerNotification];
 #endif
 [YHNotification yh_rigsterAPNs];
 
 参考链接：
 1、http://blog.csdn.net/yydev/article/details/52105830
 2、http://www.jianshu.com/p/bb89d636f989
 */
NS_CLASS_AVAILABLE_IOS(8_0) @interface YHNotification : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 注册通知
 包括本地推送和远程推送，因为本地推送和远程推送设置是一样的
 */
+ (void)yh_registerNotification NS_CLASS_AVAILABLE_IOS(8_0);
+ (void)yh_registerNotificationWithDelegate:(id<UNUserNotificationCenterDelegate>)delegate NS_CLASS_AVAILABLE_IOS(10_0);



/**
 检查通知授权状态
 有些app对于没有打开通知，会有一个弹出框提示，提示去打开通知。调用此方法，就会获取当前应用的通知打开状态。不过，这儿有一点需要注意，一般第一次安装app时，都会弹出是否允许通知的弹出框，这是一个延迟事件，而这个方法是一个即时事件，因此，就会有个现象，调用此方法会返回denied或者NotDetermined状态，然而此时却正好是用户选择的时候。因此有种做法就是,可以在沙盒里面设置一个key，用于记录用户打开app(完全杀死进程，再打开)的次数，当打开次数为1的时候，不调用此方法；当大于1的时候，再调用此方法
 兼容iOS 10之下以及iOS 10之后
 */
+ (void)yh_checkNotificationAuthorizationWithResultBlock:(void(^)(YHNotificationAuthorizationType authorizationType))resultBlock NS_CLASS_AVAILABLE_IOS(8_0);



/**
 调用此方法注册APNs，同时也是为了获取token(注：模拟器下是无法获得devicetoken的)
 此方法的调用应该在 yh_registerNotification 或者 yh_registerNotificationWithDelegate:(id<UNUserNotificationCenterDelegate>)delegate 之后，即注册通知之后
 同时可能会走以下代理方法中的其中一个:
 1、成功获取token
 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{ }
 2、获取token失败
 - (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{ }
 */
+ (void)yh_rigsterAPNs NS_CLASS_AVAILABLE_IOS(8_0);



@end

NS_ASSUME_NONNULL_END
