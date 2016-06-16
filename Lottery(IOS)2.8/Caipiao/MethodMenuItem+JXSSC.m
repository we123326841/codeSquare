//
//  MethodMenuItem+JXSSC.m
//  Caipiao
//
//  Created by GroupRich on 15/1/13.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "MethodMenuItem+JXSSC.h"
#import "MethodMenuItem+CQSSC.h"
@implementation MethodMenuItem (JXSSC)
+ (NSArray *)generateMethodMenuItemsForJXSSC:(NSInteger)lotteryId{
    return [self generateMethodMenuItemsForCQSSC:lotteryId];
}
@end
