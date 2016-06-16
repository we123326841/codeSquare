//
//  RQWithdrawCash.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQWithdrawCash.h"
#import "RQSafe.h"
@implementation RQWithdrawCashInit

- (id)init
{
    self = [super init];
    if (self){
        self.url = kUrlWithdrawInit;
    }
    return self;
}

- (void)parse:(NSDictionary *)result
{
    if ([result isKindOfClass:[NSDictionary class]]) {
        
        NSArray *bankArray = [result objectForKey:@"banks"];
        _banksList = [[NSMutableArray alloc] init];
        for (NSDictionary *banksDict in bankArray) {
            
            BankModel *model = [[BankModel alloc] init];
            model.account = [banksDict stringForKey:@"account"];
            model.account_name = [banksDict stringForKey:@"accountName"];
            model.bank_id = [banksDict intForKey:@"bankId"];
            model.bank_name = [banksDict stringForKey:@"bankName"];
            model.b_id = [banksDict intForKey:@"id"];
            [_banksList addObject:model];
        }
        
//        self.count = [result intForKey:@"count"];
        self.times = [result intForKey:@"times"];

//        NSDictionary *userInfoDict = [result objectForKey:@"userinfo"];
        self.availableBalance = [result floatForKey:@"availablebalance"];
//        self.userId = [userInfoDict intForKey:@"userid"];
//        self.userName = [userInfoDict stringForKey:@"username"];
        self.maxWithdrawMoney = [[result stringForKey:@"maxWithdrawMoney"]floatValue];
        self.lowLimit = [result intForKey:@"lowLimit"];

        self.upLimit = [result intForKey:@"upLimit"];

    }
}

@end

@implementation RQWithdrawCashCheck

- (id)init
{
    self = [super init];
    if (self){
        self.url = kUrlWithdrawVerify;
    }
    return self;
}

- (void)prepare
{
    [self setPostValue:_money forField:@"money"];
    [self setPostValue:_bankInfo forField:@"bankinfo"];
    
    [super prepare];
}

- (void)parse:(NSDictionary *)result
{
    if ([result isKindOfClass:[NSDictionary class]]) {
     
//        self.availableBalance = [result floatForKey:@"availablebalance"];
        NSDictionary *datas = [result objectForKey:@"datas"];
        if (_bankModel==nil) {
            self.bankModel = [[[BankModel alloc] init]autorelease];
        }
//        self.bankModel.city = [datas stringForKey:@"bankcity"];
        self.bankModel.bank_name = [datas stringForKey:@"bankName"];
        self.bankModel.account = [datas stringForKey:@"cardid"];//
        self.bankModel.bankno = [datas stringForKey:@"bankno"];//
//        self.bankModel.b_id = [datas intForKey:@"cardid"];
//        self.bankModel.province = [datas stringForKey:@"province"];
        self.bankModel.account_name = [datas stringForKey:@"truename"];
//        self.bankModel.bank_id = [result intForKey:@"bank_id"];
        
        self.money_resp = [datas stringForKey:@"money"];

        NSDictionary *user = [result objectForKey:@"user"];
//        self.userId = [user intForKey:@"userid"];
        self.userName = [user stringForKey:@"userName"];
        self.availableBalance= [[user objectForKey:@"availablebalance"]floatValue];
        
        
        NSArray *questins = [result objectForKey:@"questions"];
        self.questions = [NSMutableArray array];
        for (NSDictionary *que in questins) {
            QuestEntity *c = [[QuestEntity alloc]init];
            c.question = [que stringForKey:@"question"];
            c.qid= [[que objectForKey:@"questionId"]intValue];
            [_questions addObject:c];
            [c release];
        }
        
    }
}

@end

@implementation RQWithdrawCashConfirm

- (id)init
{
    self = [super init];
    if (self){
        self.url = kUrlWithdrawCommit;
    }
    return self;
}

- (void)prepare
{
    [self setPostValue:_money forField:@"money"];
//    [self setPostValue:[NSString stringWithFormat:@"%d",_cardid] forField:@"cardid"];
    [self setPostValue:@(_cardid) forField:@"bindId"];
    [self setPostValue:_secpwd forField:@"secpwd"];
    [self setPostValue:[NSString stringWithFormat:@"%ld",(long)_questionId] forField:@"questionId"];
    [self setPostValue:_questionpwd forField:@"questionpwd"];

    [super prepare];
}
@end
//
//@implementation CashQusetion
//
//@end
