//
//  VToolBar.h
//  ProjectControls
//
//  Created by Vols on 2015/10/19.
//  Copyright © 2015年 Vols. All rights reserved.
//  Masonry 实现,包括动画

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VToolBarSeparatorStyle) {
    VToolBarSeparatorStyleNone,
    VToolBarSeparatorStyleLine
};

NS_ASSUME_NONNULL_BEGIN

@class VToolBar;
@protocol VToolBarDelegate <NSObject>
@optional
- (void)toolBar:(VToolBar *)toolBar didSelectMenuAtIndex:(NSUInteger)index;
@end


@interface VToolBar : UIView

@property (nonatomic, assign) id <VToolBarDelegate> delegate;

@property (nonatomic, copy) void(^toolBarClick)(NSInteger index);


@property (nonatomic, assign) VToolBarSeparatorStyle toolBarSeparatorStyle;
@property (nonatomic, assign) BOOL toolBarSizeToFit;    // 是否根据按钮宽度自动缩小标题, default: NO

@property (nonatomic, strong) NSArray *titleArray;      // 标题数组

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;   // 选中的按钮文字的颜色, default: redColor
@property (nonatomic, strong) UIColor *barBackgroundColor;

@property (nonatomic, strong) UIColor *bottomLineColor; // 底部线条的颜色, default: grayColor
@property (nonatomic, strong) UIColor *selectedLineColor;

@property (nonatomic, assign) NSInteger titleFont;
@property (nonatomic, assign) CGFloat buttonSpacing;     //按钮之间的间距, default: 10



#pragma mark - Tool Bar Separation Style
/**
 *  注意: 下边属性的前提是设置toolBarSeparatorStyle为VToolBarSeparatorStyleLine才有效
 */

@property (nonatomic, strong) UIColor *separationColor;     //Separation分割线的颜色
@property (nonatomic, assign) CGFloat separationWidth;      // Separation分割线的宽度

- (void)reloadData;
- (void)selectedIndex:(NSInteger)index;

- (instancetype)initWithTitles:(NSArray *)titles;

@end

NS_ASSUME_NONNULL_END

