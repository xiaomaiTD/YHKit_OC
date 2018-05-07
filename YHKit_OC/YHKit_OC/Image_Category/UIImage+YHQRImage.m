//
//  UIImage+YHQRImage.m
//  YHKit_OC
//
//  Created by 银河 on 2018/4/19.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "UIImage+YHQRImage.h"

@implementation UIImage (YHQRImage)

+ (UIImage *)yh_qrImageWithContent:(NSString *)content centerImage:(UIImage *)centerImage{
    return [self yh_qrImageWithContent:content centerImage:centerImage qrImageWidth:300.f];
}
+ (UIImage *)yh_qrImageWithContent:(NSString *)content centerImage:(UIImage *)centerImage qrImageWidth:(CGFloat)qrImageWidth{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    // 2. 给滤镜添加数据
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    //
    UIImage *qrImage = [self createNonInterpolatedUIImageFormCIImage:image withSize:qrImageWidth];
    //如果中心有小图标
    if (centerImage) {
        // 开启绘图, 获取图形上下文
        UIGraphicsBeginImageContext(qrImage.size);
        // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
        [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
        // 再把小图片画上去
        CGFloat icon_imageW = 70.f;
        CGFloat icon_imageH = icon_imageW;
        CGFloat icon_imageX = (qrImage.size.width - icon_imageW) * 0.5;
        CGFloat icon_imageY = (qrImage.size.height - icon_imageH) * 0.5;
        //
        [centerImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
        // 获取当前画得的这张图片
        qrImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return qrImage;
}
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
