//
//  VScrollPage.h
//  ProjectControls
//
//  Created by Vols on 2016/11/24.
//  Copyright © 2016年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  未完成
 */
typedef NS_ENUM(NSUInteger, VScrollPageType) {
    ScrollPageTypeDefault,
    ScrollPageTypeLine,
    ScrollPageTypeArrow,
    ScrollPageTypeSlide
};

@class VScrollPage;
@protocol VScrollPageDelegate <NSObject>

@optional
- (void)scrollMenu:(VScrollPage *)view didSelectPageAtIndex:(NSUInteger)index;

@end

@interface VScrollPage : UIView{
    NSMutableArray * _viewArray;
    NSMutableArray * _titleArray;
}

@property (nonatomic, assign) VScrollPageType scrollPageType;

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *viewArray;

//代理
@property (nonatomic, weak) id<VScrollPageDelegate> delegate;

@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, strong) UIImage *shadowImage;


///设置超过多少个title的时候，可以滑动
@property (nonatomic, assign) NSInteger maxTitles;



/*Top菜单*/
@property (nonatomic, strong) UIColor   *headColor;
@property (nonatomic, strong) UIColor   *selectColor;
@property (nonatomic, strong) UIColor   *deSelectColor;
@property (nonatomic, assign) CGFloat   fontSize;
@property (nonatomic, assign) CGFloat   fontScale;
@property (nonatomic, assign) NSInteger selectedIndex;

/*下划线风格*/
@property (nonatomic, strong) UIColor   *lineColor;
@property (nonatomic, assign) CGFloat   lineHeight;
@property (nonatomic, assign) CGFloat   lineScale;

/*箭头风格*/
@property (nonatomic, strong) UIColor   *arrowColor;

/*滑块风格*/
@property (nonatomic, strong) UIColor *slideColor;
@property (nonatomic, assign) CGFloat slideHeight;
@property (nonatomic, assign) CGFloat slideCorner;
@property (nonatomic, assign) CGFloat slideScale;

///边线
@property (nonatomic, assign) CGFloat bottomLineHeight;
@property (nonatomic, strong) UIColor *bottomLineColor;


//- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(VScrollPageType)style;

- (void)reloadData;     //数据源更新后刷新
//
//- (void)setSelectIndex:(NSInteger)index;
//
//- (void)changePointScale:(CGFloat)scale;
//
//
//- (UIView *)getScrollLineView;
//- (UIView *)getBottomLineView;


@end
