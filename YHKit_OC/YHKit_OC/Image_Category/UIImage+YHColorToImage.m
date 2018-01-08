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
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
