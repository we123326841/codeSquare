//
//  RQPublicHistory.h
//  Caipiao
//
//  Created by danal on 13-3-13.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "IssueItem.h"

@interface RQPublicHistory : RQBase
PSTRONG NSArray *issueList;
PASSIGN NSInteger lotteryId;
@property (nonatomic) BOOL lowgame;

+ (NSArray *)pastIssueList:(NSInteger)channelId lotteryId:(NSInteger)lotteryId;
+ (NSArray *)cachedIssueList DEPRECATED_ATTRIBUTE;
+ (IssueItem *)lastOpenIssue;
+ (void)saveLastOpenIssue:(IssueItem *)item;
+ (void)clearCache;

@end

//开奖走势专用
@interface RQSubPublicHistory : RQPublicHistory

@end
/*
@interface PublicDetailItem : NSObject

PASSIGN BOOL opened;
PSTRONG NSMutableArray *list;
PSTRONG NSMutableArray *indexPaths;

@end
 */

@interface RQPublicDetail : RQBase

PASSIGN NSInteger chan_id;
PASSIGN NSInteger lottery_id;
PASSIGN BOOL lowgame;
PSTRONG NSArray *issueList;

@end
