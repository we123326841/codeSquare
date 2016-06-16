//
//  MethodMenuItem+XJSSC.m
//  Caipiao
//
//  Created by GroupRich on 15/1/13.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "MethodMenuItem+XJSSC.h"
#import "MethodMenuItem+CQSSC.h"
@implementation MethodMenuItem (XJSSC)
+ (NSArray *)generateMethodMenuItemsForXJSSC:(NSInteger)lotteryId
{
   return   [self generateMethodMenuItemsForCQSSC:lotteryId];
}

@end
