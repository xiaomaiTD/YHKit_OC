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

/** 格式化URL，如果URL里面有中文，则进行转码 */
- (NSString *)yh_formatURL;


@end

NS_ASSUME_NONNULL_END
