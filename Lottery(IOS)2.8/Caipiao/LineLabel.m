//
//  LineLabel.m
//  Caipiao
//
//  Created by danal on 13-1-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "LineLabel.h"

@implementation LineLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    [kYellowTextColor set];
    UIRectFrame(CGRectMake(0, rect.size.height - 1.f, rect.size.width, 1.f));
}


@end
