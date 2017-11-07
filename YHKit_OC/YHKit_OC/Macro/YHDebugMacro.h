//
//  YHDebugMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/6.
//  Copyright © 2017年 银河. All rights reserved.
//

#ifndef YHDebugMacro_h
#define YHDebugMacro_h

#ifdef DEBUG
    #define YHLog(...)   NSLog(@">>>:%@",[NSString stringWithFormat:__VA_ARGS__])
#else
    #define YHLog(...)
#endif

#endif /* YHDebugMacro_h */
