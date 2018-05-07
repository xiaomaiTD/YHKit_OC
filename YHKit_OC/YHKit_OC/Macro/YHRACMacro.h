//
//  YHRACMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2018/4/16.
//  Copyright © 2018年 银河. All rights reserved.
//

#ifndef YHRACMacro_h
#define YHRACMacro_h

/** RAC避免循环引用，必须成对出现 */
#define YH_RAC_Weak     @weakify(self)
#define YH_RAC_Strong   @strongify(self)

#endif /* YHRACMacro_h */
