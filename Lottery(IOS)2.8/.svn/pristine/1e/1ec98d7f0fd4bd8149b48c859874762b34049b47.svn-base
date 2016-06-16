//
//  CDOrderInfo.m
//  Caipiao
//
//  Created by danal on 13-1-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CDOrderInfo.h"


@implementation CDOrderInfo

@dynamic type;
@dynamic dateNumber;
@dynamic mode;
@dynamic multiple;
@dynamic userAccount;
@dynamic userId;
@dynamic pay;

+ (CDOrderInfo *)orderForAccount:(NSString *)account{
    CDOrderInfo *order = [CDOrderInfo findFirst:@"userAccount = '%@'",account];
    if (order == nil) {
        order = [[CDOrderInfo new] autorelease];
        order.userAccount = account;
    }
    return order;
}

+ (BOOL)deleteOrderForAccount:(NSString *)account{
    CDOrderInfo *order = [CDOrderInfo findFirst:@"userAccount = '%@'",account];
    if (order != nil) {
       return [order destroy];
    }
    return YES;
}

@end
