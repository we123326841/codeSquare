//
//  RQAddBonusData.m
//  Caipiao
//
//  Created by GroupRich on 15/8/4.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "RQAddBonusData.h"

@implementation RQAddBonusData


-(void)prepare
{
    self.url=kUrlAddBonusData;
    
    [self setValue:@(_awardGroupId) forField:@"awardGroupId"];
    [self setValue:@(_chan_id) forField:@"chan_id"];
    [self setValue:@(_lotteryId) forField:@"lotteryId"];
    
    [super prepare];
}
- (void)parse:(id)result
{
    self.status = [(NSDictionary*)result objectForKey:@"status"];
    self.msg = [(NSDictionary*)result objectForKey:@"content"];
}

@end
