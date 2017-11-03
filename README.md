# YDAnimatedTransition
## Installation
```
pod  'YDAnimatedTransition'
```
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
## 效果图
![单页翻页](https://github.com/HYDupup/YDAnimatedTransition/raw/master/image/单页翻页.gif)  
