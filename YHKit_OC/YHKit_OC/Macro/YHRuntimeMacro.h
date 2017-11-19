//
//  YHRuntimeMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#ifndef YHRuntimeMacro_h
#define YHRuntimeMacro_h



/** runtime get */
#define YH_RUNTIME_GET                     objc_getAssociatedObject(self, _cmd)


/** runtime set for strong */
#define YH_RUNTIME_STRONG_SET(key,value)   objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
/** runtime set for copy */
#define YH_RUNTIME_COPY_SET(key,value)     objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC)
/** runtime set for assign */
#define YH_RUNTIME_ASSIGN_SET(key,value)   objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN)



#endif /* YHRuntimeMacro_h */
