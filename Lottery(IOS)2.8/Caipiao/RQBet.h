//
//  RQBet.h
//  Caipiao
//
//  Created by danal on 13-3-7.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "BetProject.h"

@interface RQBet : RQBase
PASSIGN NSInteger channelId;
PASSIGN NSInteger lotteryId;
PASSIGN NSInteger curmid;
PCOPY NSString *flag;               //'save'
PCOPY NSString *mode;   
PCOPY NSString *select4;            //values (’一倍’ ,‘两倍’)
PASSIGN NSInteger multiple;
PSTRONG NSArray *betList;   //an array contains betProject objects
PASSIGN NSInteger totalNumbers;
PASSIGN CGFloat totalMoney;
PCOPY NSString *issueNumber;

PASSIGN BOOL traceIf;                    //是否追号
PASSIGN BOOL traceStop;                  //追中是否就停
//PCOPY NSString *traceMoney;             //当前追单所有money
//PSTRONG NSArray *traceIssues;           //追号的奖期号
//PSTRONG NSArray *traceIssucesMoney;      //对应奖期的追号的钱
PSTRONG NSArray *traceIssueItems;

//Response
PASSIGN NSInteger success;
PASSIGN NSInteger fail;
PASSIGN BOOL fullFail;
PCOPY NSString *successDetail;
PCOPY NSString *failDetail;
//V2.8
PASSIGN BOOL isHighChaseNum;//是否是高级追号
PSTRONG NSMutableArray *multiples;
PASSIGN NSInteger beiShu;
//V2.1
PASSIGN NSInteger orderId;              //注单id
PASSIGN CGFloat beforeAmount;           //原始金额
PASSIGN CGFloat afterAmount;            //调整后的金额
PASSIGN CGFloat reduceAmount;           //减少的金额
PASSIGN BOOL isSlip;                    //是否变价
PASSIGN BOOL isLock;                    //是否封锁
PSTRONG NSArray *overMutipleDTO;
PSTRONG NSDictionary *gameOrderDTO;
PSTRONG NSArray *lists;                 //处理后的注单

@end


/**
 * 低频投注
 */
@interface RQBetLow : RQBase
PASSIGN NSInteger channelId;
PASSIGN NSInteger lotteryId;            //彩种id
PASSIGN NSInteger methodId;             //玩法id
PCOPY NSString *flag;                   //'save'
PCOPY NSString *mode;

/** 投注接口有返回lists时使用此字段 */
PSTRONG NSArray *betList;               //注单列表
/** 单条注单投注时 */
PASSIGN NSInteger multiple;             //倍数
PCOPY NSString *issueNumber;            //投注奖期
PSTRONG NSString *numbers;              //注单号码
PASSIGN NSInteger totalNumbers;         //总注数
PASSIGN CGFloat totalMoney;               //总金额
PASSIGN BOOL traceIf;                   //是否追号
PASSIGN BOOL traceStop;                 //追中是否就停
PSTRONG NSArray *traceIssueItems;       //追号内容

//Response
PASSIGN NSInteger success;              //投注成功个数
PASSIGN NSInteger fail;                 //投注失败个数
PASSIGN BOOL fullFail;                  //投注失败
PCOPY NSString *successDetail;          //成功详情
PCOPY NSString *failDetail;             //失败详情
//V2.1
PASSIGN NSInteger orderId;              //注单id
PASSIGN CGFloat beforeAmount;           //原始金额
PASSIGN CGFloat afterAmount;            //调整后的金额
PASSIGN CGFloat reduceAmount;           //减少的金额
PASSIGN BOOL isSlip;                    //是否变价
PASSIGN BOOL isLock;                    //是否封锁
PSTRONG NSArray *overMutipleDTO;
PSTRONG NSDictionary *gameOrderDTO;
PSTRONG NSArray *lists;                 //处理后的注单
PCOPY NSString *isFirstSubmit;//封锁变价之后再投注时带这个参数 值为1
PCOPY NSArray *slipResonseDTOList;//封锁变价 直接丢回给服务端

@end



@interface TraceIssueItem : NSObject
PCOPY NSString *issue;
PASSIGN CGFloat money;
+ (id)itemWithIssue:(NSString *)issue money:(CGFloat)money;
@end
