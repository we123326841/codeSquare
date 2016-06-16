//
//  RQAgentMember.m
//  Caipiao
//
//  Created by danal on 13-10-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQAgentMember.h"


@implementation AgentMember

- (void)dealloc{
    [_name release];
    [_balance release];
    [_money release];
    [_password release];
    [_bankBalance release];
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    self.uid = [aDecoder decodeIntForKey:@"uid"];
    self.high = [aDecoder decodeBoolForKey:@"high"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.balance = [aDecoder decodeObjectForKey:@"balance"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.uid forKey:@"uid"];
    [aCoder encodeBool:self.high forKey:@"high"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.balance forKey:@"balance"];
}

@end


@implementation RQAgentMemberCount

- (id)init{
    self = [super init];
    if (self){
        self.high = YES;
        self.url = kUrlUserListCount;
    }
    return self;
}

- (void)setHigh:(BOOL)high{
    _high = high;
    [self setValue:high ? @"4" : @"1" forField:@"chan_id"];
}

- (void)setUid:(NSInteger)uid{
    _uid = uid;
    if (uid > 0)
    [self setValue:[NSNumber numberWithInteger:uid] forField:@"uid"];
}

- (void)parse:(NSDictionary *)result{
    self.memberCount = [result intForKey:@"membernum"];
    self.agentCount = [result intForKey:@"proxynum"];
}

@end


@implementation RQAgentMemberList

- (void)dealloc{
    [_list release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        self.high = YES;
    }
    return self;
}

- (void)prepare
{
    self.url = kUrlUserList;
    [self setValue:_high ? @"4" : @"1" forField:@"chan_id"];
    [super prepare];
}

- (void)setUid:(NSInteger)uid{
    _uid = uid;
    if (uid > 0)
        [self setValue:[NSNumber numberWithInteger:uid] forField:@"uid"];
}

- (void)setType:(NSInteger)type{
    _type = type;
    [self setValue:[NSNumber numberWithInteger:type] forField:@"type"];
}

- (void)setPage:(NSInteger)page{
    _page = page;
    [self setValue:[NSNumber numberWithInteger:page] forField:@"p"];
}

- (void)parse:(NSDictionary *)result{
    self.count = [result intForKey:@"count"];
    NSArray *content = [result objectForKey:@"content"];
    
    if ([content isKindOfClass:[NSArray class]]) {
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *d in content) {
            AgentMember *am = [[[AgentMember alloc] init] autorelease];
            am.name  = [d stringForKey:@"name"];
            am.balance = [d stringForKey:@"balance"];
            am.uid = [d intForKey:@"uid"];
            [list addObject:am];
        }
        self.list = list;
    }
}

@end


@implementation RQSearchUser

- (void)dealloc{
    [_keyword release];
    [_list release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        self.url = kUrlSearchUser;
    }
    return self;
}

- (void)setHigh:(BOOL)high{
    _high = high;
    _chan_id = _high ? @"4" : @"1";
    [self setValue:_chan_id forField:@"chan_id"];
}

- (void)setKeyword:(NSString *)keyword{
    [_keyword release];
    _keyword = [keyword copy];
    [self setValue:keyword forField:@"username"];
}

- (void)parse:(id)result{
    @try {
//        NSArray *content = result;
        NSMutableArray *list = [NSMutableArray array];
//        for (NSDictionary *d in content) {
            NSDictionary *d = result;
            AgentMember *am = [[[AgentMember alloc] init] autorelease];
            am.name  = [d stringForKey:@"username"];
            if (!am.name) am.name = [d stringForKey:@"name"];
            am.balance = [d stringForKey:@"balance"];
            am.uid = [d intForKey:@"uid"];
            [list addObject:am];
//        }
        self.list = list;
    }
    @catch (NSException *exception) {
        Echo(@"RQSearchUser %@",exception);
    }
}

@end

@implementation RQBankBalance

- (void)dealloc{
    [_balance release];
    [_username release];
    [super dealloc];
}

- (void)prepare
{
    self.url = kUrlTeamBalance;
    [self setValue:@"0" forField:@"chan_id"];
    [super prepare];
}

- (void)parse:(NSDictionary *)result{
    if ([result isKindOfClass:[NSDictionary class]]){
        self.balance = [result stringForKey:@"balance"];
        self.username = [result stringForKey:@"username"];
    }
}

@end

@implementation RQTeamBalance

- (void)prepare
{
    self.url = kUrlTeamBalance;
    [self setValue:_high ? @"4" : @"1" forField:@"chan_id"];
    [super prepare];
}

@end

@implementation RQUserBankBalance

- (void)prepare
{
    self.url = kUrlUserTeamBalance;
    [self setValue:@"0" forField:@"chan_id"];
    [self setValue:[NSNumber numberWithInteger:self.uid] forField:@"uid"];
    [super prepare];
}

@end

@implementation RQUserTeamBalance

- (void)prepare
{
    self.url = kUrlUserTeamBalance;
    [self setValue:self.high ? @"4" : @"1" forField:@"chan_id"];
    [self setValue:[NSNumber numberWithInteger:self.uid] forField:@"uid"];
    [super prepare];
}

@end