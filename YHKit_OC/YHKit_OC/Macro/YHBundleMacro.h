//
//  YHBundleMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/8.
//  Copyright © 2018年 银河. All rights reserved.
//

#ifndef YHBundleMacro_h
#define YHBundleMacro_h

/** 获取非framework的bundle里面的资源 */
#define YHBundleFilePath(bundleName,fileName) \
({ \
NSString *filePath = nil; \
NSString *path = [NSString stringWithFormat:@"%@.bundle",bundleName]; \
filePath = [path stringByAppendingPathComponent:fileName]; \
(filePath); \
})

/** 获取framework里面的bundle里面的资源 */
#define YHFrameworkBundleFilePath(frameworkName,bundleName,fileName) \
({ \
NSString *filePath = nil; \
NSString *path = [NSString stringWithFormat:@"Frameworks/%@.framework/%@.bundle",frameworkName,bundleName]; \
filePath = [path stringByAppendingPathComponent:fileName]; \
(filePath); \
})


#endif /* YHBundleMacro_h */
