# YDAnimatedTransition
## Overview
![单页翻页](https://github.com/HYDupup/YDAnimatedTransition/raw/master/image/单页翻页.gif)  
![横:纵分割](https://github.com/HYDupup/YDAnimatedTransition/raw/master/image/横:纵分割.gif) 
![动力学-重力](https://github.com/HYDupup/YDAnimatedTransition/raw/master/image/动力学-重力.gif) 
![双页翻页 圆点扩散](https://github.com/HYDupup/YDAnimatedTransition/raw/master/image/双页翻页 圆点扩散.gif) 
## Usage
1.只需声明引入你需要的类的头文件
```
#import "ZoomTransition.h"
```
2.初始化类
```
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    return [[ZoomTransition alloc]init];
}
```
## Installation
```
pod  'YDAnimatedTransition'
```
