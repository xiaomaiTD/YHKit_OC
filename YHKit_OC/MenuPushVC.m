//
//  MenuPushVC.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/23.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "MenuPushVC.h"

@interface MenuPushVC ()

@end

@implementation MenuPushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    self.yh_naviTitle = @"menuPushVC";
    [self yh_setupDefaultSystemNaviLeftBackItemWithAction:@selector(back:)];
    self.yh_isHideShadowImage = YES;
    self.yh_naviBgColor = [UIColor orangeColor];
}
- (void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
