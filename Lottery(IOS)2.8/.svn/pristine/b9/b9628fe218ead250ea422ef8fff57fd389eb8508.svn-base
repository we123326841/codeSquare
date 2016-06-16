//
//  CDSSC.h
//  Caipiao
//
//  Created by danal on 13-5-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StoredModel.h"

@interface CDSSC : StoredModel

@property (nonatomic, retain) NSString * abbreviation;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * lotteryId;
@property (nonatomic, retain) NSNumber *channelid;

+ (NSString *)nameForAbbr:(NSString *)abbreviation;
+ (NSString *)nameForLotteryId:(int)lotteryId andChannelId:(int)channelId;
@end
