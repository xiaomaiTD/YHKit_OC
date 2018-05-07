//
//  VC1.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "VC1.h"

#import "UIViewController+YHTransition.h"
#import "YHDebugMacro.h"

#import "VC2.h"

@interface VC1 ()

@end

@implementation VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.yh_naviTitle = @"vc1";
    [self yh_setupDefaultSystemNaviLeftBackItemWithAction:@selector(back)];
    
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"进入VC2" forState:UIControlStateNormal];
    btn.center = self.view.center;
    btn.bounds = CGRectMake(0, 0, 200, 100);
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(gotoVC2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

    [self yh_registerToInteractiveTransitionWithGestureDirection:YHPanGestureDirectionLeft interactiveType:YHInteractiveTypePresentDismiss transitionInteractiveBlock:^UIViewController * _Nonnull{
        return [[VC2 alloc] init];
    } makeTransition:^(YHTransitionManager * _Nonnull transition) {
        transition.animationDuration = 1.f;
        transition.animationType = YHTransitionAnimationTypeScaleShrink;
    } transitionInteractiveBeginBlock:^{
        YHLog(@"开始");
    } completion:^{
        YHLog(@"vc1通过左滑入场结束");
    }];
    
}
- (void)gotoVC2:(UIButton *)sender{
    VC2 *vc = [[VC2 alloc] init];
    [self yh_presentViewController:vc makeTransition:^(YHTransitionManager * _Nonnull transition) {
        transition.animationDuration = 1.f;
        transition.animationType = YHTransitionAnimationTypeScaleShrink;
    } animated:YES completion:^{
        YHLog(@"vc1通过点击按钮present结束");
    }];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


@end
