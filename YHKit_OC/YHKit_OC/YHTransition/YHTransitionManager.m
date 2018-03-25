//
//  YHTransitionManager.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager.h"

#import "YHDebugMacro.h"
#import "YHSizeMacro.h"

#import "YHDrivenInteractiveTransition.h"

#import "YHTransitionManager+System.h"
#import "YHTransitionManager+Scale.h"
#import "YHTransitionManager+KuGou.h"
#import "YHTransitionManager+MiddlePage.h"


@interface YHTransitionManager() {
    UINavigationControllerOperation _operation;
}
@property (nonatomic,strong) YHDrivenInteractiveTransition *toInteractive;
@property (nonatomic,strong) YHDrivenInteractiveTransition *backInteractive;

@end


@implementation YHTransitionManager
- (void)dealloc{
    YHLog(@"%@ dealloc",self);
}
#pragma mark - init
- (instancetype)init{
    self = [super init];
    if (self) {
        self.animationDuration = 0.25;
        self.isAddCoverView = YES;
        self.animationType = YHTransitionAnimationTypeUnknown;
        
        self.completionBlock = nil;
    }
    return self;
}
#pragma mark - UINavigationControllerDelegate
//非手势交互 - push or pop
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    if (operation == UINavigationControllerOperationPush || operation == UINavigationControllerOperationPop) {
        return self;
    }
    return nil;
}
//手势交互 - push or pop
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (_operation == UINavigationControllerOperationPush) {
        return self.toInteractive.isPanGestureInteration ? self.toInteractive : nil;
    } else if (_operation == UINavigationControllerOperationPop){
        return self.backInteractive.isPanGestureInteration ? self.backInteractive : nil;
    }
    return nil;
}
#pragma mark - UIViewControllerTransitioningDelegate
//非手势交互 - present
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}
//非手势交互 - dismiss
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}
//手势交互 - present
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.toInteractive.isPanGestureInteration ? self.toInteractive : nil;
}
//手势交互 - dismiss
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.backInteractive.isPanGestureInteration ? self.backInteractive : nil;
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.animationDuration;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (self.animationType) {
        case YHTransitionAnimationTypeSystemPush:
        {
            [self systemPushTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeSystemPop:
        {
            [self systemPopTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeSystemPresent:
        {
            [self systemPresentTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeSystemDismiss:
        {
            [self systemDismissTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeScaleEnlarge:
        {
            [self scaleLargeTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeScaleShrink:
        {
            [self scaleShrinkTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeKuGouPush:
        {
            [self kuGouPushTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeKuGouPop:
        {
            [self kuGouPopTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeMiddlePagePush:
        {
            [self middlePagePushTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        case YHTransitionAnimationTypeMiddlePagePop:
        {
            [self middlePagePopTransitionWithTransitionContext:transitionContext completion:self.completionBlock];
        }
            break;
        default:
            break;
    }
}
@end
