//
//  GallaryView.m
//
//
//  Created by danal.luo on 5/26/14.
//  Copyright (c) 2014 danal. All rights reserved.
//

#import "MSGallaryView.h"
#import "MSWebImageView.h"


@implementation MSGallaryView

- (void)dealloc{
#if !__has_feature(objc_arc)
    [_items release];
    [_timer release];
    [super dealloc];
#endif
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self.scroll removeFromSuperview];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    scroll.backgroundColor = [UIColor clearColor];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.delegate = self;
    [self addSubview:scroll];
    [scroll release];
    self.scroll = scroll;

    [self.pageControl removeFromSuperview];
    UIPageControl *pc = [[UIPageControl alloc] initWithFrame:CGRectMake((self.bounds.size.width - 100)/2, self.bounds.size.height - 25, 100, 20)];
    pc.backgroundColor = [UIColor clearColor];
    [self addSubview:pc];
    [pc release];
    self.pageControl = pc;
    
    _pageControl.numberOfPages = 1;
    _pageControl.currentPage = 0;
    _timeInterval = 5.f;
}

- (void)update{

    for (UIView *v in _scroll.subviews){
        if ([v isKindOfClass:[MSWebImageView class]]){
            [v removeFromSuperview];
        }
    }
    
    _scroll.contentOffset = CGPointZero;
    _pageControl.numberOfPages = [_items count];
    for (NSUInteger i = 0; i < [_items count]; i++) {
        MSGallaryItem *item = _items[i];
        MSWebImageView *imgv = [[MSWebImageView alloc] initWithFrame:CGRectMake(i*_scroll.bounds.size.width, 0, _scroll.bounds.size.width, _scroll.bounds.size.height)];
        [imgv addTarget:self action:@selector(onItemClick:) forControlEvents:UIControlEventTouchUpInside];
        imgv.tag = i;
        imgv.autoLoading = YES;
        if (item.image)
            imgv.image = item.image;
        if (item.imageUrl)
            imgv.url = item.imageUrl;
        [_scroll addSubview:imgv];
        _scroll.contentSize = CGSizeMake((i+1)*_scroll.bounds.size.width, _scroll.bounds.size.height);
        [imgv release];
    }
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(scrollTick:) userInfo:nil repeats:YES];
}

- (void)onItemClick:(MSWebImageView *)sender{
    _clickedItemIndex = sender.tag;
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)scrollTick:(NSTimer *)timer{
    NSUInteger curpage = _pageControl.currentPage + 1;
    if (curpage == _pageControl.numberOfPages) {
        curpage = 0;
    }
    _pageControl.currentPage = curpage;
    [_scroll setContentOffset:CGPointMake(curpage*self.bounds.size.width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/self.bounds.size.width;
}


@end


/* MSGallaryItem  */
@implementation MSGallaryItem

- (void)dealloc{
    self.image = nil;
    self.imageUrl = nil;
    self.jumpLink = nil;
    [super dealloc];
}

+ (id)itemWithImage:(UIImage *)image url:(NSString *)imageUrl jumpLink:(NSString *)jumpLink{
    MSGallaryItem *item = [[MSGallaryItem alloc] init];
    item.image = image;
    item.imageUrl = imageUrl;
    item.jumpLink = jumpLink;
    return [item autorelease];
}

@end