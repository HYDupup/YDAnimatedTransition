//
//  CircleTransition.m
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/19.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//

#import "CircleTransition.h"


@implementation CircleTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //目的ViewController
    UIViewController *endControllView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //起始ViewController
    UIViewController *startControllView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    if (self.transitiontype == pushNavigation) {
        [[transitionContext containerView] addSubview:endControllView.view];
        [self navigation:transitionContext andstratViewController:startControllView andEndViewController:endControllView];
    }else if (self.transitiontype == popNavigation){
        [[transitionContext containerView] insertSubview:endControllView.view atIndex:0];
        [self navigation:transitionContext andstratViewController:startControllView andEndViewController:endControllView];
    }
}

-(void)navigation:(id <UIViewControllerContextTransitioning>)transitionContext andstratViewController:(UIViewController *)stratViewController andEndViewController:(UIViewController *)endViewController{
    
    //画起始圆
    UIBezierPath *stratbezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake([transitionContext containerView].centerX, [transitionContext containerView].centerY, 0.1, 0.1)];
    //结束圆
    CGFloat radius = sqrt(pow([transitionContext containerView].width/2, 2)+pow([transitionContext containerView].height/2, 2));
    UIBezierPath *endbezierPath = [UIBezierPath bezierPathWithArcCenter:[transitionContext containerView].center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = self.transitiontype ?  stratbezierPath.CGPath : endbezierPath.CGPath;//最终的shapeLayer
    
    if (self.transitiontype == pushNavigation) {
        endViewController.view.layer.mask = shapeLayer;
    }else{
        stratViewController.view.layer.mask = shapeLayer;
    }
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.keyPath = @"path";
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(self.transitiontype ? endbezierPath.CGPath : stratbezierPath.CGPath);//所改变属性的起始值
    maskLayerAnimation.toValue = (__bridge id)((self.transitiontype ? stratbezierPath.CGPath : endbezierPath.CGPath));//所改变属性的结束时的值
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];//动画的持续时间
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];//设置动画的速度变化
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [shapeLayer addAnimation:maskLayerAnimation forKey:@"path"];//开始动画
    
}

//动画已经结束的回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (self.transitiontype) {
        case pushNavigation:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }
            break;
        case popNavigation:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
           
        }
            break;
    }
}

@end
