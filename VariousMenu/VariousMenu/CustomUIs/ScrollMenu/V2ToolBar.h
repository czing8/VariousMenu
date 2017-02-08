//
//  V2ToolBar.h
//  ProjectControls
//
//  Created by Vols on 2015/3/18.
//  Copyright © 2015年 vols. All rights reserved.
//  纯代码实现

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, V2ToolBarSeparatorStyle) {
    V2ToolBarSeparatorStyleNone,
    V2ToolBarSeparatorStyleLine
};

NS_ASSUME_NONNULL_BEGIN

@class V2ToolBar;
@protocol V2ToolBarDelegate <NSObject>
@optional
- (void)toolBar:(V2ToolBar *)toolBar didSelectMenuAtIndex:(NSUInteger)index;
@end


@interface V2ToolBar : UIView

@property (nonatomic, assign) id <V2ToolBarDelegate> delegate;

@property (nonatomic, copy) void(^toolBarClick)(NSInteger index);


@property (nonatomic, assign) V2ToolBarSeparatorStyle toolBarSeparatorStyle;
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
