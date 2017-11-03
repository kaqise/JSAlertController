//
//  JSSheepPresentTransition.m
//  AlertView
//
//  Created by Milton on 17/9/18.
//  Copyright © 2017年 Milton. All rights reserved.
//

#import "JSSheepPresentTransition.h"

typedef NS_ENUM(NSInteger , JSSheetTransitionStyle) {
    JSSheetTransitionStyle_Present,
    JSSheetTransitionStyle_Dissmiss,
};

@interface JSSheepPresentTransition ()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign)JSSheetTransitionStyle transitionStyle;

@property (nonatomic, strong)UIView *markView;

@end

@implementation JSSheepPresentTransition

- (UIView *)markView{
    if (!_markView) {
        _markView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _markView.backgroundColor = [UIColor blackColor];
    }
    _markView.alpha = 0;
    return _markView;
}

//present实现者
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.transitionStyle = JSSheetTransitionStyle_Present;
    return self;
}
//dismiss实现者
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.transitionStyle = JSSheetTransitionStyle_Dissmiss;
    return self;
}
//动画时间
-  (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return kCustomPresentTransitionDurtion;
}
//动画的具体执行
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *to_vc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *from_vc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!to_vc || !from_vc) return;//两个控制器有一个为空 不进行跳转相关操作
   
    switch (self.transitionStyle) {
        case JSSheetTransitionStyle_Present:
            [self js_presentTransition:transitionContext fromViewController:from_vc toController:to_vc];
            break;
        case JSSheetTransitionStyle_Dissmiss:
            [self js_dissmissTransition:transitionContext fromViewController:from_vc toController:to_vc];
            break;
        default:
            break;
    }
}
//Present处理者
- (void)js_presentTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromController toController:(UIViewController *)toController{
    UIView *container = [transitionContext containerView];
    
    UIView *to_view = toController.view;
    UIView  *willMove = [to_view viewWithTag:1];
    [to_view insertSubview:self.markView belowSubview:willMove];
    [container addSubview:to_view];
    CGRect rect = willMove.frame;
    willMove.frame = CGRectMake(rect.origin.x, [UIScreen mainScreen].bounds.size.height, rect.size.width, rect.size.height);
    [UIView animateWithDuration:kCustomPresentTransitionDurtion animations:^{
        self.markView.alpha = 0.4;
        willMove.frame = rect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

//Dissmiss处理者
- (void)js_dissmissTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromViewController:(UIViewController *)fromController toController:(UIViewController *)toController{
    
    UIView *from_view = fromController.view;
    UIButton *wiiMove = [from_view viewWithTag:1];
    CGRect rect = wiiMove.frame;
    self.markView.alpha = 0.4;
    [UIView animateWithDuration:kCustomPresentTransitionDurtion animations:^{
        self.markView.alpha = 0;
        wiiMove.frame = CGRectMake(rect.origin.x, [UIScreen mainScreen].bounds.size.height, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        [self.markView removeFromSuperview];
        [from_view removeFromSuperview];
        self.markView = nil;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)dealloc{
    NSLog(@"转场动画销毁");
}

@end
