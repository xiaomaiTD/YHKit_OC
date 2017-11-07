//
//  YHAuthorization.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/7.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHAuthorization.h"

/** iOS 8.0 之后可用 */
#import <Photos/Photos.h>
/** iOS 4.0 之后可用 */
#import <AVFoundation/AVFoundation.h>

#import <CoreLocation/CoreLocation.h>


/*
#ifdef NSFoundationVersionNumber_iOS_9_0
    #import <Contacts/Contacts.h>
#else
    #import <AddressBook/AddressBook.h>
#endif
*/
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    #import <Contacts/Contacts.h>//iOS 9.0 之后可用
#else
    #import <AddressBook/AddressBook.h>//iOS 9.0之前可用
#endif





@interface YHAuthorization () <CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager         * locationManager;
@property (nonatomic,copy) AuthorizationResultBlock    authorizationResultBlock;
@property (nonatomic,strong) NSTimer                   * timer;//当调用地理位置权限时，使用此timer
@end

@implementation YHAuthorization

- (void)dealloc{
    NSLog(@"YHAuthorization dealloc");
}
+ (void)yh_requestAuthorizationWithAuthorizationType:(YHAuthorizationType)authorizationType authorizationResultBlock:(AuthorizationResultBlock)authorizationResultBlock{
    switch (authorizationType) {
        case AuthorizationTypePhotoLibrary:
        {
            [self requestPhotoLibraryAuthorizationWithAuthorizationResultBlock:authorizationResultBlock];
        }
            break;
        case AuthorizationTypeCamera:
        {
            [self requestAuthorizationWithMediaType:AVMediaTypeVideo authorizationResultBlock:authorizationResultBlock];
        }
            break;
        case AuthorizationTypeMicrophone:
        {
            [self requestAuthorizationWithMediaType:AVMediaTypeAudio authorizationResultBlock:authorizationResultBlock];
        }
            break;
        case AuthorizationTypeAddressBook:
        {
            [self requestAddressBookAuthorizationWithAuthorizationResultBlock:authorizationResultBlock];
        }
            break;
        default:
            break;
    }
}
/** 地理位置权限 */
+ (void)yh_requestLocationAuthorizationWithLocationAuthorizationType:(YHLocationAuthorizationType)LocationAuthorizationType authorizationResultBlock:(AuthorizationResultBlock)authorizationResultBlock{
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        authorizationResultBlock ? authorizationResultBlock(AuthorizationResultRestricted) : nil;
        return;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAlways) : nil;
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultWhenInUse) : nil;
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultRestricted) : nil;
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            //注意:CLLocationManager的实例必须要用全局变量，否则授权提示框就会一闪而过，而不是一直显示
            YHAuthorization *authorization = [[YHAuthorization alloc] init];
            authorization.locationManager = [[CLLocationManager alloc] init];;
            authorization.locationManager = [[CLLocationManager alloc] init];
            authorization.locationManager.delegate = authorization;
            
            switch (LocationAuthorizationType) {
                case LocationAuthorizationAlways:
                {
                    [authorization.locationManager requestAlwaysAuthorization];//iOS 8.0之后可用
                }
                    break;
                case LocationAuthorizationWhenInUse:
                {
                    [authorization.locationManager requestWhenInUseAuthorization];//iOS 8.0之后可用
                }
                    break;
                default:
                    break;
            }
            authorization.authorizationResultBlock = authorizationResultBlock;
            //该timer的作用是强制持有self，因为测试发现，该方法调用完毕，不会走代理方法
            authorization.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:authorization selector:@selector(ss:) userInfo:nil repeats:YES];
        }
            break;
        default:
            break;
    }
}
- (void)ss:(NSTimer *)timer{}
/** 通讯录权限 */
+ (void)requestAddressBookAuthorizationWithAuthorizationResultBlock:(AuthorizationResultBlock)authorizationResultBlock{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusAuthorized:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAuthorized) : nil;
        }
            break;
        case CNAuthorizationStatusDenied:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
        }
            break;
        case CNAuthorizationStatusRestricted:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultRestricted) : nil;
        }
            break;
        case CNAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"%@",error);
                    authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
                } else {
                    if (granted) {
                        authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAuthorized) : nil;
                    } else {
                        authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
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
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAuthorized) : nil;
        }
            break;
        case kABAuthorizationStatusDenied:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
        }
            break;
        case kABAuthorizationStatusRestricted:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultRestricted) : nil;
        }
            break;
        case kABAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAuthorized) : nil;
                } else {
                    authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
                }
            });
        }
            break;
        default:
            break;
    }
#endif
}
/** 相机或者麦克风权限
 当是相机权限时,mediaType = AVMediaTypeVideo
 当是麦克风权限时,mediaType = AVMediaTypeAudio
 */
+ (void)requestAuthorizationWithMediaType:(AVMediaType)mediaType authorizationResultBlock:(AuthorizationResultBlock)authorizationResultBlock{
    //iOS 7.0 之后可用
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAuthorized) : nil;
        }
            break;
        case AVAuthorizationStatusDenied:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
        }
            break;
        case AVAuthorizationStatusRestricted:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultRestricted) : nil;
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if (granted) {
                    authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAuthorized) : nil;
                } else {
                    authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
                }
            }];
        }
            break;
        default:
            break;
    }
}

/** 相册权限 */
+ (void)requestPhotoLibraryAuthorizationWithAuthorizationResultBlock:(AuthorizationResultBlock)authorizationResultBlock{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusAuthorized:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAuthorized) : nil;
        }
            break;
        case PHAuthorizationStatusDenied:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
        }
            break;
        case PHAuthorizationStatusRestricted:
        {
            authorizationResultBlock ? authorizationResultBlock(AuthorizationResultRestricted) : nil;
        }
            break;
        case PHAuthorizationStatusNotDetermined:
        {
            //当是NotDetermined时，重新请求权限
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                switch (status) {
                    case PHAuthorizationStatusAuthorized:
                    {
                        authorizationResultBlock ? authorizationResultBlock(AuthorizationResultAuthorized) : nil;
                    }
                        break;
                    case PHAuthorizationStatusRestricted:
                    {
                        authorizationResultBlock ? authorizationResultBlock(AuthorizationResultRestricted) : nil;
                    }
                        break;
                    case PHAuthorizationStatusDenied:
                    {
                        authorizationResultBlock ? authorizationResultBlock(AuthorizationResultDenied) : nil;
                    }
                        break;
                    case PHAuthorizationStatusNotDetermined:
                    {
                        //按照正常流程是不会走这个Block的
                        authorizationResultBlock ? authorizationResultBlock(AuthorizationResultNotDetermined) : nil;
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





#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            self.authorizationResultBlock(AuthorizationResultWhenInUse);
            [self.timer invalidate];
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            self.authorizationResultBlock(AuthorizationResultAlways);
            [self.timer invalidate];
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            self.authorizationResultBlock(AuthorizationResultRestricted);
            [self.timer invalidate];
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            self.authorizationResultBlock(AuthorizationResultDenied);
            [self.timer invalidate];
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            self.authorizationResultBlock(AuthorizationResultNotDetermined);
        }
            break;
        default:
            break;
    }
}

@end























