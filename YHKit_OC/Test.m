//
//  Test.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/7.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "Test.h"

@implementation Test
- (void)dealloc{
    NSLog(@"销毁了");
}
- (void)testShow{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testDebug];
    });
}
- (void)testDebug{
    NSLog(@"hello");
}

@end
