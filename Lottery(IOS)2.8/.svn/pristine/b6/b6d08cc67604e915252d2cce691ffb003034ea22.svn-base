//
//  HighChaseNumType.m
//  Caipiao
//
//  Created by 王浩 on 15/12/10.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "HighChaseNumType.h"

@implementation HighChaseNumType
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:@(self.totalIssue) forKey:@"totalIssue"];
    [aCoder encodeObject:@(self.startBeiShu) forKey:@"startBeiShu"];
    [aCoder encodeObject:@(self.isStop) forKey:@"isStop"];
    [aCoder encodeObject:@(self.type) forKey:@"type"];
    [aCoder encodeObject:@(self.issue) forKey:@"issue"];
    [aCoder encodeObject:@(self.beiShu) forKey:@"beiShu"];
    [aCoder encodeObject:@(self.beiShu2) forKey:@"beiShu2"];
    [aCoder encodeObject:@(self.payOffAmount) forKey:@"payOffAmount"];
    [aCoder encodeObject:@(self.payOffAmount2) forKey:@"payOffAmount2"];
    [aCoder encodeObject:@(self.payOffRate) forKey:@"payOffRate"];
    [aCoder encodeObject:@(self.payOffRate2) forKey:@"payOffRate2"];
    
    
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.totalIssue=[[aDecoder decodeObjectForKey:@"totalIssue"] integerValue];
        self.startBeiShu =[[aDecoder decodeObjectForKey:@"startBeiShu"] integerValue];
        self.isStop =[[aDecoder decodeObjectForKey:@"isStop"] integerValue];
        self.type =[[aDecoder decodeObjectForKey:@"type"] integerValue];
        self.issue =[[aDecoder decodeObjectForKey:@"issue"] integerValue];
        self.beiShu =[[aDecoder decodeObjectForKey:@"beiShu"] integerValue];
        self.beiShu2 =[[aDecoder decodeObjectForKey:@"beiShu2"] integerValue];
        self.payOffAmount =[[aDecoder decodeObjectForKey:@"payOffAmount"] integerValue];
        self.payOffAmount2=[[aDecoder decodeObjectForKey:@"payOffAmount2"] integerValue];
        self.payOffRate =[[aDecoder decodeObjectForKey:@"payOffRate"] integerValue];
        self.payOffRate2 =[[aDecoder decodeObjectForKey:@"payOffRate2"] integerValue];
    }
    return self;
}
@end
