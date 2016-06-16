//
//  LowFooterActionView.m
//  Caipiao
//
//  Created by cYrus_c on 14-3-6.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "LowFooterActionView.h"

@implementation LowFooterActionView

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

- (void)awakeFromNib{
    self.checkBox.backgroundColor = [UIColor orangeColor];
    self.checkBox.checked = YES;
}

@end
