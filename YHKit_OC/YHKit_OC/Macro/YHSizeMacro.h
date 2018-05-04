//
//  YHSizeMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/6.
//  Copyright © 2017年 银河. All rights reserved.
//

#ifndef YHSizeMacro_h
#define YHSizeMacro_h

/*
 IPhone X:            375 x 812             3x
 
 IPhone 8:            375 x 667             2x
 iPhone 8 Plus:       414 x 736             3x
 
 IPhone 7:            375 x 667             2x
 IPhone 7 plus:       414 x 736             3x
 
 IPhone 6:            375 x 667             2x
 IPhone 6s:           375 x 667             2x
 iPhone 6 Plus:       414 x 736             3x
 IPhone 6s plus:      414 x 736             3x
 
 IPhone 5:            320 x 568             2x
 IPhone 5s:           320 x 568             2x
 */

/** 屏幕宽度 */
#define YH_SCREENWIDTH          [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define YH_SCREENHEIGHT         [UIScreen mainScreen].bounds.size.height

//只有当设备是5系列时，才对高度做处理，其他情况用实际高度
#define YH_HEIGHT(h) \
({ \
CGFloat height = h; \
if YH_IS_IPHONE_5_SERIES { \
height = h/667.f*YH_SCREENHEIGHT; \
} \
(height); \
})
//只有当设备是5系列时，才对宽度做处理，其他情况用实际高度
#define YH_WIDTH(w) \
({ \
CGFloat width = w; \
if YH_IS_IPHONE_5_SERIES { \
width = w/375.f*YH_SCREENHEIGHT; \
} \
(width); \
})

/** iPhone X 高度 */
#define YH_IPHONE_X_HEIGHT      812.f
/** iPhone X 宽度 */
#define YH_IPHONE_X_WIDTH       375.f
/** 是否是iPhone X */
#define YH_IS_IPHONE_X      (YH_SCREENHEIGHT == YH_IPHONE_X_HEIGHT && YH_SCREENWIDTH == YH_IPHONE_X_WIDTH)


/** 是否开启个人热点 */
#define YH_IS_OPEN_HOTSPOT   (YH_IS_IPHONE_X && YH_STATUSBARFRAME.size.height == 40)


/** 是否是iPhone 5系列，iPhone 5系列机型的宽高都一样 */
#define YH_IS_IPHONE_5_SERIES   (YH_SCREENWIDTH == 320.f && YH_SCREENHEIGHT == 568.f)


/** 状态栏Frame
 1、当状态栏是隐藏的时候，是CGRectZero，iPhone X状态栏永远不隐藏
 2、当状态栏不隐藏的时候。iPhone X：44px    其他机型:20px
 3、当开启个人热点时，状态栏高度变为40px，页面会整体下移20px。特别是TabBar，下移20px之后，严重影响用户体验。当状态栏高度发生变化时，会走UIApplicationWillChangeStatusBarFrameNotification通知
 */
#define YH_STATUSBARFRAME       [[UIApplication sharedApplication] statusBarFrame]

/** 导航栏Frame
 1、当所属控制器没有navi时，是CGRectZero
 2、当有navi时，高度是44px，即使navigationBarHidden属性为YES仍然是44px
 */
#define YH_NAVIFRAME            self.navigationController.navigationBar.frame


#endif /* YHSizeMacro_h */
































