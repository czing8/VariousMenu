//
//  VScrollMenuController.m
//  VariousMenu
//
//  Created by Vols on 2017/2/8.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VScrollMenuController.h"

#import "VSlideMenuView.h"
#import "UIView+VAdd.h"
#import "ExampleViewController.h"
#import "FrostedNavigationController.h"

@interface VScrollMenuController ()<UIScrollViewDelegate, SlideMenuViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, weak) VSlideMenuView *slideView;

@end

@implementation VScrollMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"话题",@"问吧",@"关注"];
    self.viewControllers = @[[ExampleViewController new],[ExampleViewController new],[ExampleViewController new]];
    
    [self initNavBar];
    
    [self addChildViewControllers];
    [self configureViews];
    [self addShowMenuButton];
}

- (void)initNavBar {
    
    VSlideMenuView *slideView = [[VSlideMenuView alloc] initWithFrame:CGRectMake(0, 0, 200, 30) titles:self.titles];
    slideView.delegate = self;
    slideView.borderColor = [UIColor whiteColor];
    slideView.titleNormalColor = [UIColor whiteColor];
    slideView.titleSelectedColor = self.navigationController.navigationBar.barTintColor;
    
    self.navigationItem.titleView = slideView;
    self.slideView = slideView;
}


- (void)addChildViewControllers {
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:vc];
    }];
}

- (void)configureViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mainScrollView];
    [self scrollViewDidEndScrollingAnimation:_mainScrollView];
}

- (void)addShowMenuButton {
    UIButton * showMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showMenuBtn.frame = CGRectMake(0, 0, 60, 44);
    [showMenuBtn setTitle:@"展开菜单" forState:UIControlStateNormal];
    [showMenuBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    showMenuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [showMenuBtn addTarget:(FrostedNavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:showMenuBtn];
}

#pragma mark - Properties

- (UIScrollView *) mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}

#pragma mark - GKTitleSlideViewDelegate
- (void)slideView:(VSlideMenuView *)slideView didSelectedAtIndex:(NSInteger)index {
    [self addChildVCViewWithIndex:index];
    
    [self.mainScrollView setContentOffset:CGPointMake(self.mainScrollView.width * index, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.slideView changeColorWithOffsetX:scrollView.contentOffset.x width:scrollView.width];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    if (index == self.childViewControllers.count - 1) {
        [self addChildVCViewWithIndex:index];
    }
    else {
        for (NSInteger i = index; i <= index+1; i++) {
            [self addChildVCViewWithIndex:i];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)addChildVCViewWithIndex:(NSInteger)index {
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = index * self.mainScrollView.width;
    vc.view.y = 0;
    vc.view.height = self.mainScrollView.height;
    [self.mainScrollView addSubview:vc.view];
}


@end
