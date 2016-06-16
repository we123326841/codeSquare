//
//  RQPlaySetting.h
//  Caipiao
//
//  Created by 王浩 on 15/10/26.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RQBase.h"

@interface RQPlaySetting : RQBase
@property (nonatomic,copy)NSString* linkid;



@property (nonatomic,copy)NSString*end;
@property (nonatomic,copy)NSString* start;
@property (nonatomic,retain)NSArray *objects;
@end


@interface PlaySettingObject : NSObject

@property (nonatomic,assign)NSInteger channelid;
@property (nonatomic,copy)NSString*cnname;
@property (nonatomic,copy)NSString*indefinitePoint;
@property (nonatomic,copy)NSString*lot_name;
@property (nonatomic,assign)NSInteger lotteryid;
@property (nonatomic,copy)NSString*userpoint;
@property (nonatomic,assign)NSInteger rows;
@property (nonatomic,copy)NSArray *labels;
@property(nonatomic,assign)BOOL isSelected;
@end
