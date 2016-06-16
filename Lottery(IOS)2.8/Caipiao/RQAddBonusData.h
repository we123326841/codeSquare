//
//  RQAddBonusData.h
//  Caipiao
//
//  Created by GroupRich on 15/8/4.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "RQBase.h"

@interface RQAddBonusData : RQBase
//{"awardGroupId":1","chan_id":"1","lotteryId":"2"}
@property (nonatomic,assign)NSInteger awardGroupId;
@property (nonatomic,assign)NSInteger chan_id;
@property (nonatomic,assign)NSInteger lotteryId;

PCOPY NSString * status ;//返回状态
PCOPY NSString *msg ;//返回信息

@end
