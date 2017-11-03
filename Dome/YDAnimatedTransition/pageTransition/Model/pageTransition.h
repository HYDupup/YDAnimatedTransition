//
//  pageTransition.h
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/18.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIView+HYDView.h"

@interface pageTransition : NSObject<UIViewControllerAnimatedTransitioning>

/*
 转场类型
 */
@property (nonatomic,assign)TransitionType transitiontype;

@end
