//
//  RQLink.m
//  Caipiao
//
//  Created by danal-rich on 4/1/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "RQLink.h"

@implementation RQLinkList

- (void)dealloc{
    self.linkList = nil;
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlOpenLinkList;
    
    [super prepare];
}

- (void)parse:(id)result{
    if ([result isKindOfClass:[NSArray class]]){
        _linkList = [[NSMutableArray alloc] init];
        for (NSDictionary *one in result){
            LinkItem *item = [[LinkItem alloc] init];
            item.linkId = [one intForKey:@"id"];
            item.type = [one intForKey:@"type"];
            item.urlString = [one stringForKey:@"urlstring"];
            item.remark = [one stringForKey:@"remark"];
            item.startTime = [one stringForKey:@"created"];
            item.validDay = [one intForKey:@"validdays"];
            [_linkList addObject:item];
            [item release];
        }
    }
    //Error Occured
    else if ([result isKindOfClass:[NSDictionary class]]){
        self.msgContent = [result objectForKey:@"msg"];
    }
}

@end

@implementation RQLinkDetail

- (void)dealloc{
    self.dataList = nil;
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlOpenLinkDetail;
    [self setPostValue:MSIntToStr(self.linkId) forField:@"id"];
    
    [super prepare];
}

- (void)parse:(id)result{
    if ([result isKindOfClass:[NSDictionary class]]){
        self.startTime = [result objectForKey:@"start"];
        self.endTime = [result objectForKey:@"end"];
        
        NSDictionary *highGame = [result objectForKey:@"highGame"];
        NSDictionary *lowGame = [result objectForKey:@"lowGame"];
        NSDictionary *soccerGame = [result objectForKey:@"soccerGame"];
        
        NSMutableArray *dataList = [[NSMutableArray alloc] init];
        
        for (NSString *key in highGame){
            NSDictionary *one = [highGame objectForKey:key];
            LinkDetailItem *item = [[LinkDetailItem alloc] init];
            item.cnname = [one stringForKey:@"cnname"];
            item.itemId = [one intForKey:@"entry"];
            item.channelId = [one intForKey:@"channelid"];
            item.lotteryId = [one intForKey:@"lotteryid"];
            item.userPoint = [one stringForKey:@"userpoint"];
            item.indefinitePoint = [one stringForKey:@"indefinite_point"];
            [dataList addObject:item];
            [item release];
        }
        for (NSString *key in lowGame){
            NSDictionary *one = [lowGame objectForKey:key];
            LinkDetailItem *item = [[LinkDetailItem alloc] init];
            item.itemId = [one intForKey:@"entry"];
            item.cnname = [one stringForKey:@"cnname"];
            item.channelId = [one intForKey:@"channelid"];
            item.lotteryId = [one intForKey:@"lotteryid"];
            item.userPoint = [one stringForKey:@"userpoint"];
            item.indefinitePoint = [one stringForKey:@"indefinite_point"];
            [dataList addObject:item];
            [item release];
        }
        for (NSString *key in soccerGame){
            NSDictionary *one = [soccerGame objectForKey:key];
            LinkDetailItem *item = [[LinkDetailItem alloc] init];
            item.itemId = [one intForKey:@"entry"];
            item.cnname = [one stringForKey:@"cnname"];
            item.channelId = [one intForKey:@"channelid"];
            item.lotteryId = [one intForKey:@"lotteryid"];
            item.userPoint = [one stringForKey:@"userpoint"];
            item.indefinitePoint = [one stringForKey:@"indefinite_point"];
            [dataList addObject:item];
            [item release];
        }
        
        NSMutableArray *shuzi = [[NSMutableArray alloc] init];
        NSMutableArray *lotou = [[NSMutableArray alloc] init];
        NSMutableArray *jinuo = [[NSMutableArray alloc] init];
        NSMutableArray *threeD = [[NSMutableArray alloc] init];
        NSMutableArray *shuangseqiu = [[NSMutableArray alloc] init];
        NSMutableArray *P5 = [[NSMutableArray alloc] init];
        NSMutableArray *jingcai = [[NSMutableArray alloc] init];
        //Resort with headers
        {
            LinkDetailHeaderItem *header = [[LinkDetailHeaderItem alloc] init];
            header.lotteryType = @"数字型";
            header.point1 = @"所有玩法返点\n(不定位除外)";
            header.point2 = @"不定位返点";
            [shuzi addObject:header];
            [header release];
        }
        {
            LinkDetailHeaderItem *header = [[LinkDetailHeaderItem alloc] init];
            header.lotteryType = @"乐透型";
            header.point1 = @"所有玩法返点";
            header.point2 = @"";
            header.hasSecondPoint = NO;
            [lotou addObject:header];
            [header release];
            
        }
        {
            LinkDetailHeaderItem *header = [[LinkDetailHeaderItem alloc] init];
            header.lotteryType = @"基诺型";
            header.point1 = @"任选玩法返点";
            header.point2 = @"趣味型玩法返点";
            [jinuo addObject:header];
            [header release];
            
        }
        {
            LinkDetailHeaderItem *header = [[LinkDetailHeaderItem alloc] init];
            header.lotteryType = @"3D";
            header.point1 = @"所有玩法返点\n(一码不定位除外)";
            header.point2 = @"一码不定位返点";
            [threeD addObject:header];
            [header release];
            
        }
        {
            LinkDetailHeaderItem *header = [[LinkDetailHeaderItem alloc] init];
            header.lotteryType = @"双色球";
            header.point1 = @"所有玩法返点";
            header.point2 = @"";
            header.hasSecondPoint = NO;
            [shuangseqiu addObject:header];
            [header release];
            
        }
        {
            LinkDetailHeaderItem *header = [[LinkDetailHeaderItem alloc] init];
            header.lotteryType = @"P5";
            header.point1 = @"所有玩法返点\n(一码不定位除外)";
            header.point2 = @"一码不定位返点";
            [P5 addObject:header];
            [header release];
            
        }
        {
            LinkDetailHeaderItem *header = [[LinkDetailHeaderItem alloc] init];
            header.lotteryType = @"竞彩";
            header.point1 = @"所有玩法返点";
            header.point2 = @"";
            header.hasSecondPoint = NO;
            [jingcai addObject:header];
            [header release];
            
        }
        
        for (LinkDetailItem *item in dataList){
            if ([item.cnname rangeOfString:@"时时彩"].length > 0){
                [shuzi addObject:item];
            }
            else if ([item.cnname rangeOfString:@"分分彩"].length > 0){
                [shuzi addObject:item];
            }
            else if ([item.cnname rangeOfString:@"时时乐"].length > 0){
                [shuzi addObject:item];
            }
            else if ([item.cnname rangeOfString:@"11选5"].length > 0){
                item.hasSecondPoint = NO;
                [lotou addObject:item];
            }
            else if ([item.cnname rangeOfString:@"快乐8"].length > 0){
                [jinuo addObject:item];
            }
            else if ([item.cnname rangeOfString:@"3D"].length > 0){
                [threeD addObject:item];
            }
            else if ([item.cnname rangeOfString:@"双色球"].length > 0){
                item.hasSecondPoint = NO;
                [shuangseqiu addObject:item];
            }
            else if ([item.cnname rangeOfString:@"P5"].length > 0){
                [P5 addObject:item];
            }
            else if ([item.cnname rangeOfString:@"尽猜天下"].length > 0){
                item.hasSecondPoint = NO;
                [jingcai addObject:item];
            }
            else if ([item.cnname rangeOfString:@"竞彩"].length > 0){
                item.hasSecondPoint = NO;
                [jingcai addObject:item];
            }
        }
        
        _dataList = [[NSMutableArray alloc] init];
        [_dataList addObjectsFromArray:shuzi];
        [_dataList addObjectsFromArray:lotou];
        [_dataList addObjectsFromArray:jinuo];
        [_dataList addObjectsFromArray:threeD];
        [_dataList addObjectsFromArray:shuangseqiu];
        [_dataList addObjectsFromArray:P5];
        [_dataList addObjectsFromArray:jingcai];
        [shuzi release];
        [lotou release];
        [jinuo release];
        [threeD release];
        [P5 release];
        [shuangseqiu release];
        [jingcai release];
        [dataList release];
    }
}

@end

@implementation LinkItem

- (void)dealloc{
    self.urlString = nil;
    self.remark = nil;
    [super dealloc];
}

@end

@implementation LinkDetailItem

- (void)dealloc{
    self.indefinitePoint = nil;
    self.userPoint = nil;
    self.cnname = nil;
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        _hasSecondPoint = YES;
    }
    return self;
}

@end

@implementation LinkDetailHeaderItem

- (void)dealloc{
    self.lotteryType = nil;
    self.point1 = nil;
    self.point2 = nil;
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        _hasSecondPoint = YES;
    }
    return self;
}

@end