//
//  YHBaseViewController.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/8.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHBaseViewController.h"

#import "YHSizeMacro.h"
#import "UIImage+YHColorToImage.h"
#import "UIBarButtonItem+YHBarButtonItem.h"
#import "YHBundleMacro.h"

#define YHNaviBackImage [UIImage imageNamed:YHBundleFilePath(@"YHNavigation", @"btn_back_black")] ? : [UIImage imageNamed:YHFrameworkBundleFilePath(@"YHKit_OC", @"YHNavigation", @"btn_back_black")]

@interface YHBaseViewController ()
@property (nonatomic,strong) YHNavigationBar     *yh_navigationBar;
@property (nonatomic,strong) UINavigationItem    *yh_navigationItem;
@end

@implementation YHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNaviBar];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self setNaviFrame];
}
//########################################################################
- (void)setupNaviBar{
    [self.view addSubview:self.yh_navigationBar];
    [self setNaviFrame];
    self.yh_navigationBar.items = @[self.yh_navigationItem];
}
- (void)setNaviFrame{
    CGFloat statusBarHeight = YH_STATUSBARFRAME.size.height;
    CGFloat barH = 44.f;
    CGFloat naviH = barH + statusBarHeight;
    self.yh_navigationBar.frame = CGRectMake(0, 0, YH_SCREENWIDTH, naviH);
}
#pragma mark - public methods
- (void)yh_setupDefaultSystemNaviLeftBackItemWithAction:(SEL)action{
    [self yh_setupDefaultSystemNaviLeftBackItemWithImage:YHNaviBackImage action:action];
}
- (void)yh_setupDefaultSystemNaviLeftBackItemWithImage:(UIImage *)image action:(SEL)action{
    UIBarButtonItem *backItem = [UIBarButtonItem yh_systemItemWithImage:image target:self action:action];
    self.yh_naviLeftBarButtonItem = backItem;
}
#pragma mark - setter
- (void)setYh_barTintColor:(UIColor *)yh_barTintColor{
    _yh_barTintColor = yh_barTintColor;
    self.yh_navigationBar.barTintColor = _yh_barTintColor;
}
- (void)setYh_naviBgColor:(UIColor *)yh_naviBgColor{
    _yh_naviBgColor = yh_naviBgColor;
    [self.yh_navigationBar setBackgroundImage:[UIImage yh_imageWithColor:_yh_naviBgColor] forBarMetrics:UIBarMetricsDefault];
}
- (void)setYh_naviBgImage:(UIImage *)yh_naviBgImage{
    _yh_naviBgImage = yh_naviBgImage;
    [self.yh_navigationBar setBackgroundImage:_yh_naviBgImage forBarMetrics:UIBarMetricsDefault];
}
- (void)setYh_naviShadowColor:(UIColor *)yh_naviShadowColor{
    _yh_naviShadowColor = yh_naviShadowColor;
    self.yh_navigationBar.shadowImage = [UIImage yh_imageWithColor:_yh_naviShadowColor size:CGSizeMake(YH_SCREENWIDTH, 0.5)];
}
- (void)setYh_naviShadowImage:(UIImage *)yh_naviShadowImage{
    _yh_naviShadowImage = yh_naviShadowImage;
    self.yh_navigationBar.shadowImage = _yh_naviShadowImage;
}
- (void)setYh_isHideShadowImage:(BOOL)yh_isHideShadowImage{
    _yh_isHideShadowImage = yh_isHideShadowImage;
    [self.yh_navigationBar layoutIfNeeded];//不加这句的话，在iOS11以上不会有任何效果
    UIView *backgroundView = self.yh_navigationBar.subviews.firstObject;
    for (UIView *view in backgroundView.subviews) {
        if (view.frame.size.height <= 1.0) {
            view.hidden = _yh_isHideShadowImage;
        }
    }
}
- (void)setYh_naviTintColor:(UIColor *)yh_naviTintColor{
    _yh_naviTintColor = yh_naviTintColor;
    self.yh_navigationBar.tintColor = _yh_naviTintColor;
}
- (void)setYh_naviTitle:(NSString *)yh_naviTitle{
    _yh_naviTitle = yh_naviTitle;
    self.yh_navigationItem.title = _yh_naviTitle;
}
- (void)setYh_naviTitleView:(UIView *)yh_naviTitleView{
    _yh_naviTitleView = yh_naviTitleView;
    self.yh_navigationItem.titleView = _yh_naviTitleView;
}
- (void)setYh_naviTitleColor:(UIColor *)yh_naviTitleColor{
    _yh_naviTitleColor = yh_naviTitleColor;
    self.yh_navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:_yh_naviTitleColor};
}
- (void)setYh_naviTitleFont:(UIFont *)yh_naviTitleFont{
    _yh_naviTitleFont = yh_naviTitleFont;
    self.yh_navigationBar.titleTextAttributes = @{NSFontAttributeName:_yh_naviTitleFont};
}
- (void)setYh_naviLeftBarButtonItem:(UIBarButtonItem *)yh_naviLeftBarButtonItem{
    _yh_naviLeftBarButtonItem = yh_naviLeftBarButtonItem;
    self.yh_naviLeftBarButtonItems = @[_yh_naviLeftBarButtonItem];
}
- (void)setYh_naviLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)yh_naviLeftBarButtonItems{
    _yh_naviLeftBarButtonItems = yh_naviLeftBarButtonItems;
    self.yh_navigationItem.leftBarButtonItems = _yh_naviLeftBarButtonItems;
}
- (void)setYh_naviRightBarButtonItem:(UIBarButtonItem *)yh_naviRightBarButtonItem{
    _yh_naviRightBarButtonItem = yh_naviRightBarButtonItem;
    self.yh_naviRightBarButtonItems = @[_yh_naviRightBarButtonItem];
}
- (void)setYh_naviRightBarButtonItems:(NSArray<UIBarButtonItem *> *)yh_naviRightBarButtonItems{
    _yh_naviRightBarButtonItems = yh_naviRightBarButtonItems;
    self.yh_navigationItem.rightBarButtonItems = _yh_naviRightBarButtonItems;
}
#pragma mark - getter
- (YHNavigationBar *)yh_navigationBar{
    if (!_yh_navigationBar) {
        _yh_navigationBar = [[YHNavigationBar alloc] initWithFrame:CGRectZero];
    }
    return _yh_navigationBar;
}
- (UINavigationItem *)yh_navigationItem{
    if (!_yh_navigationItem) {
        _yh_navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
    }
    return _yh_navigationItem;
}

@end

