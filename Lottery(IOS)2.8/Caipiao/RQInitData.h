//
//  RQInitData.h
//  Caipiao
//
//  Created by danal on 13-3-1.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

@interface RQInitData : RQBase
PASSIGN NSInteger lotteryId;
PASSIGN NSInteger curmid;     //菜单id ？？
PSTRONG id lastOpenCode;
PSTRONG NSString *currentIssue; //当前期号
PSTRONG NSString *currentIssueCode; //当前期号
PCOPY NSString *nowTime;
PCOPY NSString *endTime;
PSTRONG id menuData;
PASSIGN NSInteger sortIndex;  //排序
PCOPY NSString *lotteryName;

+ (NSInteger)lotteryId;
+ (NSInteger)curmid;

@end

@interface RQSimpleInit : RQInitData
@property (assign, nonatomic) NSInteger channelId;
@property (nonatomic) BOOL isPaused;    //暂停销售

@property (nonatomic,retain)NSArray*awardGroups;
@property (nonatomic,assign)NSInteger bonusGroupStatus;
@end