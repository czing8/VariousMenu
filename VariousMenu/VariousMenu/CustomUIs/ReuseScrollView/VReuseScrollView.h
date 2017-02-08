//
//  VReuseScrollView.h
//  ProjectControls
//
//  Created by Vols on 2015/3/18.
//  Copyright © 2015年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - VReuseView

@interface VReuseView : UIView

@property (nonatomic, copy,   readonly) NSString *identifier;
@property (nonatomic, assign, readonly) NSInteger index;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end


@protocol VReuseScrollViewDelegate;

@interface VReuseScrollView : UIScrollView

/**
 如果直接设置这个属性, 则所有reuseView的inset都一致.
 想要单独设置某个view的inset可以使用HYReuseScrollViewDelegate协议内的方法.
 */
@property (nonatomic, assign) UIEdgeInsets reuseViewInset;

/**
 前后保留的页数, 默认是2.(前后各会保留preloadNum个view)
 */
@property (nonatomic, assign) NSInteger preloadNum;

@property (nonatomic, assign) id<VReuseScrollViewDelegate> reuseDelegate;


/**
 根据identifier尝试获取可重用的view. (参照UITableView的用法)
 */
- (id)dequeueReusableViewWithIdentifier:(NSString *)identifier;

/**
 初始化用这个.
 */
- (id)initWithFrame:(CGRect)frame;


/**
 刷新数据
 */
- (void)reloadData;

@end






@protocol VReuseScrollViewDelegate <NSObject>

@required

- (NSInteger)numberOfItemsInScrollView:(VReuseScrollView *)scrollView;
- (VReuseView *)scrollView:(VReuseScrollView *)scrollView viewForItemAtIndex:(NSInteger)index;


@optional

/**
 获取对应下标的偏移量(可以用来做间隔).
 */
- (UIEdgeInsets)scrollView:(VReuseScrollView *)scrollView insetForForItemAtIndex:(NSInteger)index;

- (void)reuseScrollView:(VReuseScrollView *)view didSelectPageAtIndex:(NSUInteger)index;

@end
