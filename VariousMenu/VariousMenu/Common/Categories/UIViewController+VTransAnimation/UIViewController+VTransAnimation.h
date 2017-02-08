//
//  UIViewController+VTransAnimation.h
//  CAAnimation
//
//  Created by Vols on 16/4/16.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (VTransAnimation)

/**
 *  开场转场动画
 *
 *  @param duration           动画时长
 *  @param completionCallBack 结束回调
 */
- (void)startTransitionAnimationWithDuration:(CGFloat)duration backgroundColor:(UIColor *)backgroundColor completion:(void (^)(BOOL finished))completionCallBack ;

/**
 *  闭幕转场动画
 *
 *  @param duration           动画时长
 *  @param completionCallBack 结束回调
 */
- (void)endTransitionAnimationWithDuration :(CGFloat)duration backgroundColor :(UIColor *)backgroundColor completion :(void (^)(BOOL finished))completionCallBack;


@end
