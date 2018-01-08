//
//  YHDrawerVC.m
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHDrawerVC.h"

@interface YHDrawerVC ()

@end

@implementation YHDrawerVC

+ (YHDrawerVC *)sharedDrawer{
    static YHDrawerVC *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[YHDrawerVC alloc] init];
    });
    return vc;
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
#pragma mark - public methods
/** 重新设置主页的方法 */
- (void)yh_resetMainVC:(UIViewController *)mainVC withAnimationType:(YHDrawerResetMainPageAnimationType)animationType{
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
#pragma mark - private methods
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
@end






















