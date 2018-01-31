//
//  YHOtherMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#ifndef YHOtherMacro_h
#define YHOtherMacro_h

#define YH_WeakSelf(weakName)    __weak typeof(self) weakName = self
#define YH_Weak(name,weakName)   __weak typeof(name) weakName = name



/** APP version */
#define YH_AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** APP build */
#define YH_AppBulid   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


/** 弧度转角度 */
#define YH_RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
/** 角度转弧度 */
#define YH_DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


#endif /* YHOtherMacro_h */
