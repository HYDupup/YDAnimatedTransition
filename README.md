# YDAnimatedTransition
## pod  'YDAnimatedTransition'即可使用<br>
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
