//
//  YHPhotoDetailModel.h
//  YHKit_OC
//
//  Created by 银河 on 2017/12/1.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface YHPhotoDetailModel : NSObject
/** asset资源 */
@property (nonatomic,strong) PHAsset * asset;
/** 是否被选中 */
@property (nonatomic,assign) BOOL isSelected;
@end
