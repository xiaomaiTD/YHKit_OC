//
//  ViewController.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "ViewController.h"


#import "YHKit_OC.h"
#import "Test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *hardwareStr = [YHDeviceUtil hardwareString];
    NSLog(@"%@",hardwareStr);
    
//    [YHAuthorization asdsas:^(YHAuthorizationResultType authorizationResultType) {
//        [self.navigationController pushViewController:self animated:YES];
//    }];
    
}
- (IBAction)alertTestAction:(id)sender {
    [self yh_showActionSheetAlertWithTitle:nil message:nil alertMaker:^(YHAlertController * _Nonnull alert) {
        alert.addActionDefaultTitle(@"111111")
        .addActionDefaultTitle(@"2222222")
        .addActionDestructiveTitle(@"333333")
        .addActionCancelTitle(@"44444444");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, YHAlertController * _Nonnull alert) {
        if (buttonIndex == 0) {
            NSLog(@"1111111");
        } else if (buttonIndex == 1) {
            NSLog(@"22222222");
        } else if (buttonIndex == 2) {
            NSLog(@"333333");
        } else if (buttonIndex == 3) {
            NSLog(@"444444");
        }
    }];
//    [self yh_showAlertWithTitle:@"提示" message:@"请点击选项" alertMaker:^(YHAlertController * _Nonnull alert) {
//        alert.addActionDefaultTitle(@"111111")
//        .addActionDefaultTitle(@"2222222")
//        .addActionDestructiveTitle(@"333333")
//        .addActionCancelTitle(@"44444444");
//    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, YHAlertController * _Nonnull alert) {
//        if (buttonIndex == 0) {
//            NSLog(@"1111111");
//        } else if (buttonIndex == 1) {
//            NSLog(@"22222222");
//        } else if (buttonIndex == 2) {
//            NSLog(@"333333");
//        } else if (buttonIndex == 3) {
//            NSLog(@"444444");
//        }
//    }];
}
- (IBAction)photoLibraryAction:(id)sender {
    [YHAuthorization yh_requestAuthorizationWithAuthorizationType:AuthorizationTypePhotoLibrary authorizationResultBlock:^(YHAuthorizationResultType authorizationResultType) {
        [self debugWith:authorizationResultType];
    }];
}

- (IBAction)camera:(id)sender {
    [YHAuthorization yh_requestAuthorizationWithAuthorizationType:AuthorizationTypeCamera authorizationResultBlock:^(YHAuthorizationResultType authorizationResultType) {
        [self debugWith:authorizationResultType];
    }];
}
- (IBAction)adressBookAction:(id)sender {
    [YHAuthorization yh_requestAuthorizationWithAuthorizationType:AuthorizationTypeAddressBook authorizationResultBlock:^(YHAuthorizationResultType authorizationResultType) {
        [self debugWith:authorizationResultType];
    }];
}


- (IBAction)microphoneAction:(id)sender {
    [YHAuthorization yh_requestAuthorizationWithAuthorizationType:AuthorizationTypeMicrophone authorizationResultBlock:^(YHAuthorizationResultType authorizationResultType) {
        [self debugWith:authorizationResultType];
    }];
}


- (IBAction)locationAction:(id)sender {
    [YHAuthorization yh_requestLocationAuthorizationWithLocationAuthorizationType:LocationAuthorizationWhenInUse authorizationResultBlock:^(YHAuthorizationResultType authorizationResultType) {
        [self debugWith:authorizationResultType];
    }];
}

- (IBAction)locationAlwaysAction:(id)sender {
    [YHAuthorization yh_requestLocationAuthorizationWithLocationAuthorizationType:LocationAuthorizationAlways authorizationResultBlock:^(YHAuthorizationResultType authorizationResultType) {
        [self debugWith:authorizationResultType];
    }];
    
}


- (void)debugWith:(YHAuthorizationResultType)authorizationResultType{
    if (authorizationResultType == AuthorizationResultAuthorized) {
        NSLog(@"同意");
    } else if (authorizationResultType == AuthorizationResultDenied) {
        NSLog(@"拒绝");
    } else if (authorizationResultType == AuthorizationResultRestricted) {
        NSLog(@"受限制");
    } else if (authorizationResultType == AuthorizationResultNotDetermined) {
        NSLog(@"还没有做决定");
    } else if (authorizationResultType == AuthorizationResultWhenInUse) {
        NSLog(@"使用期间允许定位");
    } else if (authorizationResultType == AuthorizationResultAlways) {
        NSLog(@"一直允许定位");
    }
}



@end
