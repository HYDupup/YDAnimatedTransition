//
//  ViewController.m
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/17.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//

#import "ViewController.h"
#import "EndViewController.h"

#import "ZoomTransition.h"
#import "pageTransition.h"
#import "PageTwoTransition.h"
#import "CircleTransition.h"
#import "LevelLineTransition.h"
#import "VerticalLineTransition.h"
#import "GravityTransition.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic,strong)NSArray *transitions;

@property (nonatomic,strong)UITableView *tableView;

@end

static int selectIndex = 0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    
    self.transitions = @[@"ZoomTransition",@"pageTransition",@"PageTwoTransition",@"CircleTransition",@"LevelLineTransition",@"VerticalLineTransition",@"GravityTransition"];
    
    [self CreatUI];
}

#pragma mark CreatUI
-(void)CreatUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.transitions.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.transitions[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectIndex = (int)indexPath.row;
    [self.navigationController pushViewController:[[EndViewController alloc]init] animated:YES];
}


#pragma mark 自定义转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        if ([toVC isKindOfClass:[EndViewController class]]) {
            return [self transition:selectIndex andTransitiontype:pushNavigation];
       }
    }else if(operation == UINavigationControllerOperationPop){
        if ([toVC isKindOfClass:[ViewController class]]) {
            return [self transition:selectIndex andTransitiontype:popNavigation];
        }
    }
    return nil;
}

#pragma mark 跳转的动画选择
-(id)transition:(int)index andTransitiontype:(TransitionType)transitiontype{
    if (index == 0) {
        ZoomTransition *zoomTransition = [[ZoomTransition alloc]init];
        zoomTransition.transitiontype = transitiontype;
        return zoomTransition;
    }else if (index == 1){
        pageTransition *pagetransition = [[pageTransition alloc]init];
        pagetransition.transitiontype = transitiontype;
        return pagetransition;
    }else if(index == 2){
        PageTwoTransition *pageTwoTransition = [[PageTwoTransition alloc]init];
        pageTwoTransition.transitiontype = transitiontype;
        return pageTwoTransition;
    }else if (index == 3){
        CircleTransition *circleTransition = [[CircleTransition alloc]init];
        circleTransition.transitiontype = transitiontype;
        return circleTransition;
    }else if (index == 4){
        LevelLineTransition *levelLineTransition = [[LevelLineTransition alloc]init];
        levelLineTransition.transitiontype = transitiontype;
        return levelLineTransition;
    }else if (index == 5){
        VerticalLineTransition *verticalLineTransition = [[VerticalLineTransition alloc]init];
        verticalLineTransition.transitiontype = transitiontype;
        return verticalLineTransition;
    }else if (index == 6){
        GravityTransition *gravityTransition = [[GravityTransition alloc]init];
        gravityTransition.transitiontype = transitiontype;
        return gravityTransition;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
