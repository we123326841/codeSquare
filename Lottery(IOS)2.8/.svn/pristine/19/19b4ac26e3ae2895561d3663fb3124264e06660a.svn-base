//
//  BetProject.h
//  Caipiao
//  投注对象
//  Created by danal on 13-3-7.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

//Deprecated,See CDBetList class

@interface BetProject : NSObject
@property (assign, nonatomic) int methodId;     //玩法id
@property (assign, nonatomic) int lotteryId;        //彩种类型?
@property (copy, nonatomic) NSString *betNumber;    //codes，投注号码
@property (assign, nonatomic) int count;               //注单注数
@property (assign, nonatomic) int multiple;               //注单倍数
@property (assign, nonatomic) int money;                //注单金额
@property (assign, nonatomic) int mode;                 //1-元角模式，0-角模式

- (NSDictionary *)toDict;

@end
