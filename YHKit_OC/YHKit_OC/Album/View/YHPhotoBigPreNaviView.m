//
//  YHPhotoBigPreNaviView.m
//  YHKit_OC
//
//  Created by 银河 on 2017/12/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoBigPreNaviView.h"

#import <SDAutoLayout/SDAutoLayout.h>



@interface YHPhotoBigPreNaviView()
@property (nonatomic,strong) UIView      * bar;
@property (nonatomic,strong) UIButton    * backBtn;
@property (nonatomic,strong) UILabel     * titleLabel;
@property (nonatomic,strong) UIButton    * selectBtn;
@end

@implementation YHPhotoBigPreNaviView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.bar];
    [self.bar addSubview:self.backBtn];
    [self.bar addSubview:self.selectBtn];
    [self.bar addSubview:self.titleLabel];
    
    self.bar.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(44.f);
    
    self.backBtn.sd_layout
    .leftEqualToView(self.bar)
    .topEqualToView(self.bar)
    .bottomEqualToView(self.bar)
    .widthIs(60.f);
    
    self.selectBtn.sd_layout
    .rightEqualToView(self.bar)
    .topEqualToView(self.bar)
    .bottomEqualToView(self.bar)
    .widthIs(60.f);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.backBtn, 0)
    .rightSpaceToView(self.selectBtn, 0)
    .topEqualToView(self.bar)
    .bottomEqualToView(self.bar);
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
- (void)backBtnClick:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(didBackActionForNaviView:)]) {
        [_delegate didBackActionForNaviView:self];
    }
}
- (void)selectBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(naviView:didTouchSelectBtn:)]) {
        [_delegate naviView:self didTouchSelectBtn:sender];
    }
    [sender.layer addAnimation:[self addButtonScaleAnimation] forKey:nil];
}
#pragma mark - public method
- (void)setSelectBtnSelect:(BOOL)isSelect{
    self.selectBtn.selected = isSelect;
}
- (void)setNaviHidden:(BOOL)isHidden{
    self.hidden = isHidden;
}
#pragma mark - setter
- (void)setNaviTitle:(NSString *)naviTitle{
    _naviTitle = naviTitle;
    self.titleLabel.text = _naviTitle;
}
#pragma mark - getter
- (UIView *)bar{
    if (!_bar) {
        _bar = [[UIView alloc] init];
    }
    return _bar;
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"yh_photo_naviBack"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
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
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}





@end
