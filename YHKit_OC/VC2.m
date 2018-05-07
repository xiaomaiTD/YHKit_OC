//
//  VC2.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/28.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "VC2.h"

#import "YHTransition.h"
#import "YHDebugMacro.h"

@interface VC2 ()

@end

@implementation VC2
- (void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.yh_naviTitle = @"vc2";
    [self yh_setupDefaultSystemNaviLeftBackItemWithAction:@selector(back)];
    
    
    [self yh_registerBackInteractiveTransitionWithGestureDirection:YHPanGestureDirectionRight interactiveType:YHInteractiveTypePresentDismiss makeTransition:^(YHTransitionManager * _Nonnull transition) {
        transition.animationType = YHTransitionAnimationTypeScaleEnlarge;
    } transitionInteractiveBeginBlock:^{
        YHLog(@"开始");
    } completion:^{
        YHLog(@"vc2通过右滑返回结束");
    }];
}

- (void)back{
    [self yh_dismissViewControllerWithMakeTransition:^(YHTransitionManager * _Nonnull transition) {
        transition.animationType = YHTransitionAnimationTypeScaleEnlarge;
    } animated:YES completion:^{
        YHLog(@"vc2通过点击返回按钮返回结束");
    }];
    
}
@end
