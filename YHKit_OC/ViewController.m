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





@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *hardwareStr = [YHDeviceUtil hardwareString];
//    NSLog(@"%@",hardwareStr);
    
//    [YHAuthorization asdsas:^(YHAuthorizationResultType authorizationResultType) {
//        [self.navigationController pushViewController:self animated:YES];
//    }];
    
}
- (IBAction)alertTestAction:(id)sender {
    [self yh_systemPhotoAlertWithImageBlock:^(UIImage * _Nonnull image) {
        NSLog(@"%@",image);
    }];
    
//    [YHMBHud show];
    
//    [YHMBHud hudOnlyMessage:@"请稍后" inView:nil dismissBlock:nil];
    
    
//    [self yh_showActionSheetAlertWithTitle:nil message:nil alertMaker:^(YHAlertController * _Nonnull alert) {
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

}

- (IBAction)camera:(id)sender {
 
}
- (IBAction)adressBookAction:(id)sender {

}


- (IBAction)microphoneAction:(id)sender {
 
}


- (IBAction)locationAction:(id)sender {

}

- (IBAction)locationAlwaysAction:(id)sender {
 
    
}




@end
