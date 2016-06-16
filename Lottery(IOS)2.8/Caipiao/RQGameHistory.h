//
//  RQGameHistory.h
//  Caipiao
//
//  Created by danal on 13-3-13.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "GameRecord.h"


#define kGameHistoryCachePath [NSString stringWithFormat:@"%@/Library/Caches/recordList.plist",NSHomeDirectory()]

@interface RQGameHistory : RQBase

@property (assign, nonatomic) BOOL isLowGame;
@property (strong, nonatomic) NSMutableArray *recordList;

+ (NSArray *)cachedRecordList;
+ (void)clearCache;

@end

@interface RQGameDetail : RQBase
//Request
PCOPY NSString *recordId;//投注单id
PCOPY NSString *enid;//投注单id
PCOPY NSString *issue;//奖期
PCOPY NSString *time;//投注时间
PASSIGN CGFloat total;//投注总额
PASSIGN CGFloat bonus;//中奖金额
PASSIGN NSInteger cancancel; //是否可以撤单 0:不可以
PASSIGN NSInteger iscancel; //iscancel  0:未撤单;1:自己撤单;2:公司撤单 //0:默认(未撤单) 1:用户 2:系统
PCOPY NSString *openCode; //开奖号码
PCOPY NSString *lotteryId; //lotteryId
PSTRONG NSMutableArray *list;//注单信息
PCOPY NSString *gameNo;
PASSIGN NSInteger chan_id;
////Response
//PASSIGN int win; //0：未开奖1：未中奖2：派奖中3：已派奖
//PCOPY NSString *mode;
//PASSIGN float amount;
//PASSIGN int multipe;
//PCOPY NSString *methodname;
//PCOPY NSString *betDetail;
//PCOPY NSString *originalCode;   //原始投注格式的号码

@end

@interface RecordInfo : NSObject //注单信息
PCOPY NSString *methodid;//彩种id
PCOPY NSString *codedetails;//注单号码
PASSIGN CGFloat price;//投注金额
PASSIGN NSInteger nums; //注单注数
PASSIGN NSInteger multiple; //倍数
PCOPY NSString *modes; //模式
PCOPY NSString *methodname; //玩法
PASSIGN NSInteger ifwin; //0：未开奖1：未中奖2：派奖中3：已派奖4：撤銷5：存在異常
PASSIGN CGFloat bonus;
+ (id)parseFromDict:(NSDictionary *)d;
@end