//
//  RQWithdrawCash.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "BankModel.h"

@interface RQWithdrawCashInit : RQBase

@property (assign, nonatomic) NSInteger userId;
@property (copy, nonatomic) NSString *userName;
@property (assign, nonatomic) CGFloat availableBalance;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger times;
@property (strong, nonatomic) NSMutableArray *banksList;
@property (assign, nonatomic) CGFloat maxWithdrawMoney;//最大可提现金额
@property (assign, nonatomic) NSInteger lowLimit;//最低提现限额
@property (assign, nonatomic) NSInteger upLimit;//最高提现限额

@end

@interface RQWithdrawCashCheck : RQBase

//request
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *bankInfo;

//response
@property (assign, nonatomic) NSInteger userId;
@property (copy, nonatomic) NSString *userName;
@property (assign, nonatomic) CGFloat availableBalance;
@property (copy, nonatomic) NSString *money_resp;
@property (strong, nonatomic) BankModel *bankModel;
@property (nonatomic,retain)NSMutableArray *questions;


@end

@interface RQWithdrawCashConfirm : RQBase

//request
@property (copy, nonatomic) NSString *money;
@property (assign, nonatomic) NSInteger cardid;
@property (copy, nonatomic) NSString* bank_id;
@property (copy, nonatomic) NSString *secpwd;
@property (assign, nonatomic) NSInteger questionId;//questionId
@property (copy, nonatomic) NSString *questionpwd;//安全問題密碼

//response


@end

//@interface CashQusetion : NSObject
//@property (copy, nonatomic) NSString *question;
//@property (assign, nonatomic) int questionId;
//@end

