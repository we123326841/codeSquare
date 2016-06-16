//
//  GameRecord.m
//  Caipiao
//
//  Created by danal on 13-3-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "GameRecord.h"

@implementation GameRecord
@synthesize recordId,win,iscancel;
@synthesize gameName;
@synthesize methodId,playType,playTime;
@synthesize amount,issueNumber,bonus;
@synthesize number;

- (void)dealloc{
    RELEASE(_lotteryName);
    RELEASE(amount);
    RELEASE(bonus);
    RELEASE(number);
    RELEASE(recordId);
    RELEASE(gameName);
    RELEASE(playType);
    RELEASE(playTime);
    RELEASE(issueNumber);
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.recordId = [aDecoder decodeObjectForKey:@"recordId"];
        self.win = [aDecoder decodeIntegerForKey:@"win"];
        self.iscancel = [aDecoder decodeIntegerForKey:@"iscancel"];
        self.gameName = [aDecoder decodeObjectForKey:@"gameName"];
        self.methodId = [aDecoder decodeIntegerForKey:@"methodId"];
        self.playType = [aDecoder decodeObjectForKey:@"playType"];
        self.playTime = [aDecoder decodeObjectForKey:@"playTime"];
        self.amount = [aDecoder decodeObjectForKey:@"amount"];
        self.issueNumber = [aDecoder decodeObjectForKey:@"issueNumber"];
        self.bonus = [aDecoder decodeObjectForKey:@"bonus"];
        self.number = [aDecoder decodeObjectForKey:@"number"];
        self.lotteryid = [aDecoder decodeIntegerForKey:@"lotteryid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.recordId forKey:@"recordId"];
    [aCoder encodeInteger:self.win forKey:@"win"];
    [aCoder encodeInteger:self.iscancel forKey:@"iscancel"];
    [aCoder encodeObject:self.gameName forKey:@"gameName"];
    [aCoder encodeInteger:self.methodId forKey:@"methodId"];
    [aCoder encodeObject:self.playType forKey:@"playType"];
    [aCoder encodeObject:self.playTime forKey:@"playTime"];
    [aCoder encodeObject:self.amount forKey:@"amount"];
    [aCoder encodeObject:self.issueNumber forKey:@"issueNumber"];
    [aCoder encodeObject:self.bonus forKey:@"bonus"];
    [aCoder encodeObject:self.number forKey:@"number"];
    [aCoder encodeInteger:self.lotteryid forKey:@"lotteryid"];
}

@end


@implementation GameRecordDetail
@synthesize sn,bingoNumber,mode,times,bettingDetail;

- (void)dealloc{
    RELEASE(sn);
    RELEASE(bingoNumber);
    RELEASE(mode);
    RELEASE(times);
    RELEASE(bettingDetail);
    [super dealloc];
}

@end