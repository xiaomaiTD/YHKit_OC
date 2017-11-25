//
//  YHPhotoManager.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/25.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHPhotoListModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface YHPhotoManager : NSObject
/** 获取所有相册列表 */
+ (void)getPhotoAlbumListWithCompletionBlock:(void(^)(NSArray<YHPhotoListModel *> *photoAlbumLists))completionBlock;
/** 根据asset获取对应的图片 */
+ (PHImageRequestID)requestImageWithAsset:(PHAsset *)asset
                                     size:(CGSize)size
                               resizeMode:(PHImageRequestOptionsResizeMode)resizeMode
                             deliveryMode:(PHImageRequestOptionsDeliveryMode)deliveryMode
                               completion:(void(^)(UIImage * _Nullable image,NSDictionary * _Nullable info))completion;
@end
NS_ASSUME_NONNULL_END
