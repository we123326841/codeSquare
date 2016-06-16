//
//  TransferResultView.m
//  Caipiao
//
//  Created by cYrus_c on 14-1-8.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "TransferResultView.h"

@implementation TransferResultView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    switch (_direction) {
        case kTransferBankToHigh:
            _amountLbl.text = [NSString stringWithFormat:@"银行大厅转出：%@", _transferAmount];
            break;
        case kTransferBankToLow:
            _amountLbl.text = [NSString stringWithFormat:@"银行大厅转出：%@", _transferAmount];
            break;
        case kTransferHighToBank:
            _amountLbl.text = [NSString stringWithFormat:@"高频转出：%@", _transferAmount];
            break;
        case kTransferLowToBank:
            _amountLbl.text = [NSString stringWithFormat:@"低频转出%@", _transferAmount];
            break;
        default:
            break;
    }
    
    _bankLbl.text = [_bankLbl.text stringByAppendingFormat:@"%@", [SharedModel formatBalance:[self.balanceArray objectAtIndex:0]]];
    _highLbl.text = [_highLbl.text stringByAppendingFormat:@"%@", [SharedModel formatBalance:[self.balanceArray objectAtIndex:1]]];
    _lowLbl.text = [_lowLbl.text stringByAppendingFormat:@"%@", [SharedModel formatBalance:[self.balanceArray objectAtIndex:2]]];
    
    float totalAmount = [[self.balanceArray objectAtIndex:0] floatValue] + [[self.balanceArray objectAtIndex:1] floatValue] + [[self.balanceArray objectAtIndex:2] floatValue];
    _totalLbl.text = [_totalLbl.text stringByAppendingFormat:@"%@", [SharedModel formatBalancef:totalAmount]];
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
