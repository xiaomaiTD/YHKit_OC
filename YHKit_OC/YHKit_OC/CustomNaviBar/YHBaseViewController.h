//
//  YHBaseViewController.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/8.
//  Copyright © 2018年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHNavigationBar.h"
#import "YHBarButtonItemConfigure.h"
#import "UIBarButtonItem+YHBarButtonItem.h"

/**
 空白item，用于调整item之间间隙
 WIDTH为负数时，相当于btn向右移动WIDTH数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整为0;WIDTH为正数时，正好相反，相当于往左移动WIDTH数值个像素
 */
#define YH_SPACE_ITEM(WIDTH) \
({ \
UIBarButtonItem *spaceItem = nil; \
spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil]; \
spaceItem.width = WIDTH; \
(spaceItem); \
})



NS_ASSUME_NONNULL_BEGIN
@interface YHBaseViewController : UIViewController
@property (nonatomic,strong,readonly) YHNavigationBar    *yh_navigationBar;
@property (nonatomic,strong,readonly) UINavigationItem   *yh_navigationItem;

/**
 导航栏背景颜色
 设置[UIColor clearColor]属性，会导致导航栏变为黑色
 **经过测试，最好不要使用yh_barTintColor这个属性，使用yh_naviBgColor这个属性更好**
 */
@property (nonatomic,strong,nullable) UIColor * yh_barTintColor NS_UNAVAILABLE;
/** 导航栏背景颜色 */
@property (nonatomic,strong,nullable) UIColor * yh_naviBgColor;
/** 导航栏背景图片 */
@property (nonatomic,strong,nullable) UIImage * yh_naviBgImage;
/** 是否隐藏自定义导航栏 */
@property (nonatomic,assign) BOOL yh_isHidenNaviBar;

/**
 设置shadowImage颜色
 必须设置yh_naviBgColor或者yh_naviBgImage后，此属性才有作用
 若设置yh_barTintColor，那么设置yh_navShadowColor不会起任何作用
 */
@property (nonatomic,strong,nullable) UIColor * yh_naviShadowColor;
/**
 设置shadowImage图片
 必须设置yh_naviBgColor或者yh_naviBgImage后，此属性才有作用
 若设置yh_barTintColor，那么设置yh_navShadowImage不会起任何作用
 */
@property (nonatomic,strong,nullable) UIImage * yh_naviShadowImage;
/** 是否隐藏shadowImage */
@property (nonatomic,assign) BOOL yh_isHideShadowImage;

/**
 设置导航栏左右按钮或者标题的颜色，图片或者标题的颜色都会改变。
 若想单独设置某个item的颜色，self.yh_naviLeftBarButtonItem.tintColor
 */
@property (nonatomic,strong,nullable) UIColor * yh_naviTintColor;

/** 导航栏标题 */
@property (nonatomic,copy,nullable) NSString * yh_naviTitle;
/** 导航栏titleView */
@property (nonatomic,strong,nullable) UIView * yh_naviTitleView;
/** 导航栏标题颜色 */
@property (nonatomic,strong,nullable) UIColor * yh_naviTitleColor;
/** 导航栏标题字体 */
@property (nonatomic,strong,nullable) UIFont * yh_naviTitleFont;

/** 导航栏左边item */
@property (nonatomic,strong,nullable) UIBarButtonItem * yh_naviLeftBarButtonItem;
@property (nonatomic,strong,nullable) NSArray<UIBarButtonItem *> * yh_naviLeftBarButtonItems;

/** 导航栏右边item */
@property (nonatomic,strong,nullable) UIBarButtonItem * yh_naviRightBarButtonItem;
@property (nonatomic,strong,nullable) NSArray<UIBarButtonItem *> * yh_naviRightBarButtonItems;



/** 设置导航栏默认返回按钮，使用系统样式 */
- (void)yh_setupDefaultSystemNaviLeftBackItemWithAction:(nullable SEL)action;
- (void)yh_setupDefaultSystemNaviLeftBackItemWithImage:(nullable UIImage *)image action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END





/*
 在开发中，可能会遇到这样一种情况：
 点击某个item，会弹出一个弹窗，该弹窗位置基于该item的位置，这时就需要知道点击该item的位置，可以用yh_customizeItemWithItemType:configure:target:action:方法，然后在selector中，用[sender convertRect:sender.bounds toView:self.view]，即可获取该item的位置
 */

