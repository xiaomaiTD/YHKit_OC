//
//  YHPhotoListVC.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/25.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoListVC.h"

#import <Masonry/Masonry.h>


#import "YHDebugMacro.h"
#import "YHMBHud.h"
#import "YHOtherMacro.h"
#import "YHThreadMacro.h"

#import "YHPhotoBroswerHeader.h"
#import "YHPhotoManager.h"
#import "YHPhotoBroswerListCell.h"
#import "YHPhotoDetailListVC.h"

@interface YHPhotoListVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView                   * tableView;
@property (nonatomic,strong) NSArray<YHPhotoListModel *>   * dataSource;
@end

@implementation YHPhotoListVC
- (void)dealloc{
    YHLog(@"YHPhotoListVC dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = YHPhotoBroswerStr(@"YHPhotoBroswer.albumListTitle", @"相册列表");
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:YHPhotoBroswerStr(@"YHPhotoBroswer.cancel", @"取消") style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self setupUI];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    YH_WeakSelf(weakSelf);
    MBProgressHUD *hud = [YHMBHud hudWithMessage:nil inView:self.view];
    [YHPhotoManager getPhotoAlbumListWithCompletionBlock:^(NSArray<YHPhotoListModel *> *photoAlbumLists) {
        [hud hideAnimated:YES];
        weakSelf.dataSource = [NSArray arrayWithArray:photoAlbumLists];
        yh_DISPATCH_MAIN_THREAD(^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void)setupUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.left.and.right.and.top.and.bottom.equalTo(self.view);
        }
    }];
}
- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)pushToListVcWithModel:(YHPhotoListModel *)model{
    YHPhotoDetailListVC *listVc = [[YHPhotoDetailListVC alloc] init];
    listVc.selectedListModel = model;
    [self.navigationController pushViewController:listVc animated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHPhotoBroswerListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YHPhotoBroswerListCell class])];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHPhotoListModel *model = self.dataSource[indexPath.row];
    [self pushToListVcWithModel:model];
}
#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 65.f;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[YHPhotoBroswerListCell class] forCellReuseIdentifier:NSStringFromClass([YHPhotoBroswerListCell class])];
    }
    return _tableView;
}
@end
