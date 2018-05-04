//
//  YHTransitionManager+MiddlePage.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/28.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager.h"
NS_ASSUME_NONNULL_BEGIN
/** 模仿书本翻页效果 */
@interface YHTransitionManager (MiddlePage)
/** push */
- (void)middlePagePushTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext  completion:(nullable TransitionCompletionBlock)completion;
/** pop */
- (void)middlePagePopTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext  completion:(nullable TransitionCompletionBlock)completion;
@end
NS_ASSUME_NONNULL_END
