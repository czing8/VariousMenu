//
//  UIViewController+VTransAnimation.m
//  CAAnimation
//
//  Created by Vols on 16/4/16.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "UIViewController+VTransAnimation.h"

static UIView *transitionView;

@implementation UIViewController (VTransAnimation)

#pragma mark - 接口方法
- (void)startTransitionAnimationWithDuration :(CGFloat)duration backgroundColor :(UIColor *)backgroundColor completion:(void (^ _Nullable)(BOOL finished))completionCallBack
{
    [self setuptransitionViewWithBackgroundColor:backgroundColor];
    [self startAnimationWithDuration:duration completion:completionCallBack];
}

- (void)endTransitionAnimationWithDuration :(CGFloat)duration backgroundColor :(UIColor *)backgroundColor completion:(void (^ _Nullable)(BOOL finished))completionCallBack
{
    [UIView animateWithDuration:1 animations:^{
        transitionView.hidden = NO;
        transitionView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (completionCallBack != nil) {
            completionCallBack(YES);
            [transitionView removeFromSuperview];
        }
    }];
}

#pragma mark - 内部方法
- (void)setuptransitionViewWithBackgroundColor :(UIColor *)backgroundColor
{
    //  背景View
    transitionView = [[UIView alloc] initWithFrame:self.view.bounds];
    transitionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    transitionView.frame = self.view.frame;
    [self.view addSubview:transitionView];
    
    //  布局中部ClearColor
    UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    clearView.backgroundColor = [UIColor clearColor];
    clearView.center = transitionView.center;
    clearView.layer.cornerRadius = clearView.bounds.size.width * 0.5;
    clearView.layer.masksToBounds = YES;
    [transitionView addSubview:clearView];
    
    //  布局四周BackGroundColor
    CGFloat topHeight =  (transitionView.bounds.size.height - clearView.bounds.size.height) * 0.5;
    CGFloat circleHeight = transitionView.bounds.size.height;
    CGFloat circleWidth = transitionView.bounds.size.width;
    CGFloat leftWidth = (transitionView.bounds.size.width - clearView.bounds.size.width) * 0.5;
    //  上
    UIView *topBView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, circleWidth, topHeight)];
    topBView.backgroundColor = backgroundColor;
    //  下
    UIView *bottomBView = [[UIView alloc] initWithFrame:CGRectMake(0, circleHeight - topHeight , circleWidth, circleHeight)];
    bottomBView.backgroundColor = backgroundColor;
    //  左
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, clearView.frame.origin.y, leftWidth, clearView.frame.size.height)];
    leftView.backgroundColor = backgroundColor;
    //  右
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clearView.frame), clearView.frame.origin.y, leftWidth, clearView.frame.size.height)];
    rightView.backgroundColor = backgroundColor;
    
    [transitionView addSubview:topBView];
    [transitionView addSubview:bottomBView];
    [transitionView addSubview:leftView];
    [transitionView addSubview:rightView];
}

- (void)startAnimationWithDuration :(CGFloat)duration completion:(void (^ _Nullable)(BOOL finished))completionCallBack
{
    [UIView animateWithDuration:duration animations:^{
        transitionView.transform = CGAffineTransformMakeScale(100, 100);
    } completion:^(BOOL finished) {
        transitionView.hidden = YES;
        if (completionCallBack != nil) {
            completionCallBack(YES);
        }
    }];
}

@end
