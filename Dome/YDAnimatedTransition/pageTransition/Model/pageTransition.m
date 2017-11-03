//
//  pageTransition.m
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/18.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//

#import "pageTransition.h"

@implementation pageTransition

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
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.002;
    [transitionContext containerView].layer.sublayerTransform = transfrom3d;
    [[transitionContext containerView] addSubview:endViewController.view];
    [[transitionContext containerView] addSubview:stratViewController.view];
    
    CGPoint point = CGPointMake(0, 0.5);
    [self setAnchorPointTo:stratViewController.view andPoint:point];
    
    //添加阴影
    [self addShadowView:stratViewController.view];
    stratViewController.view.subviews.lastObject.alpha = 0;
    [self addShadowView:endViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        stratViewController.view.subviews.lastObject.alpha = 1;
        endViewController.view.subviews.lastObject.alpha = 0;
        stratViewController.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            stratViewController.view.layer.transform = CATransform3DIdentity;
            [stratViewController.view.subviews.lastObject removeFromSuperview];
            [endViewController.view.subviews.lastObject removeFromSuperview];
        }
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

-(void)popNavigation:(id <UIViewControllerContextTransitioning>)transitionContext andstratViewController:(UIViewController *)stratViewController andEndViewController:(UIViewController *)endViewController{
    //添加到上下文
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.002;
    [transitionContext containerView].layer.sublayerTransform = transfrom3d;
    [[transitionContext containerView] addSubview:endViewController.view];
    [[transitionContext containerView] addSubview:stratViewController.view];

    CGPoint point = CGPointMake(0, 0.5);
    [self setAnchorPointTo:stratViewController.view andPoint:point];
    
    //添加阴影
    [self addShadowView:stratViewController.view];
    [self addShadowView:endViewController.view];
    endViewController.view.subviews[endViewController.view.subviews.count-1].alpha = 0;
    
    stratViewController.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        stratViewController.view.subviews.lastObject.alpha = 0;
        endViewController.view.subviews.lastObject.alpha = 1;
        stratViewController.view.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            [stratViewController.view.subviews.lastObject removeFromSuperview];
            [endViewController.view.subviews.lastObject removeFromSuperview];
        }
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

//添加阴影
-(void)addShadowView:(UIView *)view{
    UIView *tpyeView = [[UIView alloc]initWithFrame:view.bounds];
    [tpyeView setBackgroundColor:[UIColor clearColor]];
    tpyeView.alpha = 1;
    CAGradientLayer *typeLayer = [CAGradientLayer layer];
    typeLayer.opacity = 1;
    typeLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    typeLayer.frame = view.bounds;
    typeLayer.startPoint = CGPointMake(0, 1);
    typeLayer.endPoint = CGPointMake(1, 1);
    [tpyeView.layer addSublayer:typeLayer];
    [view addSubview:tpyeView];
}

- (void)setAnchorPointTo:(UIView *)view andPoint:(CGPoint)point {
    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
}

@end
