//
//  UIView+YHViewExtension.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/9.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "UIView+YHViewExtension.h"

@implementation UIView (YHViewExtension)
#pragma mark - width
- (void)setWidth_yh:(CGFloat)width_yh{
    CGRect frame = self.frame;
    frame.size.width = width_yh;
    self.frame = frame;
}
- (CGFloat)width_yh{
    return self.frame.size.width;
}
#pragma mark - height
- (void)setHeight_yh:(CGFloat)height_yh{
    CGRect frame = self.frame;
    frame.size.height = height_yh;
    self.frame = frame;
}
- (CGFloat)height_yh{
    return self.frame.size.height;
}
#pragma mark - origin
- (void)setOrigin_yh:(CGPoint)origin_yh{
    CGRect frame = self.frame;
    frame.origin = origin_yh;
    self.frame = frame;
}
- (CGPoint)origin_yh{
    return self.frame.origin;
}
#pragma mark - originX
- (void)setOriginX_yh:(CGFloat)originX_yh{
    CGRect frame = self.frame;
    frame.origin.x = originX_yh;
    self.frame = frame;
}
- (CGFloat)originX_yh{
    return self.frame.origin.x;
}
#pragma mark - originY
- (void)setOriginY_yh:(CGFloat)originY_yh{
    CGRect frame = self.frame;
    frame.origin.y = originY_yh;
    self.frame = frame;
}
- (CGFloat)originY_yh{
    return self.frame.origin.y;
}
#pragma mark - center
- (void)setCenter_yh:(CGPoint)center_yh{
    CGPoint center = self.center;
    center = center_yh;
    self.center = center;
}
- (CGPoint)center_yh{
    return self.center;
}
#pragma mark - centerX
- (void)setCenterX_yh:(CGFloat)centerX_yh{
    CGPoint center = self.center;
    center.x = centerX_yh;
    self.center = center;
}
- (CGFloat)centerX_yh{
    return self.center.x;
}
#pragma mark - centerY
- (void)setCenterY_yh:(CGFloat)centerY_yh{
    CGPoint center = self.center;
    center.y = centerY_yh;
    self.center = center;
}
- (CGFloat)centerY_yh{
    return self.center.y;
}
#pragma mark - size
- (void)setSize_yh:(CGSize)size_yh{
    CGRect frame = self.frame;
    frame.size = size_yh;
    self.frame = frame;
}
- (CGSize)size_yh{
    return self.frame.size;
}
#pragma mark - right
- (void)setRight_yh:(CGFloat)right_yh{
    CGFloat tmp = right_yh - (self.frame.origin.x + self.frame.size.width);
    CGRect frame = self.frame;
    frame.origin.x += tmp;
    self.frame = frame;
}
- (CGFloat)right_yh{
    return self.frame.origin.x + self.frame.size.width;
}
#pragma mark - bottom
- (void)setBottom_yh:(CGFloat)bottom_yh{
    CGRect frame = self.frame;
    frame.origin.y = bottom_yh - self.frame.size.height;
    self.frame = frame;
}
- (CGFloat)bottom_yh{
    return self.frame.origin.y + self.frame.size.height;
}
#pragma mark - xib
+ (instancetype)viewFromXibName:(NSString *)xibName{
    return [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] lastObject];
}
@end
