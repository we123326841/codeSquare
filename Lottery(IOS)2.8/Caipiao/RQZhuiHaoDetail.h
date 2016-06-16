//
//  RQZhuiHaoDetail.h
//  Caipiao
//
//  Created by Cyrus on 13-6-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "RQZhuiHaoInfo.h"

@interface RQZhuiHaoDetail : RQBase

//Request
PCOPY NSString *rqId;
@property (assign, nonatomic) BOOL isLowGame;

//Response
PSTRONG NSMutableArray *issueList;

PCOPY NSString* taskNo ;//追号单编号
PCOPY NSString* beginissue ;//奖期
PCOPY NSString* begintime ;//投注时间
PASSIGN NSInteger  issuecount; //追号期数
PASSIGN NSInteger  finishedcount ;//完成期数
PASSIGN CGFloat  finishedmoney ;//已投注金额
PASSIGN CGFloat  totalmoney ;//总金额
PASSIGN NSInteger   traceStop ;//是否追中即停  0:不停只1:按累计盈利停止2:中奖即停
PASSIGN CGFloat  bonus ;//中奖金额
PCOPY NSString* lotteryId ;//lotteryId
PSTRONG NSMutableArray* projectList ;//追号单信息
//PCOPY NSString* methodid ;//彩种id
//PCOPY NSString* codedetails; //注单号码
//PASSIGN int   nums; //注单注数
//PASSIGN int  multiple; //倍数
//PCOPY NSString*  modes ;//模式
PSTRONG NSMutableArray*tasks ;//追号期数列表


@end

@interface ZhuiHaoDetailModel : NSObject

PCOPY NSString *issue;
PSTRONG NSNumber *multiple;
PSTRONG NSNumber *status; //0:进行中;  1:已完成;  2:已取消
PSTRONG NSNumber *canCancel;
PCOPY NSString *taskDetailId;
PASSIGN BOOL isSelected; //追号详情 ，CELL的选择操作
PCOPY NSString *issueCode;
PCOPY NSString *taskDetailNo;
+ (id)parseFromDict:(NSDictionary *)d;

@end

@interface ZhuiHaoIssueModel : NSObject

PCOPY NSString *taskDetailNo ;//方案编号
PCOPY NSString *taskdetailid ;//追号单详情id
PCOPY NSString *issue; //追号奖期
PCOPY NSString *issueCode ;//奖期号码
PASSIGN NSInteger multiple; //倍数
PASSIGN CGFloat money ;//投注金额
PCOPY NSString * opencode; //开奖号码
PASSIGN NSInteger status; //追号状态   0:未生成;1:生成追号单;2:追号单取消 对应prd文字(0:进行中;1:已完成;2:已取消;) 当status != 1时,才判断cancancel
PASSIGN CGFloat bonus ;//中奖金额
PASSIGN NSInteger  cancancel ;//是否可以终止
PSTRONG NSArray *list;//注单资料
+ (id)parseFromDict:(NSDictionary *)d;

//list
// price	投注金额	float
// ifwin	是否中奖	Tinyint 1	0：未开奖1：未中奖2：派奖中3：已派奖4：撤銷5：存在異常
// bonus	该号码中奖金额	float
@end
