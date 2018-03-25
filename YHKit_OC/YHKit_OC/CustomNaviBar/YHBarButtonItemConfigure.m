//
//  YHBarButtonItemConfigure.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/6.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "YHBarButtonItemConfigure.h"

@interface YHBarButtonItemConfigure()

@end

@implementation YHBarButtonItemConfigure
- (NSString *)itemNormaleTitle{
    if (!_itemNormaleTitle) {
        _itemNormaleTitle = @"";
    }
    return _itemNormaleTitle;
}
//#######################################################################
- (UIColor *)normalTitleColor{
    if (!_normalTitleColor) {
        _normalTitleColor = [UIColor blackColor];
    }
    return _normalTitleColor;
}
- (UIColor *)highlightTitleColor{
    return [self.normalTitleColor colorWithAlphaComponent:0.5];
}
//#######################################################################
- (UIFont *)titleFont{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:17];
    }
    return _titleFont;
}
@end
