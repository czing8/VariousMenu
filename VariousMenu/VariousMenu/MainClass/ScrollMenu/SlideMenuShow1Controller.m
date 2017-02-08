//
//  SlideMenuShow5Controller.m
//  ProjectControls
//
//  Created by Vols on 2016/11/16.
//  Copyright © 2016年 vols. All rights reserved.
//

#import "SlideMenuShow1Controller.h"
#import "VToolBar.h"
#import "V2ToolBar.h"

@interface SlideMenuShow1Controller ()<VToolBarDelegate>

@property (nonatomic, strong) VToolBar  * segmentView;
@property (nonatomic, strong) V2ToolBar  * toolBar2;

@end

@implementation SlideMenuShow1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];

    [self setupMenu];
}


- (void)setupMenu{
    
    NSArray * titleArray = @[@"Menu 1", @"Menu 2", @"Menu 3", @"Menu 4"];
    _segmentView = [[VToolBar alloc] initWithTitles:titleArray];
    _segmentView.delegate = self;
    _segmentView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_segmentView];
    
    [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentView.superview).offset(64);
        make.left.width.equalTo(_segmentView.superview);
        make.height.mas_equalTo(@(40));
    }];
    
    
    _toolBar2 = [[V2ToolBar alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 40)];
    _toolBar2.titleArray = titleArray;
    _toolBar2.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:_toolBar2];
}


#pragma mark - VSegmentMenu Delegate

- (void)toolBar:(VToolBar *)toolBar didSelectMenuAtIndex:(NSUInteger)index {

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
