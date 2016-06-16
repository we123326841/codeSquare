//
//  MSSegmentBar.m
//  Caipiao
//
//  Created by danal-rich on 7/29/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "MSSegmentBar.h"

@implementation MSSegmentBar

- (void)dealloc{
    [_buttons release];
    [_normalColor release];
    [_highlightColor release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame buttons:(NSArray *)buttons
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _buttons = [[NSArray alloc] initWithArray:buttons];
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    for (UIView *v in self.subviews){
        if ([v isKindOfClass:[MSSegmentButton class]]){
            [(MSSegmentButton *)v addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [buttons addObject:v];
        } else if ([v isKindOfClass:[MSSegmentIndicator class]]){
            _indicator = v;
        }
    }
    _buttons = [[NSArray alloc] initWithArray:buttons];
    [buttons release];
    
    [self setup];
}

- (void)setup{
    self.backgroundColor = [UIColor rgbColorWithHex:@"EEEEEE"];
    if (!self.highlightColor) self.highlightColor = [UIColor darkGrayColor];
    if (!self.normalColor) self.normalColor = [UIColor darkGrayColor];
        
    CGFloat indicatorH = 2.f;
    CGFloat w = self.bounds.size.width/_buttons.count, h = self.bounds.size.height - indicatorH;
    for (NSInteger i = 0; i < _buttons.count; i++) {
        MSSegmentButton *butt = _buttons[i];
        butt.frame = CGRectMake(i*w, 0, w, h);
    }
    if (!_indicator){
        _indicator = [[MSSegmentIndicator alloc] initWithFrame:CGRectZero];
        [self addSubview:_indicator];
        [_indicator release];
    }
    _indicator.backgroundColor = [UIColor lightGrayColor];
    _indicator.frame = CGRectMake(0, h, w, indicatorH);
    _selectedIndex = -1;
    [self setSelectedIndex:1 animated:NO];
}

- (void)setIndicatorInset:(CGFloat)indicatorInset{
    CGFloat indicatorH = 2.f;
    CGFloat w = self.bounds.size.width/_buttons.count, h = self.bounds.size.height - indicatorH;
    _indicatorInset = indicatorInset;
    _indicator.frame = CGRectMake(0+_indicatorInset, h, w-2*_indicatorInset, indicatorH);
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated{
    if (_selectedIndex != selectedIndex){
        _selectedIndex = selectedIndex;
        [UIView animateWithDuration:animated ? .15f : 0.f animations:^{
            _indicator.frame = CGRectMake(selectedIndex*(_indicator.frame.size.width+2*_indicatorInset)+_indicatorInset,
                                          _indicator.frame.origin.y,
                                          _indicator.frame.size.width,
                                          _indicator.frame.size.height);
        }];
        
        for (NSInteger i = 0; i < _buttons.count; i++) {
            MSSegmentButton *butt = _buttons[i];
            if (i == selectedIndex){
                [butt setTitleColor:_highlightColor forState:UIControlStateNormal];
            } else {
                [butt setTitleColor:_normalColor forState:UIControlStateNormal];
            }
            
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    [self setSelectedIndex:selectedIndex animated:YES];
}

- (void)buttonClick:(MSSegmentButton *)button{
    NSInteger index = [self.buttons indexOfObject:button];
    if (index != _selectedIndex){
        self.selectedIndex = index;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end



@implementation MSSegmentView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib{
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scroll];
    [_scroll release];
}

- (void)layoutSubviews{
    if (_delegate){
        _pageNum = [_delegate segmentViewNumberOfPages];
        _scroll.contentSize = CGSizeMake(self.bounds.size.width*_pageNum, self.bounds.size.height);
        for (NSInteger i = 0; i < _pageNum; i++) {
            UIView *view = [_delegate segmentView:self contentViewAtPage:i];
            view.tag = 100+i;
            view.frame = CGRectMake(_scroll.bounds.size.width*i, 0, _scroll.bounds.size.width, _scroll.bounds.size.height);
            [_scroll addSubview:view];
        }
    }
    if (_segmentBar){
        [_segmentBar addTarget:self action:@selector(onSegmentBarClick:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)onSegmentBarClick:(MSSegmentBar *)sender{
    self.currentPage = sender.selectedIndex;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    [_scroll setContentOffset:CGPointMake(currentPage*_scroll.bounds.size.width, 0) animated:YES];
    if (_delegate){
        [_delegate segmentViewDidScrollToPage:self page:currentPage];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentPage = ceilf(scrollView.contentOffset.x/scrollView.bounds.size.width);
    if (_segmentBar){
        _segmentBar.selectedIndex = _currentPage;
    }
    if (_delegate){
        [_delegate segmentViewDidScrollToPage:self page:_currentPage];
    }
}

@end