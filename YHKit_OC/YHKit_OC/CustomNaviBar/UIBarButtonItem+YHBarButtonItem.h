//
//  UIBarButtonItem+YHBarButtonItem.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/6.
//  Copyright © 2018年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YHBarButtonItemConfigure.h"


typedef NS_ENUM(NSUInteger, YHBarButtonItemType) {
    YHBarButtonItemTitle,
    YHBarButtonItemImage,
};

NS_ASSUME_NONNULL_BEGIN
@interface UIBarButtonItem (YHBarButtonItem)
+ (instancetype)yh_customizeItemWithItemType:(YHBarButtonItemType)itemType configure:(YHBarButtonItemConfigure *)configure target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)yh_systemItemWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action;
+ (instancetype)yh_systemItemWithImage:(UIImage *)image target:(nullable id)target action:(nullable SEL)action;
@end
NS_ASSUME_NONNULL_END
