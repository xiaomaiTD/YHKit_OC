//
//  YHDrawerVC.h
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, YHDrawerResetMainPageAnimationType) {
    YHDrawerResetMainPageAnimationNone,
    YHDrawerResetMainPageAnimationTypeRotationY,
};

@interface YHDrawerVC : UIViewController

/** mainVC */
@property (nonatomic,strong) UIViewController * mainVC;

/** 单列 */
+ (YHDrawerVC *)sharedDrawer;

/** 重新设置主页的方法 */
- (void)yh_resetMainVC:(UIViewController *)mainVC withAnimationType:(YHDrawerResetMainPageAnimationType)animationType;


@end





