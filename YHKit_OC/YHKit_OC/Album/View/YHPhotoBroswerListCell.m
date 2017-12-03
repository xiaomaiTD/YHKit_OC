//
//  YHPhotoBroswerListCell.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/25.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoBroswerListCell.h"

#import <SDAutoLayout/SDAutoLayout.h>

#import "YHOtherMacro.h"

#import "YHPhotoManager.h"

@interface YHPhotoBroswerListCell ()
@property (nonatomic,strong) UIImageView    * headImageView;
@property (nonatomic,strong) UILabel        * titleLabel;
@property (nonatomic,strong) UILabel        * countLabel;

@end

@implementation YHPhotoBroswerListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.countLabel];
        
        self.headImageView.sd_layout
        .leftSpaceToView(self.contentView, 15.f)
        .topSpaceToView(self.contentView, 5.f)
        .bottomSpaceToView(self.contentView, 5.f)
        .widthEqualToHeight();
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self.headImageView, 10.f)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .autoWidthRatio(0);
        
        self.countLabel.sd_layout
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .leftSpaceToView(self.titleLabel, 5.f)
        .autoWidthRatio(0);
    }
    return self;
}
#pragma mark - setter
- (void)setModel:(YHPhotoListModel *)model{
    _model = model;
    self.titleLabel.text = _model.albumTitle;
    self.countLabel.text = [NSString stringWithFormat:@"(%ld)",_model.count];
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:150.f];
    [self.countLabel setSingleLineAutoResizeWithMaxWidth:100.f];
    
    YH_WeakSelf(weakSelf);
    [YHPhotoManager requestImageWithAsset:_model.headAsset size:CGSizeMake(150, 150) resizeMode:PHImageRequestOptionsResizeModeFast deliveryMode:PHImageRequestOptionsDeliveryModeHighQualityFormat contentMode:PHImageContentModeAspectFill completion:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        weakSelf.headImageView.image = image;
    }];
}
#pragma mark - getter
- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont systemFontOfSize:17];
        _countLabel.textColor = [UIColor grayColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}
@end
