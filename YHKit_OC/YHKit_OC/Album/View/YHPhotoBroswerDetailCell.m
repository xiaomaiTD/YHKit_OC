//
//  YHPhotoBroswerDetailCell.m
//  YHKit_OC
//
//  Created by 银河 on 2017/12/1.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoBroswerDetailCell.h"
#import <objc/message.h>
#import <SDAutoLayout/SDAutoLayout.h>

#import "YHColorMacro.h"
#import "YHOtherMacro.h"

#import "YHPhotoManager.h"



@interface YHPhotoBroswerDetailCell()
@property (nonatomic,strong) UIImageView * assetImageView;
@property (nonatomic,strong) UIButton * selectBtn;
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
    [self.assetImageView addSubview:self.selectBtn];
    
    self.assetImageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    self.selectBtn.sd_layout
    .rightEqualToView(self.assetImageView)
    .topEqualToView(self.assetImageView)
    .widthRatioToView(self.assetImageView, 0.3)
    .heightEqualToWidth();
}


- (void)setModel:(YHPhotoDetailModel *)model{
    _model = model;
    self.selectBtn.selected = _model.isSelected;
    YH_WeakSelf(weakSelf);
    [YHPhotoManager requestImageWithAsset:_model.asset size:CGSizeMake(200, 200) resizeMode:PHImageRequestOptionsResizeModeFast deliveryMode:PHImageRequestOptionsDeliveryModeHighQualityFormat completion:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        weakSelf.assetImageView.image = image;
    }];
}
- (CAKeyframeAnimation *)addButtonScaleAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform";
    animation.duration = 0.3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,1.0, 1.0)]];
    return animation;
}
#pragma mark - action
- (void)selectBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    [sender.layer addAnimation:[self addButtonScaleAnimation] forKey:nil];
    _model.isSelected = sender.selected;
    
    _selectBlock ? _selectBlock() : nil;
}

#pragma mark - getter
- (UIImageView *)assetImageView{
    if (!_assetImageView) {
        _assetImageView = [[UIImageView alloc] init];
        _assetImageView.contentMode = UIViewContentModeScaleAspectFill;
        _assetImageView.clipsToBounds = YES;
        _assetImageView.userInteractionEnabled = YES;
    }
    return _assetImageView;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"yh_photo_image_normal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"yh_photo_image_selected"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}


@end
