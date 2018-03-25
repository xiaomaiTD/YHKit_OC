//
//  PushVC.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/23.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "PushVC.h"

#import "YHKit_OC.h"

#import "UIViewController+YHTransition.h"

@interface PushVC ()

@end

@implementation PushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.yh_isHideShadowImage = YES;
    self.yh_naviTitle = @"push界面";
    [self yh_setupDefaultSystemNaviLeftBackItemWithAction:@selector(back:)];
    self.yh_naviLeftBarButtonItem.tintColor = [UIColor purpleColor];
}
- (void)back:(id)sender{
//    [self yh_popViewControllerWithAnimationDuration:3 animationType:YHTransitionAnimationTypeScaleShrink animated:YES];
}
@end
