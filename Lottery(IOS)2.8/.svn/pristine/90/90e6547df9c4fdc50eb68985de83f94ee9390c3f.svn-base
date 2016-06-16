//
//  CycleScrollView.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-18.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CycleScrollView.h"

@implementation CycleScrollView

- (void)dealloc
{
    Echo(@"%s",__func__);
    RELEASE(_scrollView);
    RELEASE(_pageControl);
    RELEASE(_curViews);
    _datasource = nil;
    _delegate = nil;
    [super dealloc];
}

- (void)removeAndClear
{
    _scrollView.delegate = nil;
    [self release];
    [_timer invalidate];
    [_timer release];
    [self removeFromSuperview];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = self.bounds.size;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //_scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        /*
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        
        [self addSubview:_pageControl];
         */
        
        
        _curPage = 0;
    }
    return self;
}

- (void)setDataource:(id<CycleScrollViewDatasource>)datasource
{
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData
{
    [_pageControl removeFromSuperview];
    
    //Add PageControl
    CGRect pcRect = CGRectMake(0, self.bounds.size.height, 60, 20);
    _pageControl = [[PageControl alloc] initWithFrame:pcRect
                                          normalImage:[UIImage imageNamed:@"games_slider_li.png"]
                                         currentImage:[UIImage imageNamed:@"games_slider_li_curr.png"]];
    _pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:_pageControl];
    
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        _pageControl.alpha = 0;
        _totalPages = 1; //没广告的时候显示Placeholder
        //return;
    }else if (_totalPages == 1) {
        _pageControl.alpha = 0;
    }
    
    _pageControl.numberOfPages = _totalPages;
    
    CGRect newRect = _pageControl.frame;
    newRect.origin.x = self.bounds.size.width/2 - newRect.size.width/2;
    _pageControl.frame = newRect;
    
    [self loadData];
}

- (void)loadData
{
    _pageControl.currentIndex = _curPage;
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if (_totalPages == 1) {
        
        if (!_curViews) {
            _curViews = [[NSMutableArray alloc] init];
        }
        
        [_curViews removeAllObjects];
        [_curViews addObject:[_datasource viewForPageAtIndex:0]];
        [self addViewAtIndex:0];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        
    }else {
        
        if (!_timer) {
            _timer = [[NSTimer scheduledTimerWithTimeInterval:kAdAutoScrollTime target:self selector:@selector(autoScroll) userInfo:nil repeats:YES] retain];
        }
        
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        [self getDisplayImagesWithCurrentPage:_curPage];
        
        for (int i = 0; i < 3; i++) {
            [self addViewAtIndex:i];
        }
        
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    }
}

- (void)autoScroll
{
    _curPage = [self validPageValue:_curPage];
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * 2, 0) animated:YES];
    [self loadData];
}

- (void)addViewAtIndex:(int)index
{
    UIView *v = [_curViews objectAtIndex:index];
    v.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleTap:)];
    [v addGestureRecognizer:singleTap];
    [singleTap release];
    v.frame = CGRectMake(_scrollView.bounds.size.width*index, 0, v.bounds.size.width, v.bounds.size.height);
    [_scrollView addSubview:v];
    
}

- (void)getDisplayImagesWithCurrentPage:(NSInteger)page {
    
    NSInteger pre = [self validPageValue:_curPage-1];
    NSInteger last = [self validPageValue:_curPage+1];
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    [_curViews addObject:[_datasource viewForPageAtIndex:pre]];
    [_curViews addObject:[_datasource viewForPageAtIndex:page]];
    [_curViews addObject:[_datasource viewForPageAtIndex:last]];
}

- (NSInteger)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
            [singleTap release];
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [_scrollView addSubview:v];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    int x = aScrollView.contentOffset.x;

    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    _pageControl.currentIndex = _curPage;
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
}

@end
