//
//  RQLogin.m
//  Caipiao
//
//  Created by danal on 13-2-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQLogin.h"
#import "CD.h"

@implementation RQLogin
@synthesize loginPass, loginPassSource, validCode, validCodeSource, username, flag;

@synthesize userid,userType,userRank,frozenType,isTester;
@synthesize nickname,language,token,exception;

- (void)dealloc{
    [exception release];
    [loginPass release];
    [validCode release];
    [username release];
    [flag release];
    
    [nickname release];
    [language release];
    [token release];
    [super dealloc];
}

- (void)setLoginPass:(NSString *)loginPass_{
    loginPass = loginPass_;
    self.loginPassSource = loginPass_;
}

- (void)prepare{
    self.url = kUrlLogin;
    
    NSString *strLoginPassSource;
    NSString *strLoginPass = strLoginPassSource = [[loginPass dataUsingEncoding:NSUTF8StringEncoding] md5];
//    strLoginPass = [NSString stringWithFormat:@"%@+(null)", strLoginPass, nil];
//    strLoginPass = [[strLoginPass dataUsingEncoding:NSUTF8StringEncoding] md5];
//    [self setPostValue:strLoginPass forField:@"loginpass"];
     [self setPostValue:strLoginPass forField:@"loginpassSource"];
//    [self setPostValue:strLoginPassSource forField:@"loginpass_source"];
    [self setPostValue:self.username forField:@"username"];
    
    [super prepare];
}

- (void)parse:(NSDictionary *)json{
    
    self.userid = [json intForKey:@"userid"] ;
    self.nickname = [json stringForKey:@"nickname"];
    self.token = [json stringForKey:@"token"];
//    self.exception = [json objectForKey:@"unusual"];
    self.userType = [json intForKey:@"agentType"];
    self.source = [json stringForKey:@"source"];
    BOOL bSecPass = [json boolForKey:@"needSetSecurityPass"];
//    [SharedModel shared].nickname = self.nickname;
//    [SharedModel shared].username = self.username;
    [SharedModel shared].token = self.token;
//    [SharedModel shared].userid = [NSString stringWithFormat:@"%d",self.userid];
    
    
    CDUserInfo *u = [CDUserInfo findFirst:@"account = '%@'",self.username];
    if (!u){
        u = [[CDUserInfo new] autorelease];
    }
    u.userid = [@(self.userid) stringValue];
    u.account = self.username;
    u.passwd = [json stringForKey:@"loginpwd"];
    u.nickname = self.nickname;
    u.token = self.token;
    u.needSetSecurityPass = @(bSecPass);
    u.userType = @(self.userType);
    u.unread = @([json intForKey:@"unread"]);
    u.logined = @(YES);
    u.isvip = [json valueForKey:@"isvip"];
    u.needSetSafeQuest = @([json boolForKey:@"needSetSafeQuest"]);
    u.source=self.source;
    [u save];
    
    MSNotificationCenterPost(kNotificationUserInfoUpdated);
}

@end

//======
@implementation RQLogout

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlLogout;
    }
    return self;
}

- (void)parse:(NSDictionary *)json{
    
}

@end

//=======

@implementation RQBalance
@synthesize balance;

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlBalance;
        self.silent = YES;
    }
    return self;
}

- (void)parse:(NSDictionary *)json{
    self.balance = [json floatForKey:@"balannce"];
    [SharedModel shared].balance = [json stringForKey:@"balannce"];
}

+ (void)getBalance{
    RQBalance *rq = [[RQBalance alloc] init];
    [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        [rq_ release];
    } sender:nil];
}
@end

@implementation RQGetBalance

- (id)init
{
    self = [super init];
    if (self) {
        self.url = kUrlGetAllChannelBalance;
        self.silent = YES;
    }
    return self;
}

- (void)parse:(NSDictionary *)result
{
    if ([result isKindOfClass:[NSDictionary class]]) {
//        self.bankBalance = [result objectAtIndex:0] == nil ? @"" : [result objectAtIndex:0];
        self.bankBalance = [[result objectForKey:@"balance"] stringValue];

//        self.highBalance = [result objectAtIndex:1] == nil ? @"" : [result objectAtIndex:1];
//        self.lowBalance = [result objectAtIndex:2] == nil ? @"" : [result objectAtIndex:2];
        [SharedModel shared].balance = self.bankBalance;
//        [SharedModel shared].lowBalance = self.lowBalance;
    }
}

+ (void)getBalance
{
    RQGetBalance *rq = [[RQGetBalance alloc] init];
    [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        [rq_ release];
    } sender:nil];
}

+ (void)getBalance:(void (^)(RQBase *rq, NSError *error, id sender))block{
    RQGetBalance *rq = [[[RQGetBalance alloc] init] autorelease];
    [rq startPostWithBlock:block sender:nil];
}

@end