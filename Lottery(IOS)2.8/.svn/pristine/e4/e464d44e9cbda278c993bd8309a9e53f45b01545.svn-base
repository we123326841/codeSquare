//
//  CDSSC.m
//  Caipiao
//
//  Created by danal on 13-5-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CDSSC.h"
#import "CDLottery.h"

@implementation CDSSC

@dynamic abbreviation;
@dynamic name;
@dynamic lotteryId;
@dynamic channelid;


+ (NSString *)nameForAbbr:(NSString *)abbreviation{
    CDLottery *lot = [CDLottery findFirst:@"abbreviation = '%@'",abbreviation];
    if (lot) {
#ifdef DEBUG
        return [NSString stringWithFormat:@"%@",lot.name];
#else
        return lot.name;
#endif
    }
    return nil;
}

+ (NSString *)nameForLotteryId:(int)lotteryId andChannelId:(int)channelId{
    CDLottery *lot = [CDLottery findFirst:@"lotteryId = %d and channelid = %d",lotteryId,channelId];
    if (lot) {
        return lot.name;
    }
    return nil;
}

@end
