//
//  RQCardBinding.m
//  Caipiao
//
//  Created by danal-rich on 13-11-25.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQCardBinding.h"
#import "Musou.h"
@implementation RQCardBindingInit

- (void)dealloc{
    [_provinceList release];
    [_bankList release];
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlCardBindingInit;
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    self.allowNumber = [json intForKey:@"allowNum"];
    self.availableNumber = [json intForKey:@"availableNum"];
    self.restNumber = [json intForKey:@"leftNum"];
    self.setSecurity = [json boolForKey:@"setsecurity"];
    NSArray *plist = [json objectForKey:@"provinceList"];
    NSMutableArray *provinceList = [NSMutableArray array];
    for (NSDictionary *one in plist){
        ProvinceModel *provine = [[[ProvinceModel alloc] init] autorelease];
        provine.provinceId = [one intForKey:@"id"];
        provine.name = [one stringForKey:@"name"];
        [provinceList addObject:provine];
    }
    self.isLocked = [json intForKey:@"isLocked"];
    self.provinceList = provinceList;
    
    NSArray *blist = [json objectForKey:@"bankList"];
    NSMutableArray *bankList = [NSMutableArray array];
    for (NSDictionary *one in blist){
        BankModel *bank = [[[BankModel alloc] init] autorelease];
        bank.bank_id = [one intForKey:@"bankId"];
        bank.bank_name = [one stringForKey:@"bank"];
        [bankList addObject:bank];
    }
    self.bankList = bankList;
}

@end


@implementation RQCardList

- (void)dealloc{
//    [_bankName release];
//    [_bankAccount release];
    [_cardList release];
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlCardList;
    [super prepare];
}

- (void)parse:(id)result{
    NSArray *json = result;
    if ([json count] > 0){
        NSMutableArray *cardList = [NSMutableArray array];
        for (NSDictionary *one in json){
            BankModel *bank = [[BankModel alloc] init];
            bank.bank_id = [one intForKey:@"id"];
            bank.bank_name = [one stringForKey:@"bankName"];
            bank.account = [one stringForKey:@"account"];
            bank.isEffect = [one boolForKey:@"iseffect"];
            bank.account_name = [one stringForKey:@"user_name"];
            bank.bindId = [one intForKey:@"bindId"];
            [cardList addObject:bank];
            [bank release];
        }
        self.cardList = cardList;
    }
//    self.bankId = [json intForKey:@"id"];
//    self.bankName = [json stringForKey:@"bank_name"];
//    self.bankAccount = [json stringForKey:@"account"];
//    self.isEffect = [json boolForKey:@"iseffect"];
}

@end


@implementation RQCardConfirm

- (void)dealloc{
    [_bankAccount release];
    [_bankAccountName release];
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlCardBindingConfirm;
    
    [self setPostValue:[NSNumber numberWithInteger:self.bankId] forField:@"id"];
    [self setPostValue:self.bankAccount forField:@"account"];
    [self setPostValue:self.bankAccountName forField:@"accountName"];
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    NSString *errmsg = [json stringForKey:@"error_message"];
    if (errmsg) {
        self.msgContent = errmsg;
    } else {
        NSString *status = [json stringForKey:@"status"];
        self.statusOK = [status isEqualToString:@"success"];
    }
}

@end


@implementation RQCardCommit

- (void)dealloc{
    [_bankName release];
    [_provinceName release];
    [_cityName release];
    [_branch release];
    [_accountName release];
    [_account release];
    [_secPass release];
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlCardBindingCommit;
    
    [self setPostValue:@(self.bankId) forField:@"bankId"];
    [self setPostValue:self.bankName forField:@"bank"];
//    [self setPostValue:@(self.provinceId) forField:@"province_id"];
    [self setPostValue:self.provinceName forField:@"province"];
//    [self setPostValue:@(self.cityId) forField:@"city_id"];
    [self setPostValue:self.cityName forField:@"city"];
    [self setPostValue:self.branch forField:@"branch"];
    [self setPostValue:self.account forField:@"account"];
    [self setPostValue:self.accountName forField:@"accountName"];
    [self setPostValue:self.secPass forField:@"secpass"];
    
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    NSString *errmsg = [json stringForKey:@"error_message"];
    if (errmsg) {
        self.msgContent = errmsg;
    } else {
        NSString *status = [json stringForKey:@"status"];
        self.statusOK = [status isEqualToString:@"success"];
    }
}

@end


@implementation RQCardDelete

- (void)dealloc{
    [_account release];
    [_accountName release];
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlCardDelete;
//    [self setPostValue:self.account forField:@"account"];
//    [self setPostValue:self.accountName forField:@"accountName"];
    [self setPostValue:@(self.Id) forField:@"id"];
       [self setPostValue:@(self.bankId) forField:@"bindId"];//跟id相同
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    NSString *errmsg = [json stringForKey:@"error_message"];
    if (errmsg) {
        self.msgContent = errmsg;
    } else {
        NSString *status = [json stringForKey:@"status"];
        self.statusOK = [status isEqualToString:@"success"];
    }
}

@end


@implementation RQCheckSecPwd

- (void)dealloc{
    [_pwd release];
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlCheckSecPwd;
    [self setPostValue:self.pwd forField:@"secpass"];
    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    NSString *errmsg = [json stringForKey:@"error_message"];
    if (errmsg) {
        self.msgContent = errmsg;
    } else {
        NSString *status = [json stringForKey:@"status"];
        self.statusOK = [status isEqualToString:@"success"];
    }
}

@end


@implementation RQCityList
- (void)dealloc{
    [_cityList release];
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlGetCityList;
    [self setPostValue:@(self.provinceId) forField:@"province"];
    [super prepare];
}

- (void)parse:(id)result{
    NSArray *json = result;
    if ([json isKindOfClass:[NSArray class]] && [json count] > 0){
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *one in json){
            CityModel *city = [[CityModel alloc] init];
            city.name = [one stringForKey:@"name"];
            city.cityId = [one intForKey:@"id"];
            [list addObject:city];
            [city release];
        }
        self.cityList = list;
    }
}

@end



@implementation RQCheckSecPwdB

- (void)dealloc{
    [_fundpassword release];
    [_msg release];
    [_status release];
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlPlatformBBalance;
    [self setPostValue:self.fundpassword forField:@"fundpassword"];
    [self setPostValue:[CDUserInfo user].userid forField:@"userid"];
//    [self setPostValue:@"826289" forField:@"userid"];//255798

    [super prepare];
}

- (void)parse:(id)result{
    NSDictionary *json = result;
    if ([json isKindOfClass:[NSDictionary class]]){
        self.msg = [json stringForKey:@"msg"];
        self.status = [json stringForKey:@"status"];
    }
}

@end