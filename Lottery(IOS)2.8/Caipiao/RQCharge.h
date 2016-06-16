//
//  RQCharge.h
//  Caipiao
//
//  Created by danal-rich on 13-10-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

/**
 *  检查下级充值金额
 */
@interface RQCheckCharge : RQBase
@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) NSInteger money;

//Response
@property (nonatomic) BOOL success;
@end

/**
 *  给下级充值金额
 * uid=847370&secpwd=123qweasd&money=10.000000
 */
@interface RQCharge : RQBase
@property (assign, nonatomic) NSInteger uid;
@property (assign, nonatomic) NSString *money;
@property (assign, nonatomic) NSString *password;
//Response
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *rmbMoney;
@property (assign, nonatomic) NSInteger responedMoney;
@end

/**
* 取得下级充值资料
*/
@interface RQChargeData : RQBase
@property (assign, nonatomic) NSInteger uid;
//Response
@property (assign, nonatomic) CGFloat ownBalance;
@property (assign, nonatomic) NSInteger ownUid;
@property (copy, nonatomic) NSString *ownUsername;
@property (assign, nonatomic) CGFloat receiverBalance;
@property (assign, nonatomic) NSInteger receiverUid;
@property (copy, nonatomic) NSString *receiverUsername;
@end
