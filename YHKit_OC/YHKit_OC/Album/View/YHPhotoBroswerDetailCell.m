//
//  YHPhotoBroswerDetailCell.m
//  YHKit_OC
//
//  Created by 银河 on 2017/12/1.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoBroswerDetailCell.h"

#import <SDAutoLayout/SDAutoLayout.h>

#import "YHColorMacro.h"
#import "YHOtherMacro.h"

#import "YHPhotoManager.h"



@interface YHPhotoBroswerDetailCell()
@property (nonatomic,strong) UIImageView * assetImageView;
@end

@implementation YHPhotoBroswerDetailCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self.contentView addSubview:self.assetImageView];
    
    self.assetImageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}


- (void)setModel:(YHPhotoDetailModel *)model{
    _model = model;
    
    YH_WeakSelf(weakSelf);
    [YHPhotoManager requestImageWithAsset:_model.asset size:CGSizeMake(200, 200) resizeMode:PHImageRequestOptionsResizeModeFast deliveryMode:PHImageRequestOptionsDeliveryModeHighQualityFormat completion:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        weakSelf.assetImageView.image = image;
    }];
}

#pragma mark - getter
- (UIImageView *)assetImageView{
    if (!_assetImageView) {
        _assetImageView = [[UIImageView alloc] init];
        _assetImageView.contentMode = UIViewContentModeScaleAspectFill;
        _assetImageView.clipsToBounds = YES;
    }
    return _assetImageView;
}


@end
