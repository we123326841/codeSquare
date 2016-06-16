//
//  RQZhuiHaoInfo.h
//  Caipiao
//
//  Created by danal on 13-6-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

@interface RQZhuiHaoInfo : RQBase

@property (assign, nonatomic) NSInteger chan_id;
@property (strong, nonatomic) NSMutableArray *dataList;

@end

@interface ZhuiHaoInfoItem : NSObject
PASSIGN NSInteger methodId,//玩法id
multiple;//投注倍数
PSTRONG NSNumber *lotteryId,*channelId,//彩种id 频道id
*issueCount,//追号期数
*finishedCount,//完成期数
*cancelCount,//是否可以终止 
*stopOnWin,//
*status, //追号状态 0:进行中;1:取消;2:已完成
//新接口 ：0:未开始1:进行中2已结束3已终止4暂停5存在异常6执行中
*taskPrice,//
*bonus; //中奖金额
PCOPY NSString * username,//用户名
*taskId, //追单编号
*begainTime,//追号时间
*beginIssue,//开始期数
*codes,//投注号码
*methodname,//玩法
*cnname,//游戏
*lotteryName;//

+ (id)parseFromDict:(NSDictionary *)dict;
@end