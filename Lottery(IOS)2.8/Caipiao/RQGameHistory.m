//
//  RQGameHistory.m
//  Caipiao
//
//  Created by danal on 13-3-13.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQGameHistory.h"

@implementation RQGameHistory
@synthesize recordList;

- (void)dealloc{
    RELEASE(recordList);
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        self.recordList = [NSMutableArray array];
    }
    return self;
}

- (void)setIsLowGame:(BOOL)isLowGame
{
    _isLowGame = isLowGame;
    if (_isLowGame) {
        [self setPostValue:@"1" forField:@"chan_id"];
    }else {
        [self setPostValue:@"4" forField:@"chan_id"];
    }
}

- (void)prepare
{
    self.url = kUrlGameHistory;
    [super prepare];
}

- (void)parse:(NSArray *)json{
    Echo(@"RQGameHistory:%@",json);
    if ([json isKindOfClass:[NSArray class]]) {
        for (NSDictionary *one in json){
            GameRecord *gr = [[GameRecord alloc] init];
            gr.number = [one stringForKey:@"code"];
            gr.recordId = [one stringForKey:@"enid"];
            gr.win = [one intForKey:@"ifwin"];
            gr.iscancel = [one intForKey:@"iscancel"];
            gr.gameName = [one stringForKey:@"name"];
            gr.methodId = [one intForKey:@"methodid"];
            gr.playType = [one stringForKey:@"methodname"];
            gr.playTime = [one stringForKey:@"time"];
            gr.amount = [one stringForKey:@"totalprice"];
            gr.issueNumber = [one stringForKey:@"issue"];
            gr.bonus = [one stringForKey:@"bonus"];
            gr.lotteryid = [one intForKey:@"lotteryid"];
            gr.methodName = [one stringForKey:@"methodname"];
            gr.channelid = [one intForKey:@"channelid"];
            gr.lotteryName = [CDLottery findLotteryById:gr.lotteryid andChannelId:gr.channelid].name;
            if ([gr.lotteryName length] >0){
                [self.recordList addObject:gr];
            }
//            if ([gr.lotteryName length] ==0){
//                gr.lotteryName = @"重庆时时彩";
//                [self.recordList addObject:gr];
//            }
            [gr release];
        }
        [[NSFileManager defaultManager] removeItemAtPath:kGameHistoryCachePath error:nil];
        [NSKeyedArchiver archiveRootObject:self.recordList toFile:kGameHistoryCachePath];
    }
    
}

+ (NSArray *)cachedRecordList{
    return nil;
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kGameHistoryCachePath];
}

+ (void)clearCache{
    [[NSFileManager defaultManager] removeItemAtPath:kGameHistoryCachePath error:nil];
}

@end


@implementation RQGameDetail
@synthesize recordId;
//@synthesize win,openCode,bonus,time,mode,amount,multipe,betDetail,methodname,originalCode;


- (void)dealloc{
//    RELEASE(originalCode);
//    RELEASE(methodname);
    RELEASE(_openCode);
    RELEASE(_time);
//    RELEASE(mode);
//    RELEASE(betDetail);
    RELEASE(recordId);
    RELEASE(_gameNo);
    [super dealloc];
}

//- (id)init {
//    self = [super init];
//    if (self) {
//        self.url = kUrlGameDetail;
//    }
//    return self;
//}

- (void)prepare
{
    self.url = kUrlGameDetail;

    [self setPostValue:recordId forField:@"id"];
    [super prepare];
}

- (void)setChan_id:(NSInteger)chan_id
{
    _chan_id = chan_id;
    [self setPostValue:[NSNumber numberWithInteger:_chan_id] forField:@"chan_id"];
}

- (void)parse:(NSDictionary *)json{
    Echo(@"RQGameDetail：%@",json);
    if ([json isKindOfClass:[NSDictionary class]]&&json.count) {
        NSDictionary *d = json;
//        NSDictionary *d = @{
//                            @"enid":@"1",@"time":@"2014",@"issue":@"20140506",@"total":@"1234",@"bonus":@"4567",@"iscancel":@"0",@"cancancel":@"0",@"opencode":@"01234567",@"lotteryId":@"22",@"list":@{@"methodid":@"3",@"codedetails":@"03456789",@"price":@"3445",@"nums":@"3",@"multiple":@"4",@"modes":@"元",@"ifwin":@"1"}
//        };
//        
//        self.win = [d intForKey:@"ifwin"];
        
        
        
//        self.mode = [d stringForKey:@"modes"];
        
//        self.multipe = [d intForKey:@"multiple"];
//        self.methodname = [d stringForKey:@"methodname"];
//        self.betDetail = [d stringForKey:@"codedetails"];
//        self.originalCode = [d stringForKey:@"originalcode"];
        
        self.enid = [d stringForKey:@"enid"];
        self.recordId=[d stringForKey:@"enid"];
        self.time = [d stringForKey:@"time"];
        self.issue =[d stringForKey:@"issue"];
        self.total = [d floatForKey:@"total"];
        self.bonus = [d floatForKey:@"bonus"];
        self.iscancel = [d intForKey:@"iscancel"];
        self.cancancel = [d intForKey:@"cancancel"];
        self.openCode = [d stringForKey:@"opencode"];
         self.lotteryId = [d stringForKey:@"lotteryId"];
        self.gameNo = [d stringForKey:@"gameNo"];
        self.list = [NSMutableArray array];
        if (![[d objectForKey:@"list"] isKindOfClass:[NSNull class]]) {
            for (NSDictionary *record in [d objectForKey:@"list"])
            {
                RecordInfo *info =  [[RecordInfo alloc]init];
                info.methodid = [record stringForKey:@"methodid"];//彩种id
                info.codedetails= [record stringForKey:@"codedetails"];//注单号码
                info.price= [record floatForKey:@"price"];//投注金额
                info.nums= [record intForKey:@"nums"]; //注单注数
                info.multiple= [record intForKey:@"multiple"]; //倍数
                info.modes= [record stringForKey:@"modes"]; //模式
                info.ifwin= [record intForKey:@"ifwin"]; //0:未开奖1:未中奖2:派奖
                info.methodname=[record stringForKey:@"methodname"];
                info.bonus = [record floatForKey:@"bonus"];
                [_list addObject:info];
                [info release];
            }

        }
       //        if (!originalCode) {
//            self.originalCode = self.betDetail;
//        }
    }
}

@end

@implementation RecordInfo
+ (id)parseFromDict:(NSDictionary *)d{
    RecordInfo *item = [[RecordInfo alloc] init];
    item.methodid = [d stringForKey:@"methodid"];
    item.codedetails = [d stringForKey:@"codedetails"];
    item.price = [d floatForKey:@"price"];
    item.nums = [d intForKey:@"nums"];
    item.multiple = [d intForKey:@"multiple"];
    item.modes = [d stringForKey:@"modes"];
    item.ifwin = [d intForKey:@"ifwin"];
    item.bonus = [d floatForKey:@"bonus"];
    item.methodname = [d stringForKey:@"methodname"];
    return [item autorelease];
}
@end