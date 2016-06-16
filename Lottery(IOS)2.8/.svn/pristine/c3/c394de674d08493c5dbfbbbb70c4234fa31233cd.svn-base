//
//  RQPublicHistory.m
//  Caipiao
//
//  Created by danal on 13-3-13.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQPublicHistory.h"
#import "CDSSC.h"
#import "CDLottery.h"

#define kPublicHistoryCachePath [NSString stringWithFormat:@"%@/Library/Caches/issuelist.plist",NSHomeDirectory()]
#define kPublicHistoryLowCachePath [NSString stringWithFormat:@"%@/Library/Caches/issuelistL.plist",NSHomeDirectory()]

@implementation RQPublicHistory
@synthesize issueList, lowgame;

- (void)dealloc{
    RELEASE(issueList);
    [super dealloc];
}

- (void)prepare{
    self.url =  kUrlPublicHistory;
    [self setPostValue:self.lowgame ? MSIntToStr((long)kChannelLow) : MSIntToStr((long)kChannelHigh) forField:@"chan_id"];
    if (_lotteryId > 0){
        [self setPostValue:@(_lotteryId) forField:@"lotteryId"];
    }
    [super prepare];
}

- (void)parse:(NSArray *)json{
    
    if ([json isKindOfClass:[NSArray class]]) {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (NSDictionary *one in json){
            IssueItem *item = [[IssueItem alloc] init];
            item.number = [one stringForKey:@"code"];
            item.issueNumber = [one stringForKey:@"issue"];
            item.openTime = [one stringForKey:@"time"];
            item.lotteryId = [one intForKey:@"lotteryid"];
            item.channelid = [one intForKey:@"channelid"];
            item.lotteryName =  [CDLottery findNameById:item.lotteryId andChannelId:item.channelid]; //[CDSSC nameForLotteryId:item.lotteryId andChannelId:item.channelid];
//            CDPublicHistory *ph = [CDPublicHistory new];
//            ph.channelId = @(item.channelid);
//            ph.lotteryId = @(item.lotteryId);
//            ph.openTime = item.openTime;
//            ph.number = item.number;
//            ph.issueNumber = item.issueNumber;
//            [ph save];
//            [ph release];
            if(item.lotteryName)
            [list addObject:item];
            [item release];
        }
        self.issueList = [NSArray arrayWithArray:list];
        [list release];
        
        if (!self.lowgame) {     //缓存高频彩种
            [[NSFileManager defaultManager] removeItemAtPath:kPublicHistoryCachePath error:nil];
            [NSKeyedArchiver archiveRootObject:self.issueList toFile:kPublicHistoryCachePath];
        } else {
            [[NSFileManager defaultManager] removeItemAtPath:kPublicHistoryLowCachePath error:nil];
            [NSKeyedArchiver archiveRootObject:self.issueList toFile:kPublicHistoryLowCachePath];
        }
        MSNotificationCenterPost(kNotificationPublicHistoryUpdated);
    }
}

+ (NSArray *)pastIssueList:(NSInteger)channelId lotteryId:(NSInteger)lotteryId{
    NSString *path = channelId == 1 ? kPublicHistoryLowCachePath : kPublicHistoryCachePath;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSArray *issuelist = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        NSMutableArray *result = [NSMutableArray array];
        for (IssueItem *it in issuelist){
            if (it.channelid == channelId && it.lotteryId == lotteryId){
                [result addObject:it];
            }
        }
        return result;
    }
    return nil;
}

+ (NSArray *)cachedIssueList{
    return nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:kPublicHistoryCachePath]) {
        NSArray *issuelist = [NSKeyedUnarchiver unarchiveObjectWithFile:kPublicHistoryCachePath];
        return issuelist;
    }
    return nil;
}

+ (IssueItem *)lastOpenIssue{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[NSBundle pathInCaches:@"lastOpen"]];
}

+ (void)saveLastOpenIssue:(IssueItem *)item{
    [NSKeyedArchiver archiveRootObject:item toFile:[NSBundle pathInCaches:@"lastOpen"]];
}

+ (void)clearCache{
    [[NSFileManager defaultManager] removeItemAtPath:kPublicHistoryCachePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:kPublicHistoryLowCachePath error:nil];
}

@end

//开奖走势  若chan_id、lotteryId为空则返回高低频最新3笔的开奖号码 不为空,则返回该彩种最新20笔开奖号码 
@implementation RQSubPublicHistory

- (void)prepare{
    self.url =  kUrlPublicHistory;
    [super prepare];
}

- (void)parse:(NSArray *)json{
    
    if ([json isKindOfClass:[NSArray class]])
    {
        NSMutableArray *deleteDisenableArr = [NSMutableArray arrayWithArray:json];
        [json enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop)
         {
             NSInteger lotteryId = [obj intForKey:@"lotteryid"];
             NSInteger channelid = [obj intForKey:@"channelid"];
             if (![CDLottery findLotteryById:lotteryId andChannelId:channelid]) {
                 [deleteDisenableArr removeObject:obj];
             }
         }];
        json = [deleteDisenableArr copy];
        
        
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (int i = 0; i < [json count]; ) {
            NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
            for (int j = 0; j < 3; j++) {
                if (i+j>=json.count) break;
                NSDictionary *one = [json objectAtIndex:i+j];
                if (tmpArr.count>0) {
                    IssueItem *i = [tmpArr objectAtIndex:0];
                    if (i.lotteryId!=[one intForKey:@"lotteryid"]) {
                        break;
                    }
                }
                IssueItem *item = [[IssueItem alloc] init];
                item.number = [one stringForKey:@"code"];
                item.issueNumber = [one stringForKey:@"issue"];
                item.openTime = [one stringForKey:@"time"];
                item.lotteryId = [one intForKey:@"lotteryid"];
                item.channelid = [one intForKey:@"channelid"];
                item.lotteryName = [CDLottery findNameById:item.lotteryId andChannelId:item.channelid];
                [tmpArr addObject:item];
                [item release];
                
            }
            [list addObject:tmpArr];
            i+=[tmpArr count];
            [tmpArr release];
        }
        
        self.issueList = [NSArray arrayWithArray:list];
        [list release];
    }
}

@end
/*
@implementation PublicDetailItem

- (void)dealloc
{
    [_list release];
    [_indexPaths release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _list = [[NSMutableArray alloc] init];
        _indexPaths = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
 */

@implementation RQPublicDetail

- (void)prepare{
    self.url =  kUrlPublicHistory;
    [self setPostValue:@(_chan_id) forField:@"chan_id"];
    [self setPostValue:@(_lottery_id) forField:@"lotteryId"];
    [super prepare];
}

- (void)parse:(NSArray *)json{
    
    if ([json isKindOfClass:[NSArray class]]) {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (NSDictionary *one in json){
            IssueItem *item = [[IssueItem alloc] init];
            item.number = [one stringForKey:@"code"];
            item.issueNumber = [one stringForKey:@"issue"];
            item.openTime = [[[one stringForKey:@"time"] componentsSeparatedByString:@" "] objectAtIndex:0];
            item.lotteryId = [one intForKey:@"lotteryid"];
            item.channelid = [one intForKey:@"channelid"];
            item.lotteryName = [CDLottery findNameById:item.lotteryId andChannelId:item.channelid];
            if(item.lotteryName)
            [list addObject:item];
            [item release];
        }
        self.issueList = [NSArray arrayWithArray:list];
        [list release];
        
        /* 根据日期分Section
        NSMutableArray *list = [[NSMutableArray alloc] init];
        for (NSDictionary *one in json){
            IssueItem *item = [[IssueItem alloc] init];
            item.number = [one stringForKey:@"code"];
            item.issueNumber = [one stringForKey:@"issue"];
            item.openTime = [[[one stringForKey:@"time"] componentsSeparatedByString:@" "] objectAtIndex:0];
            item.lotteryId = [one intForKey:@"lotteryid"];
            item.channelid = [one intForKey:@"channelid"];
            item.lotteryName = [CDLottery findNameById:item.lotteryId andChannelId:item.channelid];
            [list addObject:item];
            [item release];
        }
        
        NSMutableArray *result = [[NSMutableArray alloc] init];
        PublicDetailItem *model = [[PublicDetailItem alloc] init];
        IssueItem *tmpObj = [list objectAtIndex:0];
        NSString *currTime = tmpObj.openTime;
        for (int i = 0; i < [list count]; i++) {
            if (i == 0) model.opened = YES;
            IssueItem *item = [list objectAtIndex:i];
            if ([item.openTime isEqualToString:currTime]) {
                [model.list addObject:item];
            }else {
                currTime = item.openTime;
                [result addObject:model];
                [model release];
                model = [[PublicDetailItem alloc] init];
                [model.list addObject:item];
            }
        }
        [result addObject:model];
        [model release];
        
        self.issueList = [NSArray arrayWithArray:result];
        [result release];
         */
        
    }
}

@end


