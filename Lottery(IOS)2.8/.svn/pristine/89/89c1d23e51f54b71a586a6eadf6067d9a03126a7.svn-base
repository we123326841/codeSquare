//
//  RQTransfer.h
//  Caipiao
//
//  Created by Cyrus on 13-6-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

typedef enum{
    kTransferBankToHigh,
    kTransferHighToBank,
    kTransferBankToLow,
    kTransferLowToBank
}TransferDirection;

@interface RQTransfer : RQBase

//Request
PCOPY NSString * fmoney; //需要转的金额
@property (nonatomic) TransferDirection direction;

//Response
PCOPY NSString *status;
PCOPY NSString *error_message;
PSTRONG NSArray *balanceArray; //返回3个数字，依次银行大厅、高频、低频
@end
