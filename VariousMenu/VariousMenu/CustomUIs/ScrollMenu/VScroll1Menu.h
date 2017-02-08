//
//  VScroll1Menu.h
//  ProjectControls
//
//  Created by Vols on 2015/11/14.
//  Copyright © 2015年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VScroll1Menu;
@protocol VScroll1MenuDelegate <NSObject>

@optional
- (void)scrollMenu:(VScroll1Menu *)view didSelectPageAtIndex:(NSUInteger)index;

@end


@interface VScroll1Menu : UIView{
    NSMutableArray * _viewArray;
}

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, weak) id<VScroll1MenuDelegate> delegate;

@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, strong) UIImage *shadowImage;

- (void)reloadData;     //数据源更新后  刷新

@end
