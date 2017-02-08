//
//  FrostedNavigationController.m
//  HaierSmart
//
//  Created by Vols on 15/3/4.
//  Copyright © 2015年 HaierSmart. All rights reserved.
//

#import "FrostedNavigationController.h"

#import "REFrostedViewController.h"
#import "UIViewController+REFrostedViewController.h"


@interface FrostedNavigationController ()

@end

@implementation FrostedNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu {

    // Dismiss keyboard (optional)
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    
    if (self.childViewControllers.count == 1) {
        
        // Dismiss keyboard (optional)
        //
        [self.view endEditing:YES];
        [self.frostedViewController.view endEditing:YES];
        
        // Present the view controller
        //
        [self.frostedViewController panGestureRecognized:sender];
    }
}


@end
