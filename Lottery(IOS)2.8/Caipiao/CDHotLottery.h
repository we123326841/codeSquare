//
//  CDHotLottery.h
//  Caipiao
//
//  Created by danal-rich on 7/22/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoredModel.h"

@interface CDHotLottery : StoredModel

@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * logoHot;
@property (nonatomic, retain) NSNumber * lotteryId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sortIndex;
@property (nonatomic, retain) NSNumber * channelid;
@property (nonatomic, retain) NSNumber *isNewLottery;

@end
