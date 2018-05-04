//
//  YHBarButtonItemConfigure.h
//  YHKit_OC
//
//  Created by 银河 on 2018/2/6.
//  Copyright © 2018年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface YHBarButtonItemConfigure : NSObject
/** 默认为空字符串 */
@property (nonatomic,copy,nullable) NSString    * itemNormaleTitle;
/** 默认为空 */
@property (nonatomic,copy,nullable) NSString    * itemSelectTitle;
/** 默认为空 */
@property (nonatomic,copy,nullable) NSString    * itemHighlightTitle;

/** 默认黑色 */
@property (nonatomic,strong,nullable) UIColor   * normalTitleColor;
/** 默认空 */
@property (nonatomic,strong,nullable) UIColor   * selectTitleColor;
/** 默认空 */
@property (nonatomic,strong,nullable) UIColor   * highlightTitleColor;

/** 默认17号字体 */
@property (nonatomic,strong,nullable) UIFont    * titleFont;

/** 默认空 */
@property (nonatomic,strong,nullable) UIImage   * normalImage;
/** 默认空 */
@property (nonatomic,strong,nullable) UIImage   * selectImage;
/** 默认空 */
@property (nonatomic,strong,nullable) UIImage   * highlightImage;
@end
NS_ASSUME_NONNULL_END








