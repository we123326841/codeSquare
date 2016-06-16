//
//  RQRevokeZhuiHaoOrder.h
//  Caipiao
//
//  Created by Cyrus on 13-6-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

@interface RQRevokeZhuiHaoOrder : RQBase

//Request
PASSIGN BOOL isLowGame;
PCOPY NSString *recordId;
PCOPY NSString *taskId;
PCOPY NSString *lotteryId;//彩种id
PCOPY NSString *issueCode;//撤单issue
//Response
PSTRONG NSNumber *messageType;
PCOPY NSString*error;

@end
