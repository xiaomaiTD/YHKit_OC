//
//  NSString+YHExchange.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/22.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "NSString+YHExchange.h"

@implementation NSString (YHExchange)

/** 中文格式化。如果有中文，则进行相应的转码 */
- (NSString *)yh_formatStr{
    NSURL *url = [NSURL URLWithString:self];
    if (url) {
        return self;
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
        return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
#else
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];// 9.0之后，该方法被废弃
#pragma clang diagnostic pop
#endif
    }
}


@end
