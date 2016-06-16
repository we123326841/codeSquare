//
//  RQInitData.m
//  Caipiao
//
//  Created by danal on 13-3-1.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQInitData.h"
#import "CDMenuItem.h"
#import "CDSSC.h"
#import "CDLottery.h"
//#import "IssueItem.h"

@implementation RQInitData
@synthesize lotteryId = _lotteryId, curmid = _curmid;
@synthesize lastOpenCode,currentIssue,nowTime,endTime,menuData,sortIndex,lotteryName,currentIssueCode;

- (void)dealloc{
    RELEASE(lotteryName);
    RELEASE(lastOpenCode);
    RELEASE(currentIssue);
    RELEASE(currentIssueCode);
    RELEASE(nowTime);
    RELEASE(menuData);
    [super dealloc];
}

+ (NSInteger)lotteryId{
    return MSIntForKey(@"LotteryId");
}

+ (NSInteger)curmid{
    return MSIntForKey(@"CurrentMid");
}

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlInit;
    }
    return self;
}

- (void)parse:(NSDictionary *)json{
//    Echo(@"%@",json);
    
    CDLottery *lot = [CDLottery lotteryForValue:self.url ofProperty:@selector(apiUrl)];
    self.lotteryName = lot.name;
    
    //Current infomation
    self.lotteryId = [json intForKey:@"lotteryId"];
    self.curmid = [json intForKey:@"curmid"];
    NSInteger lotteryId = self.lotteryId;
    
    lot.lotteryId = @(self.lotteryId);
    lot.curmid = @(self.curmid);
    
    MSSetIntForKey(self.lotteryId, @"LotteryId");
    MSSetIntForKey(self.curmid, @"CurrentMid");
    
    self.lastOpenCode = [json objectForKey:@"lastOpenCode"];
    

    //Save current issue information
    {
        NSDictionary *d = [json objectForKey:@"acurrentIssue"];
        lot.issue =  [d stringForKey:@"issue"];
        if ([lot.issue length] == 0){
            lot.paused = [NSNumber numberWithBool:YES];
        } else {
            lot.paused = [NSNumber numberWithBool:NO];
        }
        lot.startTime = [d stringForKey:@"salestart"];
        lot.endTime = [d stringForKey:@"saleend"];
        self.endTime = lot.endTime;
        self.currentIssue = lot.issue;
    }

    
    //Calculate remaining time
    self.nowTime = [json objectForKey:@"nowTime"];
    float limitBonus = [[json objectForKey:@"limitBonus"] floatValue];
    int totalIssue = [[json objectForKey:@"totalIssue"] intValue];
    lot.totalIssue = [NSNumber numberWithInt:totalIssue];
    
    //Special：吉利分分彩,其它的从接口获取
    if ([lot.name isEqualToString:JLFFC]){
        lot.totalIssue = [NSNumber numberWithInt:300];
    }
    
    [lot save];
    Echo(@"[LOTTERYNAME]=====%@=====",lot.name);
    
    //Methods
//    dispatch_queue_t queue = dispatch_queue_create("init", NULL);
//    dispatch_async(queue, ^{
    
        //Update status
        NSArray *menuItems = [CDMenuItem find:@"lotteryId = %d", self.lotteryId];
        for (CDMenuItem *one in menuItems) {
            one.enabled = [NSNumber numberWithBool:NO];
            [one save];
        }
    
        //Update data
        NSArray *aMenuData = [json objectForKey:@"aMenuData"];
        for (int i = 0 ; i < [aMenuData count]; i++) {
            NSDictionary *dataDict = [aMenuData objectAtIndex:i];
            NSString *showName = [dataDict objectForKey:@"showName"];
            CGFloat methodPrice = [[dataDict objectForKey:@"method_prize"] floatValue];
            NSInteger mid = [dataDict intForKey:@"methodid"];
            Echo(@">>showName:%@ | methodPrize:%f | limitBonus:%f",showName,methodPrice,limitBonus);
            CDMenuItem *item = [CDMenuItem findFirst:@"methodid = %d",mid];
            if (item == nil) {
                item = [CDMenuItem new];
                item.methodid = [NSNumber numberWithInteger:mid];
                [item autorelease];
            }
            item.enabled = [NSNumber numberWithBool:YES];
            item.lotteryId = [NSNumber numberWithInteger:lotteryId];
            item.menuName = [showName stringByReplacingOccurrencesOfString:@" " withString:@""];
            item.methodPrice = [NSNumber numberWithFloat:methodPrice];
            item.limitBonus = [NSNumber numberWithFloat:limitBonus];
            item.sortIndex = [NSNumber numberWithInt:i];    //调整排序
            [item save];
            
        }
        
        //时时彩名称
        NSArray *sscList = [json objectForKey:@"aLotteryD"];
//        if ([sscList count] != [[CDSSC count] intValue]) {    //每次都更新
    
            [CDSSC deleteAll];
            for (int i = 0; i < [sscList count]; i++) {
                NSDictionary *ssc = [sscList objectAtIndex:i];
                NSString *abbr = [ssc objectForKey:@"enname"];
                NSString *name = [ssc objectForKey:@"lotteryname"];
                NSNumber *lotteryId = [ssc numberiForKey:@"lotteryid"];
                NSNumber *channelid = [ssc numberiForKey:@"channelid"];

                name = [ssc objectForKey:@"description"];
                CDSSC *s = [CDSSC new];
                s.abbreviation = abbr;
                s.name = name;
                s.lotteryId = lotteryId;
                s.channelid = channelid;
                [s save];
                [s release];
            }
//        }
    
        MSSetIntForKey(1, @"dataInitialized");
        
        //relreae
//       dispatch_release(queue);
//    });
    
}

@end


#pragma mark - RQSimpleInit

@implementation RQSimpleInit

- (void)dealloc{
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        self.url = kUrlSimpleInit;
        self.silent = YES;
    }
    return self;
}

- (void)prepare{
    [self setPostValue:MSIntToStr(self.lotteryId) forField:@"lotteryId"];
    [self setPostValue:MSIntToStr(self.channelId) forField:@"chan_id"];

    [super prepare];
}

- (void)parse:(NSDictionary *)result{
    if (![result isKindOfClass:[NSDictionary class]]) {
        return;
    }

    CDLottery *lot = [CDLottery findLotteryById:self.lotteryId andChannelId:self.channelId];
    if (lot) {
        NSDictionary *lotDict = result;
        NSDictionary *issueDict = [result objectForKey:@"issue"];
        NSDictionary *nextIssue = [issueDict objectForKey:@"nextIssue"];
        NSString *lastOpenCode = [lotDict stringForKey:@"lastOpenCode"];//当此值存在时，表示当前彩种暂停销售
        if (nextIssue !=nil && ![nextIssue isKindOfClass:[NSNull class]]){
            lot.paused = [NSNumber numberWithBool:YES];
            self.isPaused = YES;
        } else {
            lot.paused = [NSNumber numberWithBool:NO];
            lot.issue =  [issueDict stringForKey:@"issue"];//当前奖期
            lot.startTime = [issueDict stringForKey:@"salestart"];//开始销售时间
            lot.endTime = [issueDict stringForKey:@"saleend"];//结束销售时间
            lot.issueCode = [issueDict stringForKey:@"issueCode"];//奖期code 用于投注的issue
            lot.backOutStartFee = [lotDict numberfForKey:@"backOutStartFee"];//金额超过此数目才收手续费
            lot.backOutRadio = [lotDict numberfForKey:@"backOutRadio"];//手续费收的比例
            lot.lastOpenCode = lastOpenCode;
            self.endTime = lot.endTime;
            MSNotificationCenterPostUserInfo(kNotificationLastOpenCodeUpdated, [NSDictionary dictionaryWithObject:lot.name forKey:@"lotteryName"]);
        }
        [lot save];
            
        if (self.lotteryId == [lot.lotteryId intValue]){
            self.currentIssue = lot.issue;
            self.currentIssueCode = lot.issueCode;
            self.endTime = lot.endTime;
            self.awardGroups = [result arrayForKey:@"awardGroups"];
            self.bonusGroupStatus = [result intForKey:@"bonusGroupStatus"];
        }
    }
}

@end
