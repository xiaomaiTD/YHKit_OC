//
//  NSObject+YHAuthorization.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/19.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "NSObject+YHAuthorization.h"

#import <UIKit/UIKit.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    #import <AVFoundation/AVFoundation.h>
    #import <Photos/Photos.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    #import <Contacts/Contacts.h>
#else
    #import <AddressBook/AddressBook.h>
#endif
#endif

#import <LocalAuthentication/LocalAuthentication.h>

@implementation NSObject (YHAuthorization)
/** 请求相册权限 */
- (void)yh_requestPhotoLibraryAuthorizationWithResultBlock:(void (^)(YHAuthorizationResultTypeForPhotoLibrary))resultBlock{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
            
        case PHAuthorizationStatusAuthorized:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock ? resultBlock(YHPhotoLibraryAuthorizationAuthorized) : nil;
            });
        }
            break;
        case PHAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock ? resultBlock(YHPhotoLibraryAuthorizationDenied) : nil;
            });
        }
            break;
        case PHAuthorizationStatusRestricted:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock ? resultBlock(YHPhotoLibraryAuthorizationRestricted) : nil;
            });
        }
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                switch (status) {
                    case PHAuthorizationStatusAuthorized:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            resultBlock ? resultBlock(YHPhotoLibraryAuthorizationAuthorized) : nil;
                        });
                    }
                        break;
                    case PHAuthorizationStatusRestricted:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            resultBlock ? resultBlock(YHPhotoLibraryAuthorizationRestricted) : nil;
                        });
                    }
                        break;
                    case PHAuthorizationStatusDenied:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            resultBlock ? resultBlock(YHPhotoLibraryAuthorizationDenied) : nil;
                        });
                    }
                        break;
                    case PHAuthorizationStatusNotDetermined:
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //按照正常流程是不会走这个Block的
                            resultBlock ? resultBlock(YHPhotoLibraryAuthorizationNotDetermined) : nil;
                        });
                    }
                        break;
                    default:
                        break;
                }
            }];
        }
            break;
        default:
            break;
    }
}

/** 请求相机权限 */
-(void)yh_requestCameraAuthorizationwithResultBlock:(void (^)(YHAuthorizationResultTypeForCameraOrMicrophone))resultType{
    [self yh_requestCameraOrMicrophoneAuthorizationWithMediaType:AVMediaTypeVideo withResultBlock:resultType];
}
/** 请求麦克风权限 */
- (void)yh_requestMicrophoneAuthorizationwithResultBlock:(void (^)(YHAuthorizationResultTypeForCameraOrMicrophone))resultType{
    [self yh_requestCameraOrMicrophoneAuthorizationWithMediaType:AVMediaTypeAudio withResultBlock:resultType];
}
-(void)yh_requestCameraOrMicrophoneAuthorizationWithMediaType:(AVMediaType)mediaType withResultBlock:(void (^)(YHAuthorizationResultTypeForCameraOrMicrophone))resultType{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHCameraOrMicrophoneAuthorizationAuthorized) : nil;
            });
        }
            break;
        case AVAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHCameraOrMicrophoneAuthorizationDenied) : nil;
            });
        }
            break;
        case AVAuthorizationStatusRestricted:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHCameraOrMicrophoneAuthorizationRestricted) : nil;
            });
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resultType ? resultType(YHCameraOrMicrophoneAuthorizationAuthorized) : nil;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resultType ? resultType(YHCameraOrMicrophoneAuthorizationDenied) : nil;
                    });
                }
            }];
        }
            break;
        default:
            break;
    }
}



/** 通讯录权限 */
- (void)yh_requestAddressBookAuthorizationwithResultBlock:(void (^)(YHAuthorizationResultTypeForAddressBook))resultType{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusAuthorized:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHAddressBookAuthorizationAuthorized) : nil;
            });
        }
            break;
        case CNAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHAddressBookAuthorizationDenied) : nil;
            });
        }
            break;
        case CNAuthorizationStatusRestricted:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHAddressBookAuthorizationRestricted) : nil;
            });
        }
            break;
        case CNAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"使用Contacts框架获取通讯录权限发生错误:%@",error);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resultType ? resultType(YHAddressBookAuthorizationDenied) : nil;
                    });
                } else {
                    if (granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            resultType ? resultType(YHAddressBookAuthorizationAuthorized) : nil;
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            resultType ? resultType(YHAddressBookAuthorizationDenied) : nil;
                        });
                    }
                }
            }];
        }
            break;
        default:
            break;
    }
#else
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    switch (status) {
        case kABAuthorizationStatusAuthorized:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHAddressBookAuthorizationAuthorized) : nil;
            });
        }
            break;
        case kABAuthorizationStatusDenied:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHAddressBookAuthorizationDenied) : nil;
            });
        }
            break;
        case kABAuthorizationStatusRestricted:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultType ? resultType(YHAddressBookAuthorizationRestricted) : nil;
            });
        }
            break;
        case kABAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resultType ? resultType(YHAddressBookAuthorizationAuthorized) : nil;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        resultType ? resultType(YHAddressBookAuthorizationDenied) : nil;
                    });
                }
            });
        }
            break;
        default:
            break;
    }
#endif
}

/** Touch ID 是否可用 */
- (BOOL)yh_touchIDEnabled{
    NSError *error;
    LAContext *context = [[LAContext alloc] init];
    BOOL res = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    NSLog(@"%@",error);
    return res;
}
@end
