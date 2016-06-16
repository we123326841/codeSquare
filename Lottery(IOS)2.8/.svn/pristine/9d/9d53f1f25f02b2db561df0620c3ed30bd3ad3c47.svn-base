//
//  RQCardBinding.h
//  Caipiao 绑卡相关接口
//
//  Created by danal-rich on 13-11-25.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "BankModel.h"

/**
 * 绑卡初始化
 */
@interface RQCardBindingInit : RQBase
//Response
@property (assign, nonatomic) NSInteger allowNumber;      //可绑卡数
@property (assign, nonatomic) NSInteger availableNumber;  //已绑卡数
@property (assign, nonatomic) NSInteger restNumber;       //剩余卡数
@property (assign, nonatomic) BOOL setSecurity;     //是否设定安全密码
@property (strong, nonatomic) NSArray *provinceList;    //provinces
@property (strong, nonatomic) NSArray *bankList;    //banks
@property (assign, nonatomic) NSInteger isLocked; 
@end


/**
* 绑卡清单
*/
@interface RQCardList : RQBase
//Response
@property (strong, nonatomic) NSArray *cardList;

//@property (assign, nonatomic)  int bankId;  //绑卡银行id
//@property (copy, nonatomic)  NSString *bankName;  //绑卡银行名称
//@property (copy, nonatomic) NSString *bankAccount; //绑卡卡号
//@property (nonatomic) BOOL isEffect;    //是否生效
@end

/**
* 绑卡验证
*/
@interface RQCardConfirm : RQBase
@property (assign, nonatomic) NSInteger bankId;
@property (copy, nonatomic) NSString *bankAccount; //账号
@property (copy, nonatomic) NSString *bankAccountName; //账号名称
//Response
@property (nonatomic) BOOL statusOK;
@end

/**
* 绑卡提交
*/
@interface RQCardCommit : RQBase
@property (assign, nonatomic) NSInteger bankId;
@property (strong, nonatomic) NSString* bankName;
@property (assign, nonatomic) NSInteger provinceId;
@property (strong, nonatomic) NSString* provinceName;
@property (assign, nonatomic) NSInteger cityId;
@property (strong, nonatomic) NSString* cityName;
@property (strong, nonatomic) NSString* branch;         //银行分行
@property (strong, nonatomic) NSString* accountName;    //账号名称
@property (strong, nonatomic) NSString* account;        //账号
@property (strong, nonatomic) NSString* secPass;        //安全密码

//Response
@property (nonatomic) BOOL statusOK;
@end


/**
 *  删卡
 */
@interface RQCardDelete : RQBase
@property (strong, nonatomic) NSString *account;    //账号
@property (strong, nonatomic) NSString *accountName;    //账号名称
@property (assign, nonatomic) NSInteger bankId;
@property (assign, nonatomic) NSInteger Id;

//Response
@property (nonatomic) BOOL statusOK;
@end

/**
 * 安全密码验证
*/
@interface RQCheckSecPwd : RQBase
@property (strong, nonatomic) NSString *pwd;
//Response
@property (nonatomic) BOOL statusOK;
@end

/**
* 按省份获取城市
*/
@interface RQCityList : RQBase
@property (assign, nonatomic) NSInteger provinceId;
//Response
@property (strong, nonatomic) NSArray *cityList;
@end

/**
 * 安全密码验证
 */
@interface RQCheckSecPwdB : RQBase
@property (strong, nonatomic) NSString *fundpassword;
//Response
@property (copy,nonatomic) NSString* status;
@property (copy,nonatomic) NSString *msg;
@end

