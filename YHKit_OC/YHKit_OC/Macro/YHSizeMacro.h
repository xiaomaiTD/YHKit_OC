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
 IPhone X: 375 x 812
 IPhone 8:
 IPhone 7: 375 x 667
 IPhone 7 plus: 414 x 736
 IPhone 6: 375 x 667
 IPhone 6s: 375 x 667
 IPhone 6s plus: 414 x 736
 IPhone 5: 320 x 568
 IPhone 5s: 320 x 568
 */

/** 屏幕宽度 */
#define YH_SCREENWIDTH          [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define YH_SCREENHEIGHT         [UIScreen mainScreen].bounds.size.height

//以7plus为基准，长宽按比例缩放
#define YH_HEIGHT(h)            (h/736.f*YH_SCREENHEIGHT)
#define YH_WIDTH(w)             (w/414.f*YH_SCREENWIDTH)

/** iPhone X 高度 */
#define YH_IPHONE_X_HEIGHT      812.f
/** iPhone X 宽度 */
#define YH_IPHONE_X_WIDTH       375.f

/** 是否是iPhone 5系列，iPhone 5系列机型的狂傲都一样 */
#define YH_IS_IPHONE_5_SERIES   (YH_SCREENWIDTH==320.f && YH_SCREENHEIGHT==568.f)


/** 状态栏Frame
 1、当状态栏是隐藏的时候，是CGRectZero
 2、当状态栏不隐藏的时候。iPhone X：44px    其他机型:20px
 */
#define YH_STATUSBARFRAME       [[UIApplication sharedApplication] statusBarFrame]

/** 导航栏Frame
 1、当所属控制器没有navi时，是CGRectZero
 2、当有navi时，高度是44px，即使navigationBarHidden属性为YES仍然是44px
 */
#define YH_NAVIFRAME            self.navigationController.navigationBar.frame


#endif /* YHSizeMacro_h */
































