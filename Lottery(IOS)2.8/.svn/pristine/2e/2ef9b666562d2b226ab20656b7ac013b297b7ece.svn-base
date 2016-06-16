//
//  IconLabelView.m
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "IconLabelView.h"

@implementation IconLabelView
@synthesize iconView = _iconView;
@synthesize textLbl = _textLbl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        float mar = 10.f, w = 6, h = w, x = mar, y = (frame.size.height - w)/2;
        CGRect rect = CGRectMake(x, y, w, w);
        _iconView = [[UIImageView alloc] initWithFrame:rect];
        //        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        _iconView.clipsToBounds = YES;
        [self addSubview:_iconView];
        
        UIFont *font = [UIFont systemFontOfSize:15.f];
        h = [font lineHeight];
        rect.origin.x += (rect.size.width + mar);
        rect.origin.y = (frame.size.height - h)/2;
        rect.size.width = frame.size.width - rect.origin.x - mar;
        rect.size.height = h;
        
        _textLbl = [[UILabel alloc] initWithFrame:rect];
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

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    for (UIView *v in self.subviews){
        v.backgroundColor = backgroundColor;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _iconView.center = CGPointMake(_iconView.center.x, self.bounds.size.height/2);
    _textLbl.center = CGPointMake(_textLbl.center.x, self.bounds.size.height/2);
}

@end
