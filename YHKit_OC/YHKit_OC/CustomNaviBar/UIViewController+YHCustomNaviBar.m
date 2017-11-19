//
//  UIViewController+YHCustomNaviBar.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "UIViewController+YHCustomNaviBar.h"

#import <objc/message.h>

#import "YHRuntimeMacro.h"
#import "YHColorMacro.h"
#import "YHSizeMacro.h"



#define NaviHeight               YH_STATUSBARFRAME.size.height + YH_NAVIFRAME.size.height
#define NaviHeight_top           YH_STATUSBARFRAME.size.height
#define NaviHeight_bottom        YH_NAVIFRAME.size.height

/** 导航栏左右按钮的宽度 */
static CGFloat const ItemWidth = 65.f;
/** 导航栏底部线的高度 */
static CGFloat const BottomLineHeight = 0.5f;

@interface UIViewController()
@property (nonatomic,strong) UIView            * yh_naviBgView;
@property (nonatomic,strong) UIButton          * yh_leftButton;
@property (nonatomic,strong) UIButton          * yh_rightButton;
@property (nonatomic,strong) UILabel           * yh_titleLabel;
@property (nonatomic,strong) UIView            * yh_lineView;
@end


@implementation UIViewController (YHCustomNaviBar)


#pragma mark - methods
- (void)yh_creatNaviBar{
    
    self.yh_naviBgView = [[UIView alloc] init];
    self.yh_naviBgView.backgroundColor = YH_RGB(249, 249, 250);
    [self.view addSubview:self.yh_naviBgView];
    
    
    self.yh_leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yh_leftButton setTitle:self.yh_leftTitle forState:UIControlStateNormal];
    [self.yh_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.yh_leftButton setTitleColor:[self.yh_leftButton.currentTitleColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    self.yh_leftButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.yh_leftButton setImage:self.yh_leftImage forState:UIControlStateNormal];
    [self.yh_leftButton addTarget:self action:@selector(yh_leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.yh_naviBgView addSubview:self.yh_leftButton];
    
    
    self.yh_rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yh_rightButton setTitle:self.yh_rightTitle forState:UIControlStateNormal];
    [self.yh_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.yh_rightButton setTitleColor:[self.yh_rightButton.currentTitleColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    self.yh_rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.yh_rightButton setImage:self.yh_rightImage forState:UIControlStateNormal];
    [self.yh_rightButton addTarget:self action:@selector(yh_rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.yh_naviBgView addSubview:self.yh_rightButton];
    
    
    self.yh_titleLabel = [[UILabel alloc] init];
    self.yh_titleLabel.textAlignment = NSTextAlignmentCenter;
    self.yh_titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.yh_titleLabel.numberOfLines = 0;
    self.yh_titleLabel.textColor = [UIColor blackColor];
    self.yh_titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.yh_naviBgView addSubview:self.yh_titleLabel];
    
    
    self.yh_lineView = [[UIView alloc] init];
    self.yh_lineView.backgroundColor = YH_RGB(228, 227, 228);
    [self.yh_naviBgView addSubview:self.yh_lineView];
    
    
    self.yh_naviBgView.frame = CGRectMake(0, 0, YH_SCREENWIDTH, NaviHeight);
    self.yh_leftButton.frame = CGRectMake(0, NaviHeight_top, ItemWidth, NaviHeight_bottom);
    self.yh_rightButton.frame = CGRectMake(YH_SCREENWIDTH-ItemWidth, NaviHeight_top, ItemWidth, NaviHeight_bottom);
    
    CGFloat o_x = self.yh_leftButton.frame.origin.x+self.yh_leftButton.frame.size.width+15;
    CGFloat width = YH_SCREENWIDTH-o_x-(self.yh_rightButton.frame.size.width+15.f);
    self.yh_titleLabel.frame = CGRectMake(o_x, NaviHeight_top, width, NaviHeight_bottom);
    
    self.yh_lineView.frame = CGRectMake(self.yh_naviBgView.frame.origin.x, self.yh_naviBgView.frame.size.height-BottomLineHeight, self.yh_naviBgView.frame.size.width, BottomLineHeight);
}


#pragma mark - button click action
- (void)yh_leftButtonClick:(UIButton *)leftButton{
    //重写此方法
}
- (void)yh_rightButtonClick:(UIButton *)rightButton{
    //重写此方法
}




#pragma mark - setter && getter
//navi bg color
- (void)setYh_naviColor:(UIColor *)yh_naviColor{
    YH_RUNTIME_STRONG_SET(@selector(yh_naviColor), yh_naviColor);
    self.yh_naviBgView.backgroundColor = yh_naviColor;
}
- (UIColor *)yh_naviColor{
    return YH_RUNTIME_GET;
}
//left image
- (void)setYh_leftImage:(UIImage *)yh_leftImage{
    YH_RUNTIME_STRONG_SET(@selector(yh_leftImage), yh_leftImage);
    [self.yh_leftButton setImage:yh_leftImage forState:UIControlStateNormal];
}
- (UIImage *)yh_leftImage{
    return YH_RUNTIME_GET;
}
//left title
- (void)setYh_leftTitle:(NSString *)yh_leftTitle{
    YH_RUNTIME_COPY_SET(@selector(yh_leftTitle), yh_leftTitle);
    [self.yh_leftButton setTitle:yh_leftTitle forState:UIControlStateNormal];
}
- (NSString *)yh_leftTitle{
    return YH_RUNTIME_GET;
}
//left title color
- (void)setYh_leftTitleColor:(UIColor *)yh_leftTitleColor{
    YH_RUNTIME_STRONG_SET(@selector(yh_leftTitleColor), yh_leftTitleColor);
    [self.yh_leftButton setTitleColor:yh_leftTitleColor forState:UIControlStateNormal];
}
- (UIColor *)yh_leftTitleColor{
    return YH_RUNTIME_GET;
}
//left title size
- (void)setYh_leftTitleSize:(CGFloat)yh_leftTitleSize{
    YH_RUNTIME_ASSIGN_SET(@selector(yh_leftTitleSize), [NSNumber numberWithFloat:yh_leftTitleSize]);
    self.yh_leftButton.titleLabel.font = [UIFont systemFontOfSize:yh_leftTitleSize];
}
- (CGFloat)yh_leftTitleSize{
    return [YH_RUNTIME_GET floatValue];
}
//right image
- (void)setYh_rightImage:(UIImage *)yh_rightImage{
    YH_RUNTIME_STRONG_SET(@selector(yh_rightImage), yh_rightImage);
    [self.yh_rightButton setImage:yh_rightImage forState:UIControlStateNormal];
}
- (UIImage *)yh_rightImage{
    return YH_RUNTIME_GET;
}
//right title
- (void)setYh_rightTitle:(NSString *)yh_rightTitle{
    YH_RUNTIME_COPY_SET(@selector(yh_rightTitle), yh_rightTitle);
    [self.yh_rightButton setTitle:yh_rightTitle forState:UIControlStateNormal];
}
- (NSString *)yh_rightTitle{
    return YH_RUNTIME_GET;
}
//right title color
- (void)setYh_rightTitleColor:(UIColor *)yh_rightTitleColor{
    YH_RUNTIME_STRONG_SET(@selector(yh_rightTitleColor), yh_rightTitleColor);
    [self.yh_rightButton setTitleColor:yh_rightTitleColor forState:UIControlStateNormal];
}
- (UIColor *)yh_rightTitleColor{
    return YH_RUNTIME_GET;
}
//right title size
- (void)setYh_rightTitleSize:(CGFloat)yh_rightTitleSize{
    YH_RUNTIME_ASSIGN_SET(@selector(yh_rightTitleSize), [NSNumber numberWithFloat:yh_rightTitleSize]);
    self.yh_rightButton.titleLabel.font = [UIFont systemFontOfSize:yh_rightTitleSize];
}
- (CGFloat)yh_rightTitleSize{
    return [YH_RUNTIME_GET floatValue];
}
//navi title
- (void)setYh_naviTitle:(NSString *)yh_naviTitle{
    YH_RUNTIME_COPY_SET(@selector(yh_naviTitle), yh_naviTitle);
    self.yh_titleLabel.text = yh_naviTitle;
}
- (NSString *)yh_naviTitle{
    return YH_RUNTIME_GET;
}
//navi title color
- (void)setYh_naviTitleColor:(UIColor *)yh_naviTitleColor{
    YH_RUNTIME_STRONG_SET(@selector(yh_naviTitleColor), yh_naviTitleColor);
    self.yh_titleLabel.textColor = yh_naviTitleColor;
}
- (UIColor *)yh_naviTitleColor{
    return YH_RUNTIME_GET;
}
//navi title font
- (void)setYh_naviTitleFont:(UIFont *)yh_naviTitleFont{
    YH_RUNTIME_STRONG_SET(@selector(yh_naviTitleFont), yh_naviTitleFont);
    self.yh_titleLabel.font = yh_naviTitleFont;
}
- (UIFont *)yh_naviTitleFont{
    return YH_RUNTIME_GET;
}
//navi line color
- (void)setYh_lineColor:(UIColor *)yh_lineColor{
    YH_RUNTIME_STRONG_SET(@selector(yh_lineColor), yh_lineColor);
    self.yh_lineView.backgroundColor = yh_lineColor;
}
- (UIColor *)yh_lineColor{
    return YH_RUNTIME_GET;
}
//is hide navi line
- (void)setYh_isHideLine:(BOOL)yh_isHideLine{
    YH_RUNTIME_ASSIGN_SET(@selector(yh_isHideLine), [NSNumber numberWithBool:yh_isHideLine]);
    self.yh_lineView.hidden = yh_isHideLine;
}
- (BOOL)yh_isHideLine{
    return [YH_RUNTIME_GET boolValue];
}
//navi bg view
- (void)setYh_naviBgView:(UIView *)yh_naviBgView{
    YH_RUNTIME_STRONG_SET(@selector(yh_naviBgView), yh_naviBgView);
}
- (UIView *)yh_naviBgView{
    return YH_RUNTIME_GET;
}
//left button
- (void)setYh_leftButton:(UIButton *)yh_leftButton{
    YH_RUNTIME_STRONG_SET(@selector(yh_leftButton), yh_leftButton);
}
- (UIButton *)yh_leftButton{
    return YH_RUNTIME_GET;
}
//right button
- (void)setYh_rightButton:(UIButton *)yh_rightButton{
    YH_RUNTIME_STRONG_SET(@selector(yh_rightButton), yh_rightButton);
}
- (UIButton *)yh_rightButton{
    return YH_RUNTIME_GET;
}
//title label
- (void)setYh_titleLabel:(UILabel *)yh_titleLabel{
    YH_RUNTIME_STRONG_SET(@selector(yh_titleLabel), yh_titleLabel);
}
- (UILabel *)yh_titleLabel{
    return YH_RUNTIME_GET;
}
//line view
- (void)setYh_lineView:(UIView *)yh_lineView{
    YH_RUNTIME_STRONG_SET(@selector(yh_lineView), yh_lineView);
}
- (UIView *)yh_lineView{
    return YH_RUNTIME_GET;
}



@end












