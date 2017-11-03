//
//  EndViewController.m
//  YDAnimatedTransition
//
//  Created by 黄亚栋 on 2017/10/17.
//  Copyright © 2017年 黄亚栋. All rights reserved.
//

#import "EndViewController.h"
#import "ThirdViewController.h"

#define RANDOM_FLOAT(MIN,MAX) (((CGFloat)arc4random() / 0x100000000) * (MAX - MIN) + MIN);

@interface EndViewController ()

@property (nonatomic,strong)UIImageView *backImageView;


@end

@implementation EndViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self CreatUI];
}


#pragma mark CreatUI
-(void)CreatUI{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.backImageView.image = [UIImage imageNamed:@"2"];
    [self.view addSubview:self.backImageView];
 
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.navigationController pushViewController:[[ThirdViewController alloc]init] animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
