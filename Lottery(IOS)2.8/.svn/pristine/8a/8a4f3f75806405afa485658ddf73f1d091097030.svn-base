//
//  RQTransactionHistory.h
//  Caipiao
//
//  Created by danal on 13-3-13.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "TransactionRecord.h"
#import "RechargeRecordModel.h"

#define kTransactionHistoryCachePath [NSString stringWithFormat:@"%@/Library/Caches/transactionList.plist",NSHomeDirectory()]

@interface RQTransactionHistory : RQBase
PSTRONG NSMutableArray *transactionList;
PASSIGN BOOL isLowGame;
PASSIGN NSInteger chan_id;

//Request
PCOPY NSString *ordertype;
//"0：所有类型
//1：转入频道
//2：频道转出
//3：加入游戏
//4：销售返点
//5：奖金派送
//6：追号扣款
//7：当期追号返款
//9：撤单返款
//10：撤单手续费
//11：撤销返点
//12：撤销派奖
//13：频道小额转出
//14：特殊金额整理
//15：特殊金额清理
//未填则预设为0"

+ (NSArray *)cachedTransactionList;
+ (void)clearCache;

@end


@interface RQUserTransactionHistory : RQBase
@property (assign, nonatomic) NSInteger uid;
@property (copy, nonatomic) NSString *username;

PSTRONG NSMutableArray *transactionList;
@end


@interface RQRechargeRecord : RQBase
@property (assign, nonatomic) NSInteger chargeType;
//0：查询全部
//1：网银汇款
//2：快捷充值
//3：财付通充值

PSTRONG NSMutableArray *rechargeRecordList;
@end
