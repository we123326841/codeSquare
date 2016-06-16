//
//  TranslucentLabel.m
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TranslucentLabel.h"

@implementation TranslucentLabel
@synthesize textLbl = _textLbl;
@synthesize text = _text;
@synthesize cornerRadius = _cornerRadius;
@synthesize bgView = _bgView;

- (void)dealloc{
    [_textLbl release];     _textLbl = nil;
    [_bgView release];      _bgView = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.cornerRadius = 5.f;
        self.clipsToBounds = YES;
        
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.4f;
        [self addSubview:_bgView];
        
        _textLbl = [[UILabel alloc] initWithFrame:self.bounds];
        _textLbl.backgroundColor = [UIColor clearColor];
        _textLbl.textColor = kYellowTextColor;
        _textLbl.font = [UIFont boldSystemFontOfSize:14.f];
        [self addSubview:_textLbl];
        
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

- (void)setAlpha:(CGFloat)alpha{
    _bgView.alpha = alpha;
}

- (void)setText:(NSString *)text{
    _textLbl.text = text;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

@end
