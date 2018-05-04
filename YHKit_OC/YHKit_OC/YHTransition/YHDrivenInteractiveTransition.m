//
//  YHDrivenInteractiveTransition.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/26.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHDrivenInteractiveTransition.h"

#import "YHSizeMacro.h"
#import "UIView+YHViewExtension.h"
#import "YHDebugMacro.h"

@interface YHDrivenInteractiveTransition()
@property (nonatomic,assign) YHPanGestureDirection direction;
@property (nonatomic,copy) dispatch_block_t eventBlock;
@property (nonatomic,copy) InteractiveBeginBlock interactiveBeginBlock;
@end

@implementation YHDrivenInteractiveTransition
- (void)dealloc{
    YHLog(@"%@ dealloc",self);
}
- (instancetype)initWithDirection:(YHPanGestureDirection)direction eventBlock:(dispatch_block_t)eventBlock In:(UIView *)inView interactiveBeginBlock:(nullable InteractiveBeginBlock)interactiveBeginBlock
{
    self = [super init];
    if (self) {
        self.eventBlock = eventBlock;
        self.direction = direction;
        self.interactiveBeginBlock = interactiveBeginBlock;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [inView addGestureRecognizer:panGesture];
    }
    return self;
}
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    [super startInteractiveTransition:transitionContext];
}
- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture{
    CGFloat progress = 0.0;
    CGFloat velocity = 0.0;
    if (self.direction == YHPanGestureDirectionUp) {
        //上滑
        progress = [panGesture translationInView:panGesture.view].x / (panGesture.view.height_yh * 1.0);
        velocity = [panGesture velocityInView:panGesture.view].y;
        if (progress >= 0.0) {
            progress = 0.0;
        } else if (progress <= -1.0) {
            progress = 1.0;
        } else {
            progress = ABS(progress);
        }
    } else if (self.direction == YHPanGestureDirectionDown) {
        //下滑
        progress = [panGesture translationInView:panGesture.view].x / (panGesture.view.height_yh * 1.0);
        velocity = [panGesture velocityInView:panGesture.view].y;
        if (progress >= 1.0) {
            progress = 1.0;
        } else if (progress <= 0) {
            progress = 0.0;
        }
    } else if (self.direction == YHPanGestureDirectionLeft) {
        //左滑
        progress = [panGesture translationInView:panGesture.view].x / (panGesture.view.width_yh * 1.0);
        velocity = [panGesture velocityInView:panGesture.view].x;
        if (progress >= 0.0) {
            progress = 0.0;
        } else if (progress <= -1.0) {
            progress = 1.0;
        } else {
            progress = ABS(progress);
        }
    } else if (self.direction == YHPanGestureDirectionRight) {
        //右滑
        progress = [panGesture translationInView:panGesture.view].x / (panGesture.view.width_yh * 1.0);
        velocity = [panGesture velocityInView:panGesture.view].x;
        if (progress >= 1.0) {
            progress = 1.0;
        } else if (progress <= 0) {
            progress = 0.0;
        }
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.direction == YHPanGestureDirectionRight || self.direction == YHPanGestureDirectionDown) {
                if (velocity <= 0) {
                    return;
                }
            } else {
                if (velocity >= 0) {
                    return;
                }
            }
            self.isPanGestureInteration = YES;
            self.interactiveBeginBlock ? self.interactiveBeginBlock() : nil;
            self.eventBlock ? self.eventBlock() : nil;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 更新 interactive transition 的进度
            
                [self updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (self.direction == YHPanGestureDirectionRight || self.direction == YHPanGestureDirectionDown) {
                if (progress >= 0.3) {
                    if (velocity >= 0.f) {
                        [self finishInteractiveTransition];
                    } else {
                        [self cancelInteractiveTransition];
                    }
                } else {
                    if (velocity > 10.f) {
                        [self finishInteractiveTransition];
                    } else {
                        [self cancelInteractiveTransition];
                    }
                }
            } else {
                if (progress >= 0.3) {
                    if (velocity <= 0.f) {
                        [self finishInteractiveTransition];
                    } else {
                        [self cancelInteractiveTransition];
                    }
                } else {
                    if (velocity <- 10.f) {
                        [self finishInteractiveTransition];
                    } else {
                        [self cancelInteractiveTransition];
                    }
                }
            }
            self.isPanGestureInteration = NO;
        }
            break;
        default:
            break;
    }
}
@end
