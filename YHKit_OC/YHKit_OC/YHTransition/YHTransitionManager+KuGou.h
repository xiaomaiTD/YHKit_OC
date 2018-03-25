//
//  YHTransitionManager+KuGou.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager.h"

NS_ASSUME_NONNULL_BEGIN
/** 模仿酷狗页面切换动画 */
@interface YHTransitionManager (KuGou)
/** push */
- (void)kuGouPushTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext  completion:(nullable TransitionCompletionBlock)completion;
/** pop */
- (void)kuGouPopTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext  completion:(nullable TransitionCompletionBlock)completion;
@end
NS_ASSUME_NONNULL_END
