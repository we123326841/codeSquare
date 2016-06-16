//
//  RQBankRecharge.m
//  Caipiao
//
//  Created by danal-rich on 13-11-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBankRecharge.h"

@implementation RQBankRechargeInit

- (void)prepare{
    self.url = kUrlBankRechargeInit;
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    if ([json count] > 0){
        NSMutableArray *list = [NSMutableArray array];
        
        NSArray *listarr = [json objectForKey:@"list"];
        
        for (NSDictionary *bankdic in listarr)
        {
            
            BankModel *bank = [[BankModel alloc] init];
            bank.bank_name = [bankdic stringForKey:@"bankName"];
//            bank.bank_id = [bankdic intForKey:@"bid"];
            bank.bankCode = [bankdic intForKey:@"bank"];
//            bank.bankRadio = [bankdic stringForKey:@"bankradio"];
//            bank.account_name = [bankdic stringForKey:@"account_name"];
//            bank.hiddenAccount = [bankdic stringForKey:@"hiddenaccount"];
            bank.loadmax = [bankdic intForKey:@"loadmin"];
            bank.loadmin = [bankdic intForKey:@"loadmax"];
            [list addObject:bank];
            [bank release];
        }
        self.bankList = list;
    }
}

@end



@implementation RQBankRechargeCommit

- (void)prepare{
    self.url = kUrlBankRechargeCommit;
//    [self setPostValue:self.bankRadio forField:@"bankradio"];
    [self setPostValue:self.amount forField:@"amount"];
//    [self setPostValue:self.secPass forField:@"secpwd"];
//    [self setPostValue:@(self.bankId) forField:@"bid"];
    [self setPostValue:@(self.bankCode) forField:@"bank"];
    [self setPostValue:@(self.alertmin) forField:@"alertmin"];
    
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    NSString *errmsg = [json stringForKey:@"error_message"];
    if (errmsg){
        self.msgContent = errmsg;
    }
    self.account = [json stringForKey:@"account"];
    if (!self.account) self.account = [json stringForKey:@"email"];
    
    self.bankName = [json stringForKey:@"shortname"];
    self.area = [[json stringForKey:@"area"] length] == 0 ? @"" : [json stringForKey:@"area"];
    self.key = [json stringForKey:@"key"];
    self.accountName = [json stringForKey:@"accName"];
    self.email = [json stringForKey:@"email"];
}

@end



//******************QUICK RECHARGE******************

@implementation RQQuickRechargeInit

- (void)prepare{
    self.url = kUrlQuickRechargeInit;
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    if ([json count] > 0){
        //NSMutableArray *list = [NSMutableArray array];
        self.quickBankList = [[NSMutableArray alloc] init];
        for (NSDictionary *bankdic in json){
            BankModel *bank = [[BankModel alloc] init];
            bank.bank_name = [bankdic stringForKey:@"bankName"];
            bank.bank_id = [bankdic intForKey:@"bankId"];
            bank.loadmax = [bankdic intForKey:@"max"];
            bank.loadmin = [bankdic intForKey:@"min"];
            [self.quickBankList addObject:bank];
            [bank release];
        }
        
        //self.quickBankList = list;
    }
}

@end

@implementation RQQuickRechargeCommit

- (void)prepare{
    self.url = kUrlQuickRechargeCommit;
    [self setPostValue:self.amount forField:@"money"];
    [self setPostValue:@(self.bankId) forField:@"bankId"];
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    NSString *errmsg = [json stringForKey:@"error_message"];
    if (errmsg){
        self.msgContent = errmsg;
    }
    self.quickUrl = [json stringForKey:@"url"];
}

@end