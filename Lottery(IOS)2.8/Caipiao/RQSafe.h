//
//  RQSafe.h
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "RQBase.h"

@interface RQSafeQuestInit : RQBase
//Response
PSTRONG NSMutableArray *issues;
@end

@interface QuestEntity : NSObject

PASSIGN NSInteger qid; //问题流水号 int
PCOPY NSString* question; //问题 varchar
PASSIGN NSInteger isUsed ;//是否被使用

@end


@interface RQSafeQuestSet : RQBase

//Request
PSTRONG NSArray * quests ;//问题列
//PASSIGN int qid ;//问题流水号
//PCOPY NSString * qpwd ;//问题答案

//Response
PCOPY NSString *  status;

@end


@interface RQSafeQuestVerify : RQSafeQuestSet

@end


@interface RQSafeQuestEdit : RQSafeQuestSet

@end