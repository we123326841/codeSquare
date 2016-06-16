//
//  BasketCellView.m
//  Caipiao
//
//  Created by danal-rich on 8/4/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BasketCellView.h"

@implementation BasketCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (void)update{
    CGSize size = [_methodLabel.text sizeWithFont:_methodLabel.font];
    CGRect rect = _methodLabel.frame;
    rect.size.width = size.width;
    _methodLabel.frame = rect;

    rect = _detailLabel.frame;
    rect.origin.x = _methodLabel.frame.origin.x + _methodLabel.frame.size.width + 5.f;
    _detailLabel.frame = rect;
}

@end
