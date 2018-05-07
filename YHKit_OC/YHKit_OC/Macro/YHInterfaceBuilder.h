//
//  YHInterfaceBuilder.h
//  YHKit_OC
//
//  Created by 银河 on 2018/5/3.
//  Copyright © 2018年 银河. All rights reserved.
//

#ifndef YHInterfaceBuilder_h
#define YHInterfaceBuilder_h

#define YH_VIEW_XIB(xibName)   [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] lastObject]
#define YH_VC_SB(storyboardName, Identifier) \
({ \
UIViewController *vc = nil; \
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil]; \
vc = [storyboard instantiateViewControllerWithIdentifier:Identifier]; \
(vc); \
})





#endif /* YHInterfaceBuilder_h */
