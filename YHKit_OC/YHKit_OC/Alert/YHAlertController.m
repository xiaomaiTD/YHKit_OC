//
//  YHAlertController.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/7.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHAlertController.h"
#import <objc/message.h>

@interface YHAlertActionModel : NSObject
@property (nonatomic,copy) NSString                   * yh_title;
@property (nonatomic,assign) UIAlertActionStyle       yh_style;
@end

@implementation YHAlertActionModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.yh_title = @"";
        self.yh_style = UIAlertActionStyleDefault;
    }
    return self;
}
@end




typedef void(^YHAlertActionsConfig)(YHAlertActionBlock actionBlock);

@interface YHAlertController ()
@property (nonatomic,strong) NSMutableArray<YHAlertActionModel *> * yh_alertActionArray;
- (YHAlertActionsConfig)yh_alertActionsConfig;
@end

@implementation YHAlertController
//初始化必须以init开头，不然会报错
- (instancetype)init_yh_alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle{
    if (!(title.length > 0) && (message.length > 0) && (preferredStyle == UIAlertControllerStyleAlert)) {
        title = @"";
    }
    self = [object_getClass(self) alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (!self) {
        return nil;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (NSMutableArray<YHAlertActionModel *> *)yh_alertActionArray{
    if (!_yh_alertActionArray) {
        _yh_alertActionArray = [NSMutableArray array];
    }
    return _yh_alertActionArray;
}
- (YHAlertActionsConfig)yh_alertActionsConfig{
    return ^(YHAlertActionBlock actionBlock) {
        if (self.yh_alertActionArray.count > 0) {
            __weak typeof(self) weakSelf = self;
            [self.yh_alertActionArray enumerateObjectsUsingBlock:^(YHAlertActionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:obj.yh_title style:obj.yh_style handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    actionBlock ? actionBlock(idx,action, strongSelf) : nil;
                }];
                [self addAction:action];
            }];
        }
    };
}
- (YHAlertActionTitle)addActionDefaultTitle{
    return ^(NSString *title) {
        YHAlertActionModel *actionModel = [[YHAlertActionModel alloc] init];
        actionModel.yh_title = title;
        actionModel.yh_style = UIAlertActionStyleDefault;
        [self.yh_alertActionArray addObject:actionModel];
        return self;
    };
}
- (YHAlertActionTitle)addActionCancelTitle{
    return ^(NSString *title) {
        YHAlertActionModel *actionModel = [[YHAlertActionModel alloc] init];
        actionModel.yh_title = title;
        actionModel.yh_style = UIAlertActionStyleCancel;
        [self.yh_alertActionArray addObject:actionModel];
        return self;
    };
}
- (YHAlertActionTitle)addActionDestructiveTitle{
    return ^(NSString *title) {
        YHAlertActionModel *actionModel = [[YHAlertActionModel alloc] init];
        actionModel.yh_title = title;
        actionModel.yh_style = UIAlertActionStyleDestructive;
        [self.yh_alertActionArray addObject:actionModel];
        return self;
    };
}
@end











@implementation UIViewController (YHAlertController)

- (void)yh_showAlertWithTitle:(NSString *)title message:(NSString *)message alertMaker:(YHAlertMaker)alertMaker actionsBlock:(YHAlertActionBlock)actionBlock{
    [self yh_showAlertWithPreferredStyle:UIAlertControllerStyleAlert Title:title message:message alertMaker:alertMaker actionsBlock:actionBlock];
}
- (void)yh_showActionSheetAlertWithTitle:(NSString *)title message:(NSString *)message alertMaker:(YHAlertMaker)alertMaker actionsBlock:(YHAlertActionBlock)actionBlock{
    [self yh_showAlertWithPreferredStyle:UIAlertControllerStyleActionSheet Title:title message:message alertMaker:alertMaker actionsBlock:actionBlock];
}




- (void)yh_showAlertWithPreferredStyle:(UIAlertControllerStyle)preferredStyle Title:(NSString *)title message:(NSString *)message alertMaker:(YHAlertMaker)alertMaker actionsBlock:(YHAlertActionBlock)actionBlock{
    if (alertMaker) {
        YHAlertController *alertController = [[YHAlertController alloc] init_yh_alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        
        if (!alertController) { return; }
        
        //核心模块
        alertMaker(alertController);//点语法
        alertController.yh_alertActionsConfig(actionBlock);//响应block
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



@end
