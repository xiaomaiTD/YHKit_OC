//
//  NSString+YHValid.m
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/17.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "NSString+YHValid.h"

@implementation NSString (YHValid)
#pragma mark - --
/** 字符串是不是整形 */
- (BOOL)yh_isInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/** 字符串是不是浮点型 */
- (BOOL)yh_isFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/** 字符串是不是数字（包括整形和浮点型） */
- (BOOL)yh_isNumber{
    if (self.yh_isFloat || self.yh_isInt) {
        return YES;
    } else {
        return NO;
    }
}
/** 字符串中是否含有表情 */
- (BOOL)yh_isHaveEmoji{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}
#pragma mark - 正则表达式判断
/** 是否是url */
- (BOOL)yh_isValidUrl{
    NSPredicate *urlReg = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", k_YH_URL_Regex];
    return [urlReg evaluateWithObject:self];
}
/** 是否是邮箱 */
- (BOOL)yh_isValidEmail{
    NSPredicate *emailReg = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", k_YH_Email_Regex];
    return [emailReg evaluateWithObject:self];
}
/** 是不是手机号(中国) */
- (BOOL)yh_isPhone_CN{
    NSPredicate *phone_cn_rege = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", k_YH_Phone_CN_Regex];
    return [phone_cn_rege evaluateWithObject:self];
}
/** 是否是纯数字 */
- (BOOL)yh_isNumber1{
    NSPredicate *number_rege = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", k_YH_Number_Regex];
    return [number_rege evaluateWithObject:self];
}
/** 是否是纯大写字母 */
- (BOOL)yh_isUpperAlphabet{
    NSPredicate *upperAlphabet_rege = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", k_YH_UpperAlphabet_Regex];
    return [upperAlphabet_rege evaluateWithObject:self];
}
/** 是否是纯小写字母 */
- (BOOL)yh_isLowerAlphabet{
    NSPredicate *lowerAlphabet_rege = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", k_YH_LowerAlphabet_Regex];
    return [lowerAlphabet_rege evaluateWithObject:self];
}
/** 是否是纯字母 */
- (BOOL)yh_isAlphabet{
    NSPredicate *alphabet_rege = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", k_YH_Alphabet_Regex];
    return [alphabet_rege evaluateWithObject:self];
}
@end
