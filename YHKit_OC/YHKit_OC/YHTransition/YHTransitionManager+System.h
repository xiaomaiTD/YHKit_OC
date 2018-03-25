//
//  YHTransitionManager+System.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager.h"

NS_ASSUME_NONNULL_BEGIN
/** 模仿系统的push、pop、present、dismiss */
@interface YHTransitionManager (SystemPush)
- (void)systemPushTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion;
- (void)systemPopTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion;
- (void)systemPresentTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion;
- (void)systemDismissTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(nullable TransitionCompletionBlock)completion;
@end
NS_ASSUME_NONNULL_END



