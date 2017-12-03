//
//  YHPhotoDetailListVC.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/25.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoDetailListVC.h"

#import <Masonry/Masonry.h>

#import "YHSizeMacro.h"
#import "YHOtherMacro.h"

#import "YHPhotoListModel.h"
#import "YHPhotoDetailBottomView.h"
#import "YHPhotoBroswerDetailCell.h"
#import "YHPhotoBigPreVC.h"


static CGFloat const kBottomVireHeight                   = 49.f;
static CGFloat const kSpace                              = 5.f;
static int const kPerLineCount                           = 4;


@interface YHPhotoDetailListVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView                     * collectionView;
@property (nonatomic,strong) YHPhotoDetailBottomView              * bottomView;

@property (nonatomic,strong) NSMutableArray<YHPhotoDetailModel *> * dataSource;
@end

@implementation YHPhotoDetailListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.selectedListModel.albumTitle;
    self.dataSource = [NSMutableArray array];
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.selectedListModel.result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YHPhotoDetailModel *model = [[YHPhotoDetailModel alloc] init];
        model.isSelected = NO;
        model.asset = obj;
        [self.dataSource addObject:model];
    }];
    
    //此处不能再reloadData，不然，会造成图片错乱
    [self setupUI];
    
    
}
- (void)setupUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.left.and.right.and.bottom.equalTo(self.view);
        }
        make.height.mas_equalTo(kBottomVireHeight);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.left.and.right.and.top.equalTo(self.view);
        }
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

- (void)changeBottomViewState{
    __block NSInteger selectCount = 0;
    [self.dataSource enumerateObjectsUsingBlock:^(YHPhotoDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            selectCount ++;
        }
    }];
    [self.bottomView setSelectedCount:selectCount];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHPhotoBroswerDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YHPhotoBroswerDetailCell class]) forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    
    YH_WeakSelf(weakSelf);
    cell.selectBlock = ^{
        [weakSelf changeBottomViewState];
    };
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YHPhotoBigPreVC *vc = [[YHPhotoBigPreVC alloc] init];
    vc.dataSource = self.dataSource;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter
- (YHPhotoDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[YHPhotoDetailBottomView alloc] init];
    }
    return _bottomView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat width = (YH_SCREENWIDTH - (kPerLineCount+1)*kSpace)/kPerLineCount;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(width, width);
        layout.sectionInset = UIEdgeInsetsMake(kSpace, kSpace, kSpace, kSpace);
        layout.minimumLineSpacing = kSpace;
        layout.minimumInteritemSpacing = kSpace;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[YHPhotoBroswerDetailCell class] forCellWithReuseIdentifier:NSStringFromClass([YHPhotoBroswerDetailCell class])];
    }
    return _collectionView;
}
@end























