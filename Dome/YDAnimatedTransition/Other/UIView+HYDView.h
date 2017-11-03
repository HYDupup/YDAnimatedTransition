
#import <UIKit/UIKit.h>

typedef enum{
    pushNavigation = 0,
    popNavigation
}TransitionType;

@interface UIView (HYDView)
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;


//仿射
@property (nonatomic) CGFloat rotation;
@property (nonatomic) CGFloat xscale;
@property (nonatomic) CGFloat yscale;
@property (nonatomic) CGFloat tx;
@property (nonatomic) CGFloat ty;

@property (nonatomic, readonly) CGRect originalFrame;
@property (nonatomic, readonly) CGPoint originalCenter;

@property (nonatomic, readonly) CGPoint transformedTopLeft;
@property (nonatomic, readonly) CGPoint transformedTopRight;
@property (nonatomic, readonly) CGPoint transformedBottomLeft;
@property (nonatomic, readonly) CGPoint transformedBottomRight;

@property (nonatomic, readonly) NSString *transformDescription;

- (CGPoint) pointInTransformedView: (CGPoint) pointInParentCoordinates;
- (BOOL) intersectsView: (UIView *) aView;
@end
