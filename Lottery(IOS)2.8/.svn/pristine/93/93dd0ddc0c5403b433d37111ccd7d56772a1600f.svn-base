//
//  RQOpenLinkList.m
//  Caipiao
//
//  Created by GroupRich on 15/8/4.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "RQOpenLinkList.h"

@implementation RQOpenLinkList

-(void)prepare
{
    self.url=kUrlOpenLinkList;
    [super prepare];
}
- (void)parse:(NSArray*)result
{
    NSMutableArray *arr0 = @[].mutableCopy;
    NSMutableArray *arr1 = @[].mutableCopy;
    
    [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
        OpenLinkObject *o = [[OpenLinkObject alloc]init];
        o.end = [obj stringForKey:@"end"];
        o.linkid = [obj stringForKey:@"id"];
        o.registers = [obj intForKey:@"registers"];
        o.remark = [obj stringForKey:@"remark"];
        o.start = [obj stringForKey:@"start"];
        o.urlstring = [obj stringForKey:@"urlstring"];
        o.type = [obj intForKey:@"type"];
        if (o.type==0) {
            [arr0 addObject:o];
        }else
        {
            [arr1 addObject:o];
        }
    }];
    
    self.openLink = @[arr0.mutableCopy,arr1.mutableCopy];
    if (arr0.count==0&&arr1.count==0) {
        _isEmpty = YES;
    }else
    {
        _isEmpty = NO;
    }
}

@end

@implementation OpenLinkObject

-(void)dealloc
{
    [_linkid release];
    [_urlstring release];
    [_remark release];
    [_start release];
    [_end release];
    [super dealloc];
}

@end