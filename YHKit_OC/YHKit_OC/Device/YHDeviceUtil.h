//
//  YHDeviceUtil.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDeviceUtil : NSObject


/**
 获取设备型号，比如iPhone9,2
 疑问：这里的9和2分别代表什么意思？
 猜测:其中9代表第九代iPhone，2代表第二款版本
 参考链接：http://blog.csdn.net/hherima/article/details/49887439
 */
+ (NSString *)hardwareString;

@end
