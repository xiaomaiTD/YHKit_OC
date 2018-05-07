//
//  YHDrawerVC.h
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 切换mainVC时的动画类型
 当两个模块之间的关联不大，或者并没有直接的通信，而且两个模块之间需要进行切换，可以用此动画类型。
 比如登陆模块和主页模块，一般登录成功之后要切换到主页模块都是重新设置window的根控制器，没有动画，很死板。若想切换的时候加上点动画，则可以加上以下动画类型。
 */
typedef NS_ENUM(NSUInteger, YHDrawerResetMainPageAnimationType) {
    YHDrawerResetMainPageAnimationNone, // 无动画
    YHDrawerResetMainPageAnimationTypeRotationY, // 要中心Y轴旋转
};
/** 打开侧边栏的动画类型，目前只完成了两种类型，其余的动画类型不再做，其原理都一样 */
typedef NS_ENUM(NSUInteger, YHDrawerOpenMenuAnimationType) {
    YHDrawerOpenMenuAnimationType1, //抽屉的mainVC不动，侧边栏以先加速，再减速的运动方式移动到目标位置
    YHDrawerOpenMenuAnimationType2, //抽屉的mainVC和侧边栏同时移动，但是mainVC的移动幅度没有侧边栏的移动幅度大，给人一种交错的感觉
};
typedef void(^CloseDrawerCompleteBlock)(void);
NS_ASSUME_NONNULL_BEGIN
@class YHDrawerNavi;
@interface YHDrawerVC : UIViewController
/** 抽屉的背景颜色(纯颜色) */
@property (nonatomic,strong) UIColor                        * drawerColor;
/** mainVC */
@property (nonatomic,strong) UIViewController               * mainVC;

/** 左抽屉 */
@property (nonatomic,strong) UIViewController               * leftMenuVC;
@property (nonatomic,assign) YHDrawerOpenMenuAnimationType  openLeftMenuAnimationType;
@property (nonatomic,assign) CGFloat                        leftMenuWidth;
@property (nonatomic,assign,readonly) BOOL                  isOpenLeftMenu;

/** 右抽屉 */
@property (nonatomic,strong) UIViewController               * rightMenuVC;
@property (nonatomic,assign) YHDrawerOpenMenuAnimationType  openRightMenuAnimationType;
@property (nonatomic,assign) CGFloat                        rightMenuWidth;
@property (nonatomic,assign,readonly) BOOL                  isOpenRightMenu;

/** 关闭抽屉的回调 */
@property (nonatomic,copy) CloseDrawerCompleteBlock         closeDrawerCompleteBlock;

/** 单列 */
+ (YHDrawerVC *)sharedDrawer;

+ (YHDrawerNavi *)getAppDelegateRootVCWith:(YHDrawerVC *)drawerVC;

/**
 重新设置主页的方法
 比如点击登录按钮，点击突出登录按钮
 */
- (void)resetMainVC:(UIViewController *)mainVC withAnimationType:(YHDrawerResetMainPageAnimationType)animationType;


- (void)openLeftMenu;
- (void)closeLeftMenu;

- (void)openRightMenu;
- (void)closeRightMenu;

- (void)pushToVC:(UIViewController *)vc isCloseDrawer:(BOOL)isCloseDrawer;

@end



@interface YHDrawerNavi : UINavigationController


@end



NS_ASSUME_NONNULL_END




