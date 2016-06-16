//
//  RQAllTraceIssues.h
//  Caipiao
//
//  Created by danal on 13-7-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

@interface RQAllTraceIssues : RQBase
@property (assign, nonatomic) NSInteger lotteryId, channelId;

+ (NSArray *)allIssues:(NSInteger)lotteryId channelId:(NSInteger)channelId;

@end


@interface TraceIssueObject : NSObject <NSCoding>
@property (copy, nonatomic) NSString *issue, *issueCode, *saleEnd, *endTime;

+ (id)parseFromDict:(NSDictionary *)dict;
@end