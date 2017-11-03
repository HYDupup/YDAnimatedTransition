//
//  ZoomTransition.m
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/17.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//

#import "ZoomTransition.h"

@implementation ZoomTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //目的ViewController
    UIViewController *endControllView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //起始ViewController
    UIViewController *startControllView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.transitiontype == pushNavigation) {
        [self pushNavigation:transitionContext andstratViewController:startControllView andEndViewController:endControllView];
    }else if (self.transitiontype == popNavigation){
     
        [self popNavigation:transitionContext andstratViewController:endControllView andEndViewController:startControllView];
    }
}

-(void)pushNavigation:(id <UIViewControllerContextTransitioning>)transitionContext andstratViewController:(UIViewController *)stratViewController andEndViewController:(UIViewController *)endViewController{
    
    //添加到上下文
    [[transitionContext containerView] insertSubview:endViewController.view aboveSubview:stratViewController.view];
    
    endViewController.view.transform = CGAffineTransformScale(endViewController.view.transform, 0.01, 0.01);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        endViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
-(void)popNavigation:(id <UIViewControllerContextTransitioning>)transitionContext andstratViewController:(UIViewController *)stratViewController andEndViewController:(UIViewController *)endViewController{
    //添加到上下文
    [[transitionContext containerView] insertSubview:stratViewController.view aboveSubview:endViewController.view];
    
    stratViewController.view.transform = CGAffineTransformScale(stratViewController.view.transform, 0.01, 0.01);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        stratViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
