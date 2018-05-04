//
//  YHPhotoBigPreVC.m
//  YHKit_OC
//
//  Created by 银河 on 2017/12/2.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoBigPreVC.h"

#import <Masonry/Masonry.h>
#import <SDAutoLayout/SDAutoLayout.h>

#import "YHSizeMacro.h"
#import "YHOtherMacro.h"


#import "YHPhotoBigPreNaviView.h"
#import "YHPhotoBigPreCell.h"


@interface YHPhotoBigPreVC () <YHPhotoBigPreNaviViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
    BOOL _naviHidden;
}
@property (nonatomic,strong) YHPhotoBigPreNaviView   * naviView;
@property (nonatomic,strong) UICollectionView        * collectionView;
@end

@implementation YHPhotoBigPreVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    _naviHidden = NO;
    
    [self setupUI];
}
- (void)setupUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.naviView];
    
    CGFloat naviHeight = 64.f;
    if (YH_SCREENHEIGHT == 812.f) {
        //iPhone X
        naviHeight = naviHeight + 24.f;
    }
    
    self.naviView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .heightIs(naviHeight);
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.left.and.right.and.bottom.equalTo(self.view);
        }
        make.top.equalTo(self.view);
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHPhotoBigPreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YHPhotoBigPreCell class]) forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    YH_WeakSelf(weakSelf);
    cell.singleTapBlock = ^{
        _naviHidden = !_naviHidden;
        [weakSelf.naviView setNaviHidden:_naviHidden];
    };
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - YHPhotoBigPreNaviViewDelegate
- (void)didBackActionForNaviView:(YHPhotoBigPreNaviView *)naviView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)naviView:(YHPhotoBigPreNaviView *)naviView didTouchSelectBtn:(UIButton *)selectBtn{
    if (selectBtn.selected) {
        
    } else {
        
    }
}
#pragma mark - getter
- (YHPhotoBigPreNaviView *)naviView{
    if (!_naviView) {
        _naviView = [[YHPhotoBigPreNaviView alloc] init];
        _naviView.delegate = self;
    }
    return _naviView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        if (@available(iOS 11.0, *)) {
            height = height - self.view.safeAreaInsets.bottom;
        }
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[YHPhotoBigPreCell class] forCellWithReuseIdentifier:NSStringFromClass([YHPhotoBigPreCell class])];
    }
    return _collectionView;
}




@end




































