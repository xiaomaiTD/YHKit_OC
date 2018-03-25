//
//  YHTransitionManager+Public.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager+Public.h"

#import "YHRuntimeMacro.h"

@implementation YHTransitionManager (Public)
- (void)completeTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    fromVC.navigationController.delegate = nil;
    toVC.navigationController.delegate = nil;
    fromVC.transitioningDelegate = nil;
    toVC.transitioningDelegate = nil;
    BOOL wasCancelled = [transitionContext transitionWasCancelled];
    [transitionContext completeTransition:!wasCancelled];
}
- (void)addCoverViewWithBaseVC:(UIViewController *)baseVC{
    if (self.isAddCoverView) {
        self.coverView = [[UIView alloc] initWithFrame:baseVC.view.bounds];
        [baseVC.view addSubview:self.coverView];
    }
}
- (void)setCoverViewAlpha:(CGFloat)alpha{
    if (self.isAddCoverView) {
        self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    }
}
- (void)removeCoverView{
    if (self.isAddCoverView) {
        [self.coverView removeFromSuperview];
    }
}
#pragma mark - ++++++++++
- (UIView *)coverView{
    return YH_RUNTIME_GET;
}
- (void)setCoverView:(UIView *)coverView{
    YH_RUNTIME_STRONG_SET(@selector(coverView), coverView);
}
@end
