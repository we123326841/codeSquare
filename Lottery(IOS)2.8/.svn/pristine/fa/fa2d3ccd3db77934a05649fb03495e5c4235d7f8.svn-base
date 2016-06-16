//
//  RQCharge.m
//  Caipiao
//
//  Created by danal-rich on 13-10-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQCharge.h"

@implementation RQCheckCharge

- (id)init{
    self = [super init];
    if (self){
        self.url = kUrlCheckCharge;
    }
    return self;
}

- (void)setUid:(NSInteger)uid{
    _uid = uid;
    [self setValue:[NSNumber numberWithInteger:uid] forField:@"uid"];
}

- (void)setMoney:(NSInteger)money{
    _money = money;
    [self setValue:[NSNumber numberWithInteger:money] forField:@"money"];
}

- (void)parse:(id)result{
    
}

@end

@implementation RQCharge

- (void)dealloc{
    [_username release];
    [_rmbMoney release];
    [super dealloc];
}
- (id)init{
    self = [super init];
    if (self){
        self.url = kUrlCharge;
    }
    return self;
}

- (void)setUid:(NSInteger)uid{
    _uid = uid;
    [self setValue:[NSNumber numberWithInteger:uid] forField:@"uid"];
}

- (void)setMoney:(NSString *)money{
    [self setValue:money forField:@"money"];
}

- (void)setPassword:(NSString *)password{
    [self setValue:password forField:@"secpwd"];
}

- (void)parse:(NSDictionary *)result{
    self.username = [result stringForKey:@"username"];
    self.responedMoney = [result intForKey:@"money"];
    self.rmbMoney = [result stringForKey:@"cnymoney"];
}

@end

@implementation RQChargeData

- (id)init{
    self = [super init];
    if (self){
        self.url = kUrlChargeData;
    }
    return self;
}

- (void)setUid:(NSInteger)uid{
    _uid = uid;
    [self setValue:[NSNumber numberWithInteger:uid] forField:@"uid"];
}

- (void)parse:(NSDictionary *)result{
    if ([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *ownfund = [result objectForKey:@"ownfund"];
        NSDictionary *userfund = [result objectForKey:@"userfund"];
        self.ownBalance = [ownfund floatForKey:@"availablebalance"];
        self.ownUid = [ownfund intForKey:@"userid"];
        self.ownUsername = [ownfund stringForKey:@"username"];
        self.receiverBalance = [userfund floatForKey:@"availablebalance"];
        self.receiverUid = [userfund intForKey:@"userid"];
        self.receiverUsername = [userfund stringForKey:@"username"];
    }
}

@end