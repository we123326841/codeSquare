//
//  RQZhuiHaoInfo.m
//  Caipiao
//
//  Created by danal on 13-6-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQZhuiHaoInfo.h"
#import "CDSSC.h"
#import "CDLottery.h"

@implementation RQZhuiHaoInfo
@synthesize dataList;

- (void)dealloc{
    self.dataList = nil;
    [super dealloc];
}

//- (id)init{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)prepare
{
    self.url = kUrlZhuihaoList;
    [super prepare];
}

- (void)setChan_id:(NSInteger)chan_id
{
    _chan_id = chan_id;
    [self setPostValue:[NSNumber numberWithInteger:_chan_id] forField:@"chan_id"];
}

- (void)parse:(id)result{
    Echo(@"%@",result);
    if ([result isKindOfClass:[NSArray class]]) {
        NSArray *list = result;
        self.dataList = [NSMutableArray array];
        for (NSDictionary *one in list){
            ZhuiHaoInfoItem *item = [ZhuiHaoInfoItem parseFromDict:one];
            if (item)
                [self.dataList addObject:item];
        }
    }
}

@end


@implementation ZhuiHaoInfoItem

- (void)dealloc{
    self.channelId = nil;
    self.lotteryId = nil;
    self.taskId = nil;
    self.issueCount = nil;
    self.finishedCount = nil;
    self.cancelCount = nil;
    self.stopOnWin = nil;
    self.status = nil;
    self.username = nil;
    self.begainTime = nil;
    self.beginIssue = nil;
    self.codes = nil;
    self.taskPrice = nil;
    self.methodname = nil;
    self.bonus = nil;
    self.cnname = nil;
    self.lotteryName = nil;
    [super dealloc];
}
/*
 beginissue = 140804024;
 begintime = "2014-08-04 09:38:58";
 bonus = "0.0000";
 channelid = 4;
 cnname = CQSSC;
 codes = "||7||";
 finishedcount = 1;
 issuecount = 3;
 lotteryid = 1;
 methodid = 30;
 methodname = "\U767e\U4f4d";
 multiple = 1;
 status = 0;
 taskid = T140804024VBGFIAGGDK;
 taskprice = "6.0000";
 username = agrelvis;
 */
+ (id)parseFromDict:(NSDictionary *)d{
    ZhuiHaoInfoItem *item = [[[self alloc] init] autorelease];
    item.channelId = [d numberiForKey:@"channelid"];
    item.lotteryId = [d numberiForKey:@"lotteryid"];
    item.methodId = [d intForKey:@"methodid"];
    item.methodname = [d stringForKey:@"methodname"];
    item.taskId = [d stringForKey:@"taskid"];
    item.codes = [d stringForKey:@"codes"];
    item.issueCount = [d numberiForKey:@"issuecount"];
    item.finishedCount = [d numberiForKey:@"finishedcount"];
    item.cancelCount = [d numberiForKey:@"cancelcount"];
    item.status = [d numberiForKey:@"status"];
//    item.taskPrice = [d numberiForKey:@"taskprice"];
    item.taskPrice = [d numberiForKey:@"totalmoney"];

    item.begainTime = [d stringForKey:@"begintime"];
    item.beginIssue = [d stringForKey:@"beginissue"];
    item.bonus = [d numberfForKey:@"bonus"];
    item.cnname = [CDSSC nameForAbbr:[d stringForKey:@"cnname"]];
    item.multiple = [d intForKey:@"multiple"];
    item.lotteryName = [CDLottery findNameById:item.lotteryId.intValue andChannelId:item.channelId.intValue];
    if ([item.lotteryName length] > 0){
        return item;
    } else {
        return nil; //CDLottery里没有的彩种返回nil
    }
}

@end