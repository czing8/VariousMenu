//
//  VShowWeb1Controller.m
//  PrejectTools
//
//  Created by Vols on 2015/10/25.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "VShowWeb1Controller.h"

#define kSCREEN_SIZE        [UIScreen mainScreen].bounds.size

@interface VShowWeb1Controller () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation VShowWeb1Controller

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    
    NSLog(@"title --> %@, url --> %@", _theTitle, _theURL);
}

- (void)configureViews {
    
    self.title = _theTitle;
    [self setNavBackBarButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.indicatorView];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_theURL]];
    
    [_webView loadRequest:request];
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2-44-20);
    }
    return _indicatorView;
}


#pragma mark - UIWebViewDelgate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicatorView startAnimating] ;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.indicatorView stopAnimating];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Properties

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.height)];
        _webView.scalesPageToFit = YES;  //自动对页面进行缩放以适应屏幕
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark - Helper

- (void)setNavBackBarButton {
    
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 10, 24, 24);
//    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"X" forState:UIControlStateNormal];

    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.showsTouchWhenHighlighted = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

@end
