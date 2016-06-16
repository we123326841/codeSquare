//
//  LotteryTimer.h
//  Caipiao
//
//  Created by danal on 13-8-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RQInitData.h"

@interface LotteryTimer : NSObject
{
    NSMutableDictionary *_requestQueues;
}
@property (assign, nonatomic) NSTimeInterval serverTimestamp;
@property (assign, nonatomic) NSTimeInterval diffTime;  //Server - Mobile
@property (copy, nonatomic) NSString *serverTimeStr;
@property (nonatomic) BOOL enabled;

+ (LotteryTimer *)shared;

- (void)launch;
- (void)stop;
- (void)requestServerTime;
//Convert date string to timestamp
- (NSTimeInterval)timestampFromDatetimeStr:(NSString *)str;

//Get remanning time
- (NSTimeInterval)remainningTimeForLottery:(NSString *)lotteryName;
- (NSString *)remainningTimeStrForLottery:(NSString *)lotteryName;
- (NSString *)remainningTimeStrForLowLottery:(NSString *)lotteryName;

@end


@interface SimpleLotteryTimer : LotteryTimer
{
    id _target;
    SEL _selector;
}
@property (nonatomic) BOOL isPaused;    //暂停销售
@property (copy, nonatomic) NSString *endTime;  //结束时间
@property (assign, nonatomic) NSInteger lotteryId,channelId;
@property (strong, nonatomic) RQSimpleInit *request;

+ (SimpleLotteryTimer *)shared;
- (void)simpleInit;
/**
 * Donn't forget to setup before the timer launch
 */
- (void)setupWithLotteryId:(int)lotteryId andChannel:(int)channelId endTime:(NSString *)endTime;

- (NSString *)remainningTimeStr;
//Override
- (NSString *)remainningTimeStrForLottery:(NSString *)lotteryName;
//Callback selector, and the timer instance passed in as the parameter
- (void)setTimerLoopCallback:(SEL)selector target:(id)target;

@end
