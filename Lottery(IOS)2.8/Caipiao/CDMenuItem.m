//
//  CDMenuItem.m
//  Caipiao
//
//  Created by danal on 13-3-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CDMenuItem.h"


@implementation CDMenuItem
@dynamic lotteryId;
@dynamic methodid;
@dynamic menuName;
@dynamic methodPrice;
@dynamic limitBonus;
@dynamic sortIndex;
@dynamic enabled;

+ (NSArray *)menuItemTitles:(int)lotteryId{
    NSArray *menuItems = [CDMenuItem findByOrder:@"sortIndex" andQuery:@"lotteryId = %d AND enabled = 1", lotteryId];
    NSMutableArray *titles = [NSMutableArray array];
    for (CDMenuItem *item in menuItems) {
        [titles addObject:item.menuName];
    }
    return titles;
}

+ (CDMenuItem *)firstMenItem:(int)lotteryId{
    CDMenuItem *item = [CDMenuItem findFirstByOrder:@"sortIndex" andQuery:@"lotteryId = %d AND enabled = 1", lotteryId];
    return item;
}

@end
