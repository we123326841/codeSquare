//
//  IntroView.m
//  Caipiao
//
//  Created by danal on 13-4-15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "IntroView.h"

@interface IntroView ()
@property (nonatomic, assign) UIButton *skipButton;
@property (nonatomic, assign) UIButton *enterButton;
@end

@implementation IntroView
@synthesize imageFiles = _imageFiles;

- (void)dealloc{
    [_scroll release];
    [_pageControl release];
    [_imageFiles release];
    [_comblock release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scroll.delegate = self;
        _scroll.pagingEnabled = YES;
        _scroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scroll];
        self.backgroundColor  = [UIColor whiteColor];
        
        CGRect bounds = self.bounds;
        CGRect pcRect;

        pcRect = CGRectMake((bounds.size.width - 50)/2, bounds.size.height - 30, 50, 20);
        _pageControl = [[PageControl alloc] initWithFrame:pcRect
                                              normalImage:[UIImage imageNamed:@"games_slider_li.png"]
                                             currentImage:[UIImage imageNamed:@"games_slider_li_curr.png"]];
        _pageControl.numberOfPages = 1;
        _pageControl.backgroundColor = [UIColor clearColor];
        [self addSubview:_pageControl];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImages:(NSArray *)imageFiles{
    [_imageFiles release];
    _imageFiles = [imageFiles retain];
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            [view removeFromSuperview];
//        }
//    }
    _pageControl.numberOfPages = [imageFiles count];
    int i = 0;
    for (NSString *file in imageFiles){
        NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        CGRect rect = CGRectMake(i*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        if (!IPHONE5) {
            rect.size.height += (568 - 480)/2;
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
        imageView.tag = i+1;
        imageView.image = image;
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = self.backgroundColor;
        [_scroll addSubview:imageView];
        [imageView release];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        [tap release];
        
        _scroll.contentSize = CGSizeMake((i+1)*self.bounds.size.width, self.bounds.size.height);
        i++;
    }
    
    //Skip button
    UIButton *skip = [UIButton buttonWithType:UIButtonTypeCustom];
    [skip setTitle:@"跳过" forState:UIControlStateNormal];
    [skip setTitleColor:kLightGrayTextColor forState:UIControlStateNormal];
    skip.titleLabel.font = [UIFont systemFontOfSize:15.f];
    skip.frame = CGRectMake(self.bounds.size.width - 70, self.bounds.size.height - 50, 60, 30);
    [skip addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:skip];
    self.skipButton = skip;
    
    //Eneter button
    UIButton *enter = [UIButton buttonWithType:UIButtonTypeCustom];
    [enter setTitle:@"立即体验" forState:UIControlStateNormal];
    [enter setTitleColor:RGBAHex(@"3d998a") forState:UIControlStateNormal];
    [enter setBackgroundImage:ResImage(@"btn_600_80.png") forState:UIControlStateNormal];
    [enter setBackgroundImage:ResImage(@"btn_600_80_down.png") forState:UIControlStateHighlighted];
    enter.titleLabel.font = [UIFont systemFontOfSize:18.f];
    enter.frame = CGRectMake(self.bounds.size.width - 30 - 260, self.bounds.size.height - 70, 260, 40);
    [enter addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:enter];
    enter.hidden = YES;
    self.enterButton = enter;
}

static NSInteger _currentIndex = -1;
- (IBAction)tapAction:(UITapGestureRecognizer *)g{
    NSInteger index = g.view.tag - 1;
    
    if (index == [self.imageFiles count] - 1) {
        [UIView animateWithDuration:.5f animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview] ;
            if (_comblock) {
                _comblock();
            }
        }];
    } else {
        if (index != _currentIndex) {
            [_scroll setContentOffset:CGPointMake((index+1)*self.bounds.size.width, 0) animated:YES];
            _scroll.scrollEnabled = NO;
        }
    }
    _currentIndex = index;
    [_pageControl setCurrentIndex:_currentIndex+1];
}

- (IBAction)skipAction:(id)sender{
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview] ;
        if (_comblock) {
            _comblock();
        }
    }];
}

#pragma mark - Scroll Delegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _scroll.scrollEnabled = YES;
    
    int page = ceil(scrollView.contentOffset.x/scrollView.bounds.size.width);
    //The last page
    if (page == _pageControl.numberOfPages-1){
        _skipButton.hidden = YES;
        _enterButton.hidden = NO;
    } else {
        //Other pages
        _skipButton.hidden = NO;
        _enterButton.hidden = YES;
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    Echo(@"%s",__func__);
    int page = ceil(scrollView.contentOffset.x/scrollView.bounds.size.width);
    if (page > _pageControl.numberOfPages) return;
    if (page - 1 != _currentIndex) {
        
        _currentIndex = page - 1;
        [_pageControl setCurrentIndex:page];
    }
    //The last page
    if (page == _pageControl.numberOfPages-1){
        _skipButton.hidden = YES;
        _enterButton.hidden = NO;
    } else {
    //Other pages
        _skipButton.hidden = NO;
        _enterButton.hidden = YES;
    }
}

@end
