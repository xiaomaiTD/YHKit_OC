//
//  YHPhotoDetailBottomView.m
//  YHKit_OC
//
//  Created by 银河 on 2017/12/1.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoDetailBottomView.h"

#import <SDAutoLayout/SDAutoLayout.h>

#import "YHPhotoBroswerHeader.h"

#define kColor   [UIColor colorWithRed:38/255.0 green:185/255.0 blue:34/255.0 alpha:1]

@interface YHPhotoDetailBottomView()
@property (nonatomic,strong) UIButton * preBtn;
@property (nonatomic,strong) UIButton * sureBtn;
@end

@implementation YHPhotoDetailBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
        
        [self sureForNoPhoto];
        [self preForPhoto:0];
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.preBtn];
    [self addSubview:self.sureBtn];
    
    self.preBtn.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(70.f);
    
    self.sureBtn.sd_layout
    .centerYEqualToView(self)
    .heightRatioToView(self, 0.7)
    .rightSpaceToView(self, 15.f)
    .widthIs(80.f);
}
- (void)setSelectedCount:(NSInteger)count{
    if (count == 0) {
        [self sureForNoPhoto];
    } else {
        [self sureFoPhoto:count];
    }
    [self preForPhoto:count];
}
- (void)sureForNoPhoto{
    self.sureBtn.userInteractionEnabled = NO;
    self.sureBtn.alpha = 0.3;
    [self.sureBtn setTitle:YHPhotoBroswerStr(@"YHPhotoBroswer.completion", @"完成") forState:UIControlStateNormal];
}
- (void)sureFoPhoto:(NSInteger)count{
    self.sureBtn.userInteractionEnabled = YES;
    self.sureBtn.alpha = 1;
    [self.sureBtn setTitle:[NSString stringWithFormat:@"%@(%ld)",YHPhotoBroswerStr(@"YHPhotoBroswer.completion", @"完成"),count] forState:UIControlStateNormal];
}
- (void)preForPhoto:(NSInteger)count{
    if (count == 0) {
        self.preBtn.userInteractionEnabled = NO;
        self.preBtn.alpha = 0.3;
    } else {
        self.preBtn.userInteractionEnabled = YES;
        self.preBtn.alpha = 1;
    }
}
#pragma mark - action
- (void)preBtnClick:(UIButton *)sender{
    
}
- (void)sureBtnClick:(UIButton *)sender{
    
}







#pragma mark - getter
- (UIButton *)preBtn{
    if (!_preBtn) {
        _preBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_preBtn setTitleColor:kColor forState:UIControlStateNormal];
        [_preBtn setTitle:YHPhotoBroswerStr(@"YHPhotoBroswer.pre", @"预览") forState:UIControlStateNormal];
        [_preBtn addTarget:self action:@selector(preBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _preBtn;
}
- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = kColor;
        _sureBtn.layer.cornerRadius = 3.f;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _sureBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}










@end
