//
//  UIViewController+YHTransition.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YHTransitionConfig.h"
#import "YHTransitionManager.h"

NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (YHTransition)

/** PUSH */
- (void)yh_pushViewController:(UIViewController *)viewController
               makeTransition:(nullable TransitionMakeBlcok)transitionBlock
                     animated:(BOOL)animated
                   completion:(nullable TransitionCompletionBlock)completion;
/** POP */
- (void)yh_popViewControllerWithMakeTransition:(nullable TransitionMakeBlcok)transitionBlock
                                      animated:(BOOL)animated
                                    completion:(nullable TransitionCompletionBlock)completion;
/** PRESENT */
- (void)yh_presentViewController:(UIViewController *)viewController
                  makeTransition:(nullable TransitionMakeBlcok)transitionBlock
                        animated:(BOOL)animated
                      completion:(nullable TransitionCompletionBlock)completion;
/** DISMISS */
- (void)yh_dismissViewControllerWithMakeTransition:(nullable TransitionMakeBlcok)transitionBlock
                                          animated:(BOOL)animated
                                        completion:(nullable TransitionCompletionBlock)completion;
/** 注册入场手势 */
- (void)yh_registerToInteractiveTransitionWithGestureDirection:(YHPanGestureDirection)gestureDirection
                                               interactiveType:(YHInteractiveType)interactiveType
                                    transitionInteractiveBlock:(TransitionInteractiveBlock)transitionInteractiveBlock
                                                makeTransition:(nullable TransitionMakeBlcok)transitionBlock
                                                    transitionInteractiveBeginBlock:(nullable TransitionInteractiveBeginBlock)transitionInteractiveBeginBlock
                                                    completion:(nullable TransitionCompletionBlock)completion;

/** 注册返回手势 */
- (void)yh_registerBackInteractiveTransitionWithGestureDirection:(YHPanGestureDirection)gestureDirection
                                                 interactiveType:(YHInteractiveType)interactiveType
                                                  makeTransition:(nullable TransitionMakeBlcok)transitionBlock
                                 transitionInteractiveBeginBlock:(nullable TransitionInteractiveBeginBlock)transitionInteractiveBeginBlock
                                                      completion:(nullable TransitionCompletionBlock)completion;
@end
NS_ASSUME_NONNULL_END
