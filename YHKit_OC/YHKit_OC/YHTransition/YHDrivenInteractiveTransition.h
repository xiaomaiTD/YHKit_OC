//
//  YHDrivenInteractiveTransition.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/26.
//  Copyright © 2018年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YHTransitionConfig.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^InteractiveBeginBlock)(void);
@interface YHDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic,assign) BOOL isPanGestureInteration;
- (instancetype)initWithDirection:(YHPanGestureDirection)direction eventBlock:(dispatch_block_t)eventBlock In:(UIView *)inView interactiveBeginBlock:(nullable InteractiveBeginBlock)interactiveBeginBlock;
@end
NS_ASSUME_NONNULL_END
