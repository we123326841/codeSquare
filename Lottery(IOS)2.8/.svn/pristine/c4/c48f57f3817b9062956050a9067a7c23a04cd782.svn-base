//
//  RQLogin.h
//  Caipiao
//
//  Created by danal on 13-2-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RQBase.h"
#import "Defines.h"

@interface RQLogin : RQBase
//Request
PCOPY NSString *loginPass;
PCOPY NSString *loginPassSource;
PCOPY NSString *validCode;
PCOPY NSString *validCodeSource;
PCOPY NSString *username;
PCOPY NSString *flag;

//Response
PASSIGN NSInteger userid;
PASSIGN UserType userType;
PCOPY NSString *nickname;
PCOPY NSString *language;
PASSIGN NSInteger userRank;
PASSIGN NSInteger frozenType;
PASSIGN NSInteger isTester;
PCOPY NSString *token;
PCOPY NSString *exception;  //登录异常消息
PCOPY NSString *source;//用户来源 若为旧用户则返回3.0，此时才开启资金转移的功能	
@end

//=======
@interface RQLogout : RQBase
@end

//=======
@interface RQBalance : RQBase
PASSIGN float balance;

+ (void)getBalance;

@end

@interface RQGetBalance : RQBase

PCOPY NSString *bankBalance,
*highBalance,
*lowBalance;

+ (void)getBalance;
+ (void)getBalance:(void (^)(RQBase *rq, NSError *error, id sender))block;
@end