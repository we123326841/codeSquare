//
//  CDMenuItem.h
//  Caipiao
//  玩法类型菜单
//  Created by danal on 13-3-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StoredModel.h"

@interface CDMenuItem : StoredModel
@property (nonatomic, retain) NSNumber * lotteryId;
//personal properties
@property (nonatomic, retain) NSNumber * methodid;
@property (nonatomic, retain) NSString * menuName;
@property (nonatomic, retain) NSNumber *methodPrice;
@property (nonatomic, retain) NSNumber *limitBonus;
@property (nonatomic, retain) NSNumber *sortIndex;
@property (nonatomic, retain) NSNumber *enabled;

+ (NSArray *)menuItemTitles:(int)lotteryId;
+ (CDMenuItem *)firstMenItem:(int)lotteryId;

@end
