//
//  TransactionRecord.m
//  Caipiao
//
//  Created by danal on 13-3-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "TransactionRecord.h"

@implementation TransactionRecord
@synthesize type,time,change,balance;

- (void)dealloc{
    RELEASE(type);
    RELEASE(time);
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.change = [aDecoder decodeFloatForKey:@"change"];
        self.balance = [aDecoder decodeObjectForKey:@"balance"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeFloat:self.change forKey:@"change"];
    [aCoder encodeObject:self.balance forKey:@"balance"];
}

@end
