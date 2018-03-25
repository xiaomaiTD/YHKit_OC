//
//  NSString+YHValid.h
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/17.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (YHValid)
/** 字符串是不是url */
- (BOOL)yh_isValidUrl;

/** 字符串是不是整形 */
- (BOOL)yh_isInt;

/** 字符串是不是浮点型 */
- (BOOL)yh_isFloat;

/** 字符串是不是数字（包括整形和浮点型） */
- (BOOL)yh_isNumber;

/** 字符串中是否含有表情 */
- (BOOL)yh_isHaveEmoji;

/** 是否是邮箱 */
- (BOOL)yh_isValidEmail;

@end
NS_ASSUME_NONNULL_END
