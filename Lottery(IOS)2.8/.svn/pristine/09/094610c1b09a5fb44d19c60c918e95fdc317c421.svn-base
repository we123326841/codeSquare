//
//  RQBet.m
//  Caipiao
//
//  Created by danal on 13-3-7.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBet.h"
#import "CDBetList.h"
#import "CDLottery.h"


@implementation RQBet
@synthesize channelId,lotteryId,curmid;
@synthesize flag,mode,select4;
@synthesize multiple,betList;
@synthesize totalMoney,totalNumbers;
@synthesize issueNumber;
@synthesize success,fail,fullFail;
@synthesize successDetail;
@synthesize failDetail;

@synthesize traceIf,traceStop, traceIssueItems;

- (void)dealloc{
    RELEASE(successDetail);
    RELEASE(failDetail);
    RELEASE(issueNumber);
    RELEASE(flag);
    RELEASE(mode);
    RELEASE(select4);
    RELEASE(betList);
    RELEASE(traceIssueItems);
    RELEASE(successDetail);
    RELEASE(failDetail);
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlBetting;
        self.flag = @"save";
    }
    return self;
}

- (void)prepare{
   
    //New Api version
    [self setPostValue:@([[CDUserInfo user].userid intValue]) forField:@"userid"];
    [self setPostValue:MSIntToStr(self.lotteryId) forField:@"lotteryId"];

    [self setPostValue:self.issueNumber forField:@"issue"];
    [self setPostValue:MSIntToStr(self.channelId) forField:@"chan_id"];
    [self setPostValue:[NSString stringWithFormat:@"%.1f",self.totalMoney] forField:@"money"];
    
    NSMutableArray *betProjects = [[[NSMutableArray alloc] init] autorelease];
    NSNumber *moneyNum=nil;
    NSNumber *times =nil;
    for (CDBetList *bet in self.betList) {
        if(self.isHighChaseNum&&self.multiples.count==1){
            moneyNum =@(self.totalMoney/self.betList.count);
            times =@(self.beiShu);
        }else{
            moneyNum =@([bet.amount floatValue]*multiple);
            times =@(multiple);
        }
        NSDictionary *one = @{
                              @"codes":bet.number,
                              @"methodid":bet.methodId,
                              @"mode":bet.mode,
                              @"money":moneyNum,
                              @"nums":bet.count,
                              @"times":times //选多倍的时候呢？
                              };
        [betProjects addObject:one];
//        [betProjects addObject:[bet toDict]];
    }
    [self setPostValue:betProjects forField:@"list"];
    
    //追号
    if (self.traceIf) {
        CGFloat totalTraceMoney = 0.f;
        NSMutableArray *traceTimes = [NSMutableArray array];
        NSMutableArray *traceIssueArray = [NSMutableArray array];
        for (TraceIssueItem *item in self.traceIssueItems){
            [traceIssueArray addObject:item.issue];
            totalTraceMoney += item.money * self.multiple;  //新版投注金额要算上追号金额
            [traceTimes addObject:@(self.multiple)];
        }
        if (self.isHighChaseNum) {
            traceTimes =self.multiples;
        }
        totalTraceMoney *= [self.betList count];
        [self setPostValue:@"1" forField:@"traceIstrace"];
//        [self setPostValue:[NSString stringWithFormat:@"%.1f",totalTraceMoney] forField:@"money"];
        [self setPostValue:[traceIssueArray componentsJoinedByString:@","]forField:@"traceIssues"];
        [self setPostValue:[traceTimes componentsJoinedByString:@","] forField:@"traceTimes"];
        [self setPostValue:self.traceStop ? @(2): @(0) forField:@"traceStop"];
    }
    
    [super prepare];
}

- (void)parse:(NSDictionary *)json{
    self.orderId = [json intForKey:@"orderId"];
    self.overMutipleDTO = [json arrayForKey:@"overMutipleDTO"];
    self.success = self.orderId > 0;
    
    self.gameOrderDTO = [json dictForKey:@"gameOrderDTO"];
    self.lists = [_gameOrderDTO arrayForKey:@"lists"];
    self.beforeAmount = [_gameOrderDTO floatForKey:@"beforeAmount"];
    self.afterAmount = [_gameOrderDTO floatForKey:@"afterAmount"];
//    if(![_gameOrderDTO objectForKey:@"afterAmount"])
//    {
//        self.afterAmount = [_gameOrderDTO floatForKey:@"afreAmount"];
//    }
    self.reduceAmount = [_gameOrderDTO floatForKey:@"reduceAmount"];
    self.isSlip = [_gameOrderDTO boolForKey:@"isSlip"];
    self.isLock = [_gameOrderDTO boolForKey:@"isLock"];
/*
    self.success = 0;
    
    NSString *staus = [json objectForKey:@"stats"];
    if (staus == nil) {
        staus = [json objectForKey:@"status"];
    }
    if ([staus isEqualToString:@"error"]) {
        id data = [json objectForKey:@"data"];
        if ([data isKindOfClass:[NSString class]]){
            self.failDetail = data;
            self.fullFail = YES;
        }
    }
    else if([staus isEqualToString:@"success"]){
        self.success = 1;
    }
    else if([staus isEqualToString:@"fail"]){
        id data = [json objectForKey:@"data"];
        if ([data isKindOfClass:[NSDictionary class]]){
            self.success = [[data objectForKey:@"success"] intValue];
            self.fail = [[data objectForKey:@"fail"] intValue];
            self.fullFail = self.success == 0 && self.fail > 0;
            NSArray *contents = [data objectForKey:@"content"];
            NSMutableString *detail = [[NSMutableString alloc] init];
            for (NSString *s in contents){
                Echo(@"%@",s);
                [detail appendFormat:@"%@\n",s];
            }
            [detail replaceOccurrencesOfString:@"&nbsp;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [detail length])];
            self.failDetail = [NSString stringWithString:detail];
            [detail release];
        }
    }
 */
}


@end


@implementation RQBetLow

- (void)dealloc{
    RELEASE(_successDetail);
    RELEASE(_failDetail);
    RELEASE(_issueNumber);
    RELEASE(_flag);
    RELEASE(_numbers);
    RELEASE(_traceIssueItems);
    RELEASE(_successDetail);
    RELEASE(_failDetail);
    RELEASE(_overMutipleDTO);
    RELEASE(_gameOrderDTO);
    RELEASE(_lists);
    RELEASE(_slipResonseDTOList)
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlBettingLow;
        self.flag = @"save";
    }
    return self;
}

- (void)prepare{
    //version 2.1
    [self.requestParams removeAllObjects];
    
    [self setPostValue:@(self.channelId) forField:@"chan_id"];
    [self setPostValue:@([[CDUserInfo user].userid intValue]) forField:@"userid"];
    [self setPostValue:MSIntToStr(self.lotteryId) forField:@"lotteryId"];
    [self setPostValue:self.issueNumber forField:@"issue"];
    [self setPostValue:[NSString stringWithFormat:@"%.1f",self.totalMoney] forField:@"money"];
    
    if (_betList == nil){
        NSMutableArray *betProjects = [[[NSMutableArray alloc] init] autorelease];
        NSDictionary *bet = @{
                              @"codes":self.numbers,
                              @"methodid":@(self.methodId),
                              @"mode":self.mode,
                              @"money":self.traceIf ? @((_mode.integerValue==kModeYuan?2.f:0.2f)*_multiple*_totalNumbers) : @(self.totalMoney),

                              @"nums":@(self.totalNumbers),
                              @"times":@(self.multiple)
                                  };
        [betProjects addObject:bet];
        [self setPostValue:betProjects forField:@"list"];
        
    } else {
        [self setPostValue:_betList forField:@"list"];
    }
    
    //追号
    if (self.traceIf) {
        
        CGFloat totalTraceMoney = 0.f;
        NSMutableArray *traceTimes = [NSMutableArray array];
        NSMutableArray *traceIssueArray = [NSMutableArray array];
        for (TraceIssueItem *item in self.traceIssueItems){
            [traceIssueArray addObject:item.issue];
            [traceTimes addObject:@(self.multiple)];
            totalTraceMoney += (item.money * self.multiple);
        }
        totalTraceMoney *= self.totalNumbers;
//        [self setPostValue:@(totalTraceMoney) forField:@"money"];
        [self setPostValue:@"1" forField:@"traceIstrace"];
        [self setPostValue:[traceIssueArray componentsJoinedByString:@","] forField:@"traceIssues"];
        [self setPostValue:[traceTimes componentsJoinedByString:@","] forField:@"traceTimes"];
        [self setPostValue:self.traceStop ? @(2): @(0) forField:@"traceStop"];
      
        
    } else {
       [self setPostValue:@"0" forField:@"traceIstrace"];
    }
    if(_isFirstSubmit) [self setPostValue:_isFirstSubmit forField:@"isFirstSubmit"];
   
    if(_slipResonseDTOList)[self setPostValue:_slipResonseDTOList forField:@"slipResonseDTOList"];
    [super prepare];

}

- (void)parse:(NSDictionary *)json{
    self.orderId = [json intForKey:@"orderId"];
    self.overMutipleDTO = [json arrayForKey:@"overMutipleDTO"];
    self.success = self.orderId > 0;
    
    self.gameOrderDTO = [json dictForKey:@"gameOrderDTO"];
    self.lists = [_gameOrderDTO arrayForKey:@"lists"];
    self.beforeAmount = [_gameOrderDTO floatForKey:@"beforeAmount"];
    self.afterAmount = [_gameOrderDTO floatForKey:@"afterAmount"];
//    if(![_gameOrderDTO objectForKey:@"afterAmount"])
//    {
//        self.afterAmount = [_gameOrderDTO floatForKey:@"afreAmount"];
//    }
    self.reduceAmount = [_gameOrderDTO floatForKey:@"reduceAmount"];
    self.isSlip = [_gameOrderDTO boolForKey:@"isSlip"];
    self.isLock = [_gameOrderDTO boolForKey:@"isLock"];
    self.slipResonseDTOList = [_gameOrderDTO arrayForKey:@"slipResonseDTOList"];
    
    
/*
    self.success = 0;

    NSString *staus = [json objectForKey:@"stats"];
    if (staus == nil) {
        staus = [json objectForKey:@"status"];
    }
    if ([staus isEqualToString:@"error"]) {
        id data = [json objectForKey:@"data"];
        if ([data isKindOfClass:[NSString class]]) {
            self.failDetail = data;
            self.fullFail = YES;
        }
        
    }
    else if([staus isEqualToString:@"success"]){
        self.success = 1;
        
    }
    else if([staus isEqualToString:@"fail"]){
        id data = [json objectForKey:@"data"];
        if ([data isKindOfClass:[NSDictionary class]]){
            self.success = [[data objectForKey:@"success"] intValue];
            self.fail = [[data objectForKey:@"fail"] intValue];
            self.fullFail = self.success == 0 && self.fail > 0;
            NSArray *contents = [data objectForKey:@"content"];
            NSMutableString *detail = [[NSMutableString alloc] init];
            for (NSString *s in contents){
                Echo(@"%@",s);
                [detail appendFormat:@"%@\n",s];
            }
            [detail replaceOccurrencesOfString:@"&nbsp;" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [detail length])];
            self.failDetail = [NSString stringWithString:detail];
            [detail release];
        }
    }
 */
}

@end


 
@implementation TraceIssueItem
@synthesize issue,money;

- (void)dealloc{
    [issue release];
    [super dealloc];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"TraceIssueItem:issue=%@,money=%.2f",self.issue,self.money];
}

+ (id)itemWithIssue:(NSString *)issue money:(CGFloat)money{
    TraceIssueItem *item = [[[self alloc] init] autorelease];
    item.issue = issue;
    item.money = money;
    return item;
}

@end