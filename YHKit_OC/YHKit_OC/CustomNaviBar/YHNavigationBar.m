//
//  YHNavigationBar.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/8.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHNavigationBar.h"

#import "YHSizeMacro.h"

@interface YHNavigationBar()

@end


@implementation YHNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (@available(iOS 11.0, *)) {
        //适配iOS11，需要遍历所有的子控件，并向下移动状态栏的高度
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                CGRect frame = obj.frame;
                frame.size.height = self.frame.size.height;
                obj.frame = frame;
            } else {
                CGRect frame   = obj.frame;
                frame.origin.y += YH_STATUSBARFRAME.size.height;
                obj.frame      = frame;
            }
        }];
    }
}
@end























