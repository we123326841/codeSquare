//
//  HigherChaseModel.h
//  Caipiao
//
//  Created by 王浩 on 15/12/4.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HigherChaseModel : NSObject
@property (nonatomic,copy)NSString * serialNumber;
@property (nonatomic,copy)NSString *issueNumber;
@property (nonatomic,copy)NSString *beiShuNumber;
@property (nonatomic,copy)NSString *totalNumber;
@property (nonatomic,copy)NSString  *payOffNumber;
@property (nonatomic,copy)NSString *payOffRate;
@property (nonatomic,copy)NSString *methodName;
@property (nonatomic,copy)NSString *beiTouLimit;
@property (nonatomic,assign)BOOL isNeedSX;
@property (nonatomic,assign)long long issueCode;
@end
