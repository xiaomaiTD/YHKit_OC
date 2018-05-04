//
//  CustomNaviVC.m
//  YHKit_OC
//
//  Created by 银河 on 2018/2/8.
//  Copyright © 2018年 银河. All rights reserved.
//

#import "CustomNaviVC.h"
#import "YHKit_OC.h"
#import "LeftMenuVC.h"
#import "RightMenuVC.h"
#import "PushVC.h"

#import "VC1.h"

#import "UIViewController+YHTransition.h"

#import <Masonry/Masonry.h>

@interface CustomNaviVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) NSArray       * dataSource;
@property (nonatomic,strong) UITableView   * tableView;
@end

@implementation CustomNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",[UIDevice currentDevice].systemVersion);
    
    self.yh_navigationItem.title = @"1111";
    
//    UIBarButtonItem *leftItem = [UIBarButtonItem yh_systemItemWithImage:[UIImage imageNamed:@"yh_naiv_back"] target:self action:@selector(adsa:)];
//    self.yh_naviLeftBarButtonItem = leftItem;
//
//    UIBarButtonItem *rightItem1 = [UIBarButtonItem yh_systemItemWithTitle:@"1111" target:self action:@selector(adsa)];
////    rightItem1.tag = 100;
////    rightItem1.width = 400;
//    UIBarButtonItem *rightItem2 = [UIBarButtonItem yh_systemItemWithImage:[UIImage imageNamed:@"yh_naiv_back"] target:self action:@selector(adsa)];
////    self.yh_naviLeftBarButtonItem = leftItem;
//    self.yh_naviRightBarButtonItems = @[rightItem1,rightItem2];
////
////    self.yh_barTintColor = [UIColor clearColor];
////    self.yh_naviBgColor = [UIColor clearColor];
//    self.yh_naviBgColor = [UIColor cyanColor];
//////    self.yh_barTintColor = [UIColor cyanColor];
////
////    self.yh_naviTitleColor = [UIColor purpleColor];
////
////    self.yh_naviTintColor = [UIColor redColor];
////    self.yh_naviLeftBarButtonItem.tintColor = [UIColor orangeColor];
////
////    self.yh_navShadowColor = [UIColor redColor];
//    self.yh_isHideShadowImage = NO;
//
//    [self yh_setupDefaultNaviLeftBackItemWithAction:@selector(adsa:)];
    [self yh_setupDefaultSystemNaviLeftBackItemWithAction:@selector(adsa:)];
//
//
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = -5;
//    self.yh_naviRightBarButtonItems = @[spaceItem,rightItem1,rightItem2];
//
//    NSLog(@"++%f",rightItem1.width);
//    [self.yh_navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"--%@",NSStringFromClass([obj class]));
//        NSLog(@"--%ld",obj.tag);
//    }];
    
    
    YHBarButtonItemConfigure *configure = [[YHBarButtonItemConfigure alloc] init];
    configure.itemNormaleTitle = @"12345";
    configure.normalTitleColor = [UIColor redColor];
    UIBarButtonItem *item = [UIBarButtonItem yh_customizeItemWithItemType:YHBarButtonItemTitle configure:configure target:self action:@selector(haha:)];
    self.yh_naviRightBarButtonItems = @[YH_SPACE_ITEM(0), item];
    
    self.yh_naviRightBarButtonItem.tintColor = [UIColor purpleColor];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            make.left.and.right.and.bottom.equalTo(self.view);
        }
        make.top.equalTo(self.yh_navigationBar.mas_bottom).mas_offset(1);
    }];
    
    
    
    
    self.dataSource = @[@"打开左抽屉-YHDrawerOpenMenuAnimationType1",
                        @"打开左抽屉-YHDrawerOpenMenuAnimationType2",
                        @"打开右抽屉-YHDrawerOpenMenuAnimationType1",
                        @"打开右抽屉-YHDrawerOpenMenuAnimationType2",
                        @"自定义导航栏push",
                        @"自定义导航栏-转场push"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self aaaaaaa];
    });
}
- (void)aaaaaaa{
    NSLog(@"111");
}
- (void)adsa:(id)sender{
    NSLog(@"%@",sender);
}
- (void)haha:(UIButton *)sender{
    NSLog(@"%@",sender);
    
    CGRect frame = [sender convertRect:sender.bounds toView:self.view];
    
    NSLog(@"%@----%f",NSStringFromCGRect(frame),[UIScreen mainScreen].bounds.size.width);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //打开左抽屉--YHDrawerOpenMenuAnimationType1
        [YHDrawerVC sharedDrawer].leftMenuVC = [[LeftMenuVC alloc] init];
        [YHDrawerVC sharedDrawer].openLeftMenuAnimationType = YHDrawerOpenMenuAnimationType1;
        [YHDrawerVC sharedDrawer].leftMenuWidth = 250.f;
        [[YHDrawerVC sharedDrawer] openLeftMenu];
    } else if (indexPath.row == 1) {
        //打开左抽屉--YHDrawerOpenMenuAnimationType2
        [YHDrawerVC sharedDrawer].leftMenuVC = [[LeftMenuVC alloc] init];
        [YHDrawerVC sharedDrawer].openLeftMenuAnimationType = YHDrawerOpenMenuAnimationType2;
        [YHDrawerVC sharedDrawer].leftMenuWidth = 250.f;
        [[YHDrawerVC sharedDrawer] openLeftMenu];
    } else if (indexPath.row == 2) {
        //打开右抽屉--YHDrawerOpenMenuAnimationType1
        [YHDrawerVC sharedDrawer].rightMenuVC = [[RightMenuVC alloc] init];
        [YHDrawerVC sharedDrawer].openRightMenuAnimationType = YHDrawerOpenMenuAnimationType1;
        [YHDrawerVC sharedDrawer].rightMenuWidth = 300.f;
        [[YHDrawerVC sharedDrawer] openRightMenu];
    } else if (indexPath.row == 3) {
        //打开右抽屉--YHDrawerOpenMenuAnimationType2
        [YHDrawerVC sharedDrawer].rightMenuVC = [[RightMenuVC alloc] init];
        [YHDrawerVC sharedDrawer].openRightMenuAnimationType = YHDrawerOpenMenuAnimationType2;
        [YHDrawerVC sharedDrawer].rightMenuWidth = 300.f;
        [[YHDrawerVC sharedDrawer] openRightMenu];
    } else if (indexPath.row == 4) {
        [YHDrawerVC sharedDrawer].drawerColor = [UIColor whiteColor];
        PushVC *vc = [[PushVC alloc] init];
//        [self yh_pushViewController:vc animationDuration:3 animationType:YHTransitionAnimationTypeScaleEnlarge animated:YES];
    } else if (indexPath.row == 5) {
        [YHDrawerVC sharedDrawer].drawerColor = [UIColor blackColor];
        
        VC1 *vc = [[VC1 alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//        [self yh_pushViewController:vc makeTransition:^(YHTransitionManager * _Nonnull transition) {
//            transition.animationDuration = YH_Kugou_Animation;
//            transition.animationType = YHTransitionAnimationTypeKuGouPush;
//            transition.isAddCoverView = NO;
//        } animated:YES completion:^{
//            YHLog(@"完了");
//        }];
    }
}

#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"1"];
    }
    return _tableView;
}

@end


















