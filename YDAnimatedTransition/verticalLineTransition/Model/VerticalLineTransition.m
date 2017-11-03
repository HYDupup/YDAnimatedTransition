//
//  VerticalLineTransition.m
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/20.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//

#import "VerticalLineTransition.h"

#define RANDOM_FLOAT(MIN,MAX) (((CGFloat)arc4random() / 0x100000000) * (MAX - MIN) + MIN);

@implementation VerticalLineTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //目的ViewController
    UIViewController *endControllView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //起始ViewController
    UIViewController *startControllView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    //起始界面的分割视图
    NSArray *startSnapshots = [self creatSnapshots:startControllView.view afterScreenUpdates:NO];
    //目的界面的分割视图
    UIView *endVC = [endControllView.view snapshotViewAfterScreenUpdates:YES];
    endVC.frame = [transitionContext finalFrameForViewController:endControllView];//是过渡开始和结束时每个 ViewController 的 frame
    NSArray *endSnapshots = [self creatSnapshots:endVC afterScreenUpdates:YES];
    
    startControllView.view.hidden = YES;
    
    for (UIView *snapshotView in startSnapshots) {
        [containerView addSubview:snapshotView];
    }
    for (UIView *snapshotView in endSnapshots) {
        [containerView addSubview:snapshotView];
    }
    
    [self removeSnapshots:endSnapshots];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self removeSnapshots:startSnapshots];
        [self restoreSnapshots:endSnapshots];
    } completion:^(BOOL finished) {
        if (![transitionContext transitionWasCancelled]) {
            startControllView.view.hidden = NO;
            [containerView addSubview:endControllView.view];
            for (UIView *snapshotView in startSnapshots) {
                [snapshotView removeFromSuperview];
            }
            for (UIView *snapshotView in endSnapshots) {
                [snapshotView removeFromSuperview];
            }
        }
        // 声明过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

    
}


//分割视图
-(NSMutableArray *)creatSnapshots:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates{
    
    NSMutableArray *snapshots = [NSMutableArray array];
    
    CGFloat height = 4.0;
    int number = (int)(view.height/height);
    for (int i=0; i <= number; i++) {
        CGRect frame = CGRectMake(0, i*height, view.width, height);
        UIView *snapshot = [view resizableSnapshotViewFromRect:frame afterScreenUpdates:afterScreenUpdates withCapInsets:UIEdgeInsetsZero];
        snapshot.frame = frame;
        [snapshots addObject:snapshot];
    }
    return snapshots;
}

//移动分割视图
-(void)removeSnapshots:(NSArray<UIView *> *)snapshots{
    //YES：向左 NO：向右
    BOOL direction = YES;
    
    for (UIView *snapshotView in snapshots) {
        
        CGFloat offsetY = CGRectGetWidth(snapshotView.frame) * RANDOM_FLOAT(1.0, 4.0);
        snapshotView.tx = direction ? -offsetY : offsetY;
        direction = !direction;
        
    }
    
}

//还原分割视图
-(void)restoreSnapshots:(NSArray<UIView *> *)snapshots{
    
    for (UIView *snapshotView in snapshots) {
        snapshotView.transform = CGAffineTransformIdentity;
    }
    
}



@end
