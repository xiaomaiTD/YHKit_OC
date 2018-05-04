//
//  UIViewController+YHSystemPhoto.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/10.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YHSystemPhoto) 

//这两个值可以选择性的传，也可以都为空
@property (nonatomic,copy) NSString * yh_systemmPhotoAlertTitle;
@property (nonatomic,copy) NSString * yh_systemmPhotoAlertMessage;

//这三个值,要么传入一个具体值，要么不传。不传的话，用默认值
@property (nonatomic,copy) NSString * yh_systemmPhotoCameraTitle;
@property (nonatomic,copy) NSString * yh_systemmPhotoAlblumTitle;
@property (nonatomic,copy) NSString * yh_systemmPhotoCancelTitle;

@property (nonatomic, copy) NSString *yh_permissionTitle;//权限失败的标题
@property (nonatomic, copy) NSString *yh_cameraPermissionMessage;//相机权限失败信息
@property (nonatomic, copy) NSString *yh_alblumPermissionMessage;//相册权限失败信息
@property (nonatomic, copy) NSString *yh_permissionOK;

/** 是否正在显示 */
@property (nonatomic,assign,readonly) BOOL yh_isShowSystemPhoto;

/** 弹出"相机"、"相册"、"取消" 这三个选择 */
- (void)yh_systemPhotoAlertWithImageBlock:(void(^)(UIImage * _Nullable image))imageBlock NS_AVAILABLE_IOS(8_0);

/** 直接进入系统相册选择照片 */
- (void)yh_systemPhotoOnlyAlblumWithImageBlock:(void (^)(UIImage * _Nullable image))imageBlock;

/** 直接进入系统相机开始拍摄照片 */
- (void)yh_systemPhotoOnlyCameraWithImageBlock:(void (^)(UIImage * _Nullable  image))imageBlock;

@end

NS_ASSUME_NONNULL_END
