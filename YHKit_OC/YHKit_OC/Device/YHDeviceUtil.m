//
//  YHDeviceUtil.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHDeviceUtil.h"

#import <UIKit/UIKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#include <sys/utsname.h>
#include <sys/socket.h> // Per msqr
#include <sys/ioctl.h>
#include <sys/sockio.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <mach/mach.h>
#include <ifaddrs.h>


@interface YHDeviceUtil()
@property (nonatomic,copy) NSString     *yh_sim_carrierName;
@property (nonatomic,copy) NSString     *yh_sim_countryCode;
@property (nonatomic,copy) NSString     *yh_sim_netCode;
@property (nonatomic,copy) NSString     *yh_sim_isoCountryCode;
@property (nonatomic,assign) BOOL       yh_sim_isAllowVOIP;
@property (nonatomic,copy) NSString     *yh_hardwareString;
@property (nonatomic,copy) NSString     * yh_systemVersion;
@property (nonatomic,copy) NSString     * yh_deveiceName;
@property (nonatomic,copy) NSString     * yh_ipAdress;
@property (nonatomic,copy) NSString     * yh_ipAdressForWiFi;
@property (nonatomic,copy) NSString     * yh_ipAdressForCellular;
@property (nonatomic,assign) BOOL       yh_isCanMakePhone;
@end


@implementation YHDeviceUtil
+ (instancetype)sharedUtil{
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
        
        device.yh_sim_carrierName = carrierName;
        device.yh_sim_countryCode = countryCode;
        device.yh_sim_netCode = netCode;
        device.yh_sim_isoCountryCode = isoCountryCode;
        device.yh_sim_isAllowVOIP = isAllowVOIP;
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *hardwareString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        device.yh_hardwareString = hardwareString;
        
    });
    return device;
}
/** 获取设备型号，比如iPhone9,2 */
- (NSString *)yh_systemVersion{
    return [UIDevice currentDevice].systemVersion;
}
/** 设备名字(比如iPhone 7 Plus) */
- (NSString *)yh_deveiceName{
    NSString *machineString = self.yh_hardwareString;
    
    if ([machineString isEqualToString:@"iPhone1,1"])   return kYHDevice_iphone_1G;
    if ([machineString isEqualToString:@"iPhone1,2"])   return kYHDevice_iphone_3G;
    if ([machineString isEqualToString:@"iPhone2,1"])   return kYHDevice_iphone_3GS;
    
    if ([machineString isEqualToString:@"iPhone3,1"])   return kYHDevice_iphone_4;
    if ([machineString isEqualToString:@"iPhone3,3"])   return kYHDevice_iphone_4_Verizon;
    if ([machineString isEqualToString:@"iPhone4,1"])   return kYHDevice_iphone_4S;
    
    if ([machineString isEqualToString:@"iPhone5,1"])   return kYHDevice_iphone_5_GSM;
    if ([machineString isEqualToString:@"iPhone5,2"])   return kYHDevice_iphone_5_CDMA;
    if ([machineString isEqualToString:@"iPhone5,3"])   return kYHDevice_iphone_5C_GSM;
    if ([machineString isEqualToString:@"iPhone5,4"])   return kYHDevice_iphone_5C_GSM_CDMA;
    if ([machineString isEqualToString:@"iPhone6,1"])   return kYHDevice_iphone_5S_GSM;
    if ([machineString isEqualToString:@"iPhone6,2"])   return kYHDevice_iphone_5S_GSM_CDMA;
    
    if ([machineString isEqualToString:@"iPhone7,2"])   return kYHDevice_iphone_6;
    if ([machineString isEqualToString:@"iPhone7,1"])   return kYHDevice_iphone_6_Plus;
    if ([machineString isEqualToString:@"iPhone8,1"])   return kYHDevice_iphone_6S;
    if ([machineString isEqualToString:@"iPhone8,2"])   return kYHDevice_iphone_6S_Plus;
    
    if ([machineString isEqualToString:@"iPhone8,4"])   return kYHDevice_iphone_SE;
    
    if ([machineString isEqualToString:@"iPhone9,1"])   return kYHDevice_iphone_7_Chinese;
    if ([machineString isEqualToString:@"iPhone9,2"])   return kYHDevice_iphone_7Plus_Chinese;
    if ([machineString isEqualToString:@"iPhone9,3"])   return kYHDevice_iphone_7_American;
    if ([machineString isEqualToString:@"iPhone9,4"])   return kYHDevice_iphone_7Plus_American;
    
    if ([machineString isEqualToString:@"iPhone10,1"])  return kYHDevice_iphone_8_Chinese;
    if ([machineString isEqualToString:@"iPhone10,4"])  return kYHDevice_iphone_8_Global;
    if ([machineString isEqualToString:@"iPhone10,2"])  return kYHDevice_iphone_8_Plus_Chinese;
    if ([machineString isEqualToString:@"iPhone10,5"])  return kYHDevice_iphone_8_Plus_Global;
    
    if ([machineString isEqualToString:@"iPhone10,3"])  return kYHDevice_iphoneX_Chinese;
    if ([machineString isEqualToString:@"iPhone10,6"])  return kYHDevice_iphoneX_Global;
    
    if ([machineString isEqualToString:@"iPod1,1"])     return kYHDevice_iPod_Touch_1G;
    if ([machineString isEqualToString:@"iPod2,1"])     return kYHDevice_iPod_Touch_2G;
    if ([machineString isEqualToString:@"iPod3,1"])     return kYHDevice_iPod_Touch_3G;
    if ([machineString isEqualToString:@"iPod4,1"])     return kYHDevice_iPod_Touch_4G;
    if ([machineString isEqualToString:@"iPod5,1"])     return kYHDevice_iPod_Touch_5Gen;
    if ([machineString isEqualToString:@"iPod7,1"])     return kYHDevice_iPod_Touch_6G;
    
    if ([machineString isEqualToString:@"iPad1,1"])     return kYHDevice_iPad_1;
    if ([machineString isEqualToString:@"iPad1,2"])     return kYHDevice_iPad_3G;
    if ([machineString isEqualToString:@"iPad2,1"])     return kYHDevice_iPad_2_WIFI;
    if ([machineString isEqualToString:@"iPad2,2"])     return kYHDevice_iPad_2_GSM;
    if ([machineString isEqualToString:@"iPad2,3"])     return kYHDevice_iPad_2_CDMA;
    if ([machineString isEqualToString:@"iPad2,4"])     return kYHDevice_iPad_2_CDMA;
    
    
    if ([machineString isEqualToString:@"iPad2,5"])     return kYHDevice_iPadMini_WIFI;
    if ([machineString isEqualToString:@"iPad2,6"])     return kYHDevice_iPadMini_GSM;
    if ([machineString isEqualToString:@"iPad2,7"])     return kYHDevice_iPadMini_CDMA;
    
    if ([machineString isEqualToString:@"iPad3,1"])     return kYHDevice_iPad_3_WIFI;
    if ([machineString isEqualToString:@"iPad3,2"])     return kYHDevice_iPad_3_GSM;
    if ([machineString isEqualToString:@"iPad3,3"])     return kYHDevice_iPad_3_CDMA;
    if ([machineString isEqualToString:@"iPad3,4"])     return kYHDevice_iPad_4_WIFI;
    if ([machineString isEqualToString:@"iPad3,5"])     return kYHDevice_iPad_4_GSM;
    if ([machineString isEqualToString:@"iPad3,6"])     return kYHDevice_iPad_4_CDMA;
    if ([machineString isEqualToString:@"iPad4,1"])     return kYHDevice_iPadAir;
    if ([machineString isEqualToString:@"iPad4,2"])     return kYHDevice_iPadAir_Cellular;
    if ([machineString isEqualToString:@"iPad4,4"])     return kYHDevice_iPadMini_2;
    if ([machineString isEqualToString:@"iPad4,5"])     return kYHDevice_iPadMini_2_Cellular;
    if ([machineString isEqualToString:@"iPad4,7"])     return kYHDevice_iPad_3_WIFI;
    if ([machineString isEqualToString:@"iPad4,8"])     return kYHDevice_iPadMini_3_Cellular;
    if ([machineString isEqualToString:@"iPad4,9"])     return kYHDevice_iPadMini_3_Cellular;
    if ([machineString isEqualToString:@"iPad5,1"])     return kYHDevice_iPadMini_4_WIFI;
    if ([machineString isEqualToString:@"iPad5,2"])     return kYHDevice_iPadMini_4_Cellular;
    
    if ([machineString isEqualToString:@"iPad5,3"])     return kYHDevice_iPadAir_2_WIFI;
    if ([machineString isEqualToString:@"iPad5,4"])     return kYHDevice_iPadAir_2_Cellular;
    if ([machineString isEqualToString:@"iPad6,3"])     return kYHDevice_iPad_Pro_97inch_WiFi;
    if ([machineString isEqualToString:@"iPad6,4"])     return kYHDevice_iPad_Pro_97inch_Cellular;
    if ([machineString isEqualToString:@"iPad6,7"])     return kYHDevice_iPad_Pro_129inch_WiFi;
    if ([machineString isEqualToString:@"iPad6,8"])     return kYHDevice_iPad_Pro_129inch_Cellular;
    
    if ([machineString isEqualToString:@"iPad6,11"])    return kYHDevice_iPad_5_WiFi;
    if ([machineString isEqualToString:@"iPad6,12"])    return kYHDevice_iPad_5_Cellular;
    if ([machineString isEqualToString:@"iPad7,1"])     return kYHDevice_iPad_Pro_129inch_2nd_gen_WiFi;
    if ([machineString isEqualToString:@"iPad7,2"])     return kYHDevice_iPad_Pro_129inch_2nd_gen_Cellular;
    if ([machineString isEqualToString:@"iPad7,3"])     return kYHDevice_iPad_Pro_105inch_WiFi;
    if ([machineString isEqualToString:@"iPad7,4"])     return kYHDevice_iPad_Pro_105inch_Cellular;
    
    if ([machineString isEqualToString:@"AppleTV2,1"])  return kYHDevice_appleTV_2;
    if ([machineString isEqualToString:@"AppleTV3,1"])  return kYHDevice_appleTV_3;
    if ([machineString isEqualToString:@"AppleTV3,2"])  return kYHDevice_appleTV_3;
    if ([machineString isEqualToString:@"AppleTV5,3"])  return kYHDevice_appleTV_4;
    
    if ([machineString isEqualToString:@"i386"])        return kYHDevice_i386_Simulator;
    if ([machineString isEqualToString:@"x86_64"])      return kYHDevice_x86_64_Simulator;
    
    return machineString;
}

- (NSString *)yh_ipAdress{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP = @"";
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}
- (NSString *)ipAddressWithIfaName:(NSString *)name {
    if (name.length == 0) return nil;
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr) {
            if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:name]) {
                sa_family_t family = addr->ifa_addr->sa_family;
                switch (family) {
                    case AF_INET:
                    { // IPv4
                        char str[INET_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in *)addr->ifa_addr)->sin_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    }
                        break;
                    case AF_INET6:
                    { // IPv6
                        char str[INET6_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in6 *)addr->ifa_addr)->sin6_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    }
                        break;
                    default:
                        break;
                }
                if (address) break;
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address;
}
- (NSString *)yh_ipAdressForWiFi{
    return [self ipAddressWithIfaName:@"en0"];
}
- (NSString *)yh_ipAdressForCellular{
    return [self ipAddressWithIfaName:@"pdp_ip0"];
}
- (BOOL)yh_isCanMakePhone{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}
- (NSString *)yh_appleName{
    return [UIDevice currentDevice].name;
}
@end
