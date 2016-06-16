//
//  FooterActionView.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "FooterActionView.h"


@implementation FooterActionView
@synthesize leftView = _leftView;
@synthesize middleView = _middleView;
@synthesize rightView = _rightView;

- (void)dealloc{
    [_leftView release];
    [_middleView release];
    [_rightView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.4f;
//        bgView.layer.shadowOffset = CGSizeMake(0, -2);
//        bgView.layer.shadowOpacity = 0.5f;
//        bgView.layer.shadowColor = [UIColor grayColor].CGColor;
        [self addSubview:bgView];
        [bgView release];
        _bgView = bgView;
        
        float mar = 10.f;//(frame.size.width - (3*w + exWitdth))/4;
        float w = 80.f, h = 30.f, exWitdth = frame.size.width - 2*mar - 3*w;
        float x = mar, y = 5.f;
        CGRect rect = CGRectMake(x, y, w, h);
        {
            IconTextButton *but = [IconTextButton buttonWithType:UIButtonTypeCustom];
            but.frame = rect;
            but.identifier = kIdentifierLeft;
            but.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
            [but setTitle:@"清空" forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:@"trash.png"] forState:UIControlStateNormal];
            [self addSubview:but];
            _leftView = [but retain];
        }
        {
            rect.origin.x += (w);
            IconTextButton *but = [IconTextButton buttonWithType:UIButtonTypeCustom];
            rect.size.width = w + exWitdth;
            but.frame = rect;
            but.identifier = kIdentifierMiddle;
            but.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
            [but setTitle:@"添加" forState:UIControlStateNormal];
            [but setImage:[UIImage imageNamed:@"cart_add.png"] forState:UIControlStateNormal];
            [self addSubview:but];
            _middleView = [but retain];
        }
        {
            rect.origin.x += (rect.size.width);
            rect.size.width = w;
            IconTextButton *but = [IconTextButton buttonWithType:UIButtonTypeCustom];
            but.frame = rect;
            but.identifier = kIdentifierRight;
            but.titleEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
            but.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
            [but setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
            [but setTitle:@"确认" forState:UIControlStateNormal];
            [self addSubview:but];
            _rightView = [but retain];
        }
    }
    return self;
}

- (void)setLeftView:(UIView *)view{
    if (_leftView != view) {
        CGRect frame = _leftView.frame;
        [_leftView removeFromSuperview];
        [_leftView release];
        _leftView = nil;
        _leftView = [view retain];
        _leftView.frame = frame;
        [self addSubview:_leftView];
        
    }
}

- (void)setMiddleView:(UIView *)middleView{
    if (_middleView != middleView) {
        CGRect frame = _middleView.frame;
        [_middleView removeFromSuperview];
        [_middleView release];
        _middleView = nil;
        _middleView = [middleView retain];
        _middleView.frame = frame;
        [self addSubview:_middleView];
        
    }
}

- (void)setRightView:(UIView *)rightView{
    if (_rightView != rightView) {
        CGRect frame = _rightView.frame;
        [_rightView removeFromSuperview];
        [_rightView release];
        _rightView = nil;
        _rightView = [rightView retain];
        _rightView.frame = frame;
        [self addSubview:_rightView];
        
    }
}

- (void)setAlpha:(CGFloat)alpha{
    _bgView.alpha = alpha;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
