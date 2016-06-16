//
//  HallLotteryCell.m
//  Caipiao
//
//  Created by cYrus_c on 14-2-28.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "HallLotteryCell.h"

@implementation HallLotteryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    self.layer.cornerRadius = 3.f;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.1f];
    self.endLabel.textColor = kYellowWhiteTextColor;
    self.cornerLabel.textColor = kYellowWhiteTextColor;
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
