//
//  MaskView.m
//  Caipiao
//
//  Created by danal on 13-7-12.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView

+ (MaskView *)mask{
    CGRect rect = [[UIScreen mainScreen] bounds];
    return [[[self alloc] initWithFrame:rect] autorelease];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.25f];
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

@end
