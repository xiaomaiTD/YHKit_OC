//
//  YHTransitionManager+System.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager+System.h"

#import "YHSizeMacro.h"

#import "YHTransitionManager+Public.h"

@implementation YHTransitionManager (SystemPush)
- (void)systemPushTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion{
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
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformMakeTranslation(-YH_SCREENWIDTH/5, 0);
        [self setCoverViewAlpha:0.3];
    } completion:^(BOOL finished) {
        completion ? completion() : nil;
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
        [self removeCoverView];
        [self completeTransition:transitionContext];
    }];
}
- (void)systemPopTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    [self addCoverViewWithBaseVC:toVC];
    [self setCoverViewAlpha:0.3];
    
    toVC.view.transform = CGAffineTransformMakeTranslation(-YH_SCREENWIDTH/2, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformMakeTranslation(YH_SCREENWIDTH, 0);
        [self setCoverViewAlpha:0.0];
    } completion:^(BOOL finished) {
        completion ? completion() : nil;
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
        [self removeCoverView];
        [self completeTransition:transitionContext];
    }];
}


- (void)systemPresentTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    [self addCoverViewWithBaseVC:fromVC];
    [self setCoverViewAlpha:0.0];
    
    toVC.view.transform = CGAffineTransformMakeTranslation(0, YH_SCREENHEIGHT);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        [self setCoverViewAlpha:0.3];
    } completion:^(BOOL finished) {
        completion ? completion() : nil;
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
        [self removeCoverView];
        [self completeTransition:transitionContext];
    }];
}
- (void)systemDismissTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    [self addCoverViewWithBaseVC:toVC];
    [self setCoverViewAlpha:0.3];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation(0, YH_SCREENHEIGHT);
        [self setCoverViewAlpha:0.0];
    } completion:^(BOOL finished) {
        completion ? completion() : nil;
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;
        [self removeCoverView];
        [self completeTransition:transitionContext];
    }];
}
@end
