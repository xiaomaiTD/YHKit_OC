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
#import "YHSizeMacro.h"
#import "YHDebugMacro.h"

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
        
        [self addGesture];
    }
    return self;
}
- (void)setupUI{
    [self.contentView addSubview:self.assetImageView];
    self.assetImageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}
- (void)addGesture{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)];
    singleTap.numberOfTapsRequired = 1;
    [self.contentView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    doubleTap.numberOfTapsRequired = 2;
    [self.contentView addGestureRecognizer:doubleTap];
    
    //这行很关键，意思是只有当没有检测到doubleTap 或者 检测doubleTap失败，singleTap才有效
    [singleTap requireGestureRecognizerToFail:doubleTap];
}
#pragma mark - action
- (void)singleTap{
    YHLog(@"单击");
    _singleTapBlock ? _singleTapBlock() : nil;
}
- (void)doubleTap{
    YHLog(@"双击，待完成");
}
#pragma mark - setter
- (void)setModel:(YHPhotoDetailModel *)model{
    _model = model;
    YH_WeakSelf(weakSelf);
    [YHPhotoManager requestImageWithAsset:_model.asset size:CGSizeMake(YH_SCREENWIDTH*2, YH_SCREENHEIGHT*2) resizeMode:PHImageRequestOptionsResizeModeExact deliveryMode:PHImageRequestOptionsDeliveryModeHighQualityFormat contentMode:PHImageContentModeAspectFit completion:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
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
