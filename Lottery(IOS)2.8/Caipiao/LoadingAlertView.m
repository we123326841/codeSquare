//
//  LodingAlertView.m
//  SideMenuController
//
//  Created by danal on 13-1-3.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoadingAlertView.h"

#define kMarginX 10.f
#define kMarginY 10.f

static NSMutableArray *__hudQueue = nil;

@implementation HUDView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat w = 220.f, h = 60.f;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - w)/2, (frame.size.height - h)/2 - 20.f, w, h)];
        _imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6f];
        _imageView.layer.cornerRadius = 5.f;
        _imageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _imageView.layer.shadowOpacity = 0.6f;
        _imageView.layer.shadowRadius = 5.f;
        _imageView.layer.shadowOffset = CGSizeMake(2, 2);
        [self addSubview:_imageView];
        [_imageView release];
        
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _iconView.frame = CGRectMake(kMarginX, (_imageView.bounds.size.height - _iconView.bounds.size.height)/2,
                                     _iconView.bounds.size.width, _iconView.bounds.size.height);
        _iconView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [_imageView addSubview:_iconView];
        [_iconView release];
        
        float x = _iconView.frame.origin.x + _iconView.frame.size.width + 15.f, y = kMarginY;
        w = _imageView.frame.size.width - x - _iconView.frame.origin.x, h = 20.f;
        _textLbl = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _textLbl.backgroundColor = [UIColor clearColor];
        _textLbl.textColor = [UIColor whiteColor];
        _textLbl.font = [UIFont systemFontOfSize:13.f];
        _textLbl.numberOfLines = 0;
        [_imageView addSubview:_textLbl];
        [_textLbl release];
        
        y += h ;
        _subTextLbl = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _subTextLbl.backgroundColor = [UIColor clearColor];
        _subTextLbl.textColor = [UIColor whiteColor];
        _subTextLbl.font = [UIFont systemFontOfSize:13.f];
        _subTextLbl.numberOfLines = 0;
        _subTextLbl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [_imageView addSubview:_subTextLbl];
        [_subTextLbl release];
        
        _touchToHide = YES;
        
        //Enqueue
        if (!__hudQueue){
            __hudQueue = [[NSMutableArray alloc] init];
        }
        [__hudQueue addObject:self];
    }
    return self;
}

- (void)showMessage:(NSString *)msg subtitle:(NSString *)subtitle loading:(BOOL)loading{
    
    _textLbl.text = msg;
    _subTextLbl.text = subtitle;
    _subTextLbl.hidden = subtitle == nil;
    
    //Resize
    float maxWidth = self.bounds.size.width - 60.f;
    float lblMaxWidth = maxWidth - _textLbl.frame.origin.x - kMarginX*1.5f;
    CGRect rect = _textLbl.frame;
    CGSize size = CGSizeMake(lblMaxWidth, 10e3);
    size = [msg sizeWithFont:_textLbl.font constrainedToSize:size];
    rect.size.height = size.height;
    rect.size.width = size.width;
    _textLbl.frame = rect;
    
    rect = _subTextLbl.frame;
    size = CGSizeMake(lblMaxWidth, 10e3);
    size = [subtitle sizeWithFont:_subTextLbl.font constrainedToSize:size];
    rect.size.height = size.height;
    rect.size.width = size.width;
    _subTextLbl.frame = rect;
    
    float minHeight = 35.f;//1.5*_iconView.bounds.size.height;
    rect = _imageView.frame;
    rect.size.height = MAX(minHeight,
                           _textLbl.frame.origin.y*2 +  _textLbl.frame.size.height + _subTextLbl.frame.size.height
                           );
    _imageView.frame = rect;
    
    //Re-layout
    if (subtitle){
        CGRect frame = _subTextLbl.frame;
        frame.origin.y = _imageView.bounds.size.height - _textLbl.frame.origin.y - frame.size.height;
        _subTextLbl.frame = frame;
    } else {
        CGRect frame = _textLbl.frame;
        frame.origin.y = (_imageView.bounds.size.height - frame.size.height)/2;
        _textLbl.frame = frame;
    }
    rect = _imageView.frame;
    CGFloat w1 = _textLbl.frame.origin.x + _textLbl.frame.size.width + 30.f;
    CGFloat w2 = _subTextLbl.frame.origin.x + _subTextLbl.frame.size.width + 30.f;
    rect.size.width = MAX(w1, w2);
    rect.origin.x = (self.bounds.size.width - rect.size.width)/2;
    _imageView.frame = rect;
    
    //Add shadow
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, _imageView.bounds);
    _imageView.layer.shadowPath = path;
    CGPathRelease(path);
    
    if (loading){
        /*
        _iconView.image = [UIImage imageNamed:@"ico-loading.png"];
        CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        kfa.duration = 1.f;
        kfa.values = [NSArray arrayWithObjects:
                      [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1.f)],
                      [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1.f)],
                      [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*2, 0, 0, 1.f)]
                      , nil];
        kfa.repeatCount = 10e6;
        [_iconView.layer addAnimation:kfa forKey:@"Rotation"];
         */
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicator.center = _iconView.center;
        [indicator startAnimating];
        [_imageView addSubview:indicator];
        [indicator release];
        
    } else {
        _iconView.image = ResImage(@"info.png");
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    //Animated show
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.f)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 1.f)],
                  nil];
    kfa.duration = .1f;
    kfa.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_imageView.layer addAnimation:kfa forKey:nil];
    
    [self delayHides:3.f];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag){
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.1f];
    }
}

- (void)delayHides:(int)delay{
    if (_timer){
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

- (void)hide{
    if (_timer)
        [_timer invalidate];
    [self removeFromSuperview];
    
    //Dequeue
    [__hudQueue removeObject:self];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchToHide) {
        [self hide];
    }
}

+ (HUDView *)showMessageToView:(UIView *)superview msg:(NSString *)msg subtitle:(NSString *)subtitle{
    HUDView *hud = [[[HUDView alloc] initWithFrame:superview.bounds] autorelease];
    [superview addSubview:hud];
    [hud showMessage:msg subtitle:subtitle loading:NO];
    return hud;
}

+ (HUDView *)showLoadingToView:(UIView *)superview msg:(NSString *)msg subtitle:(NSString *)subtitle{
    HUDView *hud = [[[HUDView alloc] initWithFrame:superview.bounds] autorelease];
    hud.touchToHide = NO;
    [superview addSubview:hud];
    [hud showMessage:msg subtitle:subtitle loading:YES];
    return hud;
}

+ (HUDView *)showLoadingToView:(UIView *)superview msg:(NSString *)msg subtitle:(NSString *)subtitle touchToHide:(BOOL)touchToHide
{
    HUDView *hud = [[[HUDView alloc] initWithFrame:superview.bounds] autorelease];
    hud.touchToHide = touchToHide;
    [superview addSubview:hud];
    [hud showMessage:msg subtitle:subtitle loading:YES];
    return hud;
}

+ (HUDView *)showLoading:(UIView *)superview{
    return [self showLoadingToView:superview msg:NSLocalizedString(@"Loading...", nil) subtitle:nil];
}

+ (void)dismissCurrent{
    HUDView *hud = [__hudQueue firstObject];
    [hud hide];
}

+ (void)setTouchHide:(BOOL)hide{
    HUDView *hud = [__hudQueue firstObject];
    hud.touchToHide = hide;
}

@end