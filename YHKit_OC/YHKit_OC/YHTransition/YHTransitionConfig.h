//
//  YHTransitionConfig.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/25.
//  Copyright © 2018年 银河. All rights reserved.
//

#ifndef YHTransitionConfig_h
#define YHTransitionConfig_h

#define YHTransitionFromVC(transitionContext)  [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey]
#define YHTransitionToVC(transitionContext)    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]

#define YHTransitionCover_0_0_color            [[UIColor blackColor] colorWithAlphaComponent:0.0]
#define YHTransitionCover_0_3_color            [[UIColor blackColor] colorWithAlphaComponent:0.3]

#define YH_Kugou_Animation    0.4

/** 动画类型 */
typedef NS_ENUM(NSUInteger, YHTransitionAnimationType) {
    
    /** 默认 */
    YHTransitionAnimationTypeUnknown = 0,
    
    /**
     push && pop
     当使用push或者pop时，若抽屉背景为黑色，并且没有设置自定义导航栏的背景颜色，会使自定义导航栏颜色出现异常，因此最好设置自定义导航栏颜色
     */
    YHTransitionAnimationTypeSystemPush, //模仿系统的push
    YHTransitionAnimationTypeSystemPop, //模仿系统的pop
    
    /** present && dismiss */
    YHTransitionAnimationTypeSystemPresent, //模仿系统的present
    YHTransitionAnimationTypeSystemDismiss, //模仿系统的dismiss
    
    /** 模仿今日头条 */
    YHTransitionAnimationTypeScaleShrink, //模仿今日头条，整体形变缩小
    YHTransitionAnimationTypeScaleEnlarge, //模仿今日头条，整体形变放大
    
    /** 模仿酷狗 */
    YHTransitionAnimationTypeKuGouPush, //模仿酷狗音乐push动画
    YHTransitionAnimationTypeKuGouPop, //模仿酷狗音乐pop动画
    
    /** 模仿书本翻页效果，由于手势动画有点小瑕疵，因此建议用此动画时，不要添加手势 */
    YHTransitionAnimationTypeMiddlePagePush,
    YHTransitionAnimationTypeMiddlePagePop,
    
    
};
/** 转场手势类型 */
typedef NS_ENUM(NSUInteger, YHInteractiveType) {
    YHInteractiveTypePushPop, //push、pop类型
    YHInteractiveTypePresentDismiss, //present、dismiss类型
};
/** 转场动画手势方向 */
typedef NS_ENUM(NSUInteger, YHPanGestureDirection) {
    YHPanGestureDirectionUnknown = 0,
    YHPanGestureDirectionUp, //上滑
    YHPanGestureDirectionDown, //下滑
    YHPanGestureDirectionLeft, //左滑
    YHPanGestureDirectionRight, //右滑
};

#endif /* YHTransitionConfig_h */
