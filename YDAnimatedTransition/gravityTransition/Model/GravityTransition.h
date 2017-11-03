//
//  GravityTransition.h
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/20.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIView+HYDView.h"

@interface GravityTransition : NSObject<UIViewControllerAnimatedTransitioning>

/*
 转场类型
 */
@property (nonatomic,assign)TransitionType transitiontype;


@end
