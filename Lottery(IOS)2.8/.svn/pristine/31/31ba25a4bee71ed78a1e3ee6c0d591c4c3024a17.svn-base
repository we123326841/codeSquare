//
//  RQUserPoint.m
//  Caipiao
//
//  Created by cYrus on 13-10-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQUserPoint.h"

@implementation RQUserPoint

- (id)init{
    self = [super init];
    if (self){
        self.url = kUrlUserPoint;
        _userPointArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parse:(NSDictionary *)result
{
    self.userPointDict = result;
//    if ([result isKindOfClass:[NSDictionary class]]) {
    
//        if ([result count] != 0) {
        
//            NSDictionary *lowDict = [result objectAtIndex:0];
//            NSDictionary *highDict = [result objectAtIndex:1];
//            
//            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init] ;
//            [dict setObject:[SharedModel formatBalance:[highDict stringForKey:@"amount"]]
//                     forKey:UPHighYesterdayBetting];
//            [dict setObject:[SharedModel formatBalance:[lowDict stringForKey:@"amount"]]
//                     forKey:UPLowYesterdayBetting];
//            [dict setObject:[SharedModel formatBalance:[highDict stringForKey:@"point"]]
//                     forKey:UPHighReturnPoint];
//            [dict setObject:[SharedModel formatBalance:[lowDict stringForKey:@"point"]]
//                     forKey:UPLowReturnPoint];
//            [dict setObject:[SharedModel formatBalance:[highDict stringForKey:@"win"]]
//                     forKey:UPHighYesterdayReward];
//            [dict setObject:[SharedModel formatBalance:[lowDict stringForKey:@"win"]]
//                     forKey:UPLowYesterdayReward];
            
//            self.userPointDict = [NSDictionary dictionaryWithDictionary:dict];
//            [dict release], dict = nil;
            
/*
            [self.userPointArray addObject:[highDict stringForKey:@"amount"] == nil ? @"" : [SharedModel formatBalance:[highDict stringForKey:@"amount"]]];
            
            [self.userPointArray addObject:[lowDict stringForKey:@"amount"] == nil ? @"" : [SharedModel formatBalance:[lowDict stringForKey:@"amount"]]];
            
            [self.userPointArray addObject:[highDict objectForKey:@"point"] == nil ? @"" : [highDict objectForKey:@"point"]];
            
            [self.userPointArray addObject:[lowDict objectForKey:@"point"] == nil ? @"" : [lowDict objectForKey:@"point"]];
            
            [self.userPointArray addObject:[highDict stringForKey:@"win"] == nil ? @"" : [SharedModel formatBalance:[highDict stringForKey:@"win"]]];
            
            [self.userPointArray addObject:[lowDict stringForKey:@"win"] == nil ? @"" : [SharedModel formatBalance:[lowDict stringForKey:@"win"]]];
 */
//        } else {
//            [self.userPointArray addObjectsFromArray:@[@"", @"", @"", @"", @"", @""]];
//        }
//        Echo(@"RQUserPoint self.userPointArray | %@",self.userPointArray);
//    }
}

- (void)dealloc
{
    RELEASE(_userPointArray);
    RELEASE(_userPointDict);
    [super dealloc];
}

@end
