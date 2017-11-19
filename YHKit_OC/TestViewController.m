//
//  TestViewController.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "TestViewController.h"
#import "YHKit_OC.h"


@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self yh_requestCameraAuthorizationwithResultBlock:^(YHAuthorizationResultTypeForCameraOrMicrophone authorizationStatus) {
        
    }];
    
    [self yh_creatNaviBar];
//    self.yh_leftImage = [UIImage imageNamed:@"navi_test_left"];
//    self.yh_rightImage = [UIImage imageNamed:@"navi_test_left"];
//    self.yh_naviColor = [UIColor orangeColor];
    self.yh_leftTitle = @"取消";
    self.yh_rightTitle = @"取消";
    self.yh_naviTitle = @"消息";
    self.yh_lineColor = [UIColor redColor];
    
//    self.yh_leftTitle = @"取消";

    
    
    switch ([UIDevice currentDevice].orientation) {
            
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        {
            
        }
            break;
            
            
        case UIDeviceOrientationLandscapeLeft:
        {
            
        }
            break;
            
            
        case UIDeviceOrientationLandscapeRight:
        {
            
        }
            break;
            
            
        case UIDeviceOrientationUnknown:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
    [YHNotification yh_checkNotificationAuthorizationWithResultBlock:^(YHNotificationAuthorizationType authorizationType) {
        NSLog(@"%ld",authorizationType);
    }];
    
}
- (void)yh_leftButtonClick:(UIButton *)leftButton{
    NSLog(@"左边点击");
}
- (void)yh_rightButtonClick:(UIButton *)rightButton{
    NSLog(@"右边点击");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
