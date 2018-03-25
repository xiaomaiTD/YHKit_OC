//
//  UIImage+YHColorToImage.h
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/15.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (YHColorToImage)
/** 把颜色转换为图片 */
+ (UIImage *)yh_imageWithColor:(UIColor *)color;
+ (UIImage *)yh_imageWithColor:(UIColor *)color size:(CGSize)size;
@end
NS_ASSUME_NONNULL_END
