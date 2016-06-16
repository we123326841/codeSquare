//
//  IssueItem.h
//  Caipiao
//
//  Created by danal on 13-3-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kLotteryTypeSSC = 0,
    kLottery3D = kLotteryTypeSSC,
    kLotteryP3P5 = kLotteryTypeSSC,
    kLotterType11_5,
    kLotteryKuaile8,
    kLotteryShuangseqiu,
} LotteryType;

@interface IssueItem : NSObject <NSCoding>
{
    NSMutableArray *_issueNumberObservers;
}
@property (copy, nonatomic) NSString *number;   //code
@property (copy, nonatomic) NSString *issueNumber;
@property (assign, nonatomic) NSInteger issueId;
@property (copy, nonatomic) NSString *startTime;
@property (copy, nonatomic) NSString *endTime;
@property (copy, nonatomic) NSString *openTime;
@property (assign, nonatomic) NSInteger lotteryId;
@property (assign, nonatomic) NSInteger curmid;
@property (assign, nonatomic) NSInteger channelid;
@property (copy, nonatomic) NSString *lotteryName;
@property (readonly, nonatomic) LotteryType lotteryType;
@property (copy, nonatomic) NSString *issue;
+ (IssueItem *)current;
//This method will trigger a notification
- (void)updateIssueNumber:(NSString *)issueNumber;

- (void)addObserver:(id)observer;
- (void)removeLastObserver;

@end
