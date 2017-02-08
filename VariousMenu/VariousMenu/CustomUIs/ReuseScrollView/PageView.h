//
//  PageView.h
//  ScrollViewTest
//
//  Created by Vols on 2015/3/18.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "VReuseScrollView.h"

@interface PageView : VReuseView

@property (nonatomic, strong) UILabel *label;

- (void)setText:(NSString *)str;

@end
