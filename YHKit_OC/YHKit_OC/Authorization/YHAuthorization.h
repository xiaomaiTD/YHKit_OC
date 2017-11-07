//
//  YHAuthorization.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/7.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YHAuthorizationType) {
    AuthorizationTypePhotoLibrary,//相册
    AuthorizationTypeCamera,//相机
    AuthorizationTypeMicrophone,//麦克风
    AuthorizationTypeAddressBook,//通讯录
};
typedef NS_ENUM(NSUInteger, YHAuthorizationResultType) {
    AuthorizationResultAuthorized,//同意授权访问
    AuthorizationResultDenied,//拒绝
    AuthorizationResultRestricted,//受限制，可能是家长控制权限
    AuthorizationResultNotDetermined,//还没有做决定
    
    //针对定位权限的
    AuthorizationResultWhenInUse,
    AuthorizationResultAlways,
};
typedef NS_ENUM(NSUInteger, YHLocationAuthorizationType) {
    LocationAuthorizationWhenInUse,
    LocationAuthorizationAlways,
};
typedef void(^AuthorizationResultBlock)(YHAuthorizationResultType authorizationResultType);
/**
 权限判断，只支持iOS 8.0 以上
 */
NS_CLASS_AVAILABLE_IOS(8_0) @interface YHAuthorization : NSObject

/** 获取权限的方法 */
+ (void)yh_requestAuthorizationWithAuthorizationType:(YHAuthorizationType)authorizationType authorizationResultBlock:(AuthorizationResultBlock)authorizationResultBlock;

/** 专门针对定位权限的方法，因为定位权限的判断优点特殊，因此就单独写了一个方法 */
+ (void)yh_requestLocationAuthorizationWithLocationAuthorizationType:(YHLocationAuthorizationType)LocationAuthorizationType authorizationResultBlock:(AuthorizationResultBlock)authorizationResultBlock;

@end

NS_ASSUME_NONNULL_END




/** 必须在 Info.plist 中添加以下权限，即使项目中没有使用这个权限，也要添加，不然上传不了 iTunes store（上传成功，但是）
 NSContactsUsageDescription                      通讯录权限
 NSMicrophoneUsageDescription                    麦克风权限
 NSPhotoLibraryUsageDescription                  相册权限
 NSCameraUsageDescription                        相机权限
 NSLocationAlwaysUsageDescription                地理位置权限(始终访问)
 NSLocationAlwaysAndWhenInUseUsageDescription    地理位置权限(始终访问)
 NSLocationWhenInUseUsageDescription             地位位置权限(使用期间)
 
 

 1、当NSLocationAlwaysAndWhenInUseUsageDescription和NSLocationAlwaysUsageDescription一起写上，最终在手机上回弹出一个选择，即’使用期间‘、’一直访问‘、’拒绝‘这三个选项
 2、如果仅仅是使用期间定位，只需要加上NSLocationWhenInUseUsageDescription
 */



























