//
//  YHSizeMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/6.
//  Copyright © 2017年 银河. All rights reserved.
//

#ifndef YHSizeMacro_h
#define YHSizeMacro_h

/** 屏幕宽度 */
#define YH_SCREENWIDTH          [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define YH_SCREENHEIGHT         [UIScreen mainScreen].bounds.size.height


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















