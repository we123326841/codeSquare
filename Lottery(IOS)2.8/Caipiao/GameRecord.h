//
//  GameRecord.h
//  Caipiao
//
//  Created by danal on 13-3-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameRecord : NSObject <NSCoding>
@property (copy ,nonatomic) NSString *lotteryName;
@property (copy ,nonatomic) NSString *methodName;
@property (copy ,nonatomic) NSString *recordId;
@property (assign, nonatomic) NSInteger win;                               //是否中奖 0:未开奖;1:未中奖;2:派奖中，3已派奖
//1:等待开奖 2:中奖 3:未中奖 4:撤销 5:存在异常 6:数据归档
@property (assign, nonatomic) NSInteger iscancel;                         //iscancel  0:未撤单;1:自己撤单;2:公司撤单
//0:默认(未撤单) 1:用户 2:系统
@property (copy ,nonatomic) NSString *gameName;
@property (assign ,nonatomic)  NSInteger methodId;            //玩法ID
@property (copy ,nonatomic) NSString *playType;            //玩法
@property (copy ,nonatomic) NSString *playTime;             //购买时间
@property (copy ,nonatomic)  NSString *amount;               //投注金额
@property (copy ,nonatomic) NSString *issueNumber;      //投注期号
@property (copy, nonatomic) NSString *bonus;                        //派奖金额
@property (copy ,nonatomic) NSString *number;      //号码
@property (assign, nonatomic) NSInteger channelid;    //频道ID
@property (assign, nonatomic) NSInteger lotteryid;    //彩种ID
@end


@interface GameRecordDetail : GameRecord
@property (copy, nonatomic) NSString *sn;                       //注单编号
@property (copy, nonatomic) NSString *bingoNumber;      //中奖号码
@property (copy, nonatomic) NSString *mode;                 //模式
@property (copy, nonatomic) NSString *times;                //倍数
@property (copy, nonatomic) NSString *bettingDetail;           //中奖号码

@end