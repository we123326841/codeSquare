//
//  RQServerTime.m
//  Caipiao
//
//  Created by danal on 13-5-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQServerTime.h"
#import "IssueItem.h"

@implementation RQServerTime

- (void)dealloc{
    [_time release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlServerTime;
        self.silent = YES;
    }
    return self;
}

- (void)parse:(id)result{

    if ([result isKindOfClass:[NSDictionary class]]) {
        NSString *serverTime = [result objectForKey:@"serverTime"];
        self.time = serverTime;
    } else {    //Use current time as default
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"Y-M-d H:m:s";
        self.time = [df stringFromDate:[NSDate date]];
        [df release];
    }
}
@end
