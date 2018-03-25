//
//  YHDrawerVC.m
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHDrawerVC.h"

#define kAnimationDuration   0.3
#define kMainCoverAlpha      0.3
#define kMainCoverViewColor(alpha)   [[UIColor blackColor] colorWithAlphaComponent:alpha]

@interface YHDrawerVC ()
@property (nonatomic,assign) BOOL        isOpenLeftMenu;
@property (nonatomic,assign) BOOL        isOpenRightMenu;

@property (nonatomic,assign) BOOL        isCompleteOpenMenu;
@property (nonatomic,strong) UIView      * mainCoverView;
@property (nonatomic,strong) UIView      * leftMenuCoverView;
@property (nonatomic,strong) UIView      * rightMenuCoverView;

@end

@implementation YHDrawerVC

+ (YHDrawerVC *)sharedDrawer{
    static YHDrawerVC *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[YHDrawerVC alloc] init];
        vc.isCompleteOpenMenu = NO;
        vc.isOpenLeftMenu = NO;
    });
    return vc;
}
+ (YHDrawerNavi *)getAppDelegateRootVCWith:(YHDrawerVC *)drawerVC{
    YHDrawerNavi *navi = [[YHDrawerNavi alloc] initWithRootViewController:drawerVC];
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self add:self.mainVC];
}
- (void)add:(UIViewController *)vc{
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}
- (void)remove:(UIViewController *)vc{
    [vc removeFromParentViewController];
    [vc.view removeFromSuperview];
    vc = nil;
}




#pragma mark - 重设mainVC
/** 重新设置主页的方法 */
- (void)resetMainVC:(UIViewController *)mainVC withAnimationType:(YHDrawerResetMainPageAnimationType)animationType{
    switch (animationType) {
        case YHDrawerResetMainPageAnimationTypeRotationY:
        {
            [self resetMainPageRotationYAnimationWithMainVC:mainVC];
        }
            break;
        case YHDrawerResetMainPageAnimationNone:
        {
            [self resetMainPageAnimationNoneWithMainVC:mainVC];
        }
            break;
        default:
            break;
    }
}
- (void)resetMainPageRotationYAnimationWithMainVC:(UIViewController *)mainVC{
    [UIView animateWithDuration:0.09 animations:^{
        self.mainVC.view.layer.transform = CATransform3DMakeRotation(M_PI/2, 0, 1, 0);
    } completion:^(BOOL finished) {
        
        [self remove:self.mainVC];
        self.mainVC = mainVC;
        [self add:self.mainVC];
        
        self.mainVC.view.layer.transform = CATransform3DMakeRotation(-M_PI/2, 0, 1, 0);
        [UIView animateWithDuration:0.09 animations:^{
            self.mainVC.view.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
        } completion:nil];
    }];
}
- (void)resetMainPageAnimationNoneWithMainVC:(UIViewController *)mainVC{
    [self remove:self.mainVC];
    self.mainVC = mainVC;
    [self add:self.mainVC];
}
#pragma mark - ----
- (void)completeCloseDrawer{
    [self.leftMenuCoverView removeFromSuperview];
    [self.rightMenuCoverView removeFromSuperview];
    [self.mainCoverView removeFromSuperview];
    [self.leftMenuVC removeFromParentViewController];
    [self.leftMenuVC.view removeFromSuperview];
    [self.rightMenuVC removeFromParentViewController];
    [self.rightMenuVC.view removeFromSuperview];
    self.leftMenuCoverView = nil;
    self.rightMenuCoverView = nil;
    self.mainCoverView = nil;
    self.isOpenLeftMenu = NO;
    self.isOpenRightMenu = NO;
    self.isCompleteOpenMenu = NO;
    self.closeDrawerCompleteBlock ? self.closeDrawerCompleteBlock() : nil;
}
#pragma mark - 打开左抽屉
- (void)openLeftMenu{
    if (!self.leftMenuVC) {
        return;
    }
    [self addChildViewController:self.leftMenuVC];
    [self.leftMenuVC willMoveToParentViewController:self];
    [self.leftMenuVC didMoveToParentViewController:self];
    [self.mainVC.view addSubview:self.mainCoverView];
    switch (self.openLeftMenuAnimationType) {
        case YHDrawerOpenMenuAnimationType1:
        {
            [self openLeftMenuWithAnimationType1];
        }
            break;
        case YHDrawerOpenMenuAnimationType2:
        {
            [self openLeftMenuWithAnimationType2];
        }
            break;
        default:
            break;
    }
}
- (void)openLeftMenuWithAnimationType1{
    [self.view insertSubview:self.leftMenuVC.view atIndex:0];
    [self.leftMenuVC.view addSubview:self.leftMenuCoverView];
    self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
    self.isCompleteOpenMenu = NO;
    self.isOpenLeftMenu = YES;
    self.isOpenRightMenu = NO;
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftMenuWidth, 0);
        self.mainCoverView.backgroundColor = kMainCoverViewColor(kMainCoverAlpha);
    } completion:^(BOOL finished) {
        [self.leftMenuCoverView removeFromSuperview];
        self.isCompleteOpenMenu = YES;
    }];
}
- (void)openLeftMenuWithAnimationType2{
    [self.view insertSubview:self.leftMenuVC.view atIndex:0];
    [self.leftMenuVC.view addSubview:self.leftMenuCoverView];
    self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
    self.isCompleteOpenMenu = NO;
    self.isOpenLeftMenu = YES;
    self.isOpenRightMenu = NO;
    
    CGFloat menuOffsetX = self.leftMenuWidth/2;
    
    self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-menuOffsetX, 0);
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftMenuWidth, 0);
        self.mainCoverView.backgroundColor = kMainCoverViewColor(kMainCoverAlpha);
        self.leftMenuVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.leftMenuCoverView removeFromSuperview];
        self.isCompleteOpenMenu = YES;
    }];
}
#pragma mark - 关闭左抽屉
- (void)closeLeftMenu{
    switch (self.openLeftMenuAnimationType) {
        case YHDrawerOpenMenuAnimationType1:
        {
            [self closeLeftMenuWithAnimationType1];
        }
            break;
        case YHDrawerOpenMenuAnimationType2:
        {
            [self closeLeftMenuWithAnimationType2];
        }
            break;
        default:
            break;
    }
}
- (void)closeLeftMenuWithAnimationType1{
    [self.leftMenuVC.view addSubview:self.leftMenuCoverView];
    self.isCompleteOpenMenu = NO;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
        self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
    } completion:^(BOOL finished) {
        [self completeCloseDrawer];
    }];
}
- (void)closeLeftMenuWithAnimationType2{
    [self.leftMenuVC.view addSubview:self.leftMenuCoverView];
    self.isCompleteOpenMenu = NO;
    
    CGFloat menuOffsetX = self.leftMenuWidth/2;
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
        self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-menuOffsetX, 0);
        self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
    } completion:^(BOOL finished) {
        [self completeCloseDrawer];
    }];
}
#pragma mark - 打开右抽屉
- (void)openRightMenu{
    if (!self.rightMenuVC) {
        return;
    }
    [self addChildViewController:self.rightMenuVC];
    [self.rightMenuVC willMoveToParentViewController:self];
    [self.rightMenuVC didMoveToParentViewController:self];
    [self.mainVC.view addSubview:self.mainCoverView];
    switch (self.openRightMenuAnimationType) {
        case YHDrawerOpenMenuAnimationType1:
        {
            [self openRightMenuWithAnimationType1];
        }
            break;
        case YHDrawerOpenMenuAnimationType2:
        {
            [self openRightMenuWithAnimationType2];
        }
            break;
        default:
            break;
    }
}
- (void)openRightMenuWithAnimationType1{
    [self.view insertSubview:self.rightMenuVC.view atIndex:0];
    [self.rightMenuVC.view addSubview:self.rightMenuCoverView];
    self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
    self.isCompleteOpenMenu = NO;
    self.isOpenLeftMenu = NO;
    self.isOpenRightMenu = YES;
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(-self.rightMenuWidth, 0);
        self.mainCoverView.backgroundColor = kMainCoverViewColor(kMainCoverAlpha);
    } completion:^(BOOL finished) {
        [self.rightMenuCoverView removeFromSuperview];
        self.isCompleteOpenMenu = YES;
    }];
}
- (void)openRightMenuWithAnimationType2{
    [self.view insertSubview:self.rightMenuVC.view atIndex:0];
    [self.rightMenuVC.view addSubview:self.rightMenuCoverView];
    self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
    self.isCompleteOpenMenu = NO;
    self.isOpenLeftMenu = NO;
    self.isOpenRightMenu = YES;
    
    CGFloat menuOffsetX = self.rightMenuWidth/2;
    
    self.rightMenuVC.view.transform = CGAffineTransformMakeTranslation(menuOffsetX, 0);
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(-self.rightMenuWidth, 0);
        self.mainCoverView.backgroundColor = kMainCoverViewColor(kMainCoverAlpha);
        self.rightMenuVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.rightMenuCoverView removeFromSuperview];
        self.isCompleteOpenMenu = YES;
    }];
}
#pragma mark - 关闭右抽屉
- (void)closeRightMenu{
    switch (self.openRightMenuAnimationType) {
        case YHDrawerOpenMenuAnimationType1:
        {
            [self closeRightMenuWithAnimationType1];
        }
            break;
        case YHDrawerOpenMenuAnimationType2:
        {
            [self closeRightMenuWithAnimationType2];
        }
            break;
        default:
            break;
    }
}
- (void)closeRightMenuWithAnimationType1{
    [self.rightMenuVC.view addSubview:self.rightMenuCoverView];
    self.isCompleteOpenMenu = NO;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
        self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
    } completion:^(BOOL finished) {
        [self completeCloseDrawer];
    }];
}
- (void)closeRightMenuWithAnimationType2{
    [self.rightMenuVC.view addSubview:self.rightMenuCoverView];
    self.isCompleteOpenMenu = NO;
    
    CGFloat menuOffsetX = self.rightMenuWidth/2;
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainVC.view.transform = CGAffineTransformIdentity;
        self.rightMenuVC.view.transform = CGAffineTransformMakeTranslation(menuOffsetX, 0);
        self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
    } completion:^(BOOL finished) {
        [self completeCloseDrawer];
    }];
}
#pragma mark - mainCover tap
- (void)mainCoverViewTap:(UITapGestureRecognizer *)gesture{
    if ((self.isCompleteOpenMenu && self.isOpenLeftMenu) || (self.isCompleteOpenMenu && self.isOpenRightMenu)) {
        //抽屉完全打开完毕，才能轻拍关闭抽屉
        if (self.isOpenLeftMenu) {
            [self closeLeftMenu];
        }
        if (self.isOpenRightMenu) {
            [self closeRightMenu];
        }
    }
}
#pragma mark - mainCover pan
- (void)mainCoverViewPan:(UIPanGestureRecognizer *)gesture{
    if (self.isOpenLeftMenu && self.isCompleteOpenMenu) {
        //左抽屉完全打开了，才能左滑关闭抽屉
        [self panForLeft:gesture];
    } else if (self.isOpenRightMenu && self.isCompleteOpenMenu) {
        //右抽屉完全打开了，才能右滑关闭抽屉
        [self panForRight:gesture];
    }
}
- (void)panForLeft:(UIPanGestureRecognizer *)gesture{
    CGFloat panOffSetX = [gesture translationInView:gesture.view].x;
    CGFloat velocityX = [gesture velocityInView:gesture.view].x;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (panOffSetX > 0) {
            return;
        }
        [self.leftMenuVC.view addSubview:self.leftMenuCoverView];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        if (panOffSetX >= 0) {
            panOffSetX = 0;
        }
        if (panOffSetX < -self.leftMenuWidth) {
            panOffSetX = -self.leftMenuWidth;
        }
        CGFloat mainCoverChangeAlpha = (1 - ABS(panOffSetX) / self.leftMenuWidth) * kMainCoverAlpha;
        if (mainCoverChangeAlpha > 1) {
            mainCoverChangeAlpha = 1;
        }
        self.mainCoverView.backgroundColor = kMainCoverViewColor(mainCoverChangeAlpha);
        switch (self.openLeftMenuAnimationType) {
            case YHDrawerOpenMenuAnimationType1:
            {
                self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftMenuWidth + panOffSetX, 0);//panOffSetX小于0
            }
                break;
            case YHDrawerOpenMenuAnimationType2:
            {
                self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftMenuWidth + panOffSetX, 0);//panOffSetX小于0
                CGFloat menuOffsetX = self.leftMenuWidth/2 * (ABS(panOffSetX) / self.leftMenuWidth);
                self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-menuOffsetX, 0);
            }
                break;
            default:
                break;
        }
        if (panOffSetX == -self.leftMenuWidth) {
            [self completeCloseDrawer];
        }
    } else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
        NSTimeInterval duration = (1 - ABS(panOffSetX) / self.leftMenuWidth) * kAnimationDuration;
        if (ABS(panOffSetX) >= self.leftMenuWidth/2 || (ABS(velocityX) >= 10 && velocityX <=0)) {
            //关闭
            switch (self.openLeftMenuAnimationType) {
                case YHDrawerOpenMenuAnimationType1:
                {
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.mainVC.view.transform = CGAffineTransformIdentity;
                        self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
                    } completion:^(BOOL finished) {
                        [self completeCloseDrawer];
                    }];
                }
                    break;
                case YHDrawerOpenMenuAnimationType2:
                {
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.mainVC.view.transform = CGAffineTransformIdentity;
                        self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
                        self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.leftMenuWidth/2, 0);
                    } completion:^(BOOL finished) {
                        [self completeCloseDrawer];
                    }];
                }
                    break;
                default:
                    break;
            }
            
        } else {
            //不关闭
            switch (self.openLeftMenuAnimationType) {
                case YHDrawerOpenMenuAnimationType1:
                {
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftMenuWidth, 0);
                        self.mainCoverView.backgroundColor = kMainCoverViewColor(kMainCoverAlpha);
                    } completion:^(BOOL finished) {
                        [self.leftMenuCoverView removeFromSuperview];
                    }];
                }
                    break;
                case YHDrawerOpenMenuAnimationType2:
                {
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.leftMenuWidth, 0);
                        self.mainCoverView.backgroundColor = kMainCoverViewColor(kMainCoverAlpha);
                        self.leftMenuVC.view.transform = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        [self.leftMenuCoverView removeFromSuperview];
                    }];
                }
                    break;
                default:
                    break;
            }
        }
    }
}
- (void)panForRight:(UIPanGestureRecognizer *)gesture{
    CGFloat panOffSetX = [gesture translationInView:gesture.view].x;
    CGFloat velocityX = [gesture velocityInView:gesture.view].x;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (panOffSetX < 0) {
            return;
        }
        [self.rightMenuVC.view addSubview:self.rightMenuCoverView];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        if (panOffSetX <= 0) {
            panOffSetX = 0;
        }
        if (panOffSetX > self.rightMenuWidth) {
            panOffSetX = self.rightMenuWidth;
        }
        CGFloat mainCoverChangeAlpha = (1 - ABS(panOffSetX) / self.rightMenuWidth) * kMainCoverAlpha;
        if (mainCoverChangeAlpha > 1) {
            mainCoverChangeAlpha = 1;
        }
        self.mainCoverView.backgroundColor = kMainCoverViewColor(mainCoverChangeAlpha);
        switch (self.openRightMenuAnimationType) {
            case YHDrawerOpenMenuAnimationType1:
            {
                self.mainVC.view.transform = CGAffineTransformMakeTranslation(-(self.rightMenuWidth - panOffSetX), 0);//panOffSetX大于0
            }
                break;
            case YHDrawerOpenMenuAnimationType2:
            {
                self.mainVC.view.transform = CGAffineTransformMakeTranslation(-(self.rightMenuWidth - panOffSetX), 0);//panOffSetX大于0
                CGFloat menuOffsetX = self.rightMenuWidth/2 * (ABS(panOffSetX) / self.rightMenuWidth);
                self.rightMenuVC.view.transform = CGAffineTransformMakeTranslation(menuOffsetX, 0);
            }
                break;
            default:
                break;
        }
        if (panOffSetX == -self.rightMenuWidth) {
            [self completeCloseDrawer];
        }
    } else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
        NSTimeInterval duration = (1 - ABS(panOffSetX) / self.rightMenuWidth) * kAnimationDuration;
        if (ABS(panOffSetX) >= self.rightMenuWidth/2 || (ABS(velocityX) >= 10 && velocityX >= 0)) {
            //关闭
            switch (self.openRightMenuAnimationType) {
                case YHDrawerOpenMenuAnimationType1:
                {
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.mainVC.view.transform = CGAffineTransformIdentity;
                        self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
                    } completion:^(BOOL finished) {
                        [self completeCloseDrawer];
                    }];
                }
                    break;
                case YHDrawerOpenMenuAnimationType2:
                {
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.mainVC.view.transform = CGAffineTransformIdentity;
                        self.mainCoverView.backgroundColor = kMainCoverViewColor(0);
                        self.rightMenuVC.view.transform = CGAffineTransformMakeTranslation(self.rightMenuWidth/2, 0);
                    } completion:^(BOOL finished) {
                        [self completeCloseDrawer];
                    }];
                }
                    break;
                default:
                    break;
            }
            
        } else {
            //不关闭
            switch (self.openRightMenuAnimationType) {
                case YHDrawerOpenMenuAnimationType1:
                {
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.mainVC.view.transform = CGAffineTransformMakeTranslation(-self.rightMenuWidth, 0);
                        self.mainCoverView.backgroundColor = kMainCoverViewColor(kMainCoverAlpha);
                    } completion:^(BOOL finished) {
                        [self.rightMenuCoverView removeFromSuperview];
                    }];
                }
                    break;
                case YHDrawerOpenMenuAnimationType2:
                {
                    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.mainVC.view.transform = CGAffineTransformMakeTranslation(-self.rightMenuWidth, 0);
                        self.mainCoverView.backgroundColor = kMainCoverViewColor(kMainCoverAlpha);
                        self.rightMenuVC.view.transform = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        [self.rightMenuCoverView removeFromSuperview];
                    }];
                }
                    break;
                default:
                    break;
            }
        }
    }
}
#pragma mark - ------
- (void)pushToVC:(UIViewController *)vc isCloseDrawer:(BOOL)isCloseDrawer{
    if (self.isOpenLeftMenu) {
        [self closeLeftMenu];
    }
    if (self.isOpenRightMenu) {
        [self closeRightMenu];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - setter
- (void)setDrawerColor:(UIColor *)drawerColor{
    _drawerColor = drawerColor;
    self.view.backgroundColor = _drawerColor;
}
#pragma mark - getter
- (UIView *)mainCoverView{
    if (!_mainCoverView) {
        _mainCoverView = [[UIView alloc] initWithFrame:self.mainVC.view.bounds];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainCoverViewTap:)];
        [_mainCoverView addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mainCoverViewPan:)];
        [_mainCoverView addGestureRecognizer:panGesture];
    }
    return _mainCoverView;
}
- (UIView *)leftMenuCoverView{
    if (!_leftMenuCoverView) {
        _leftMenuCoverView = [[UIView alloc] initWithFrame:self.leftMenuVC.view.bounds];
    }
    return _leftMenuCoverView;
}
- (UIView *)rightMenuCoverView{
    if (!_rightMenuCoverView) {
        _rightMenuCoverView = [[UIView alloc] initWithFrame:self.rightMenuVC.view.bounds];
    }
    return _rightMenuCoverView;
}
@end




@implementation YHDrawerNavi
- (void)viewDidLoad{
    [self setNavigationBarHidden:YES];
}
@end

















