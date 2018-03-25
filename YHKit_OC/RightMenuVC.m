//
//  RightMenuVC.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/23.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "RightMenuVC.h"

#import "YHKit_OC.h"
#import <Masonry/Masonry.h>

@interface RightMenuVC ()

@end

@implementation RightMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"12345678990752423432423";
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.right.equalTo(self.view);
        make.width.mas_equalTo([YHDrawerVC sharedDrawer].rightMenuWidth);
        make.height.mas_equalTo(100.f);
    }];
}


@end
