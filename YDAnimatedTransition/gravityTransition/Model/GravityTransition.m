//
//  GravityTransition.m
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/20.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//

#import "GravityTransition.h"

@implementation GravityTransition{
    //动力学动画 ：需要设置全局变量 否则无效
    UIDynamicAnimator * _dynamicAnimator;
//    //捕捉所有行为
//    UIDynamicBehavior * _dynamicBehavior;
//    //重力行为
//    UIGravityBehavior * _gravityBehavior;
//    //碰撞行为
//    UICollisionBehavior * _collisionBehavior;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //目的ViewController
    UIViewController *endControllView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //起始ViewController
    UIViewController *startControllView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    startControllView.view.hidden = YES;
    [containerView addSubview:endControllView.view];
    
    NSArray *startSnapshots = [self creatSnapshots:startControllView.view afterScreenUpdates:NO];
    for (UIView *snapshot in startSnapshots) {
        [containerView addSubview:snapshot];
    }
    
    _dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:containerView];
    UIDynamicBehavior *dynamicBehavior = [[UIDynamicBehavior alloc]init];//捕捉所有行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:startSnapshots];//重力行为
    //加速度 越大下落速度越快
    gravityBehavior.magnitude = 2.5;
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:startSnapshots];//碰撞行为
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;//转换为参考坐标系为碰撞边界
    /*
    // 元素之间的碰撞
    UICollisionBehaviorModeItems        = 1 << 0,
    // 边界碰撞
    UICollisionBehaviorModeBoundaries   = 1 << 1,
    // 碰撞所有
    UICollisionBehaviorModeEverything   = NSUIntegerMax
    */
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    
    [dynamicBehavior addChildBehavior:gravityBehavior];
    [dynamicBehavior addChildBehavior:collisionBehavior];

    for (UIView *snapshot in startSnapshots) {
        UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[snapshot]];
       /* 
        elasticity（弹性系数） – 决定了碰撞的弹性程度，比如碰撞时物体的弹性。
        friction（摩擦系数） – 决定了沿接触面滑动时的摩擦力大小。
        density（密度） – 跟 size 结合使用，来计算物体的总质量。质量越大，物体加速或减速就越困难。
        resistance（阻力） – 决定线性移动的阻力大小，这根摩擦系数不同，摩擦系数只作用于滑动运动。
        angularResistance（转动阻力） – 决定转动运动的阻力大小。
        allowsRotation（允许旋转） – 这个属性很有意思，它在真实的物理世界没有对应的模型。设置这个属性为 NO 物体就完全不会转动，无力受到多大的转动力。
        */
        dynamicItemBehavior.elasticity = (rand() % 5) / 8.0;
        dynamicItemBehavior.density = (rand() % 5 / 3.0);
        [dynamicBehavior addChildBehavior:dynamicItemBehavior];
    }
    
    [_dynamicAnimator addBehavior:dynamicBehavior];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        for (UIView *snapshot in startSnapshots) {
            snapshot.alpha = 0;
        }
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            startControllView.view.hidden = NO;
            for (UIView *snapshot in startSnapshots) {
                [snapshot removeFromSuperview];
            }
        }
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

-(NSMutableArray *)creatSnapshots:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates{
    
    NSMutableArray *snapshots = [NSMutableArray array];
    
    int lineNumber = 5;
    int listNumber = 6;
    CGFloat width = view.width/lineNumber;
    CGFloat height = view.height/listNumber;
    
    for (int i=0; i<lineNumber*listNumber; i++) {
        int line = i%5;
        int list = i/5;
        CGRect frame = CGRectMake(line*width, list*height, width, height);
        UIView *snapshot = [view resizableSnapshotViewFromRect:frame afterScreenUpdates:afterScreenUpdates withCapInsets:UIEdgeInsetsZero];
        snapshot.frame = frame;
        CGFloat angle = ((list + line) % 2 ? 1 : -1) * (rand() % 5 / 10.0);
        snapshot.transform = CGAffineTransformMakeRotation(angle);
        [snapshots addObject:snapshot];
    }
    
    return snapshots;
}

@end
