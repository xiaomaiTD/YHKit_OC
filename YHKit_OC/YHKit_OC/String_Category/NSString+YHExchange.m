//
//  NSString+YHExchange.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/22.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "NSString+YHExchange.h"

@implementation NSString (YHExchange)

/** 格式化URL，如果URL里面有中文，则进行转码 */
- (NSString *)yh_formatURL{
    NSURL *url = [NSURL URLWithString:self];
    if (url) {
        return self;
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
        return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
#else
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#pragma clang diagnostic pop
#endif
    }
}


@end
