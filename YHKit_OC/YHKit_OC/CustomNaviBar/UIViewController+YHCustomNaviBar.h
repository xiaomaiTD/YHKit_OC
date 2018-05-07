//
//  UIViewController+YHCustomNaviBar.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 自定义导航栏
 此自定义导航栏适用于导航栏左边或者右边只有一个按钮，中间是标题的情况；其他情况下，请自行定义。
 使用此类目，建议要设置根控制器是navi，并且设置navigationBarHidden属性为YES。
 */
@interface UIViewController (YHCustomNaviBar)

/** 自定义导航栏View，供外部访问，只读属性 */
@property (nonatomic,strong,readonly) UIView * yh_naviBgView;


/** 导航栏背景颜色,默认:YH_RGB(249, 249, 250) */
@property (nonatomic,strong) UIColor         * yh_naviColor;


/** 导航栏左边按钮图片 */
@property (nonatomic,strong) UIImage         * yh_leftImage;
/** 导航栏左边按钮标题 */
@property (nonatomic,copy) NSString          * yh_leftTitle;
/** 导航栏左边按钮标题的字体颜色，默认黑色 */
@property (nonatomic,strong) UIColor         * yh_leftTitleColor;
/** 导航栏左边按钮标题的字体大小，默认系统字体，大小17 */
@property (nonatomic,assign) CGFloat         yh_leftTitleSize;

@property (nonatomic,strong,readonly) UIButton          * yh_leftButton;
@property (nonatomic,strong,readonly) UIButton          * yh_rightButton;


/** 导航栏右边按钮图片 */
@property (nonatomic,strong) UIImage         * yh_rightImage;
/** 导航栏右边按钮标题 */
@property (nonatomic,copy) NSString          * yh_rightTitle;
/** 导航栏右边按钮标题的字体颜色，默认黑色 */
@property (nonatomic,strong) UIColor         * yh_rightTitleColor;
/** 导航栏右边按钮标题的字体大小，默认系统字体，大小17 */
@property (nonatomic,assign) CGFloat         yh_rightTitleSize;


/** 导航栏标题 */
@property (nonatomic,copy) NSString          * yh_naviTitle;
/** 导航栏标题颜色，默认黑色 */
@property (nonatomic,strong) UIColor         * yh_naviTitleColor;
/** 导航栏标题字体，默认:[UIFont systemFontOfSize:17 weight:UIFontWeightBold] */
@property (nonatomic,strong) UIFont          * yh_naviTitleFont;


/** 导航栏底部那条线的颜色,默认：YH_RGB(228, 227, 228) */
@property (nonatomic,strong) UIColor         * yh_lineColor;
/** 是否隐藏导航栏底部的那条线，默认：NO */
@property (nonatomic,assign) BOOL            yh_isHideLine;




/** 此方法要最先调用，然后才能设置其属性，不然，不会起作用 */
- (void)yh_creatNaviBar;




//重写下面两个方法
/** 导航栏左边按钮点击事件 */
- (void)yh_leftButtonClick:(UIButton *)leftButton;
/** 导航栏右边按钮点击事件 */
- (void)yh_rightButtonClick:(UIButton *)rightButton;


@end


NS_ASSUME_NONNULL_END
