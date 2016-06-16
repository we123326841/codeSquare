//
//  RQRevokeOrder.m
//  Caipiao
//
//  Created by Cyrus on 13-6-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQRevokeOrder.h"

@implementation RQRevokeOrder
@synthesize recordId = _recordId;

- (void)prepare
{
    self.url = kUrlRevokeOrder;
    [self setPostValue:_recordId forField:@"id"];
    [super prepare];
}

- (void)setChan_id:(NSInteger)chan_id
{
    _chan_id = chan_id;
//    [self setPostValue:[NSNumber numberWithInt:_chan_id] forField:@"chan_id"];
}

//- (void)setRecordId:(NSString *)recordId_
//{
//    [_recordId release];
//    _recordId = [recordId_ copy];
//    [self setGetValue:_recordId forField:@"id"];
//}

- (void)parse:(id)result
{
    Echo(@"RQRevokeOrder : %@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        self.messagetype = [result intForKey:@"messagetype"];
        self.error = [result stringForKey:@"error"];
        self.status = [result stringForKey:@"status"];
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end
