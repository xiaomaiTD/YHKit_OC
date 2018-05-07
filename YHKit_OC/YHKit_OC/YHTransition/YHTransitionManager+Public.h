//
//  YHTransitionManager+Public.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager.h"

NS_ASSUME_NONNULL_BEGIN
@interface YHTransitionManager (Public)
@property (nonatomic,strong) UIView * coverView;
- (void)completeTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)addCoverViewWithBaseVC:(UIViewController *)baseVC;
- (void)setCoverViewAlpha:(CGFloat)alpha;
- (void)removeCoverView;
@end
NS_ASSUME_NONNULL_END
