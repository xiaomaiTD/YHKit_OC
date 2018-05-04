//
//  YHThreadMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#ifndef YHThreadMacro_h
#define YHThreadMacro_h

/** 是否是主线程 */
#define yh_isMainThread    [NSThread isMainThread]

/** 在主线程上执行，需要加上 ^{}  */
#define yh_DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

/** 开启异步线程，需要加上 ^{} */
#define yh_DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

/** 主线程判断。如果不是主线程，回到主线程 */
#define yh_MAIN_QUEUE(block)\
if (yh_isMainThread) {\
    block();\
} else {\
    yh_DISPATCH_MAIN_THREAD(block)\
}

#endif /* YHThreadMacro_h */
