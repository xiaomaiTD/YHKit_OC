//
//  YHPhotoListModel.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/25.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface YHPhotoListModel : NSObject
/** 该相册标题 */
@property (nonatomic,copy) NSString * albumTitle;
/** 该相册的照片数量 */
@property (nonatomic,assign) NSInteger count;
/** 封面图片资源 */
@property (nonatomic,strong) PHAsset * headAsset;
/** 该相册包含的照片资源集合 */
@property (nonatomic,strong) PHFetchResult<PHAsset *> *result;
@end
