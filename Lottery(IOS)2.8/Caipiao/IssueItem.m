//
//  IssueItem.m
//  Caipiao
//
//  Created by danal on 13-3-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "IssueItem.h"

@implementation IssueItem
@synthesize number,issueNumber, issueId, lotteryId, curmid;
@synthesize startTime, endTime, openTime;
@synthesize lotteryName;
@synthesize lotteryType = _lotteryType;
@synthesize channelid = _channelid;

- (void)dealloc{
    MSNotificationCenterRemoveObserver();
    [_issueNumberObservers removeAllObjects];
    [_issueNumberObservers  release];
    [number release];
    [issueNumber release];
    [_issue release];
    [startTime release];
    [endTime release];
    [openTime release];
    [lotteryName release];
    [super dealloc];
}


static IssueItem *_sharedIssue = nil;

+ (id)current{
    @synchronized(self){
        if (_sharedIssue == nil) {
            _sharedIssue = [[self alloc] init];
        }
        return _sharedIssue;
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.number = [aDecoder decodeObjectForKey:@"number"];
        self.issueNumber = [aDecoder decodeObjectForKey:@"issueNumber"];
        self.issueId = [aDecoder decodeIntForKey:@"issueId"];
        self.startTime = [aDecoder decodeObjectForKey:@"startTime"];
        self.endTime = [aDecoder decodeObjectForKey:@"endTime"];
        self.openTime = [aDecoder decodeObjectForKey:@"openTime"];
        self.lotteryName = [aDecoder decodeObjectForKey:@"lotteryName"];
        self.lotteryId = [aDecoder decodeIntForKey:@"lotteryId"];
        self.channelid = [aDecoder decodeIntForKey:@"channelid"];
        self.issue = [aDecoder decodeObjectForKey:@"issue"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.number forKey:@"number"];
    [aCoder encodeObject:issueNumber forKey:@"issueNumber"];
    [aCoder encodeInteger:self.issueId forKey:@"issueId"];
    [aCoder encodeObject:self.startTime forKey:@"startTime"];
    [aCoder encodeObject:self.endTime forKey:@"endTime"];
    [aCoder encodeObject:self.openTime forKey:@"openTime"];
    [aCoder encodeObject:self.lotteryName forKey:@"lotteryName"];
    [aCoder encodeInteger:self.lotteryId forKey:@"lotteryId"];
    [aCoder encodeInteger:self.channelid forKey:@"channelid"];
    [aCoder encodeObject:self.issue forKey:@"issue"];
}

/*
- (void)setIssueNumber:(NSString *)issueNumber_{
    NSString *lastIssueNumber = [[issueNumber copy] autorelease];
    
    if (self.lotteryId > 0
        && issueNumber != nil
        && [issueNumber_ length] > 0
        && ![issueNumber_ isEqualToString:issueNumber]) {
        [issueNumber release];
        issueNumber = [issueNumber_ copy];
        
        id observer = [_issueNumberObservers lastObject];
        if (observer) {
            NSDictionary *info = nil;   //[NSDictionary dictionaryWithObject:observer forKey:@"observer"];
            info = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithInt:self.lotteryId],@"lotteryId",
                     observer, @"observer",
                    lastIssueNumber ,@"lastIssueNumber",
             nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationIssueNumberUpdated object:self userInfo:info];
        }
    }
    
    else {
        [issueNumber release];
        issueNumber = [issueNumber_ copy];
    }
}
*/

- (void)setLotteryName:(NSString *)lotteryName_{
    [lotteryName release];
    lotteryName = [lotteryName_ copy];
    
    _lotteryType = kLotteryTypeSSC;
    if ([lotteryName_ rangeOfString:@"快乐8"].length > 0) {
        _lotteryType = kLotteryKuaile8;
    } else if([lotteryName_ rangeOfString:@"11选5"].length > 0){
        _lotteryType = kLotterType11_5;
//    } else if([lotteryName_ isEqualToString:@"3D"]){
//        _lotteryType = kLottery3D;
    } else if([lotteryName_ isEqualToString:@"双色球"]){
        _lotteryType = kLotteryShuangseqiu;
    }
}

- (void)updateIssueNumber:(NSString *)issueNumber_{
    //Must be different
    if ([issueNumber_ isEqualToString:self.issueNumber]){
        return;
    }
    
    NSString *lastIssueNumber = [[self.issueNumber copy] autorelease];
    self.issueNumber = issueNumber_;
    
    //Get a observer and post a notification to it
    id observer = [_issueNumberObservers lastObject];
    if (observer) {
        
        NSDictionary *info = nil;
        info = [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithInteger:self.lotteryId],@"lotteryId",
                observer, @"observer",
                lastIssueNumber ,@"lastIssueNumber",
                nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationIssueNumberUpdated object:self userInfo:info];
    }

}

- (void)addObserver:(id)observer{
    if (nil == _issueNumberObservers) {
        _issueNumberObservers = [[NSMutableArray alloc] init];
    }
    [_issueNumberObservers addObject:observer];
}

- (void)removeLastObserver{
    if ([_issueNumberObservers count] > 0) {
        [_issueNumberObservers removeLastObject];
    }
}

@end
