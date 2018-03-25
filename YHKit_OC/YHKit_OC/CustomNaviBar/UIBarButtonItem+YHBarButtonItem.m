//
//  UIBarButtonItem+YHBarButtonItem.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/6.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "UIBarButtonItem+YHBarButtonItem.h"


@implementation UIBarButtonItem (YHBarButtonItem)
+ (instancetype)yh_customizeItemWithItemType:(YHBarButtonItemType)itemType configure:(YHBarButtonItemConfigure *)configure target:(id)target action:(SEL)action{
    switch (itemType) {
        case YHBarButtonItemTitle:
        {
            return [self titleItemWithConfigure:configure target:target action:action];
        }
            break;
        case YHBarButtonItemImage:
        {
            return [self imageItemWithConfigure:configure target:target action:action];
        }
            break;
        default:
            return [[UIBarButtonItem alloc] init];
            break;
    }
}
+ (instancetype)yh_systemItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}
+ (instancetype)yh_systemItemWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}

+ (UIBarButtonItem *)titleItemWithConfigure:(YHBarButtonItemConfigure *)configure target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //title
    [btn setTitle:configure.itemNormaleTitle forState:UIControlStateNormal];
    if (configure.itemHighlightTitle) {
        [btn setTitle:configure.itemHighlightTitle forState:UIControlStateHighlighted];
    }
    if (configure.itemSelectTitle) {
        [btn setTitle:configure.itemSelectTitle forState:UIControlStateSelected];
    }
    //color
    [btn setTitleColor:configure.normalTitleColor forState:UIControlStateNormal];
    if (configure.highlightTitleColor) {
        [btn setTitleColor:configure.highlightTitleColor forState:UIControlStateHighlighted];
    }
    if (configure.selectTitleColor) {
        [btn setTitleColor:configure.selectTitleColor forState:UIControlStateSelected];
    }
    //font
    btn.titleLabel.font = configure.titleFont;
    //
    [btn sizeToFit];
    //适应尺寸
    CGRect bounds = btn.bounds;
    bounds.size.height = 44.f;
//    if (bounds.size.width <= 44.f) {
//        bounds.size.width = 44.f;
//    }
    btn.bounds = bounds;
    //
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)imageItemWithConfigure:(YHBarButtonItemConfigure *)configure target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //image
    [btn setImage:configure.normalImage forState:UIControlStateNormal];
    if (configure.highlightImage) {
        [btn setImage:configure.normalImage forState:UIControlStateHighlighted];
    }
    if (configure.selectImage) {
        [btn setImage:configure.selectImage forState:UIControlStateSelected];
    }
    //适应尺寸
    CGRect bounds = btn.bounds;
    bounds.size.height = 44.f;
//    if (bounds.size.width <= 20.f) {
//        bounds.size.width = 20.f;
//    }
    btn.bounds = bounds;
    //
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:btn];
}
@end















