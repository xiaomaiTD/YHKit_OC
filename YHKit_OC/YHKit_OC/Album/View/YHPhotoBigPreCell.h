//
//  YHPhotoBigPreCell.h
//  YHKit_OC
//
//  Created by 银河 on 2017/12/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPhotoDetailModel.h"

typedef void(^SingleTapBlock)(void);

@interface YHPhotoBigPreCell : UICollectionViewCell
@property (nonatomic,strong) YHPhotoDetailModel * model;
@property (nonatomic,copy) SingleTapBlock singleTapBlock;
@end
