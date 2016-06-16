//
//  SharedModel.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedModel : NSObject
//Common properties
@property (assign, nonatomic) int errorCode;
@property (copy, nonatomic) NSString *errorMessage;
//User preperties
@property (copy, nonatomic) NSString *userAccout;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *userid;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *balance;
@property (copy, nonatomic) NSString *lowBalance;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *oldBalance;
//用于临时保存团队频道余额
@property (copy, nonatomic) NSString *teamBalanceBank;
@property (copy, nonatomic) NSString *teamBalanceHigh;
@property (copy, nonatomic) NSString *teamBalanceLow;
//追号起始期
@property (copy, nonatomic) NSString *traceStartIssue;

//临时金额：存储当前所选所有投注的总金额，用于判断余额
@property (assign, nonatomic) float totalAmountInSelect;
//临时存储安全密码
@property (copy, nonatomic) NSString *securityPasswd;

//Apns config
@property (assign, nonatomic) NSInteger pushStartClock;
@property (assign, nonatomic) NSInteger pushEndClock;

+ (SharedModel *)shared;
+ (NSString *)CGISESSID;
+ (BOOL)userIsSignedin;
+ (void)signOut;
+ (int)userType;

+ (BOOL)shoudShowTipsForMethod:(int)methodId lottery:(int)lotteryId;
+ (void)closeTipsForMethod:(int)methodId lottery:(int)lotteryId;
+ (void)resetAllMethodTips;

+ (NSString *)balance;
+ (NSString *)formattedBalance;
+ (NSString *)formattedLowBalance;
+ (NSString *)formattedOldBalance;
+ (NSString *)formatBalance:(NSString *)balance;
+ (NSString *)formatBalancef:(float)balance;
+ (NSString *)formatBalance:(NSString *)balance prefix:(NSString *)prefix subfix:(NSString *)subfix;
+ (NSString *)zhHantRMB:(NSString *)amount;
+ (NSString *)zhHantDecimalRMB:(NSString *)amount;

@end
