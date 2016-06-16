//
//  CDOrderInfo.h
//  Caipiao
//
//  Created by danal on 13-1-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StoredModel.h"

@interface CDOrderInfo : StoredModel

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * dateNumber;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSNumber * multiple;
@property (nonatomic, retain) NSString * userAccount;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSNumber * pay;

+ (CDOrderInfo *)orderForAccount:(NSString *)account;
+ (BOOL)deleteOrderForAccount:(NSString *)account;

@end
