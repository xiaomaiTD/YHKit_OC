//
//  YHTransitionManager+KuGou.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager+KuGou.h"

#import "YHSizeMacro.h"
#import "YHOtherMacro.h"
#import "UIView+YHViewExtension.h"

#import "YHTransitionManager+Public.h"


@implementation YHTransitionManager (KuGou)
- (void)kuGouPushTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    [self addCoverViewWithBaseVC:fromVC];
    [self setCoverViewAlpha:0.0];
    
    fromVC.view.frame = CGRectMake(0, 0, YH_SCREENWIDTH, YH_SCREENHEIGHT);
    
    //顺序不要弄反了
    CGFloat angle = atan(YH_SCREENWIDTH/2/YH_SCREENHEIGHT)*2;
    toVC.view.layer.anchorPoint = CGPointMake(0.5, 2.0);
    toVC.view.frame = CGRectMake(0, 0, YH_SCREENWIDTH, YH_SCREENHEIGHT);
    toVC.view.transform =CGAffineTransformMakeRotation(angle);
   
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        [self setCoverViewAlpha:0.3];
    } completion:^(BOOL finished) {
        completion ? completion() : nil;
        toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toVC.view.frame = CGRectMake(0, 0, YH_SCREENWIDTH, YH_SCREENHEIGHT);
        fromVC.view.transform = CGAffineTransformIdentity;
        toVC.view.transform = CGAffineTransformIdentity;
        [self removeCoverView];
        [self completeTransition:transitionContext];
    }];
}
- (void)kuGouPopTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    [self addCoverViewWithBaseVC:toVC];
    [self setCoverViewAlpha:0.3];
    
    //顺序不要弄反了
    CGFloat angle = atan(YH_SCREENWIDTH/2/YH_SCREENHEIGHT)*2;
    fromVC.view.layer.anchorPoint = CGPointMake(0.5, 2.0);
    fromVC.view.frame = CGRectMake(0, 0, YH_SCREENWIDTH, YH_SCREENHEIGHT);
    
    // delay:0 options:UIViewAnimationOptionCurveEaseInOut
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeRotation(angle);
        [self setCoverViewAlpha:0.0];
    } completion:^(BOOL finished) {
        completion ? completion() : nil;
        fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromVC.view.frame = CGRectMake(0, 0, YH_SCREENWIDTH, YH_SCREENHEIGHT);
        fromVC.view.transform = CGAffineTransformIdentity;
        toVC.view.transform = CGAffineTransformIdentity;
        [self removeCoverView];
        [self completeTransition:transitionContext];
    }];
}
@end












