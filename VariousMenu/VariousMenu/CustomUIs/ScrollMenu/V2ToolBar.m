//
//  V2ToolBar.m
//  ProjectControls
//
//  Created by Vols on 2015/3/18.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "V2ToolBar.h"

static const CGFloat kScrollLineH           = 2;
static const CGFloat kMenuButtonBaseTag     = 100;

@interface V2ToolBar ()

@property (nonatomic, strong) NSMutableArray *menuButtons;
@property (nonatomic, strong) UIView *scrollLine;
@property (nonatomic, assign) NSInteger selectedIndex;


@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation V2ToolBar

#pragma mark - 初始化ToolBar
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _normalColor        = [UIColor blackColor];
        _selectedColor      = [UIColor redColor];
        _bottomLineColor    = [UIColor grayColor];
        _buttonSpacing      = 10.f;
        _titleFont          = 16;
        _toolBarSizeToFit   = NO;
        _toolBarSeparatorStyle  = V2ToolBarSeparatorStyleNone;
        
        
        _separationColor = [UIColor grayColor];
        _separationWidth = 1;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (instancetype)initWithTitles:(NSArray *)titles {
    self = [self initWithFrame:CGRectZero];
    
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
    
    CGFloat buttonWidth = (self.frame.size.width - self.buttonSpacing) / _titleArray.count - self.buttonSpacing;

    for (int i = 0; i<_titleArray.count; i++) {
        
        UIButton *button = [self buildButtonTitle:_titleArray[i] action:@selector(menuButtonSelected:)];
        button.frame = CGRectMake(_buttonSpacing + (buttonWidth + _buttonSpacing)*i, 0, buttonWidth, self.frame.size.height - kScrollLineH);
        button.tag = i + kMenuButtonBaseTag;
        button.titleLabel.adjustsFontSizeToFitWidth = _titleFont;

        [self.menuButtons addObject:button];
        [self addSubview:button];
    }
    
    UIButton * firstBtn = _menuButtons.firstObject;
    firstBtn.selected = YES;
    _selectedButton = firstBtn;
    _lastButton     = firstBtn;
    
    [self addSubview:self.scrollLine];
    _scrollLine.frame = CGRectMake(firstBtn.frame.origin.x, self.frame.size.height - kScrollLineH, firstBtn.frame.size.width, kScrollLineH);
}


#pragma mark - actions 必须加layoutIfNeeded，不然没有效果

- (void)menuButtonSelected:(UIButton *)sender{
    if (sender == _lastButton)  return;
    
    _lastButton.selected = NO;
    sender.selected = YES;
    _lastButton = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        _scrollLine.frame = CGRectMake(sender.frame.origin.x, self.frame.size.height - kScrollLineH, sender.frame.size.width, kScrollLineH);

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

- (UIButton*)buildButtonTitle:(NSString*)title action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
    [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.selectedColor forState:UIControlStateSelected];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
