//
//  UIView+VAdd.h
//
//
//  Created by Vols on 16/3/11.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VAdd)

@property (assign, nonatomic) CGFloat x;

@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGFloat width;

@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGFloat centerX;

@property (assign, nonatomic) CGFloat centerY;


/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

+ (instancetype)viewFromXib;


@end
