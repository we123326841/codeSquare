//
//  RQTransfer.m
//  Caipiao
//
//  Created by Cyrus on 13-6-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQTransfer.h"

@implementation RQTransfer

- (void)prepare
{
    [self setValue:_fmoney forField:@"fmoney"];
    switch (_direction) {
        case kTransferBankToHigh:
            self.url = kUrlTransferBankToHigh;
            break;
        case kTransferHighToBank:
            self.url = kUrlTransferHighToBank;
            break;
        case kTransferBankToLow:
            self.url = kUrlTransferBankToLow;
            break;
        case kTransferLowToBank:
            self.url = kUrlTransferLowToBank;
            break;
        default:
            break;
    }
    [super prepare];
}

- (void)parse:(id)result
{
    Echo(@"RQTransfer | %@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        self.status = [result stringForKey:@"status"];
        self.error_message = [result stringForKey:@"error_message"];
        self.balanceArray = [result objectForKey:@"balance"];
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end
