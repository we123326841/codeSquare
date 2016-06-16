//
//  BetProject.m
//  Caipiao
//
//  Created by danal on 13-3-7.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetProject.h"

@implementation BetProject
@synthesize lotteryId, methodId;
@synthesize betNumber;
@synthesize count,multiple,money,mode;

- (void)dealloc{
    [betNumber release];
    [super dealloc];
}

- (NSDictionary *)toDict{
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    [d setObject:MSIntToStr(lotteryId) forKey:@"type"];
    [d setObject:MSIntToStr(methodId) forKey:@"methodid"];
    [d setObject:betNumber forKey:@"codes"];
    [d setObject:MSIntToStr(count) forKey:@"nums"];
    [d setObject:MSIntToStr(multiple) forKey:@"times"];
    [d setObject:MSIntToStr(money) forKey:@"money"];
    [d setObject:MSIntToStr(mode) forKey:@"mode"];
    return d;
}

@end
