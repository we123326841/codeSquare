//
//  BankModel.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-25.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankModel : NSObject

@property (copy, nonatomic) NSString *account_name;
@property (copy, nonatomic) NSString *account;
@property (assign, nonatomic) NSInteger b_id;
@property (assign, nonatomic) NSInteger bank_id;
@property (copy, nonatomic) NSString *bank_name;
@property (assign, nonatomic) NSInteger provinceId;
@property (copy, nonatomic) NSString *province;
@property (assign, nonatomic) NSInteger cityId;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *branch;   //支行名称
@property (nonatomic) BOOL isEffect;
@property (assign, nonatomic) NSInteger bindId;//绑定银行卡流水号
//充值里需要用到的参数
@property (assign, nonatomic) NSInteger bankCode;     //bank编号
@property (assign, nonatomic) NSInteger loadmax;      //充值上限
@property (assign, nonatomic) NSInteger loadmin;          //下限
@property (copy, nonatomic) NSString *bankRadio;    //选项
@property (copy, nonatomic) NSString *hiddenAccount;        //银行账号
@property (copy, nonatomic) NSString *bankno;

@end

/*
 account = "************1111";
 "account_name" = SB;
 atime = "2013-11-10 08:00:00";
 "bank_id" = 12;
 "bank_name" = "\U4e0a\U6d77\U6d66\U4e1c\U53d1\U5c55\U94f6\U884c";
 branch = "SB\U652f\U884c";
 city = "\U4e0a\U6d77";
 "city_id" = 140;
 email = "<null>";
 id = 430845;
 islock = 0;
 locker = 0;
 locktime = "<null>";
 nickname = "<null>";
 province = "\U4e0a\U6d77";
 "province_id" = 2;
 status = 1;
 unlocker = 0;
 unlocktime = "<null>";
 "user_id" = 716645;
 "user_name" = agrelvis;
 utime = "2013-11-15 11:25:53";
*/

@interface ProvinceModel : NSObject
@property (assign, nonatomic) NSInteger provinceId;
@property (strong, nonatomic) NSString *name;
@end


@interface CityModel : NSObject
@property (assign, nonatomic) NSInteger provinceId;
@property (assign, nonatomic) NSInteger cityId;
@property (strong, nonatomic) NSString *name;
@end
