//
//  ReuseScrollViewController.m
//  ProjectControls
//
//  Created by Vols on 2015/3/18.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "ReuseScrollViewController.h"


#import "VReuseScrollView.h"
#import "PageView.h"

@interface ReuseScrollViewController ()<VReuseScrollViewDelegate>

@property (nonatomic, strong) VReuseScrollView *scrollView;

@end

@implementation ReuseScrollViewController

- (void)dealloc {
    self.scrollView.delegate = nil;
    self.scrollView.reuseDelegate = nil;

}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void) configureViews {
    self.scrollView = [[VReuseScrollView alloc]initWithFrame:self.view.bounds];

    self.scrollView.reuseDelegate = self;
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView reloadData];
}


- (VReuseView *)scrollView:(VReuseScrollView *)scrollView viewForItemAtIndex:(NSInteger)index {
    static NSString *str = @"view";
    PageView *pageView = [scrollView dequeueReusableViewWithIdentifier:str];
    if (!pageView) {
        pageView = [[PageView alloc] initWithReuseIdentifier:str];
    }
    [pageView setText:[NSString stringWithFormat:@"%ld", (long)index]];
    
    int color = index % 4;
    switch (color) {
        case 0:
            pageView.backgroundColor = [UIColor blueColor];
            break;
        case 1:
            pageView.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            pageView.backgroundColor = [UIColor orangeColor];
            break;
        default:
            pageView.backgroundColor = [UIColor blackColor];
            break;
    }
    return pageView;
}


- (NSInteger)numberOfItemsInScrollView:(VReuseScrollView *)scrollView {
    return 10;
}

- (UIEdgeInsets)scrollView:(VReuseScrollView *)scrollView insetForForItemAtIndex:(NSInteger)index {
    return UIEdgeInsetsMake(20, 10, 20, 10);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL) navigationShouldPopOnBackButton {
    
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
