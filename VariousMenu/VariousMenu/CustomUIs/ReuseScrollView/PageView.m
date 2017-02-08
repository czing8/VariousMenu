//
//  PageView.m
//  ScrollViewTest
//
//  Created by Vols on 2015/3/18.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "PageView.h"

@implementation PageView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:self.bounds];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:30.f];
        self.label.textColor = [UIColor whiteColor];
        self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.label.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];
        self.label.text = @"unknown";
    }
    return self;
}

- (void)setText:(NSString *)str {
    self.label.text = str;
}


@end
