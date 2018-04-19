//
//  UIImage+YHQRImage.h
//  YHKit_OC
//
//  Created by 银河 on 2018/4/19.
//  Copyright © 2018年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIImage (YHQRImage)
+ (UIImage *)yh_qrImageWithContent:(NSString *)content centerImage:(nullable UIImage *)centerImage;
+ (UIImage *)yh_qrImageWithContent:(NSString *)content centerImage:(nullable UIImage *)centerImage qrImageWidth:(CGFloat)qrImageWidth;
@end
NS_ASSUME_NONNULL_END
