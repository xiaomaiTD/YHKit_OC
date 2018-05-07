//
//  UIImage+YHColorToImage.m
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/15.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "UIImage+YHColorToImage.h"

@implementation UIImage (YHColorToImage)

+ (UIImage *)yh_imageWithColor:(UIColor *)color{
    return [self yh_imageWithColor:color size:CGSizeMake(1.0, 1.0)];
}
+ (UIImage *)yh_imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
