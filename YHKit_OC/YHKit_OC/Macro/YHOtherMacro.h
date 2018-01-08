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




#define YH_AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



#endif /* YHOtherMacro_h */
