//
//  RQDoRetSetting.m
//  Caipiao
//
//  Created by 王浩 on 15/11/6.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RQDoRetSetting.h"
#import "RQManualSetting.h"
@implementation RQDoRetSetting
- (id)init{
    self = [super init];
    if (self) {
        self.url = kurlDoRetSetting;
        _infos =[NSMutableArray array];
    }
    return self;
}


-(void)prepare{
    [self setPostValue:@(_type) forField:@"type"];
    [self setPostValue:@(_setUp) forField:@"setUp"];
    [self setPostValue:@(_days) forField:@"days"];
    [self setPostValue:_memo forField:@"memo"];
    [self setPostValue:@(_setValue) forField:@"setValue"];
    for (UserAwardList *listAward in self.lists) {
        NSDictionary *one = @{
                              @"awardGroupId":@(listAward.awardGroupId),
                              @"lotterySeriesCode":@(listAward.lotterySeriesCode),
                              @"channelId":@(listAward.channelId),
                              @"lotterySeriesName":listAward.lotterySeriesName,
                              @"awardName":listAward.awardName,
                              @"directRet":_isFastSetting?listAward.directRet:listAward.directRetReal,
                              @"threeoneRet":_isFastSetting?listAward.threeoneRet:listAward.threeoneRetReal,
                              @"lotteryId":@(listAward.lotteryId),
                              @"directLimitRet":@(listAward.directLimitRet),
                              @"threeLimitRet":@(listAward.threeLimitRet)
                              //选多倍的时候呢？
                              };
        [_infos addObject:one];
        //        [betProjects addObject:[bet toDict]];
    }
    [self setPostValue:_infos forField:@"infos"];

    
    
    [super prepare];
    
    
    
}


- (void)parse:(NSDictionary*)result
{
    NSLog(@"hehe");
    self.status =result[@"status"];
}

- (void)dealloc
{
    RELEASE(_memo);
   // RELEASE(_infos);
    RELEASE(_status);
    [super dealloc];
}



@end

@implementation DoRetSettingInfo

- (void)dealloc
{
    RELEASE(_awardName);
    RELEASE(_lotterySeriesName);
    [super dealloc];
}

@end
