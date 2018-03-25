//
//  UIViewController+YHTransition.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "UIViewController+YHTransition.h"

#import "YHDebugMacro.h"
#import "YHRuntimeMacro.h"
#import "YHOtherMacro.h"

#import "YHDrivenInteractiveTransition.h"

char *kYHToInteractiveKey = "kYHToInteractiveKey";
char *kYHBackInteractiveKey = "kYHBackInteractiveKey";


@interface UIViewController()

@end

@implementation UIViewController (YHTransition)
#pragma mark - PUSH
- (void)yh_pushViewController:(UIViewController *)viewController
               makeTransition:(TransitionMakeBlcok)transitionBlock
                     animated:(BOOL)animated
                   completion:(TransitionCompletionBlock)completion{
    if (!viewController) {
        return;
    }
    if (!self.navigationController) {
        return;
    }
    YHTransitionManager *transition = [[YHTransitionManager alloc] init];
    if (transitionBlock) {
        transitionBlock(transition);
    }
    if (completion) {
        transition.completionBlock = completion;
    }
    YHDrivenInteractiveTransition *toInteractive = objc_getAssociatedObject(self, &kYHToInteractiveKey);
    if (toInteractive) {
        [transition setValue:toInteractive forKey:@"toInteractive"];
    }
    self.navigationController.delegate = transition;
    [self.navigationController pushViewController:viewController animated:animated];
}

#pragma mark - POP
- (void)yh_popViewControllerWithMakeTransition:(TransitionMakeBlcok)transitionBlock
                                      animated:(BOOL)animated
                                    completion:(TransitionCompletionBlock)completion{
    if (!self.navigationController) {
        return;
    }
    YHTransitionManager *transition = [[YHTransitionManager alloc] init];
    if (transitionBlock) {
        transitionBlock(transition);
    }
    if (completion) {
        transition.completionBlock = completion;
    }
    YHDrivenInteractiveTransition *backInteractive = objc_getAssociatedObject(self, &kYHBackInteractiveKey);
    if (backInteractive) {
        [transition setValue:backInteractive forKey:@"backInteractive"];
    }
    
    self.navigationController.delegate = transition;
    [self.navigationController popViewControllerAnimated:animated];
}
#pragma mark - present
- (void)yh_presentViewController:(UIViewController *)viewController makeTransition:(TransitionMakeBlcok)transitionBlock animated:(BOOL)animated completion:(TransitionCompletionBlock)completion{
    if (self.presentedViewController) {
        return;
    }
    YHTransitionManager *transition = [[YHTransitionManager alloc] init];
    if (transitionBlock) {
        transitionBlock(transition);
    }
    if (completion) {
        transition.completionBlock = completion;
    }
    YHDrivenInteractiveTransition *toInteractive = objc_getAssociatedObject(self, &kYHToInteractiveKey);
    if (toInteractive) {
        [transition setValue:toInteractive forKey:@"toInteractive"];
    }
    viewController.transitioningDelegate = transition;
    [self presentViewController:viewController animated:animated completion:nil];
}
#pragma mark - dismiss
- (void)yh_dismissViewControllerWithMakeTransition:(TransitionMakeBlcok)transitionBlock animated:(BOOL)animated completion:(TransitionCompletionBlock)completion{
    if (!self.presentingViewController) {
        return;
    }
    YHTransitionManager *transition = [[YHTransitionManager alloc] init];
    if (transitionBlock) {
        transitionBlock(transition);
    }
    if (completion) {
        transition.completionBlock = completion;
    }
    YHDrivenInteractiveTransition *backInteractive = objc_getAssociatedObject(self, &kYHBackInteractiveKey);
    if (backInteractive) {
        [transition setValue:backInteractive forKey:@"backInteractive"];
    }
    
    self.transitioningDelegate = transition;
    [self dismissViewControllerAnimated:animated completion:nil];
}
#pragma mark - 注册入场手势
- (void)yh_registerToInteractiveTransitionWithGestureDirection:(YHPanGestureDirection)gestureDirection
                                               interactiveType:(YHInteractiveType)interactiveType
                                    transitionInteractiveBlock:(TransitionInteractiveBlock)transitionInteractiveBlock makeTransition:(TransitionMakeBlcok)transitionBlock
                               transitionInteractiveBeginBlock:(TransitionInteractiveBeginBlock)transitionInteractiveBeginBlock completion:(TransitionCompletionBlock)completion{
    YH_WeakSelf(weakSelf);
    void (^eventBlock)(void) = ^{
        UIViewController *toVC = transitionInteractiveBlock();
        if (interactiveType == YHInteractiveTypePushPop) {
            [weakSelf yh_pushViewController:toVC makeTransition:transitionBlock animated:YES completion:completion];
        } else if (interactiveType == YHInteractiveTypePresentDismiss) {
            [weakSelf yh_presentViewController:toVC makeTransition:transitionBlock animated:YES completion:completion];
        }
    };
    YHDrivenInteractiveTransition *interactive = [[YHDrivenInteractiveTransition alloc] initWithDirection:gestureDirection eventBlock:eventBlock In:self.view interactiveBeginBlock:transitionInteractiveBeginBlock];
    objc_setAssociatedObject(self, &kYHToInteractiveKey, interactive, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - 注册返回手势
- (void)yh_registerBackInteractiveTransitionWithGestureDirection:(YHPanGestureDirection)gestureDirection
                                                 interactiveType:(YHInteractiveType)interactiveType
                                                  makeTransition:(TransitionMakeBlcok)transitionBlock
                                 transitionInteractiveBeginBlock:(TransitionInteractiveBeginBlock)transitionInteractiveBeginBlock
                                                      completion:(TransitionCompletionBlock)completion{
    YH_WeakSelf(weakSelf);
    void (^eventBlock)(void) = ^{
        if (interactiveType == YHInteractiveTypePushPop) {
            [weakSelf yh_popViewControllerWithMakeTransition:transitionBlock animated:YES completion:completion];
        } else if (interactiveType == YHInteractiveTypePresentDismiss) {
            [weakSelf yh_dismissViewControllerWithMakeTransition:transitionBlock animated:YES completion:completion];
        }
    };
    YHDrivenInteractiveTransition *interactive = [[YHDrivenInteractiveTransition alloc] initWithDirection:gestureDirection eventBlock:eventBlock In:self.view interactiveBeginBlock:transitionInteractiveBeginBlock];
    objc_setAssociatedObject(self, &kYHBackInteractiveKey, interactive, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
