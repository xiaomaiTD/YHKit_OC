//
//  YHRuntimeMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/13.
//  Copyright © 2017年 银河. All rights reserved.
//

#ifndef YHRuntimeMacro_h
#define YHRuntimeMacro_h

//#import <objc/runtime.h>
#import <objc/message.h>


/** runtime get */
#define YH_RUNTIME_GET                     objc_getAssociatedObject(self, _cmd)


/** runtime set for strong */
#define YH_RUNTIME_STRONG_SET(key,value)   objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
/** runtime set for copy */
#define YH_RUNTIME_COPY_SET(key,value)     objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC)
/** runtime set for assign */
#define YH_RUNTIME_ASSIGN_SET(key,value)   objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN)



/** 交换方法 */
static inline void yh_swizzled_method(Class class, SEL origin_SEL, SEL swizzlwd_SEL) {
    Method originMethod = class_getInstanceMethod(class, origin_SEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzlwd_SEL);
    BOOL isAdd = class_addMethod(class, origin_SEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAdd) {
        class_replaceMethod(class, swizzlwd_SEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}




#endif /* YHRuntimeMacro_h */

