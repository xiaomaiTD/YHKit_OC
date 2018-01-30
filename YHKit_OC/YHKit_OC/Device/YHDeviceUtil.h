//
//  YHDeviceUtil.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
//iPhone 1系列
#define kYHDevice_iphone_1G                @"iphone 1G"
//iPhone 3系列
#define kYHDevice_iphone_3G                @"iphone 3G"
#define kYHDevice_iphone_3GS               @"iphone 3GS"
//iPhone 4系列
#define kYHDevice_iphone_4                 @"iphone 4"
#define kYHDevice_iphone_4_Verizon         @"Verizon iphone 4"
#define kYHDevice_iphone_4S                @"iphone 4S"
//iPhone 5系列
#define kYHDevice_iphone_5_GSM             @"iphone 5 (GSM)"
#define kYHDevice_iphone_5_CDMA            @"iphone 5 (CDMA)"
#define kYHDevice_iphone_5C_GSM            @"iphone 5C (GSM)"
#define kYHDevice_iphone_5C_GSM_CDMA       @"iphone 5C (GSM+CDMA)"
#define kYHDevice_iphone_5S_GSM            @"iphone 5S (GSM)"
#define kYHDevice_iphone_5S_GSM_CDMA       @"iphone 5S (GSM+CDMA)"
//iPhone 6系列
#define kYHDevice_iphone_6                 @"iphone 6"
#define kYHDevice_iphone_6_Plus            @"iphone 6 Plus"
#define kYHDevice_iphone_6S                @"iphone 6S"
#define kYHDevice_iphone_6S_Plus           @"iphone 6S Plus"
//iPhone SE系列
#define kYHDevice_iphone_SE                @"iphone SE"
//iPhone 7系列
#define kYHDevice_iphone_7_Chinese         @"iphone 7 (Chinese)"
#define kYHDevice_iphone_7Plus_Chinese     @"iphone 7 Plus (Chinese)"
#define kYHDevice_iphone_7_American        @"iphone 7 (American)"
#define kYHDevice_iphone_7Plus_American    @"iphone 7 Plus (American)"
//iPhone 8系列
#define kYHDevice_iphone_8_Chinese         @"iphone 8 (Chinese)"
#define kYHDevice_iphone_8_Global          @"iphone 8 (Global)"
#define kYHDevice_iphone_8_Plus_Chinese    @"iphone 8 Plus (Chinese)"
#define kYHDevice_iphone_8_Plus_Global     @"iphone 8 Plus (Global)"
//iPhone X
#define kYHDevice_iphoneX_Chinese          @"iphone X (Chinese)"
#define kYHDevice_iphoneX_Global           @"iphone X (Global)"
//iPod Touch系列
#define kYHDevice_iPod_Touch_1G            @"iPod Touch 1G"
#define kYHDevice_iPod_Touch_2G            @"iPod Touch 2G"
#define kYHDevice_iPod_Touch_3G            @"iPod Touch 3G"
#define kYHDevice_iPod_Touch_4G            @"iPod Touch 4G"
#define kYHDevice_iPod_Touch_5Gen          @"iPod Touch 5(Gen)"
#define kYHDevice_iPod_Touch_6G            @"iPod Touch 6G"
//iPad系列
#define kYHDevice_iPad_1                   @"iPad 1"
#define kYHDevice_iPad_3G                  @"iPad 3G"
#define kYHDevice_iPad_2_GSM               @"iPad 2 (GSM)"
#define kYHDevice_iPad_2_CDMA              @"iPad 2 (CDMA)"
#define kYHDevice_iPad_2_WIFI              @"iPad 2 (WiFi)"
#define kYHDevice_iPad_3_WIFI              @"iPad 3 (WiFi)"
#define kYHDevice_iPad_3_GSM               @"iPad 3 (GSM)"
#define kYHDevice_iPad_3_CDMA              @"iPad 3 (CDMA)"
#define kYHDevice_iPad_3_GSM_CDMA          @"iPad 3 (GSM+CDMA)"
#define kYHDevice_iPad_4_WIFI              @"iPad 4 (WiFi)"
#define kYHDevice_iPad_4_GSM               @"iPad 4 (GSM)"
#define kYHDevice_iPad_4_CDMA              @"iPad 4 (CDMA)"
#define kYHDevice_iPad_4_GSM_CDMA          @"iPad 4 (GSM+CDMA)"
#define kYHDevice_iPad_5_WiFi              @"iPad 5 (WiFi)"
#define kYHDevice_iPad_5_Cellular          @"iPad 5 (Cellular)"
//iPad Air系列
#define kYHDevice_iPadAir                  @"iPad Air"
#define kYHDevice_iPadAir_Cellular         @"iPad Air (Cellular)"
#define kYHDevice_iPadAir_2_WIFI           @"iPad Air 2 (WiFi)"
#define kYHDevice_iPadAir_2_Cellular       @"iPad Air 2 (Cellular)"
//iPad Mini系列
#define kYHDevice_iPadMini_WIFI            @"iPad Mini (WiFi)"
#define kYHDevice_iPadMini_GSM             @"iPad Mini (GSM)"
#define kYHDevice_iPadMini_CDMA            @"iPad Mini (CDMA)"
#define kYHDevice_iPadMini_2               @"iPad Mini 2"
#define kYHDevice_iPadMini_2_Cellular      @"iPad Mini 2 (Cellular)"
#define kYHDevice_iPadMini_3_WIFI          @"iPad Mini 3 (WiFi)"
#define kYHDevice_iPadMini_3_Cellular      @"iPad Mini 3 (Cellular)"
#define kYHDevice_iPadMini_4_WIFI          @"iPad Mini 4 (WiFi)"
#define kYHDevice_iPadMini_4_Cellular      @"iPad Mini 4 (Cellular)"
//iPad Pro系列
#define kYHDevice_iPad_Pro_97inch_WiFi                 @"iPad Pro 9.7 inch(WiFi)"
#define kYHDevice_iPad_Pro_97inch_Cellular             @"iPad Pro 9.7 inch(Cellular)"
#define kYHDevice_iPad_Pro_129inch_WiFi                @"iPad Pro 12.9 inch(WiFi)"
#define kYHDevice_iPad_Pro_129inch_Cellular            @"iPad Pro 12.9 inch(Cellular)"
#define kYHDevice_iPad_Pro_129inch_2nd_gen_WiFi        @"iPad Pro 12.9 inch(2nd generation)(WiFi)"
#define kYHDevice_iPad_Pro_129inch_2nd_gen_Cellular    @"iPad Pro 12.9 inch(2nd generation)(Cellular)"
#define kYHDevice_iPad_Pro_105inch_WiFi                @"iPad Pro 10.5 inch(WiFi)"
#define kYHDevice_iPad_Pro_105inch_Cellular            @"iPad Pro 10.5 inch(Cellular)"
//Apple TV系列
#define kYHDevice_appleTV_2               @"Apple TV 2"
#define kYHDevice_appleTV_3               @"Apple TV 3"
#define kYHDevice_appleTV_4               @"Apple TV 4"
//Simulator系列
#define kYHDevice_i386_Simulator          @"i386Simulator"
#define kYHDevice_x86_64_Simulator        @"x86_64Simulator"


@interface YHDeviceUtil : NSObject

+ (instancetype)sharedUtil;
#pragma mark - sim卡信息
/** 供应商名字，比如中国联通、中国移动 */
@property (nonatomic,copy,readonly) NSString     *yh_sim_carrierName;
/** 国家编号，共3位，中国地区为460 */
@property (nonatomic,copy,readonly) NSString     *yh_sim_countryCode;
/** 供应商网络编号，二到三个十进制数组成，中国移动MNC为00、02、07，中国联通的MNC为01、06、09，中国电信的MNC为03、05、11 */
@property (nonatomic,copy,readonly) NSString     *yh_sim_netCode;
/** isoCountryCode */
@property (nonatomic,copy,readonly) NSString     *yh_sim_isoCountryCode;
/** 是否允许VOIP */
@property (nonatomic,assign,readonly) BOOL       yh_sim_isAllowVOIP;
#pragma mark - 设备信息
/** 获取设备型号，比如iPhone9,2 */
@property (nonatomic,copy,readonly) NSString     *yh_hardwareString;
/** 获取当前手机系统版本，比如11.1等等 */
@property (nonatomic,copy,readonly) NSString     * yh_systemVersion;
/** 设备名字(比如iPhone 7 Plus) */
@property (nonatomic,copy,readonly) NSString     * yh_deveiceName;
/** 苹果设备名字，比如“银河的iPhone”，该名称用户可以自定义 */
@property (nonatomic,copy,readonly) NSString     * yh_appleName;
/** 获取IP地址 */
@property (nonatomic,copy,readonly) NSString     * yh_ipAdress;
/** 获取IP地址(WiFi),当WiFi关闭时，值为null */
@property (nonatomic,copy,readonly) NSString     * yh_ipAdressForWiFi;
/** 获取IP地址(Cellular)，当蜂窝网络关闭时，值为null */
@property (nonatomic,copy,readonly) NSString     * yh_ipAdressForCellular;
/** 该设备能否打电话 */
@property (nonatomic,assign,readonly) BOOL       yh_isCanMakePhone;

@end
