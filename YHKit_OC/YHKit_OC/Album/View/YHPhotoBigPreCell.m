//
//  YHPhotoBigPreCell.m
//  YHKit_OC
//
//  Created by 银河 on 2017/12/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoBigPreCell.h"

#import <SDAutoLayout/SDAutoLayout.h>
#import <Masonry/Masonry.h>

#import "YHOtherMacro.h"
#import "YHColorMacro.h"

#import "YHPhotoManager.h"


@interface YHPhotoBigPreCell()
@property (nonatomic,strong) UIImageView * assetImageView;
@end

@implementation YHPhotoBigPreCell
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
#pragma mark - setter
- (void)setModel:(YHPhotoDetailModel *)model{
    _model = model;
    YH_WeakSelf(weakSelf);
    [YHPhotoManager requestImageWithAsset:_model.asset size:self.bounds.size resizeMode:PHImageRequestOptionsResizeModeFast deliveryMode:PHImageRequestOptionsDeliveryModeHighQualityFormat completion:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        weakSelf.assetImageView.image = image;
    }];
}
#pragma mark - getter
- (UIImageView *)assetImageView{
    if (!_assetImageView) {
        _assetImageView = [[UIImageView alloc] init];
        _assetImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _assetImageView;
}
@end
