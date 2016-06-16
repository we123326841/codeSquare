//
//  RQRevokeZhuiHaoOrder.m
//  Caipiao
//
//  Created by Cyrus on 13-6-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQRevokeZhuiHaoOrder.h"

@implementation RQRevokeZhuiHaoOrder

- (void)prepare
{
    self.url = kUrlRevokeZhuiHaoOrder;
    if (_isLowGame) {
        [self setPostValue:@"1" forField:@"chan_id"];
    }else {
        [self setPostValue:@"4" forField:@"chan_id"];
    }
    [self setValue:_recordId forField:@"planId"];
    [self setValue:_taskId forField:@"taskid"];
     [self setPostValue:_lotteryId forField:@"lotteryId"];
     [self setPostValue:_issueCode forField:@"issueCode"];
    [super prepare];
}

//- (void)setRecordId:(NSString *)recordId
//{
//    [_recordId release];
//    _recordId = [recordId copy];
//    [self setValue:_recordId forField:@"id"];
//}
//
//- (void)setTaskId:(NSString *)taskId
//{
//    [_taskId release];
//    _taskId = [taskId copy];
//    [self setValue:_taskId forField:@"taskid"];
//}

- (void)parse:(NSDictionary *)result
{
    Echo(@"RQRevokeZhuiHaoOrder : %@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        self.error = [result stringForKey:@"error"];
        self.messageType = [result numberfForKey:@"messagetype"];
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end
