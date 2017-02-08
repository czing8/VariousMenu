//
//  VScroll1Menu.m
//  ProjectControls
//
//  Created by Vols on 2015/11/14.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "VScroll1Menu.h"

static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kWidthOfButtonMargin   = 16.0f;
static const CGFloat kFontSizeOfTabButton   = 17.0f;

static const CGFloat kScrollLineH           = 2;
static const CGFloat kBaseButtonTag         = 1000;


@interface VScroll1Menu () <UIScrollViewDelegate> {
    NSUInteger       _totalPages;
    NSUInteger       _curPage;
    
    UIButton        *_lastButton;
}

@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIScrollView *rootScrollView;

@property (nonatomic, strong) NSMutableArray<UIButton *>  * menuButtons;
@property (nonatomic, strong) UIView *scrollLine;

@end

@implementation VScroll1Menu

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    [self addSubview:self.topScrollView];
    [self addSubview:self.rootScrollView];
    
    self.tabItemNormalColor = [UIColor blackColor];
    self.tabItemSelectedColor = [UIColor orangeColor];
}


- (void)setViewArray:(NSMutableArray *)viewArray {
    if (viewArray == nil || viewArray.count <= 0) {
        return;
    }
    _viewArray = viewArray;
    
    [self reloadData];
}


- (void)reloadData {
    [self.topScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rootScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    _totalPages = _viewArray.count;
    if (_totalPages == 0) return;
    _curPage = 0;

    for (int i = 0; i<_totalPages; i++) {
        UIViewController *vc = _viewArray[i];
//        vc.view.frame = CGRectOffset(vc.view.frame, vc.view.frame.size.width * i, 0);
        [_rootScrollView addSubview:vc.view];
    }

    [self displayMenuButtons];
    
    [self setNeedsLayout];
}

//适配横竖屏
- (void)layoutSubviews {
    self.rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * _totalPages, self.bounds.size.height-kHeightOfTopScrollView);

    for (int i = 0; i<_totalPages; i++) {
        UIViewController *vc = self.viewArray[i];
        vc.view.frame = CGRectMake(_rootScrollView.bounds.size.width*i, 0,
                                   _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
    }
    
    [_rootScrollView setContentOffset:CGPointMake(_curPage*self.bounds.size.width, 0) animated:NO];

    [self adjustScrollViewContentX:_menuButtons[_curPage]];
}

#pragma mark - Actions
- (void)selectNameButton:(UIButton *)sender {

    if (sender == _lastButton)  return;
    [self adjustScrollViewContentX:sender];

    _lastButton.selected = NO;
    _curPage = sender.tag - kBaseButtonTag;
    _lastButton = sender;
    
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            _scrollLine.frame = CGRectMake(sender.frame.origin.x, _topScrollView.frame.size.height-kScrollLineH, sender.frame.size.width, kScrollLineH);
            
        }completion:^(BOOL finished) {
            [_rootScrollView setContentOffset:CGPointMake(_curPage*self.bounds.size.width, 0) animated:NO];

            if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenu:didSelectPageAtIndex:)]) {
                [self.delegate scrollMenu:self didSelectPageAtIndex:_curPage];
            }
        }];
    }
    //重复点击选中按钮
    else {
        
    }
    
}

#pragma mark - Views Operation

- (void)displayMenuButtons {
    [self.topScrollView addSubview:self.scrollLine];

    [self.menuButtons removeAllObjects];

    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = kWidthOfButtonMargin;
    //每个tab偏移量
    CGFloat xOffset = kWidthOfButtonMargin;
    
    for (int i = 0; i < _totalPages; i ++) {
        UIViewController *vc = _viewArray[i];
        
        CGSize textSize = [vc.title boundingRectWithSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontSizeOfTabButton]} context:nil].size;
        
        //累计每个tab文字的长度
        topScrollViewContentWidth += kWidthOfButtonMargin + textSize.width;
        
        UIButton * button = [self buildButton:CGRectMake(xOffset,0,
                                                         textSize.width, kHeightOfTopScrollView)
                                        title:vc.title
                                       action:@selector(selectNameButton:)];
    
        //计算下一个tab的x偏移量
        xOffset += textSize.width + kWidthOfButtonMargin;
        [button setTag:i+kBaseButtonTag];
        
        if (i == 0) {
            button.selected = YES;
            _lastButton = button;
            _scrollLine.frame = CGRectMake(button.frame.origin.x, _topScrollView.frame.size.height-kScrollLineH, button.frame.size.width, kScrollLineH);
        }

        [_topScrollView addSubview:button];
        [self.menuButtons addObject:button];
    }
    
    _topScrollView.contentSize = CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
}

- (void)adjustScrollViewContentX:(UIButton *)sender {
    //如果 当前显示的最后一个tab文字超出右边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x > self.bounds.size.width - (kWidthOfButtonMargin+sender.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - (_topScrollView.bounds.size.width- (kWidthOfButtonMargin+sender.bounds.size.width)), 0)  animated:YES];
    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x < kWidthOfButtonMargin) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - kWidthOfButtonMargin, 0)  animated:YES];
    }
}




#pragma mark - Properties

- (UIScrollView *)topScrollView {
    
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
        _topScrollView.delegate = self;
        _topScrollView.backgroundColor = [UIColor clearColor];
        _topScrollView.pagingEnabled = NO;
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.showsVerticalScrollIndicator = NO;
    }
    return _topScrollView;
}

- (UIScrollView *)rootScrollView {
    
    if (!_rootScrollView) {
        _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
        _rootScrollView.delegate = self;
        _rootScrollView.pagingEnabled = YES;
        _rootScrollView.userInteractionEnabled = YES;
        _rootScrollView.bounces = NO;
        _rootScrollView.showsHorizontalScrollIndicator = NO;
        _rootScrollView.showsVerticalScrollIndicator = NO;
    }
    return _rootScrollView;
}

- (UIView *)scrollLine {
    if (!_scrollLine) {
        _scrollLine = [[UIView alloc] init];
        _scrollLine.backgroundColor = [UIColor orangeColor];
    }
    return _scrollLine;
}


- (NSMutableArray *) menuButtons{
    if (!_menuButtons) {
        _menuButtons = [[NSMutableArray alloc] init];
    }
    return _menuButtons;
}

- (NSMutableArray *) viewArray{
    if (!_viewArray) {
        _viewArray = [[NSMutableArray alloc] init];
    }
    return _viewArray;
}


#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _rootScrollView) {
        _curPage = (int)scrollView.contentOffset.x/self.bounds.size.width;
        UIButton *button = _menuButtons[_curPage];
        [self selectNameButton:button];
    }
}

#pragma mark - Helper

- (UIButton*)buildButton:(CGRect)frame title:(NSString*)title action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
    
    [btn setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
    
    if (self.tabItemNormalBackgroundImage != nil) {
        [btn setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
    }
    if (self.tabItemSelectedBackgroundImage != nil) {
        [btn setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
    }

    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}



@end
