//
//  YHPhotoBroswer.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/25.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoBroswer.h"

#import "YHDebugMacro.h"
#import "NSObject+YHAuthorization.h"

#import "YHPhotoListVC.h"

@interface YHPhotoBroswer ()

@end

@implementation YHPhotoBroswer
- (void)dealloc{
    YHLog(@"YHPhotoBroswer dealloc");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
}
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}
- (UIViewController *)childViewControllerForStatusBarHidden{
    return self.topViewController;
}

- (void)showIn:(UIViewController *)showVC{
    [showVC yh_requestPhotoLibraryAuthorizationWithResultBlock:^(YHAuthorizationResultTypeForPhotoLibrary authorizationStatus) {
        switch (authorizationStatus) {
            case YHPhotoLibraryAuthorizationAuthorized:
            {
                YHLog(@"同意授权访问相册");
                
                YHPhotoListVC *listVC = [[YHPhotoListVC alloc] init];
                YHPhotoBroswer *bro = [[YHPhotoBroswer alloc] initWithRootViewController:listVC];
                [showVC presentViewController:bro animated:YES completion:nil];
                
 
            }
                break;
            case YHPhotoLibraryAuthorizationDenied:
            case YHPhotoLibraryAuthorizationRestricted:
            {
                YHLog(@"相册访问受限制或者用户拒绝访问相册");
            }
                break;
            case YHPhotoLibraryAuthorizationNotDetermined:
            {
                //正常情况下是不会走这个case的
                YHLog(@"访问相册还没有做决定");
            }
                break;
            default:
                break;
        }
    }];
}

@end




















