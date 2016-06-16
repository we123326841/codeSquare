//
//  PullingRefreshTableView.m
//  PullingTableView
//
//  Created by luo danal on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSPullingRefreshTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "MSUtil.h"
#import "MSActivityView.h"


#define kPROffsetY 60.f
#define kPRMargin 5.f
#define kPRLabelHeight 20.f
#define kPRLabelWidth 100.f
#define kPRArrowWidth 20.f  
#define kPRArrowHeight 40.f

//Tips text color of Loading view
//#define kTextColor [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
//Background color of Loading view
//#define kPRBGColor [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0]
#define kTextColor  [UIColor darkGrayColor]
#define kPRBGColor  [UIColor clearColor]
#define kPRAnimationDuration .18f

static int _effectOff = 1;

@interface LoadingView () 
- (void)updateRefreshDate :(NSDate *)date;
- (void)layouts;
@end

@implementation LoadingView
@synthesize atTop = _atTop;
@synthesize state = _state;
@synthesize loading = _loading;

- (void)dealloc{
    [_stateLabel release];
    [_dateLabel release];
    [_arrowView release];
    [_activityView release];
    [super dealloc];
}

 //Default is at top
- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top {
    self = [super initWithFrame:frame];
    if (self) {
        self.atTop = top;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = kPRBGColor;
//        self.backgroundColor = [UIColor clearColor];
        UIFont *ft = [UIFont boldSystemFontOfSize:12.f];
        _stateLabel = [[UILabel alloc] init ];
        _stateLabel.font = ft;
        _stateLabel.textColor = kTextColor;
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.backgroundColor = kPRBGColor;
        _stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _stateLabel.text = NSLocalizedString(@"下拉刷新", @"");
        [self addSubview:_stateLabel];

        _dateLabel = [[UILabel alloc] init ];
        _dateLabel.font = ft;
        _dateLabel.textColor = kTextColor;
//        _dateLabel.textAlignment = UITextAlignmentCenter;
        _dateLabel.backgroundColor = kPRBGColor;
        _dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        _dateLabel.text = NSLocalizedString(@"最后更新", @"");
        [self addSubview:_dateLabel];
        _dateLabel.hidden = YES;
        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20) ];

        _arrow = [CALayer layer];
        _arrow.frame = CGRectMake(0, 0, 20, 20);
        _arrow.contentsGravity = kCAGravityResizeAspect;
      
        NSString *file = [[NSBundle mainBundle] pathForResource:@"ico-down.png" ofType:nil];
        _arrow.contents = (id)[UIImage imageWithCGImage:[UIImage imageWithContentsOfFile:file].CGImage scale:1 orientation:UIImageOrientationDown].CGImage;

        [self.layer addSublayer:_arrow];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView];
        
        UIImage *round = [UIImage imageNamed:@"ico-loading.png"];
        if (round){
            MSActivityView *activityView  = [[MSActivityView alloc] initWithImage:round];
            [self addSubview:activityView];
            _activityView = (id)activityView;
        }
        
        [self layouts];
        
    }
    return self;
}

- (void)layouts {
    
    CGSize size = self.frame.size;
    CGRect stateFrame,dateFrame,arrowFrame;

    float x = 0,y,margin;
//    x = 0;
    margin = (kPROffsetY - 2*kPRLabelHeight)/2;
    if (self.isAtTop) {
        y = size.height - margin - kPRLabelHeight;
        dateFrame = CGRectMake(115,y,size.width,kPRLabelHeight);
        
        y = y - kPRLabelHeight;
        stateFrame = CGRectMake(115, y, size.width-230, kPRLabelHeight);
        
        
        x = kPRMargin;
        y = size.height - margin - kPRArrowHeight;
//        arrowFrame = CGRectMake(4*x, y, kPRArrowWidth, kPRArrowHeight);
        arrowFrame = CGRectMake(dateFrame.origin.x - kPRArrowWidth - 10.f, y, kPRArrowWidth, kPRArrowHeight);
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"ico-down.png" ofType:nil];
        UIImage *arrow = [UIImage imageWithContentsOfFile:file];//[UIImage imageNamed:@"blueArrow"];
        _arrow.contents = (id)arrow.CGImage;
        
    } else {    //at bottom
        y = margin;
        stateFrame = CGRectMake(100, y, size.width-200, kPRLabelHeight );
        
        y = y + kPRLabelHeight;
        dateFrame = CGRectMake(100, y, size.width, kPRLabelHeight);
        
        x = kPRMargin;
        y = margin;
//        arrowFrame = CGRectMake(4*x, y, kPRArrowWidth, kPRArrowHeight);
        arrowFrame = CGRectMake(dateFrame.origin.x - kPRArrowWidth - 10.f, y, kPRArrowWidth, kPRArrowHeight);
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"ico-up.png" ofType:nil];
        UIImage *arrow = [UIImage imageWithContentsOfFile:file]; //[UIImage imageNamed:@"blueArrowDown"];
        _arrow.contents = (id)arrow.CGImage;
        _stateLabel.text = NSLocalizedString(@"向上拉动获取更多", @"");
    }
    
    _stateLabel.frame = stateFrame;
    _dateLabel.frame = dateFrame;
    _arrowView.frame = arrowFrame;
    _activityView.center = _arrowView.center;
    _stateLabel.center = CGPointMake(_stateLabel.center.x, _arrowView.center.y);
    _arrow.frame = arrowFrame;
    _arrow.transform = CATransform3DIdentity;
}

- (void)setState:(PRState)state {
    [self setState:state animated:YES];
}

- (void)setState:(PRState)state animated:(BOOL)animated{
    float duration = animated ? kPRAnimationDuration : 0.f;
    if (_state != state) {
        _state = state;
        if (_state == kPRStateLoading) {    //Loading
            
            _arrow.hidden = YES;
            _activityView.hidden = NO;
            [_activityView startAnimating];
            
            _loading = YES;
            if (self.isAtTop) {
                _stateLabel.text = NSLocalizedString(@"正在更新", @"");
            } else {
                _stateLabel.text = NSLocalizedString(@"正在加载", @"");
            }
            
        } else if (_state == kPRStatePulling && !_loading) {    //Scrolling
            
            _arrow.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            _arrow.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            [CATransaction commit];
            
            if (self.isAtTop) {
                _stateLabel.text = NSLocalizedString(@"释放立即刷新", @"");
            } else {
                _stateLabel.text = NSLocalizedString(@"释放获取更多", @"");
            }
            
            if (!_effectOff) {
//                PlayEffect(@"pull.wav");
            }
        } else if (_state == kPRStateNormal && !_loading){    //Reset
            
            _arrow.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            _arrow.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            if (self.isAtTop) {
                _stateLabel.text = NSLocalizedString(@"下拉刷新", @"");
            } else {
                _stateLabel.text = NSLocalizedString(@"向上拉动获取更多", @"");
            }
            if (!_effectOff) {
//                PlayEffect(@"pull.wav");
            }
        } else if (_state == kPRStateHitTheEnd) {
            if (!self.isAtTop) {    //footer
                _arrow.hidden = YES;
                _stateLabel.text = NSLocalizedString(@"没有了哦", @"");
            }
        }
    }
}

- (void)setLoading:(BOOL)loading {
//    if (_loading == YES && loading == NO) {
//        [self updateRefreshDate:[NSDate date]];
//    }
    _loading = loading;
}

- (void)updateRefreshDate :(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [df stringFromDate:date];
    NSString *title = NSLocalizedString(@"今天", nil);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:date toDate:[NSDate date] options:0];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    if (year == 0 && month == 0 && day < 3) {
        if (day == 0) {
            title = NSLocalizedString(@"今天",nil);
        } else if (day == 1) {
            title = NSLocalizedString(@"昨天",nil);
        } else if (day == 2) {
            title = NSLocalizedString(@"前天",nil);
        }
        df.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",title];
        dateString = [df stringFromDate:date];
        
    } 
    _dateLabel.text = [NSString stringWithFormat:@"%@: %@",
                       NSLocalizedString(@"最后更新时间", @""),
                       dateString];
    [df release];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface MSPullingRefreshTableView ()
- (void)scrollToNextPage;
@end

@implementation MSPullingRefreshTableView
@synthesize pullingDelegate = _pullingDelegate;
@synthesize autoScrollToNextPage;
@synthesize reachedTheEnd = _reachedTheEnd;
@synthesize headerOnly = _headerOnly;


- (void)turnOffEffect:(BOOL)yesOrNo{
    _effectOff = yesOrNo == YES;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentSize"];
    [_headerView release];
    [_footerView release];
//    [_msgLabel release];
    [super dealloc];
}

- (void)setup{
    CGRect frame = self.bounds;
    CGRect rect = CGRectMake(0, 0 - frame.size.height, frame.size.width, frame.size.height);
    _headerView = [[LoadingView alloc] initWithFrame:rect atTop:YES];
    _headerView.atTop = YES;
    [self addSubview:_headerView];
    
    rect = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height);
    _footerView = [[LoadingView alloc] initWithFrame:rect atTop:NO];
    _footerView.atTop = NO;
    [self addSubview:_footerView];
    
    //Background tips
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:frame];
    self.backgroundView = backgroundView;
    [backgroundView release];
    
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<MSPullingRefreshTableViewDelegate>)aPullingDelegate {
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.pullingDelegate = aPullingDelegate;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<MSPullingRefreshTableViewDelegate>)aPullingDelegate style:(UITableViewStyle) tableStyle{
    self = [self initWithFrame:frame style:tableStyle];
    if (self) {
        self.pullingDelegate = aPullingDelegate;
    }
    return self;
}

- (void)setReachedTheEnd:(BOOL)reachedTheEnd{
    _reachedTheEnd = reachedTheEnd;
    if (_reachedTheEnd){
        _footerView.state = kPRStateHitTheEnd;
    } else {
        _footerView.state = kPRStateNormal;
    }
}

- (void)setHeaderOnly:(BOOL)headerOnly{
    _headerOnly = headerOnly;
    _footerView.hidden = _headerOnly;
}

- (void)setNoLoadingView:(BOOL)noLoadingView{
    _noLoadingView = noLoadingView;
    _headerView.hidden = noLoadingView;
    _footerView.hidden = noLoadingView;
}

#pragma mark - Scroll methods

- (void)scrollToNextPage {
    float h = self.frame.size.height;
    float y = self.contentOffset.y + h;
    y = y > self.contentSize.height ? self.contentSize.height : y;
    
//    [UIView animateWithDuration:.4 animations:^{
//        self.contentOffset = CGPointMake(0, y);
//    }];
//    NSIndexPath *ip = [NSIndexPath indexPathForRow:_bottomRow inSection:0];
//    [self scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    
    [UIView animateWithDuration:.7f 
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut 
                     animations:^{
                        self.contentOffset = CGPointMake(0, y);  
                     }
                     completion:^(BOOL bl){
                     }];
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView {

    if (_noLoadingView || _headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading) {
        return;
    }

    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.frame.size;
    CGSize contentSize = scrollView.contentSize;
 
    float yMargin = offset.y + size.height - contentSize.height;
    if (offset.y < -kPROffsetY) {   //header totally appeard
         _headerView.state = kPRStatePulling;
    } else if (offset.y > -kPROffsetY && offset.y < 0){ //header part appeared
        _headerView.state = kPRStateNormal;
        
    } else if ( yMargin > kPROffsetY){  //footer totally appeared
        if (_footerView.state != kPRStateHitTheEnd) {
            _footerView.state = kPRStatePulling;
        }
    } else if ( yMargin < kPROffsetY && yMargin > 0) {//footer part appeared
        if (_footerView.state != kPRStateHitTheEnd) {
            _footerView.state = kPRStateNormal;
        }
    }
}

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView {
    
//    CGPoint offset = scrollView.contentOffset;
//    CGSize size = scrollView.frame.size;
//    CGSize contentSize = scrollView.contentSize;
    if (_noLoadingView || _headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading) {
        return;
    }
    if (_headerView.state == kPRStatePulling) {
//    if (offset.y < -kPROffsetY) {
        _isFooterInAction = NO;
        _headerView.state = kPRStateLoading;
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(kPROffsetY, 0, 0, 0);
        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartRefreshing:)]) {
            [_pullingDelegate pullingTableViewDidStartRefreshing:self];
        }
    } else if (_footerView.state == kPRStatePulling) {
//    } else  if (offset.y + size.height - contentSize.height > kPROffsetY){
        if (self.reachedTheEnd || self.headerOnly) {
            return;
        }
        _isFooterInAction = YES;
        _footerView.state = kPRStateLoading;
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, kPROffsetY, 0);
        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartLoading:)]) {
            [_pullingDelegate pullingTableViewDidStartLoading:self];
        }
    }
}

- (void)tableViewDidFinishedLoading {
    [self tableViewDidFinishedLoadingWithMessage:nil];  
}

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg{
    if (!_effectOff) {
//        PlayEffect(@"bubble.caf");
    }
    //    if (_headerView.state == kPRStateLoading) {
    if (_headerView.loading) {
        _headerView.loading = NO;
        [_headerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewRefreshingFinishedDate)]) {
            date = [_pullingDelegate pullingTableViewRefreshingFinishedDate];
        }
        [_headerView updateRefreshDate:date];
        [UIView animateWithDuration:kPRAnimationDuration*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL bl){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
        }];
    }
    //    if (_footerView.state == kPRStateLoading) {
    else if (_footerView.loading) {
        _footerView.loading = NO;
        [_footerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewLoadingFinishedDate)]) {
            date = [_pullingDelegate pullingTableViewRefreshingFinishedDate];
        }
        [_footerView updateRefreshDate:date];
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL bl){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
        }];
    }
}

- (void)flashMessage:(NSString *)msg{
    //Show message
    __block CGRect rect = CGRectMake(0, self.contentOffset.y - 20, self.bounds.size.width, 20);
    
    if (_msgLabel == nil) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.frame = rect;
        _msgLabel.font = [UIFont systemFontOfSize:14.f];
        _msgLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _msgLabel.backgroundColor = [UIColor orangeColor];
        _msgLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_msgLabel];    
    }
    _msgLabel.text = msg;
    
    rect.origin.y += 20;
    [UIView animateWithDuration:.4f animations:^{
        _msgLabel.frame = rect;
    } completion:^(BOOL finished){
        rect.origin.y -= 20;
        [UIView animateWithDuration:.4f delay:1.2f options:UIViewAnimationOptionCurveLinear animations:^{
            _msgLabel.frame = rect;
        } completion:^(BOOL finished){
            [_msgLabel removeFromSuperview];
            _msgLabel = nil;            
        }];
    }];
}

- (void)setTipsType:(PRTipsType)type{
    if (_tipsType == type) return;
    _tipsType = type;
    static int neterrorTag = 0x1000;
    static int nodataTag = 0x2000;
    UIView *view = self.backgroundView;
    [[view viewWithTag:neterrorTag] removeFromSuperview];
    [[view viewWithTag:neterrorTag+1] removeFromSuperview];
    [[view viewWithTag:nodataTag] removeFromSuperview];
    [[view viewWithTag:nodataTag+1] removeFromSuperview];
    
    if (_tipsType != kPRTipsTypeDefault){
        if (! self.backgroundView){
            UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
            self.backgroundView = backgroundView;
            [backgroundView release];
            view = self.backgroundView;
        }
        
        float minWidth = 30.f;//135.f;
        float x = (self.bounds.size.width - minWidth)/2;
        float y = self.bounds.size.height/3 - 15;
        UIImageView *tipsIconView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 30, 40)];
        tipsIconView.tag = neterrorTag;
        tipsIconView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:tipsIconView];
        [tipsIconView release];
        
        UILabel *tipsLbl = [[UILabel alloc] initWithFrame:CGRectMake(x + 30 + 5, y, 100, 40)];
        tipsLbl.tag = neterrorTag+1;
        tipsLbl.numberOfLines = 0;
        tipsLbl.font = [UIFont systemFontOfSize:13.f];
        tipsLbl.textColor = [UIColor whiteColor];
        tipsLbl.backgroundColor = [UIColor clearColor];
        [view addSubview:tipsLbl];
        [tipsLbl release];
        
        switch (_tipsType) {
            case kPRTipsTypeNetworkError:
                tipsIconView.image = [UIImage imageNamed:@"ico-network-error.png"];
                tipsLbl.text = kStringNetworkErrorTips;
                break;
            case kPRTipsTypeNoData:
                tipsIconView.image = [UIImage imageNamed:@"ico-pull-load.png"];
                tipsLbl.text = kStringNoDataTips;
                break;
            default:
                break;
        }
    }
}

- (void)setTips:(NSString *)tips andIcon:(UIImage *)icon{
    static NSInteger tag = 0xf0f0;
    UIView *view = self.backgroundView;
    [[view viewWithTag:tag] removeFromSuperview];
    [[view viewWithTag:tag+1] removeFromSuperview];
    if (tips == nil && icon == nil) return;
    
    if (!self.backgroundView){
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor clearColor];
        self.backgroundView = backgroundView;
        [backgroundView release];
        view = self.backgroundView;
    }
    CGFloat y = 60;
    UIImageView *tipsIconView = [[UIImageView alloc] initWithFrame:CGRectMake(50, y, self.bounds.size.width-100, icon.size.height)];
    tipsIconView.tag = tag;
    tipsIconView.image = icon;
    tipsIconView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:tipsIconView];
    [tipsIconView release];
    
    y += tipsIconView.frame.size.height;
    UILabel *tipsLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, y, self.bounds.size.width-100, 50)];
    tipsLbl.tag = tag+1;
    tipsLbl.text = tips;
    tipsLbl.numberOfLines = 0;
    tipsLbl.font = [UIFont systemFontOfSize:13.f];
    tipsLbl.textColor = [UIColor lightGrayColor];
    tipsLbl.textAlignment = NSTextAlignmentCenter;
    tipsLbl.backgroundColor = [UIColor clearColor];
    [view addSubview:tipsLbl];
    [tipsLbl release];

}

- (void)launchRefreshing {
    [self setContentOffset:CGPointMake(0,0) animated:NO];
    [UIView animateWithDuration:kPRAnimationDuration delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentOffset = CGPointMake(0, -kPROffsetY-1);
    } completion:^(BOOL bl){
        [self tableViewDidEndDragging:self];
    }];
}

#pragma mark - 

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    CGRect frame = _footerView.frame;
    CGSize contentSize = self.contentSize;
    frame.origin.y = contentSize.height < self.frame.size.height ? self.frame.size.height : contentSize.height;
    _footerView.frame = frame;
    if (self.autoScrollToNextPage && _isFooterInAction) {
        [self scrollToNextPage];
        _isFooterInAction = NO;
    } else if (_isFooterInAction) {
        CGPoint offset = self.contentOffset;
        offset.y += 44.f;
        self.contentOffset = offset;
    }

    
}

@end
