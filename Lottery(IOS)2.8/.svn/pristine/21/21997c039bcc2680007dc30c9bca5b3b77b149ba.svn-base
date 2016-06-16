//
//  FundsCell.m
//  Caipiao
//
//  Created by CYRUS on 14-8-5.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "FundsCell.h"

@implementation FundsCell

- (void)awakeFromNib
{
    // Initialization code
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

- (void)dealloc {
    [_moneyLabel release];
    [super dealloc];
}
@end
