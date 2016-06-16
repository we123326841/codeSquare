//
//  CDUserInfo.h
//  Caipiao
//
//  Created by danal on 13-4-15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StoredModel.h"

@interface CDUserInfo : StoredModel

@property (nonatomic, retain) NSString * token;//登陆令牌,用来保持会话
@property (nonatomic, retain) NSString * account;//用户名
@property (nonatomic, retain) NSString * passwd;
@property (nonatomic, retain) NSString * nickname;//用户昵称
@property (nonatomic, retain) NSString * balance;
@property (nonatomic, retain) NSString * lowBalance;
@property (nonatomic, retain) NSString * userid;//用户id
@property (nonatomic, retain) NSString * lastLottery;
@property (nonatomic, retain) NSNumber * userType;//用户类型 0:用户;1:总代;2:代理
@property (nonatomic, retain) NSNumber * logined;
@property (nonatomic, retain) NSNumber * unread;
@property (nonatomic, retain) NSNumber * needSetSecurityPass;    //是否需要设置安全密码
@property (nonatomic, retain) NSNumber * isvip;//是否为vip用户
@property (nonatomic, retain) NSNumber * needSetSafeQuest; //是否需要设定安全问题密码
@property (nonatomic, retain) NSString *source;//用户来源 若为旧用户则返回3.0，此时才开启资金转移的功能

@end
