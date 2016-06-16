//
//  RQAllTraceIssues.m
//  Caipiao
//
//  Created by danal on 13-7-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQAllTraceIssues.h"
#import "CDLottery.h"

#define AllTraceIssuesCachePath(channelId_,lotteryId_) [NSString stringWithFormat:@"%@/Library/Caches/allTraceIssues_%ld%ld.plist",NSHomeDirectory(), channelId_, lotteryId_]

@implementation RQAllTraceIssues

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlAllTraceIssues;
    }
    return self;
}

- (void)prepare{
    [self setPostValue:MSIntToStr(_lotteryId) forField:@"lotteryId"];
    [self setPostValue:MSIntToStr(_channelId) forField:@"chan_id"];
    [super prepare];
}

- (void)parse:(NSArray *)result{

    NSMutableArray *list = [NSMutableArray array];
    if ([result isKindOfClass:[NSArray class]]) {
        for (NSDictionary *one in result){
            [list addObject:[TraceIssueObject parseFromDict:one]];
        }
    }
    if ([list count] > 0) {
        [NSKeyedArchiver archiveRootObject:list toFile:AllTraceIssuesCachePath((long)self.channelId, (long)self.lotteryId)];
    }
}

+ (NSArray *)allIssues:(NSInteger)lotteryId channelId:(NSInteger)channelId{
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:AllTraceIssuesCachePath((long)channelId,(long)lotteryId)];
    return obj;
}

@end


@implementation TraceIssueObject

- (void)dealloc{
    self.issue = nil;
    self.issueCode = nil;
    self.saleEnd = nil;
    self.endTime = nil;
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.issue = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(issue))];
        self.issueCode = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(issueCode))];
        self.saleEnd = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(saleEnd))];
        self.endTime = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(endTime))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.issue forKey:NSStringFromSelector(@selector(issue))];
    [aCoder encodeObject:self.issueCode forKey:NSStringFromSelector(@selector(issueCode))];
    [aCoder encodeObject:self.saleEnd forKey:NSStringFromSelector(@selector(saleEnd))];
    [aCoder encodeObject:self.endTime forKey:NSStringFromSelector(@selector(endTime))];
}

+ (id)parseFromDict:(NSDictionary *)d{
    TraceIssueObject *obj = [[[TraceIssueObject alloc] init] autorelease];
    obj.issue = [d stringForKey:@"issue"];
    obj.issueCode = [d stringForKey:@"issueCode"];
    obj.saleEnd = [d stringForKey:@"saleend"];
    obj.endTime = [d stringForKey:@"saleend"];
    return obj;
}

@end