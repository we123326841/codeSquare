//
//  TransferResultView.h
//  Caipiao
//
//  Created by cYrus_c on 14-1-8.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RQTransfer.h"

@interface TransferResultView : UIView

@property (nonatomic) TransferDirection direction;
@property (copy, nonatomic) NSString *transferAmount;
@property (strong, nonatomic) NSArray *balanceArray;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;
@property (assign, nonatomic) IBOutlet UILabel *bankLbl;
@property (assign, nonatomic) IBOutlet UILabel *highLbl;
@property (assign, nonatomic) IBOutlet UILabel *lowLbl;
@property (assign, nonatomic) IBOutlet UILabel *totalLbl;
@property (assign, nonatomic) IBOutlet UIButton *retryButton;

@end
