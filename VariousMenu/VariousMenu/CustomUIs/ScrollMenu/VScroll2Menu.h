//
//  VScroll2Menu.h
//  ProjectControls
//
//  Created by Vols on 2016/11/16.
//  Copyright © 2016年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VScroll2MenuDelegate;


/*
 *  等宽按钮
 */
@interface VScroll2Menu : UIView {
    NSMutableArray * _viewArray;
}

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, weak) id<VScroll2MenuDelegate> delegate;

@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, strong) UIImage *shadowImage;

- (void)reloadData;         //数据源更新后  刷新

@end



@protocol VScroll2MenuDelegate <NSObject>

@optional
- (void)scrollMenu:(VScroll2Menu *)view didSelectPageAtIndex:(NSUInteger)index;

@end
