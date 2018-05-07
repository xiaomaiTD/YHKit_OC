//
//  UIViewController+YHSystemPhoto.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/10.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "UIViewController+YHSystemPhoto.h"

#import <objc/message.h>

#import "YHAlertController.h"
#import "YHRuntimeMacro.h"

#import "NSObject+YHAuthorization.h"

typedef void(^ImageBlock)(UIImage * _Nullable image);

@interface UIViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 是否正在显示 */
@property (nonatomic,assign) BOOL yh_isShowSystemPhoto;
/** 选择照片之后回调 */
@property (nonatomic,copy) ImageBlock imageBlock;

@end

@implementation UIViewController (YHSystemPhoto)

#pragma mark - setter && getter
//
- (void)setYh_systemmPhotoAlertTitle:(NSString *)yh_systemmPhotoAlertTitle{
    YH_RUNTIME_COPY_SET(@selector(yh_systemmPhotoAlertTitle), yh_systemmPhotoAlertTitle);
}
- (NSString *)yh_systemmPhotoAlertTitle{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_systemmPhotoAlertMessage:(NSString *)yh_systemmPhotoAlertMessage{
    YH_RUNTIME_COPY_SET(@selector(yh_systemmPhotoAlertMessage), yh_systemmPhotoAlertMessage);
}
- (NSString *)yh_systemmPhotoAlertMessage{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_systemmPhotoCameraTitle:(NSString *)yh_systemmPhotoCameraTitle{
    YH_RUNTIME_COPY_SET(@selector(yh_systemmPhotoCameraTitle), yh_systemmPhotoCameraTitle);
}
- (NSString *)yh_systemmPhotoCameraTitle{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_systemmPhotoAlblumTitle:(NSString *)yh_systemmPhotoAlblumTitle{
    YH_RUNTIME_COPY_SET(@selector(yh_systemmPhotoAlblumTitle), yh_systemmPhotoAlblumTitle);
}
- (NSString *)yh_systemmPhotoAlblumTitle{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_systemmPhotoCancelTitle:(NSString *)yh_systemmPhotoCancelTitle{
    YH_RUNTIME_COPY_SET(@selector(yh_systemmPhotoCancelTitle), yh_systemmPhotoCancelTitle);
}
- (NSString *)yh_systemmPhotoCancelTitle{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_isShowSystemPhoto:(BOOL)yh_isShowSystemPhoto{
    YH_RUNTIME_ASSIGN_SET(@selector(yh_isShowSystemPhoto), [NSNumber numberWithBool:yh_isShowSystemPhoto]);

}
- (BOOL)yh_isShowSystemPhoto{
    return [YH_RUNTIME_GET boolValue];
}
//
- (void)setImageBlock:(ImageBlock)imageBlock{
    YH_RUNTIME_COPY_SET(@selector(imageBlock), imageBlock);
}
- (ImageBlock)imageBlock{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_permissionTitle:(NSString *)yh_permissionTitle{
    YH_RUNTIME_COPY_SET(@selector(yh_permissionTitle), yh_permissionTitle);
}
- (NSString *)yh_permissionTitle{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_cameraPermissionMessage:(NSString *)yh_cameraPermissionMessage{
    YH_RUNTIME_COPY_SET(@selector(yh_cameraPermissionMessage), yh_cameraPermissionMessage);
}
- (NSString *)yh_cameraPermissionMessage{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_alblumPermissionMessage:(NSString *)yh_alblumPermissionMessage{
    YH_RUNTIME_COPY_SET(@selector(yh_alblumPermissionMessage), yh_alblumPermissionMessage);
}
- (NSString *)yh_alblumPermissionMessage{
    return YH_RUNTIME_GET;
}
//
- (void)setYh_permissionOK:(NSString *)yh_permissionOK{
    YH_RUNTIME_COPY_SET(@selector(yh_permissionOK), yh_permissionOK);
}
- (NSString *)yh_permissionOK{
    return YH_RUNTIME_GET;
}

#pragma mark - public methods
- (void)alblumBlock:(void(^)(void))block{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
        block ? block() : nil;
    }
}
- (void)cameraBlock:(void(^)(void))block{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
        block ? block() : nil;
    }
}
- (void)yh_systemPhotoAlertWithImageBlock:(void (^)(UIImage * _Nonnull))imageBlock{
    self.yh_isShowSystemPhoto = NO;
    self.imageBlock = imageBlock;
    __weak typeof(self) weakSelf = self;
    [self yh_showActionSheetAlertWithTitle:self.yh_systemmPhotoAlertTitle message:self.yh_systemmPhotoAlertMessage alertMaker:^(YHAlertController * _Nonnull alert) {
        alert.addActionDefaultTitle(self.yh_systemmPhotoCameraTitle ? self.yh_systemmPhotoCameraTitle : @"拍摄")
        .addActionDefaultTitle(self.yh_systemmPhotoAlblumTitle ? self.yh_systemmPhotoAlblumTitle : @"从手机相册选择")
        .addActionCancelTitle(self.yh_systemmPhotoCancelTitle ? self.yh_systemmPhotoCancelTitle : @"取消");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, YHAlertController * _Nonnull alert) {
        if (buttonIndex == 0) {
            [self yh_requestCameraAuthorizationwithResultBlock:^(YHAuthorizationResultTypeForCameraOrMicrophone authorizationStatus) {
                if (authorizationStatus == YHCameraOrMicrophoneAuthorizationAuthorized) {
                    [self cameraBlock:^{
                        weakSelf.yh_isShowSystemPhoto = YES;
                    }];
                } else {
                    [self yh_showAlertWithTitle:self.yh_permissionTitle message:self.yh_cameraPermissionMessage alertMaker:^(YHAlertController * _Nonnull alert) {
                        alert.addActionDefaultTitle(self.yh_permissionOK);
                    } actionsBlock:nil];
                }
            }];
        } else if (buttonIndex == 1) {
            [self yh_requestPhotoLibraryAuthorizationWithResultBlock:^(YHAuthorizationResultTypeForPhotoLibrary authorizationStatus) {
                if (authorizationStatus == YHPhotoLibraryAuthorizationAuthorized) {
                    [self alblumBlock:^{
                        weakSelf.yh_isShowSystemPhoto = YES;
                    }];
                } else {
                    [self yh_showAlertWithTitle:self.yh_permissionTitle message:self.yh_alblumPermissionMessage alertMaker:^(YHAlertController * _Nonnull alert) {
                        alert.addActionDefaultTitle(self.yh_permissionOK);
                    } actionsBlock:nil];
                }
            }];
        }
    }];
}
- (void)yh_systemPhotoOnlyAlblumWithImageBlock:(void (^)(UIImage * _Nonnull))imageBlock{
    __weak typeof(self) weakSelf = self;
    self.imageBlock = imageBlock;
    [self alblumBlock:^{
        weakSelf.yh_isShowSystemPhoto = YES;
    }];
}
- (void)yh_systemPhotoOnlyCameraWithImageBlock:(void (^)(UIImage * _Nonnull))imageBlock{
    __weak typeof(self) weakSelf = self;
    self.imageBlock = imageBlock;
    [self cameraBlock:^{
        weakSelf.yh_isShowSystemPhoto = YES;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.yh_isShowSystemPhoto = NO;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *editImage = nil;
    NSArray *allKeys = [info allKeys];
    if ([allKeys containsObject:UIImagePickerControllerEditedImage]) {
        editImage = info[UIImagePickerControllerEditedImage];
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
    } else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
    }
    self.imageBlock ? self.imageBlock(editImage) : nil;
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.yh_isShowSystemPhoto = NO;
}

@end
