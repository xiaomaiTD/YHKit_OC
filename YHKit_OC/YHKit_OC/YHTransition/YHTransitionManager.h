//
//  YHTransitionManager.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "YHTransitionConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class YHTransitionManager;
typedef void(^TransitionMakeBlcok)(YHTransitionManager * transition);//转场配置block
typedef UIViewController *_Nonnull(^TransitionInteractiveBlock)(void);//针对入场手势Block，返回vc
typedef void(^TransitionCompletionBlock)(void);//转场结束block
typedef void(^TransitionInteractiveBeginBlock)(void);//侧滑手势开始block

@interface YHTransitionManager : NSObject <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) NSTimeInterval             animationDuration;
@property (nonatomic,assign) YHTransitionAnimationType  animationType;
@property (nonatomic,assign) BOOL                       isAddCoverView;


@property (nonatomic,copy, nullable) TransitionCompletionBlock    completionBlock;

@end
NS_ASSUME_NONNULL_END















