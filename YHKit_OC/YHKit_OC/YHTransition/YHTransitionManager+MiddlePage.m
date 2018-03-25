//
//  YHTransitionManager+MiddlePage.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/28.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHTransitionManager+MiddlePage.h"

#import "UIView+YHViewExtension.h"

#import "YHTransitionManager+Public.h"

@implementation YHTransitionManager (MiddlePage)
- (void)middlePagePushTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;//可以改为-0.1试试，就可以区分效果了
    containerView.layer.sublayerTransform = transform;
    
    CGRect from_half_right_rect = CGRectMake(fromVC.view.width_yh/2, 0, fromVC.view.width_yh/2, fromVC.view.height_yh);
    CGRect to_half_left_rect = CGRectMake(0, 0, toVC.view.width_yh/2, toVC.view.height_yh);
    CGRect to_half_right_rect = CGRectMake(toVC.view.width_yh/2, 0, toVC.view.width_yh/2, toVC.view.height_yh);
    
    UIView *from_right_snapView = [fromVC.view resizableSnapshotViewFromRect:from_half_right_rect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    UIView *to_left_snapView = [toVC.view resizableSnapshotViewFromRect:to_half_left_rect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    UIView *to_right_snapView = [toVC.view resizableSnapshotViewFromRect:to_half_right_rect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    from_right_snapView.frame = from_half_right_rect;
    to_left_snapView.frame = to_half_left_rect;
    to_right_snapView.frame = to_half_right_rect;
    
    from_right_snapView.layer.position = CGPointMake(from_right_snapView.originX_yh, from_right_snapView.originY_yh+from_right_snapView.height_yh/2);
    from_right_snapView.layer.anchorPoint = CGPointMake(0.0, 0.5);
    
    to_left_snapView.layer.position = CGPointMake(to_left_snapView.originX_yh+to_left_snapView.width_yh, to_left_snapView.originY_yh+to_left_snapView.height_yh/2);
    to_left_snapView.layer.anchorPoint = CGPointMake(1.0, 0.5);
    
    UIView *from_right_shadowView;
    UIView *to_left_shadowView;
    if (self.isAddCoverView) {
        from_right_shadowView = [self addShadowView:from_right_snapView startPoint:CGPointMake(0, 1) endPoint:CGPointMake(1, 1)];
        from_right_shadowView.alpha = 0.0;
        to_left_shadowView = [self addShadowView:to_left_snapView startPoint:CGPointMake(1, 1) endPoint:CGPointMake(0, 1)];
    }
    
    [containerView insertSubview:toVC.view atIndex:0];
    [containerView addSubview:to_left_snapView];
    [containerView addSubview:to_right_snapView];
    [containerView addSubview:from_right_snapView];
    
    to_left_snapView.hidden = YES;
    to_left_snapView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);//绕y轴先旋转到中间
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            from_right_snapView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            if (self.isAddCoverView) {
                from_right_shadowView.alpha = 1.0;
            }
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            to_left_snapView.hidden = NO;
            to_left_snapView.layer.transform = CATransform3DIdentity;
            if (self.isAddCoverView) {
                to_left_shadowView.alpha = 0.0;
            }
        }];
    } completion:^(BOOL finished) {
        to_left_snapView.hidden = YES;
        from_right_snapView.hidden = YES;
        [to_left_snapView removeFromSuperview];
        [to_right_snapView removeFromSuperview];
        [from_right_snapView removeFromSuperview];
//        [fromVC.view removeFromSuperview];
        containerView.layer.sublayerTransform = CATransform3DIdentity;
        if ([transitionContext transitionWasCancelled]) {
            [containerView addSubview:fromVC.view];
        }
        completion ? completion() : nil;
        [self completeTransition:transitionContext];
    }];
}
- (void)middlePagePopTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext completion:(TransitionCompletionBlock)completion{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = YHTransitionFromVC(transitionContext);
    UIViewController *toVC = YHTransitionToVC(transitionContext);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;//可以改为-0.1试试，就可以区分效果了
    containerView.layer.sublayerTransform = transform;
    
    CGRect from_half_left_rect = CGRectMake(0, 0, fromVC.view.width_yh/2, fromVC.view.height_yh);
    CGRect to_half_left_rect = CGRectMake(0, 0, toVC.view.width_yh/2, toVC.view.height_yh);
    CGRect to_half_right_rect = CGRectMake(toVC.view.width_yh/2, 0, toVC.view.width_yh/2, toVC.view.height_yh);
    
    UIView *from_left_snapView = [fromVC.view resizableSnapshotViewFromRect:from_half_left_rect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    UIView *to_left_snapView = [toVC.view resizableSnapshotViewFromRect:to_half_left_rect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    UIView *to_right_snapView = [toVC.view resizableSnapshotViewFromRect:to_half_right_rect afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    
    from_left_snapView.frame = from_half_left_rect;
    to_left_snapView.frame = to_half_left_rect;
    to_right_snapView.frame = to_half_right_rect;
    
    from_left_snapView.layer.position = CGPointMake(from_left_snapView.originX_yh+from_left_snapView.width_yh, from_left_snapView.originY_yh+from_left_snapView.height_yh/2);
    from_left_snapView.layer.anchorPoint = CGPointMake(1.0, 0.5);
    
    to_right_snapView.layer.position = CGPointMake(to_right_snapView.originX_yh, to_right_snapView.originY_yh+to_right_snapView.height_yh/2);
    to_right_snapView.layer.anchorPoint = CGPointMake(0.0, 0.5);
    
    UIView *from_left_shadowView;
    UIView *to_right_shadowView;
    if (self.isAddCoverView) {
        from_left_shadowView = [self addShadowView:from_left_snapView startPoint:CGPointMake(1, 1) endPoint:CGPointMake(0, 1)];
        to_right_shadowView = [self addShadowView:to_right_snapView startPoint:CGPointMake(0, 1) endPoint:CGPointMake(1, 1)];
        from_left_shadowView.alpha = 0.0;
    }
    
    [containerView insertSubview:toVC.view atIndex:0];
    [containerView addSubview:to_left_snapView];
    [containerView addSubview:to_right_snapView];
    [containerView addSubview:from_left_snapView];
    
    to_right_snapView.hidden = YES;
    
    to_right_snapView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);//绕y轴先旋转到中间
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            from_left_snapView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
            if (self.isAddCoverView) {
                from_left_shadowView.alpha = 1.0;
            }
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            to_right_snapView.hidden = NO;
            to_right_snapView.layer.transform = CATransform3DIdentity;
            if (self.isAddCoverView) {
                to_right_shadowView.alpha = 0.0;
            }
        }];
    } completion:^(BOOL finished) {
        from_left_snapView.hidden = YES;
        [to_left_snapView removeFromSuperview];
        [to_right_snapView removeFromSuperview];
        [from_left_snapView removeFromSuperview];
//        [fromVC.view removeFromSuperview];
        containerView.layer.sublayerTransform = CATransform3DIdentity;
        completion ? completion() : nil;
        [self completeTransition:transitionContext];
    }];
}
- (UIView *)addShadowView:(UIView *)view startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    UIView *shadowView = [[UIView alloc] initWithFrame:view.bounds];
    [view addSubview:shadowView];
    //颜色可以渐变
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = shadowView.bounds;
    [shadowView.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0].CGColor];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    return shadowView;
}

@end
