//
//  YHTransitionManager+Scale.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager+Scale.h"

#import "YHTransitionManager+Public.h"

#import "YHSizeMacro.h"

@implementation YHTransitionManager (Scale)

- (void)scaleShrinkTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    [self addCoverViewWithBaseVC:fromVC];
    [self setCoverViewAlpha:0.0];
    
    toVC.view.transform = CGAffineTransformMakeTranslation(YH_SCREENWIDTH, 0);
    
    fromVC.view.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.transform = CGAffineTransformMakeScale([self getScaleX], [self getScaleY]);
        toVC.view.transform = CGAffineTransformIdentity;
        [self setCoverViewAlpha:0.3];
    } completion:^(BOOL finished) {
        completion ? completion() : nil;
        fromVC.view.transform = CGAffineTransformIdentity;//一定要加这句话，不然返回界面时会出现异常
        [self removeCoverView];
        [self completeTransition:transitionContext];
    }];
}

- (void)scaleLargeTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    [self addCoverViewWithBaseVC:toVC];
    [self setCoverViewAlpha:0.3];
    
    toVC.view.transform = CGAffineTransformMakeScale([self getScaleX], [self getScaleY]);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformMakeTranslation(YH_SCREENWIDTH, 0);
        [self setCoverViewAlpha:0.0];
    } completion:^(BOOL finished) {
        completion ? completion() : nil;
        [self removeCoverView];
        [self completeTransition:transitionContext];
    }];
}
- (CGFloat)getScaleX{
    CGFloat space = 5.f;
    CGFloat scale = (YH_SCREENWIDTH - space * 2) / YH_SCREENWIDTH;
    return scale;
}
- (CGFloat)getScaleY{
    CGFloat space = 20.f;
    CGFloat scale = (YH_SCREENHEIGHT - space * 2) / YH_SCREENHEIGHT;
    return scale;
}
@end
