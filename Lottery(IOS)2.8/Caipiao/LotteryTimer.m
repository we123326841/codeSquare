//
//  LotteryTimer.m
//  Caipiao
//
//  Created by danal on 13-8-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "LotteryTimer.h"
#import "CDLottery.h"
#import "RQInitData.h"
#import "RQServerTime.h"
#import "IssueItem.h"

#define REQ_KEY(subfix) [NSString stringWithFormat:@"REQ%@",subfix]
#define LOT_KEY(subfix) [NSString stringWithFormat:@"LOT%@",subfix]
#define LOT_FROM_KEY(lot_key) [lot_key stringByReplacingOccurrencesOfString:@"LOT" withString:@""]

static int _dataInitialized = 0;

@interface LotteryTimer ()<RQBaseDelegate>
@property (assign, nonatomic) NSTimeInterval elapsedTime;
@property (strong, nonatomic) NSArray *lotteryList;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL expired;
@property (assign, nonatomic) NSInteger lotteryCount;
@end

@implementation LotteryTimer

static LotteryTimer *_sharedInstance = nil;
+ (LotteryTimer *)shared{
    @synchronized(self){
        if (!_sharedInstance){
            _sharedInstance = [[self alloc] init];
        }
        return _sharedInstance;
    }
}

- (void)dealloc{
    [_serverTimeStr release];
    [_lotteryList release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        _enabled = YES;
        _requestQueues = [[NSMutableDictionary alloc] init];
        NSArray *all = [CDLottery allEnabled];
        _lotteryCount = [all count];
        self.lotteryList = all;
    }
    return self;
}

- (void)requestServerTime{
    //Update server time
    RQServerTime *rqTime = [[[RQServerTime alloc] init] autorelease];
    [rqTime startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        if (!error_){
            RQServerTime *rqTime_ = (RQServerTime *)rq_;
            self.serverTimeStr = rqTime_.time;
            self.serverTimestamp = [self timestampFromDatetimeStr:rqTime_.time];
            self.elapsedTime = 0;
            self.diffTime = self.serverTimestamp - [self currentTimestamp];
        }
    } sender:nil];
}

static NSDateFormatter *_df =  nil;

- (NSTimeInterval)currentTimestamp{
    return [[NSDate date] timeIntervalSince1970];
}

- (NSTimeInterval)timestampFromDatetimeStr:(NSString *)str{
    if (!_df){
        _df = [[NSDateFormatter alloc] init];
        _df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        _df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    }
    NSDate *date = [_df dateFromString:str];
    return [date timeIntervalSince1970];
}

- (void)timerLoop:(NSTimer *)t{
    if (![SharedModel userIsSignedin]) return;
            ;
    for (CDLottery *lot in self.lotteryList){

        NSString *lotName = lot.name;
        int time = [self timestampFromDatetimeStr:lot.endTime] - self.serverTimestamp - self.elapsedTime;
        if (![lot.paused boolValue] && self.serverTimestamp > 0 && time < 1){     //Launch new request
            Echo(@"%@ %@ | %ds | server:%@ | elapsed:%.01f",lot.name,  lot.endTime, time, self.serverTimeStr, self.elapsedTime);
            
            NSString *reqKey = REQ_KEY(lotName);
            RQBase *q = [_requestQueues objectForKey:reqKey];
            if (!q){
//                if (_dataInitialized >= _lotteryCount){     //Call simple init data api
                
                    RQSimpleInit *rq = [[[RQSimpleInit alloc] init] autorelease];
                    rq.channelId = [lot.channelid intValue];
                    rq.lotteryName = lot.name;
                    rq.lotteryId = [lot.lotteryId intValue];
                    [rq startPostWithDelegate:self];
                    [_requestQueues setObject:rq forKey:reqKey];

//                } else {    //First time, call full init data api
//                
//                    RQInitData *rq = [[[RQInitData alloc] init] autorelease];
//                    rq.url = lot.apiUrl;
//                    [rq startPostWithDelegate:self];
//                    [_requestQueues setObject:rq forKey:reqKey];
//                }
            }
        }
    }
    _elapsedTime++;
    
    //Update server time every 30 seconds
    if (_elapsedTime > 0 && (int)_elapsedTime%30 == 0){
        [self requestServerTime];
    }
}

- (void)launch{
    [self stop];
    if (_enabled){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerLoop:) userInfo:nil repeats:YES];
        self.expired = NO;
        [self requestServerTime];
    }
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;

    [_requestQueues removeAllObjects];
}

- (NSTimeInterval)remainningTimeForLottery:(NSString *)lotteryName{
    CDLottery *lot = [CDLottery findLotteryByName:lotteryName];
    int endTimestamp = [self timestampFromDatetimeStr:lot.endTime];
    int t = endTimestamp - self.serverTimestamp - self.elapsedTime;
    return t;
}

- (NSString *)remainningTimeStrForLottery:(NSString *)lotteryName{
    int t = [self remainningTimeForLottery:lotteryName];
    if (t > 0){
//        int day = t/(24*3600);
        int hour = t/3600;
        int minute = t%3600/60;
        int second = t%60;
        NSString *s =  hour == 0
        ? [NSString stringWithFormat:@"%02d:%02d",minute,second]
        : [NSString stringWithFormat:@"%d:%02d:%02d",hour,minute,second]
        ;
        return s;
    }
    return @"-";
}

- (NSString *)remainningTimeStrForLowLottery:(NSString *)lotteryName
{
    int t = [self remainningTimeForLottery:lotteryName];
    if (t > 0){
        int hour = t/3600;
        int minute = t%3600/60;
        NSString *s =  hour == 0
        ? [NSString stringWithFormat:@"%02d",minute]
        : [NSString stringWithFormat:@"%d:%02d",hour,minute]
        ;
        return s;
    }
    return @"-";
}

#pragma mark - RQDelegate
- (void)onRQStart:(RQBase *)rq{
    
}

- (void)onRQComplete:(RQInitData *)rq error:(NSError *)error{
    NSString *lotName = rq.lotteryName;
    [_requestQueues removeObjectForKey:REQ_KEY(lotName)];
    
    if (self.expired){
        [self stop];
        Echo(@"---Session expired---");
        _dataInitialized = 0;
        return;
    }
    if (error){
        Echo(@"%s %@", __func__, error);
        return;
    }
    if ([rq.msgContent length] > 0){    //Erro occured or session expired
        [self stop];
        self.expired = YES;

        [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:rq.msgContent subtitle:nil];
        
        [SharedModel shared].username = nil;
        [SharedModel shared].balance = 0;
        [SharedModel shared].token = nil;
        MSNotificationCenterPost(kNotificationUserInfoUpdated);
        AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
        [dele.menuController swithToMenuIndex:kMenuIndexSign];

    } else {
        if([rq isKindOfClass:[RQSimpleInit class]]){
            
            RQSimpleInit *rqSimple = (RQSimpleInit *)rq;
            //Update the current issue if matchs
            if([IssueItem current].lotteryId == rqSimple.lotteryId){
                [[IssueItem current] updateIssueNumber:rqSimple.currentIssue];
            }
            
            NSString *lotName = rqSimple.lotteryName;
            [_requestQueues removeObjectForKey:REQ_KEY(lotName)];
        
        } else if ([rq isKindOfClass:[RQInitData class]]){
            
            _dataInitialized++;
            
            RQInitData *rqInit = (RQInitData *)rq;
            //Update the current issue if matchs
            if([IssueItem current].lotteryId == rqInit.lotteryId){
                [[IssueItem current] updateIssueNumber:rqInit.currentIssue];
            }
            
            NSString *lotName = rqInit.lotteryName;
            [_requestQueues removeObjectForKey:REQ_KEY(lotName)];
            [self launch];
            
        }
    }
}

@end


#pragma mark - 
#import "OABonusAlertView.h"
@interface SimpleLotteryTimer()
@end

@implementation SimpleLotteryTimer

- (void)dealloc{
    [self.request cancel];
    self.endTime = nil;
    self.request = nil;
    [super dealloc];
}

+ (SimpleLotteryTimer *)shared{
    @synchronized(self){
        static SimpleLotteryTimer *__simpleTimer = nil;
        if (!__simpleTimer){
            __simpleTimer = [[self alloc] init];
        }
        return __simpleTimer;
    }
}

- (void)setupWithLotteryId:(int)lotteryId andChannel:(int)channelId endTime:(NSString *)endTime{
    self.lotteryId = lotteryId;
    self.channelId = channelId;
    self.endTime = endTime;
    self.elapsedTime = 0;
    self.serverTimestamp = 0;
}

- (NSString *)remainningTimeStr{
    if (!self.isPaused ){
    
        NSInteger endTimestamp = [self timestampFromDatetimeStr:self.endTime];
//        int t = endTimestamp - self.serverTimestamp - self.elapsedTime;
        NSInteger t = endTimestamp - [self currentTimestamp] - self.diffTime;
        if (t > 0){
    //        int day = t/(24*3600);
            NSInteger hour = t/3600;
            NSInteger minute = t%3600/60;
            NSInteger second = t%60;
            NSString *s =  hour == 0
            ? [NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)second]
            : [NSString stringWithFormat:@"%ld:%02ld:%02ld",(long)hour,(long)minute,(long)second]
            ;
            return s;
        }
    }
    return @"-";
}

- (NSString *)remainningTimeStrForLottery:(NSString *)lotteryName{
    return [self remainningTimeStr];
}

- (void)setTimerLoopCallback:(SEL)selector target:(id)target{
    _target = target;
    _selector = selector;
}

- (void)launch{
    [self stop];
    self.expired = NO;
    self.elapsedTime = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerLoop:) userInfo:nil repeats:YES];
    [self requestServerTime];
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)simpleInit{
    RQSimpleInit *rq = [[RQSimpleInit alloc] init];
    rq.channelId = self.channelId;
    rq.lotteryId = self.lotteryId;
    [rq startPostWithDelegate:self];
    self.request = rq;
    [rq release];
}

- (void)timerLoop:(NSTimer *)t{
    if (![SharedModel userIsSignedin]) return;
    if (!self.endTime) return;
    
    NSInteger time = [self timestampFromDatetimeStr:self.endTime] - self.serverTimestamp - self.elapsedTime;
//    NSLog(@"\n--self.isPaused :%i\n--self.serverTimestamp: %f\n--self.endime: %@\n--time: %i",self.isPaused,self.serverTimestamp,self.endTime,time);
    if (!self.isPaused && self.serverTimestamp > 0 && time < 1){
        //Launch new request
        [self simpleInit];
    }
    self.elapsedTime++;
    
    if (_target && _selector){
        [_target performSelector:_selector withObject:self];
    }
    
    //Update server time every 30 seconds
    if (self.elapsedTime > 0 && (int)self.elapsedTime%30 == 0){
        [self requestServerTime];
    }
  
}
    
#pragma mark - Request
- (void)onRQStart:(RQBase *)rq{
    
}

- (void)onRQComplete:(RQInitData *)rq error:(NSError *)error{
 
    if([rq isKindOfClass:[RQSimpleInit class]]){
        RQSimpleInit *rqSimple = (RQSimpleInit *)rq;
        self.endTime = rqSimple.endTime;
        self.isPaused = rqSimple.isPaused;
        
//        if (rqSimple.bonusGroupStatus==0) {
//            [OABonusAlertView addNotiView];
//        }
        //Update the current issue if matchs
        if([IssueItem current].lotteryId == rqSimple.lotteryId){
            [[IssueItem current] updateIssueNumber:rqSimple.currentIssueCode];
        }
    }
    self.request = nil;
}



@end