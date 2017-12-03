//
//  YHPhotoBigPreNaviView.h
//  YHKit_OC
//
//  Created by 银河 on 2017/12/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHPhotoBigPreNaviViewDelegate;
@interface YHPhotoBigPreNaviView : UIView
@property (nonatomic,assign) id<YHPhotoBigPreNaviViewDelegate> delegate;

/** setter -- 设置自定义导航栏标题的setter方法 */
@property (nonatomic,copy) NSString * naviTitle;

/** 设置选择按钮点击状态的公共方法 */
- (void)setSelectBtnSelect:(BOOL)isSelect;

/** 设置自定义导航栏是否隐藏的公共方法 */
- (void)setNaviHidden:(BOOL)isHidden;

@end



@protocol YHPhotoBigPreNaviViewDelegate <NSObject>
@optional;
/** 返回按钮点击委托 */
- (void)didBackActionForNaviView:(YHPhotoBigPreNaviView *)naviView;
/** 选择按钮点击委托 */
- (void)naviView:(YHPhotoBigPreNaviView *)naviView didTouchSelectBtn:(UIButton *)selectBtn;
@end
