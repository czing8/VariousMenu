//
//  MainViewController.m
//  ProjectControls
//
//  Created by Vols on 2014/11/14.
//  Copyright © 2014年 vols. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addShowMenuButton];

    [self initData];
}

- (void)initData {
    
}


- (void)configureViews {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
