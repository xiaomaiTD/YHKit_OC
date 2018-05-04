//
//  LeftMenuVC.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/23.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "LeftMenuVC.h"
#import "YHKit_OC.h"
#import <Masonry/Masonry.h>
#import "MenuPushVC.h"
@interface LeftMenuVC ()

@end

@implementation LeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"12345678990752423432423";
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo([YHDrawerVC sharedDrawer].leftMenuWidth);
        make.height.mas_equalTo(100.f);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"抽屉push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom);
        make.left.equalTo(self.view);
        make.width.mas_equalTo([YHDrawerVC sharedDrawer].leftMenuWidth);
        make.height.mas_equalTo(60);
    }];
}
- (void)btnClick:(UIButton *)sender{
    MenuPushVC *vc = [[MenuPushVC alloc] init];
    [[YHDrawerVC sharedDrawer] pushToVC:vc isCloseDrawer:YES];
}


@end
