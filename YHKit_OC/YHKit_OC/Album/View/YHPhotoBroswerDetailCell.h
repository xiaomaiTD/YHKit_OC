//
//  YHPhotoBroswerDetailCell.h
//  YHKit_OC
//
//  Created by 银河 on 2017/12/1.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPhotoDetailModel.h"

typedef void(^SelectBlock)(void);

@interface YHPhotoBroswerDetailCell : UICollectionViewCell
@property (nonatomic,strong) YHPhotoDetailModel    * model;
@property (nonatomic,copy) SelectBlock             selectBlock;
@end
