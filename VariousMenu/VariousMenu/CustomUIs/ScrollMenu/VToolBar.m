//
//  VToolBar.m
//  ProjectControls
//
//  Created by Vols on 2015/10/19.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "VToolBar.h"

static const CGFloat kScrollLineH           = 2;
static const CGFloat kMenuButtonBaseTag     = 100;

@interface VToolBar ()

@property (nonatomic, strong) NSMutableArray *menuButtons;
@property (nonatomic, strong) UIView *scrollLine;
@property (nonatomic, assign) NSInteger selectedIndex;


@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *selectedButton;


@end

@implementation VToolBar

#pragma mark - 初始化ToolBar
- (instancetype)init {
    
    if (self = [super init]) {
        
        _normalColor        = [UIColor blackColor];
        _selectedColor      = [UIColor redColor];
        _bottomLineColor    = [UIColor grayColor];
        _buttonSpacing      = 10.f;
        _titleFont          = 16;
        _toolBarSizeToFit   = NO;
        _toolBarSeparatorStyle  = VToolBarSeparatorStyleNone;

        
        _separationColor = [UIColor grayColor];
        _separationWidth = 1;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (instancetype)initWithTitles:(NSArray *)titles {
    self = [self init];
    
    self.titleArray = titles;
    
    return self;
}

#pragma mark - setter

- (void) setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    [self reloadData];
}

- (void)reloadData {
    
    NSAssert(self.titleArray.count, @"你所传入的数组为空");
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self setupButtons];
}


- (void)selectedIndex:(NSInteger)index {
    if (self.menuButtons.count <= 0) return;
    
    [self menuButtonSelected:_menuButtons[index]];
}



- (void)setupButtons{
    [self addSubview:self.scrollLine];
    
    for (int i = 0; i<_titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        button.tag = i + kMenuButtonBaseTag;
        button.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(menuButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuButtons addObject:button];
    }
    
    [self makeEqualWidthViews:_menuButtons inView:self LRpadding:30 viewPadding:10];
    
    UIButton * firstBtn = _menuButtons.firstObject;
    firstBtn.selected = YES;
    _selectedButton = firstBtn;
    _lastButton     = firstBtn;
    
    [_scrollLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstBtn.mas_left);
        make.right.equalTo(firstBtn.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(kScrollLineH);
    }];
}


#pragma mark - actions 必须加layoutIfNeeded，不然没有效果

- (void)menuButtonSelected:(UIButton *)sender{
    if (sender == _lastButton)  return;

    _lastButton.selected = NO;
    sender.selected = YES;
    _lastButton = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        [_scrollLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sender.mas_left);
            make.right.equalTo(sender.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(kScrollLineH);
        }];
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
  
    }];
    
    if ([self.delegate respondsToSelector:@selector(toolBar:didSelectMenuAtIndex:)]) {
        [self.delegate toolBar:self didSelectMenuAtIndex:sender.tag - kMenuButtonBaseTag];
    }
}

#pragma mark - Propertys

- (NSMutableArray *)menuButtons {
    if (!_menuButtons) {
        _menuButtons = [[NSMutableArray alloc] initWithCapacity:self.titleArray.count];
    }
    return _menuButtons;
}

- (UIView *)scrollLine {
    if (!_scrollLine) {
        _scrollLine = [[UIView alloc] init];
        _scrollLine.backgroundColor = [UIColor orangeColor];
    }
    return _scrollLine;
}

#pragma mark - helper

-(void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding {
    
    UIView *lastView;
    for (UIView *view in views) {
        [containerView addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }
        else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView).offset(LRpadding);
                make.top.bottom.equalTo(containerView);
            }];
        }
        lastView = view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-LRpadding);
    }];
}

@end
