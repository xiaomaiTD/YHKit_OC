//
//  UINavigationBar+YHNavigationBar.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/7.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "UINavigationBar+YHNavigationBar.h"

#import "YHRuntimeMacro.h"

@implementation UINavigationBar (YHNavigationBar)


+ (void)load{
    //GCD
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        yh_swizzled_method(class, @selector(layoutSubviews), @selector(yh_layoutSubviews));
    });
}
- (void)yh_layoutSubviews{
    [self yh_layoutSubviews];
    
}

@end







































