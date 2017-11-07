//
//  YHColorMacro.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/6.
//  Copyright © 2017年 银河. All rights reserved.
//

#ifndef YHColorMacro_h
#define YHColorMacro_h

#define YH_RandomColor     [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define YH_RGB(R,G,B)      [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define YH_RGBA(R,G,B,A)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define YH_HexColor(hex) \
({\
UIColor *color;\
NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];\
if ([cString length] < 6) {\
color = [UIColor clearColor];\
}\
if ([cString hasPrefix:@"0X"])\
cString = [cString substringFromIndex:2];\
if ([cString hasPrefix:@"#"])\
cString = [cString substringFromIndex:1];\
if ([cString length] != 6)\
color = [UIColor clearColor];\
NSRange range;\
range.location = 0;\
range.length = 2;\
NSString *rString = [cString substringWithRange:range];\
range.location = 2;\
NSString *gString = [cString substringWithRange:range];\
range.location = 4;\
NSString *bString = [cString substringWithRange:range];\
unsigned int r, g, b;\
[[NSScanner scannerWithString:rString] scanHexInt:&r];\
[[NSScanner scannerWithString:gString] scanHexInt:&g];\
[[NSScanner scannerWithString:bString] scanHexInt:&b];\
color = [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];\
(color);\
})




#endif /* YHColorMacro_h */
