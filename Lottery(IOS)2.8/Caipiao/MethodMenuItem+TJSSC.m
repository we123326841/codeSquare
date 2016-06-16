//
//  MethodMenuItem+TJSSC.m
//  Caipiao
//
//  Created by GroupRich on 15/1/13.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "MethodMenuItem+TJSSC.h"
#import "MethodMenuItem+CQSSC.h"

@implementation MethodMenuItem (TJSSC)
+ (NSArray *)generateMethodMenuItemsForTJSSC:(NSInteger)lotteryId
{
    return [self generateMethodMenuItemsForCQSSC:lotteryId];
}

@end
