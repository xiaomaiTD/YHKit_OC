//
//  YHDeviceUtil.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHDeviceUtil : NSObject

+ (instancetype)sharedDevice;

//---------------------------sim卡信息---------------------------------------
/** 供应商名字，比如中国联通、中国移动 */
@property (nonatomic,copy) NSString     *yh_sim_carrierName;
/** 国家编号，共3位，中国地区为460 */
@property (nonatomic,copy) NSString     *yh_sim_countryCode;
/** 供应商网络编号，二到三个十进制数组成，中国移动MNC为00、02、07，中国联通的MNC为01、06、09，中国电信的MNC为03、05、11 */
@property (nonatomic,copy) NSString     *yh_sim_netCode;
/** isoCountryCode */
@property (nonatomic,copy) NSString     *yh_sim_isoCountryCode;
/** 是否允许VOIP */
@property (nonatomic,assign) BOOL       yh_sim_isAllowVOIP;
/** 本机号码(机主设置的本机号码，有可能是假号码，不能访问sim卡手机号码),CTSettingCopyMyPhoneNumber()是私有API */
@property (nonatomic,copy) NSString     *yh_sim_mayRealPhone;






//----------------------------设备信息------------------------------------------
/** 获取设备型号，比如iPhone9,2 */
@property (nonatomic,copy) NSString     *yh_hardwareString;






@end
