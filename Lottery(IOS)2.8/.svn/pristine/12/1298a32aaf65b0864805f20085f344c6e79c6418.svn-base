//
//  CDBetList.h
//  Caipiao
//  注单列表
//  Created by danal on 13-1-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StoredModel.h"

@interface CDBetList : StoredModel
//用来区分用户数据
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * userAccount;
//投注对象属性
@property (nonatomic, retain) NSString * name;      //名称
@property (nonatomic, retain) NSString * type;      //彩种，指lotteryId
@property (nonatomic, retain) NSString * betType;      //投注类型MethodBetType
@property (nonatomic, retain) NSNumber * lotteryId;      //Alilas of type
@property (nonatomic, retain) NSNumber * channelId;     //频道id
@property (nonatomic, retain) NSNumber *playType;      //玩法
@property (nonatomic, retain) NSNumber * methodId;     //玩法id
@property (nonatomic, retain) NSString * number;    //号码
@property (nonatomic, retain) NSNumber * count;     //注数
@property (nonatomic, retain) NSNumber * multiple;               //注单倍数
@property (nonatomic, retain) NSNumber * amount;    //金额
@property (nonatomic, retain) NSNumber * mode;                 //1-元角模式，2-角模式
@property (nonatomic, retain) NSString *desc;           //[name]0,1,2,3
@property (nonatomic, retain) NSNumber * bid;
@property (nonatomic, retain) NSString *origNumberStr;  //原始投注号码格式
@property (nonatomic, retain) NSNumber * limitbet; //限制的倍数
+ (void)betListFromBetNumbers:(NSString *)numbers forPlayType:(int)playType;
+ (NSMutableArray *)betListForAccount:(NSString *)account;
+ (void)deleteBetListForAccount:(NSString *)account;    
//+ (void)randomListN:(int)count forPlayType:(int)playType;     //Deprecated
+ (void)randomListN:(NSInteger)count forMethodName:(NSString *)methodName lottery:(NSInteger)lotteryId channelId:(NSInteger)chid;

+ (NSString *)numbersToDesc:(NSString *)numbers;
+ (NSString *)numbersForShow:(NSString *)numbers lotteryId:(NSInteger)lotId channelId:(NSInteger)channelId;


- (NSDictionary *)toDict;
- (NSString *)numbersForShow;

@end
