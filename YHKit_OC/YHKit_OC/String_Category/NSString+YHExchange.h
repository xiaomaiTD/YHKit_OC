//
//  NSString+YHExchange.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/22.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface NSString (YHExchange)
/** 中文格式化。如果有中文，则进行相应的转码 */
- (NSString *)yh_formatStr;
/** 解码 */
- (NSString *)yh_deFormatStr;
/** 字符串倒叙输出 */
- (NSString *)yh_reverseStr;
@end
NS_ASSUME_NONNULL_END
