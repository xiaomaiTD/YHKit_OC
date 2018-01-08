//
//  YHDeviceUtil.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHDeviceUtil.h"

#include <sys/utsname.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation YHDeviceUtil
+ (instancetype)sharedDevice{
    static YHDeviceUtil *device = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        device = [[YHDeviceUtil alloc] init];
        
        
        CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = info.subscriberCellularProvider;
        //供应商名字，比如中国联通、中国移动
        NSString *carrierName = carrier.carrierName;
        //国家编号，共3位，中国地区为460
        NSString *countryCode = carrier.mobileCountryCode;
        //供应商网络编号，二到三个十进制数组成，中国移动MNC为00、02、07，中国联通的MNC为01、06、09，中国电信的MNC为03、05、11
        NSString *netCode = carrier.mobileNetworkCode;
        //isoCountryCode
        NSString *isoCountryCode = carrier.isoCountryCode;
        //是否允许VOIP
        BOOL isAllowVOIP = carrier.allowsVOIP;
        //本机号码(机主设置的本机号码，有可能是假号码，不能访问sim卡手机号码),CTSettingCopyMyPhoneNumber()是私有API
        NSString *mayRealPhone = [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
        
        device.yh_sim_carrierName = carrierName;
        device.yh_sim_countryCode = countryCode;
        device.yh_sim_netCode = netCode;
        device.yh_sim_isoCountryCode = isoCountryCode;
        device.yh_sim_isAllowVOIP = isAllowVOIP;
        device.yh_sim_mayRealPhone = mayRealPhone;
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *hardwareString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        device.yh_hardwareString = hardwareString;
        
        
    });
    return device;
}




@end



