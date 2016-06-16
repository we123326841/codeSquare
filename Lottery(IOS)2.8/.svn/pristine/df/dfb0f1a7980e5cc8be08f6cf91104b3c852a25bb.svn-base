//
//  CD.h
//  Kefu
//
//  Created by danal-rich on 4/23/14.
//  Copyright (c) 2014 enjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharedModel.h"
#import "CDBetList.h"
#import "CDOrderInfo.h"
#import "CDMenuItem.h"
#import "CDUserInfo.h"
#import "CDSSC.h"
#import "CDLottery.h"
#import "CDHotLottery.h"


@interface CDUserInfo (Ext)

+ (CDUserInfo *)user;
- (BOOL)isLogined;
- (NSString *)lastLotteryName;
@end


@interface CDHotLottery (Ext)
+ (NSMutableArray *)allSorted;
+ (void)addFromLottery:(CDLottery *)lot;
- (CDLottery *)toLottery;
@end

@interface CDLottery (Ext)
//Fill and only fill once initial lottery data
+ (void)setupForApp;

+ (CDLottery *)lotteryForValue:(id)value ofProperty:(SEL)sel DEPRECATED_ATTRIBUTE;  //Depreacted after v1.7
+ (CDLottery *)findLotteryByName:(NSString *)lotName;
+ (CDLottery *)findLotteryById:(NSInteger)lotteryId andChannelId:(NSInteger)channelId;
+ (NSString *)findNameById:(NSInteger)lotteryId andChannelId:(NSInteger)channelId;
+ (NSMutableArray *)allEnabled;
+ (NSMutableArray *)allEnabledButHot;
@end
