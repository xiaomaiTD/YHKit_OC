//
//  NSObject+YHAuthorization.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/19.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/** 相册访问权限枚举值 */
typedef NS_ENUM(NSUInteger, YHAuthorizationResultTypeForPhotoLibrary) {
    YHPhotoLibraryAuthorizationAuthorized,/** 同意访问相册 */
    YHPhotoLibraryAuthorizationDenied,/** 拒绝访问相册 */
    YHPhotoLibraryAuthorizationRestricted,/** 访问受限制，可能是家长控制权限 */
    YHPhotoLibraryAuthorizationNotDetermined,/** 还没有做决定 */
};
/** 相机or麦克风权限枚举值 */
typedef NS_ENUM(NSUInteger, YHAuthorizationResultTypeForCameraOrMicrophone) {
    YHCameraOrMicrophoneAuthorizationAuthorized,/** 同意访问相机or麦克风 */
    YHCameraOrMicrophoneAuthorizationDenied,/** 拒绝访问相机or麦克风 */
    YHCameraOrMicrophoneAuthorizationRestricted,/** 访问受限制，可能是家长权限 */
    YHCameraOrMicrophoneAuthorizationNotDetermined,/** 还没有做决定 */
};
/** 通讯录权限枚举值 */
typedef NS_ENUM(NSUInteger, YHAuthorizationResultTypeForAddressBook) {
    YHAddressBookAuthorizationAuthorized,/** 同意访问通讯录 */
    YHAddressBookAuthorizationDenied,/** 拒绝访问通讯录 */
    YHAddressBookAuthorizationRestricted,/** 访问受限制，可能是家长权限 */
    YHAddressBookAuthorizationNotDetermined,/** 还没有做决定 */
};

/**
 此类目是针对iOS系统权限的封装
 包含：相册权限、相机权限、麦克风权限、通讯录权限
 
 
 必须在 Info.plist 中添加以下权限，即使项目中没有使用这个权限，也要添加.(上传成功，但是在iTunes store上却没有刚刚传的包）
 NSContactsUsageDescription                      通讯录权限
 NSMicrophoneUsageDescription                    麦克风权限
 NSPhotoLibraryUsageDescription                  相册权限
 NSCameraUsageDescription                        相机权限
 */
@interface NSObject (YHAuthorization)
/** 请求相册权限 */
- (void)yh_requestPhotoLibraryAuthorizationWithResultBlock:(void(^)(YHAuthorizationResultTypeForPhotoLibrary authorizationStatus))resultBlock NS_AVAILABLE_IOS(8_0);

/** 请求相机权限 */
- (void)yh_requestCameraAuthorizationwithResultBlock:(void(^)(YHAuthorizationResultTypeForCameraOrMicrophone authorizationStatus))resultType NS_AVAILABLE_IOS(8_0);

/** 请求麦克风权限 */
- (void)yh_requestMicrophoneAuthorizationwithResultBlock:(void(^)(YHAuthorizationResultTypeForCameraOrMicrophone authorizationStatus))resultType NS_AVAILABLE_IOS(8_0);

/** 通讯录权限 */
- (void)yh_requestAddressBookAuthorizationwithResultBlock:(void(^)(YHAuthorizationResultTypeForAddressBook authorizationStatus))resultType NS_AVAILABLE_IOS(8_0);
@end
NS_ASSUME_NONNULL_END

















