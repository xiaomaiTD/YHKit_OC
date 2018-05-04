//
//  NSString+YHValid.h
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/17.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const k_YH_URL_Regex = @"^(https?|ftps?|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]";
static NSString *const k_YH_Email_Regex = @"^[a-zA-Z0-9]+@[a-zA-Z0-9.]+\\.[a-zA-Z0-9]+$";
static NSString *const k_YH_Phone_CN_Regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(16[1-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}$";
static NSString *const k_YH_Number_Regex = @"^[0-9]+$";
static NSString *const k_YH_UpperAlphabet_Regex = @"^[A-Z]+$";
static NSString *const k_YH_LowerAlphabet_Regex = @"^[a-z]+$";
static NSString *const k_YH_Alphabet_Regex = @"^[a-zA-Z]+$";

NS_ASSUME_NONNULL_BEGIN
@interface NSString (YHValid)
#pragma mark - --
/** 字符串是不是整形 */
- (BOOL)yh_isInt;
/** 字符串是不是浮点型 */
- (BOOL)yh_isFloat;
/** 字符串是不是数字（包括整形和浮点型） */
- (BOOL)yh_isNumber;
/** 字符串中是否含有表情 */
- (BOOL)yh_isHaveEmoji;
#pragma mark - 正则表达式的各种判断
/** 字符串是不是url */
- (BOOL)yh_isValidUrl;
/** 是否是邮箱 */
- (BOOL)yh_isValidEmail;
/** 是不是手机号(中国) */
- (BOOL)yh_isPhone_CN;
/** 是否是纯数字 */
- (BOOL)yh_isNumber1;
/** 是否是纯大写字母 */
- (BOOL)yh_isUpperAlphabet;
/** 是否是纯小写字母 */
- (BOOL)yh_isLowerAlphabet;
/** 是否是纯字母 */
- (BOOL)yh_isAlphabet;
@end
NS_ASSUME_NONNULL_END
