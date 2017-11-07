//
//  YHDeviceUtil.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHDeviceUtil.h"

#include <sys/utsname.h>


@implementation YHDeviceUtil

/** 获取设备型号，比如iPhone9,2 */
+ (NSString *)hardwareString{
    //需要 #include <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    /*
    char *s1 = systemInfo.sysname;// Darwin
    char *s2 = systemInfo.nodename;// yinhedeiPhone
    char *s3 = systemInfo.release;// 17.0.0
    char *s4 = systemInfo.version;// Darwin Kernel Version 17.0.0: Fri Sep  1 14:59:15 PDT 2017; root:xnu-4570.2.5~167/RELEASE_ARM64_T8010
    char *s5 = systemInfo.machine;// iPhone9,2
    */
    NSString *hardwareString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return hardwareString;
}







@end



