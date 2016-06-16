//
//  RQBankRecharge.h
//  Caipiao
//
//  Created by danal-rich on 13-11-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "BankModel.h"

/**
 * 充值初始化
 */
@interface RQBankRechargeInit : RQBase
//Response
@property (strong, nonatomic) NSArray *bankList;

//@property (strong, nonatomic) NSString *bankName;
//@property (assign, nonatomic) int bankId;
//@property (assign, nonatomic) int bankCode;     //银行编号
//@property (assign, nonatomic) int loadmin;          //充值下限
//@property (assign, nonatomic) int loadmax;          //充值上限
//@property (strong, nonatomic) NSString *bankRadio;  //银行选项值
//@property (strong, nonatomic) NSString *accountName;    //绑卡用户名
//@property (strong, nonatomic) NSString *account;        //绑卡号码

@end


/**
 * 充值提交
 */
@interface RQBankRechargeCommit : RQBase
@property (assign, nonatomic) NSInteger bankId;
@property (assign, nonatomic) NSInteger bankCode;     //银行编号
@property (assign, nonatomic) NSInteger alertmin;     //固定为100
@property (strong, nonatomic) NSString *bankRadio;  //银行选项值
@property (strong, nonatomic) NSString *amount;     //金额
@property (strong, nonatomic) NSString *secPass;     //密码

//Response
@property (strong, nonatomic) NSString *bankName;   //收款银行
@property (strong, nonatomic) NSString *key;            // 附言
@property (strong, nonatomic) NSString *accountName;    //收款帐户名
@property (strong, nonatomic) NSString *account;     //收款帐号
@property (strong, nonatomic) NSString *area;           //开户城市
@property (copy, nonatomic) NSString *email;
@end
/*
 "acc_name" = "\U6768\U5065\U96c4";
 account = 6225887211401001;
 amount = 100;
 area = "\U957f\U6c99\U5206\U884c\U97f6\U5c71\U8def\U652f\U884c";
 "bank_url" = "https://ebank.spdb.com.cn/per/gb/otplogin.jsp";
 key = w000mabw;
 shortname = "\U6d66\U53d1\U8de8\U884c";
 */


//******************QUICK RECHARGE******************
/**
 * 充值初始化
 */
@interface RQQuickRechargeInit : RQBase
//Response
@property (strong, nonatomic) NSMutableArray *quickBankList;

@end


/*
 * 充值提交
 */
@interface RQQuickRechargeCommit : RQBase
@property (assign, nonatomic) NSInteger bankId;
@property (strong, nonatomic) NSString *amount;     //金额

//Response
@property (strong, nonatomic) NSString *quickUrl;   //url
@end

