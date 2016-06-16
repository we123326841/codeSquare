//
//  RQAgentMember.h
//  Caipiao
//
//  Created by danal on 13-10-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

@interface AgentMember : NSObject <NSCoding>
@property (assign, nonatomic) NSInteger uid;
@property (nonatomic) BOOL high;    //高或低频用户
@property (copy, nonatomic) NSString *name, *balance;
//充值
@property (copy, nonatomic) NSString *money, *password, *bankBalance;
@end

/**
 * (下级)代理和会员的数量
 */
@interface RQAgentMemberCount : RQBase
@property (nonatomic) BOOL high;        //YES-high,NO-low
@property (assign, nonatomic) NSInteger uid;

//Response
@property (assign, nonatomic) NSInteger memberCount;
@property (assign, nonatomic) NSInteger agentCount;
@end

/**
 * (下级)代理和会员的列表
 */
@interface RQAgentMemberList : RQBase
@property (nonatomic) BOOL high;        //YES-high,NO-low
@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger page;

//Response
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) NSArray *list;
@end

/**
 * 搜寻用户
 */
@interface RQSearchUser : RQBase
@property (nonatomic) BOOL high;
@property (copy, nonatomic) NSString *chan_id;
@property (strong, nonatomic) NSString *keyword;

//Response
@property (strong, nonatomic) NSArray *list;
@end

/**
 * 团队余额
 */
@interface RQBankBalance : RQBase
@property (assign, nonatomic) NSInteger uid;

//Response
@property (copy, nonatomic) NSString *balance;
@property (copy, nonatomic) NSString *username;
@end

@interface RQTeamBalance : RQBankBalance
@property (nonatomic) BOOL high;        //YES-high,NO-low
@end

/**
 * 下级团队余额
 */
@interface RQUserBankBalance : RQBankBalance
@end

@interface RQUserTeamBalance : RQTeamBalance
@end