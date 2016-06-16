//
//  RQTransactionHistory.m
//  Caipiao
//
//  Created by danal on 13-3-13.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQTransactionHistory.h"

@implementation RQTransactionHistory

- (void)dealloc{
    RELEASE(_transactionList);
    [_ordertype release];
    [super dealloc];
}

- (void)prepare
{
    _transactionList = [[NSMutableArray alloc] init];
    self.url = kUrlTransactionHistory;
    [self setPostValue:_ordertype forField:@"ordertype"];
    [super prepare];
}

- (void)setChan_id:(NSInteger)chan_id
{
    _chan_id = chan_id;
//    [self setPostValue:[NSNumber numberWithInt:_chan_id] forField:@"chan_id"];
}

//- (void)setOrdertype:(NSNumber *)ordertype
//{
//    [_ordertype release];
//    _ordertype = [ordertype retain];
//    [self setGetValue:_ordertype forField:@"ordertype"];
//}

- (void)parse:(NSArray *)json{
    if ([json isKindOfClass:[NSArray class]]) {
        for (NSDictionary *one in json){
            TransactionRecord *tr = [[TransactionRecord alloc] init];
            tr.type = [one stringForKey:@"ordertype"];
            tr.change = [one floatForKey:@"amount"];
            tr.time = [one stringForKey:@"time"];
            tr.balance = [one stringForKey:@"balance"];
            [self.transactionList addObject:tr];
            [tr release];
        }
    }
    [[NSFileManager defaultManager] removeItemAtPath:kTransactionHistoryCachePath error:nil];
    [NSKeyedArchiver archiveRootObject:self.transactionList toFile:kTransactionHistoryCachePath];
}

+ (NSArray *)cachedTransactionList{
    return nil;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kTransactionHistoryCachePath];
}

+ (void)clearCache{
    [[NSFileManager defaultManager] removeItemAtPath:kTransactionHistoryCachePath error:nil];
}

@end


@implementation RQUserTransactionHistory

- (void)dealloc{
    RELEASE(_transactionList);
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlUserTransaction;;
        self.transactionList = [NSMutableArray array];
    }
    return self;
}

- (void)setUid:(NSInteger)uid{
    _uid = uid;
    [self setValue:[NSNumber numberWithInteger:uid] forField:@"uid"];
}

- (void)setUsername:(NSString *)username{
    [_username release];
    _username = [username copy];
    [self setValue:username forField:@"username"];
}

//显示如下
// title    amount(operations依照此值决定颜色)
//time      银行馀额:balance
- (void)parse:(NSArray *)json{

    if ([json isKindOfClass:[NSArray class]]) {
        for (NSDictionary *one in json){
            TransactionRecord *tr = [[TransactionRecord alloc] init];
            NSInteger op = [one intForKey:@"operations"]; //1:+,0:-
            tr.type = [one stringForKey:@"title"];
            tr.change = [one floatForKey:@"amount"];
            tr.change = op == 1 ? fabsf(tr.change) : -fabsf(tr.change);
            tr.time = [one stringForKey:@"time"];
            tr.balance = [one stringForKey:@"balance"];
            [self.transactionList addObject:tr];
            [tr release];
        }
    }
}

@end


@implementation RQRechargeRecord

- (void)prepare{
    self.url = kUrlRechargeRecord;
    [self setPostValue:self.chargeType forField:@"chargeType"];
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    if ([json count] > 0){
        
        NSMutableArray *list = [NSMutableArray array];
        
        NSArray *listarr = [json objectForKey:@"list"];
        
        for (NSDictionary *recordDic in listarr)
        {
            RechargeRecordModel *rechargeRecored = [[RechargeRecordModel alloc] init];
            rechargeRecored.orderId = [recordDic stringForKey:@"orderId"];
            rechargeRecored.time = [recordDic stringForKey:@"time"];
            rechargeRecored.applyMoney = [[recordDic objectForKey:@"applyMoney"] floatValue];
            rechargeRecored.realMoney = [[recordDic objectForKey:@"realMoney"] floatValue];
            rechargeRecored.type = [recordDic stringForKey:@"type"];
            rechargeRecored.status = [recordDic intForKey:@"status"];
            [list addObject:rechargeRecored];
            [rechargeRecored release];
        }
        self.rechargeRecordList = list;
    }
}

@end

