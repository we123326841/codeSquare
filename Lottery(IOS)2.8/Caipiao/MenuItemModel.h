//
//  MenuItemModel.h
//  Caipiao
//
//  Created by cYrus_c on 14-3-3.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItemModel : NSObject

@property (nonatomic, retain) NSNumber * lotteryId;
//personal properties
@property (nonatomic, retain) NSString * showName;
@property (nonatomic, retain) NSNumber * methodid;
@property (nonatomic, retain) NSNumber * channel_id;
@property (nonatomic, retain) NSNumber * methodPrize;
@property (nonatomic, retain) NSString * desc;

/*
 model.showName = [method objectForKey:@"showname"];
 model.methodid = [method objectForKey:@"methodid"];
 model.channel_id = [method objectForKey:@"channel_id"];
 model.methodPrize = [method objectForKey:@"method_prize"];
 model.desc = [method objectForKey:@"desc"];
 */

@end
