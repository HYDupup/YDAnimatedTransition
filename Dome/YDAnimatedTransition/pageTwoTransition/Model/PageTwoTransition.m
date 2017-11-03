//
//  PageTwoTransition.m
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/19.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//

#import "PageTwoTransition.h"

@implementation PageTwoTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //目的ViewController
    UIViewController *endControllView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //起始ViewController
    UIViewController *startControllView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.transitiontype == pushNavigation) {
        [self navigation:transitionContext andstratViewController:startControllView andEndViewController:endControllView];
    }else if (self.transitiontype == popNavigation){
        [self navigation:transitionContext andstratViewController:startControllView andEndViewController:endControllView];
    }
}

-(void)navigation:(id <UIViewControllerContextTransitioning>)transitionContext andstratViewController:(UIViewController *)stratViewController andEndViewController:(UIViewController *)endViewController{
    
    [[transitionContext containerView]addSubview:endViewController.view];
    
    //切割fromVC
    NSArray *stratVCSnapshots = [self creatSnapshots:stratViewController.view afterScreenUpdates:NO];
    UIView *stratVCright = stratVCSnapshots[0];
    [self addShadowView:stratVCright andDirection:0];
    stratVCright.subviews.lastObject.alpha = 0;
    UIView *stratVCleft = stratVCSnapshots[1];
    [self addShadowView:stratVCleft andDirection:1];
    stratVCleft.subviews.lastObject.alpha = 0;
   
    CATransform3D stratVCrighttransform3D = CATransform3DIdentity;
    stratVCrighttransform3D.m34 = -0.002;
    (self.transitiontype ? stratVCleft : stratVCright).layer.transform = stratVCrighttransform3D;
    CGPoint stratVCpoint = CGPointMake(self.transitiontype ? 0 : 1, 0.5);
    [self setAnchorPointTo:self.transitiontype ? stratVCleft : stratVCright andPoint:stratVCpoint];

    //切割toVC
    NSArray *endVCSnapshots = [self creatSnapshots:endViewController.view afterScreenUpdates:YES];
    UIView *endVCright = endVCSnapshots[0];
    [self addShadowView:endVCright andDirection:0];
    UIView *endVCleft = endVCSnapshots[1];
    [self addShadowView:endVCleft andDirection:1];
    
    CATransform3D endVCLeft3D = CATransform3DIdentity;
    endVCLeft3D.m34 = -0.002;
    (self.transitiontype ? endVCright : endVCleft).layer.transform = endVCLeft3D;
    CGPoint point = CGPointMake(self.transitiontype ? 1 : 0, 0.5);
    [self setAnchorPointTo:self.transitiontype ? endVCright : endVCleft andPoint:point];

    if (self.transitiontype == pushNavigation) {
        endVCleft.layer.transform = CATransform3DRotate(endVCleft.layer.transform,-M_PI_2, 0, 1, 0);
        [[transitionContext containerView]addSubview:endVCright];
        [[transitionContext containerView]addSubview:stratVCright];
        [[transitionContext containerView]addSubview:stratVCleft];
        [[transitionContext containerView]addSubview:endVCleft];
    }else{
        endVCright.layer.transform = CATransform3DRotate(endVCright.layer.transform, M_PI_2, 0, 1, 0);
        [[transitionContext containerView]addSubview:endVCleft];
        [[transitionContext containerView]addSubview:stratVCright];
        [[transitionContext containerView]addSubview:stratVCleft];
        [[transitionContext containerView]addSubview:endVCright];
    }
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            stratVCright.subviews.lastObject.alpha = 1;
            stratVCleft.subviews.lastObject.alpha = 1;
            if (self.transitiontype == pushNavigation) {
                stratVCright.layer.transform = CATransform3DRotate(stratVCright.layer.transform, M_PI_2, 0, 1, 0);
            }else{
                stratVCleft.layer.transform = CATransform3DRotate(stratVCright.layer.transform, -M_PI_2, 0, 1, 0);
            }
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            endVCleft.subviews.lastObject.alpha = 0;
            endVCright.subviews.lastObject.alpha = 0;
            if (self.transitiontype == pushNavigation) {
                endVCleft.layer.transform = CATransform3DIdentity;
            }else{
                endVCright.layer.transform =CATransform3DIdentity;
            }
        }];

    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            [stratVCright removeFromSuperview];
            [stratVCleft removeFromSuperview];
            [endVCright removeFromSuperview];
            [endVCleft removeFromSuperview];
        }
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

-(void)popNavigation:(id <UIViewControllerContextTransitioning>)transitionContext andstratViewController:(UIViewController *)stratViewController andEndViewController:(UIViewController *)endViewController{

    [[transitionContext containerView]addSubview:endViewController.view];
    
    //切割fromVC
    NSArray *stratVCSnapshots = [self creatSnapshots:stratViewController.view afterScreenUpdates:NO];
    UIView *stratVCright = stratVCSnapshots[0];
    [self addShadowView:stratVCright andDirection:0];
    stratVCright.subviews.lastObject.alpha = 0;
    UIView *stratVCleft = stratVCSnapshots[1];
    [self addShadowView:stratVCleft andDirection:1];
    stratVCleft.subviews.lastObject.alpha = 0;
    
    CATransform3D stratVClefttransform3D = CATransform3DIdentity;
    stratVClefttransform3D.m34 = -0.002;
    stratVCleft.layer.transform = stratVClefttransform3D;
    CGPoint stratVCpoint = CGPointMake(0, 0.5);
    [self setAnchorPointTo:stratVCleft andPoint:stratVCpoint];

    //切割toVC
    NSArray *endVCSnapshots = [self creatSnapshots:endViewController.view afterScreenUpdates:YES];
    UIView *endVCright = endVCSnapshots[0];
    [self addShadowView:endVCright andDirection:0];
    UIView *endVCleft = endVCSnapshots[1];
    [self addShadowView:endVCleft andDirection:1];
    
    CATransform3D endVCright3D = CATransform3DIdentity;
    endVCright3D.m34 = -0.002;
    endVCright.layer.transform = endVCright3D;
    CGPoint point = CGPointMake(1, 0.5);
    [self setAnchorPointTo:endVCright andPoint:point];
    endVCright.layer.transform = CATransform3DRotate(endVCright.layer.transform, M_PI_2, 0, 1, 0);
    
  
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            stratVCright.subviews.lastObject.alpha = 1;
            stratVCleft.subviews.lastObject.alpha = 1;
            stratVCleft.layer.transform = CATransform3DRotate(stratVCright.layer.transform, -M_PI_2, 0, 1, 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            endVCleft.subviews.lastObject.alpha = 0;
            endVCright.subviews.lastObject.alpha = 0;
            endVCright.layer.transform =CATransform3DIdentity;
        }];
        
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            [stratVCright removeFromSuperview];
            [stratVCleft removeFromSuperview];
            [endVCright removeFromSuperview];
            [endVCleft removeFromSuperview];
        }
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

//切割界面
-(NSArray *)creatSnapshots:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates{
    
    //rightView
    CGRect rightViewFrame = CGRectMake(0, 0, view.width/2, view.height);
    //参数为YES，代表视图的属性改变渲染完毕后截屏，参数为NO代表立刻将当前状态的视图截图
    UIView *rightView = [view resizableSnapshotViewFromRect:rightViewFrame afterScreenUpdates:afterScreenUpdates withCapInsets:UIEdgeInsetsZero];
    rightView.frame = rightViewFrame;
    
    //leftView
    CGRect leftViewFrame = CGRectMake(view.width/2, 0, view.width/2, view.height);
    UIView *leftView = [view resizableSnapshotViewFromRect:leftViewFrame afterScreenUpdates:afterScreenUpdates withCapInsets:UIEdgeInsetsZero];
    leftView.frame = leftViewFrame;
        
    return @[rightView,leftView];
}

//添加阴影
-(void)addShadowView:(UIView *)view andDirection:(int)direction{
    UIView *tpyeView = [[UIView alloc]initWithFrame:view.bounds];
    [tpyeView setBackgroundColor:[UIColor clearColor]];
    tpyeView.alpha = 1;
    CAGradientLayer *typeLayer = [CAGradientLayer layer];
    typeLayer.opacity = 1;
    if (direction == 0) {
        typeLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    }else{
        typeLayer.colors = @[(id)[UIColor blackColor].CGColor,(id)[UIColor clearColor].CGColor];
    }
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
