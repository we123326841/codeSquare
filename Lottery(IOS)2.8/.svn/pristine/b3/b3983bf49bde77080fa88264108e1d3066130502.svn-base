//
//  MyAccountCell.m
//  Caipiao
//
//  Created by CYRUS on 14-7-25.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MyAccountCell.h"

@implementation MyAccountCell

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = Color(@"MyAccountCellBackground");
    _lotteryLabel.textColor = Color(@"MyAccountCellNameColor");
    _methodLabel.textColor = Color(@"MyAccountCellMethodColor");
    _timeLabel.textColor = Color(@"MyAccountCellIssueColor");
    _amountLabel.textColor = Color(@"MyAccountCellIssueColor");
    _statusLabel.textColor = Color(@"MyAccountCellStatusColor");
    _subStatusLabel.textColor = Color(@"MyAccountCellSubStatusColor");

    UIView *sbg = [[UIView alloc] initWithFrame:self.bounds];
    sbg.backgroundColor = Color(@"MyAccountCellSelectedBackground");
    self.selectedBackgroundView = sbg;
    [sbg release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
