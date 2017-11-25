//
//  YHMBHud.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/10.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHMBHud.h"
#import "YHThreadMacro.h"

//HUD的背景颜色，默认黑色
#define MB_HUD_COLOR      [UIColor blackColor]
//HUD消失的时间，默认1.5秒
#define DISMISSTIME       1.5

@implementation YHMBHud

#if __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD.h")
/** 菊花旋转，提示信息可为空，view可为空 */
+ (MBProgressHUD *)hudWithMessage:(NSString *)message inView:(UIView *)view{
    view ? (view = view) : (view = [UIApplication sharedApplication].keyWindow);
    __block MBProgressHUD *hud;
    yh_MAIN_QUEUE(^{
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];//必须在主线程，源码规定
    });
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = MB_HUD_COLOR;
    hud.removeFromSuperViewOnHide = YES;
    if (message.length > 0) {
        hud.label.text = message;
        hud.label.numberOfLines = 0;
    }
    return hud;
}
/** 仅仅只有一段提示信息，一段时间后消失 */
+ (void)hudOnlyMessage:(NSString *)message inView:(UIView *)view dismissBlock:(void (^)(void))dismissBlock{
    if (!message || message.length == 0) {
        return;
    }
    view ? (view = view) : (view = [UIApplication sharedApplication].keyWindow);
    __block MBProgressHUD *hud;
    yh_MAIN_QUEUE(^{
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];//必须在主线程，源码规定
    });
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = MB_HUD_COLOR;
    hud.removeFromSuperViewOnHide = YES;
    yh_MAIN_QUEUE(^{
        [hud hideAnimated:YES afterDelay:DISMISSTIME];//必须在主线程，源码规定
    });
    hud.completionBlock = dismissBlock;
}


#endif



@end
