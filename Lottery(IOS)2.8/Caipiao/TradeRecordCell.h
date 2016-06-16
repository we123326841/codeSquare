//
//  TradeRecordCell.h
//  Caipiao
//
//  Created by rod on 13/1/10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "GreenOddEvenCell.h"

@interface TradeRecordCell : GreenOddEvenCell

@property (strong, nonatomic) IBOutlet UILabel * lblTradeType;
@property (strong, nonatomic) IBOutlet UILabel * lblAmount;
@property (strong, nonatomic) IBOutlet UILabel * lblAccountBalance;
@property (strong, nonatomic) IBOutlet UILabel * lblDate;

@end
