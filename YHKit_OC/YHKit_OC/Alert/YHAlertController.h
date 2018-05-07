//
//  YHAlertController.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/7.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHAlertController;
/**
 对系统UIAlertController的封装，需要iOS 8.0以上
 此处参考了github上的一个开源库：https://github.com/kukumaluCN/JXTAlertManager
 注：只是针对普通alert的封装。
 对于有textField的alert无用，需要自行封装
 */
NS_ASSUME_NONNULL_BEGIN

typedef YHAlertController *_Nonnull(^YHAlertActionTitle)(NSString *title);
typedef void(^YHAlertActionBlock)(NSInteger buttonIndex,UIAlertAction *action, YHAlertController *alert);

NS_CLASS_AVAILABLE_IOS(8_0) @interface YHAlertController : UIAlertController


//链式语法的特点：方法方返回值是调用者本身
- (YHAlertActionTitle)addActionDefaultTitle;
- (YHAlertActionTitle)addActionCancelTitle;
- (YHAlertActionTitle)addActionDestructiveTitle;


@end






typedef void(^YHAlertMaker)(YHAlertController *alert);

@interface UIViewController (YHAlertController)
/** alert样式，在屏幕中央 */
- (void)yh_showAlertWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                   alertMaker:(YHAlertMaker)alertMaker
                 actionsBlock:(nullable YHAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);
/** actionSheet样式，从底部弹出 */
- (void)yh_showActionSheetAlertWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                              alertMaker:(YHAlertMaker)alertMaker
                            actionsBlock:(nullable YHAlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

@end

NS_ASSUME_NONNULL_END
