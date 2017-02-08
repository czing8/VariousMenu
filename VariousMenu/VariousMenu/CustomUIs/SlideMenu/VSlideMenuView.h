//
//  VSlideMenuView.h
//  VariousMenu
//
//  Created by Vols on 2017/2/7.
//  Copyright © 2017年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSlideMenuView;

@protocol SlideMenuViewDelegate <NSObject>

- (void)slideView:(VSlideMenuView *)slideMenu didSelectedAtIndex:(NSInteger)index;

@end


@interface VSlideMenuView : UIView

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, weak) UIView *bgView;         //选中菜单的背景视图

@property (nonatomic, assign) CGFloat titleW;
@property (nonatomic, assign) CGFloat titleH;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, assign) id<SlideMenuViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/*
 *  背景变色
 */
- (void)changeColorWithOffsetX:(CGFloat)x width:(CGFloat)width;

@end
