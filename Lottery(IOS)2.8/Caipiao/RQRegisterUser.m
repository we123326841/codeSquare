//
//  RQRegisterUser.m
//  Caipiao
//
//  Created by cYrus on 13-10-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQRegisterUser.h"
#import "JSONKit.h"

@implementation UpEditUserModelHigh

- (id)init{
    self = [super init];
    if (self) {
        [self clear];
    }
    return self;
}

- (void)clear
{
    _flag = @"rapid";
    _accord_lottery_point = 0.f;
    _accord_indefinite_point = 0.f;
    _points = [[NSMutableArray alloc] init];
    _lotterys = [[NSMutableArray alloc] init];
}

- (void)addPointOfLotteryid:(NSString *)lotteryid
                     OfType:(NSString *)type
                       OfPg:(NSInteger)pg
                 OfMinPoint:(CGFloat)min_point
                 OfMaxPoint:(CGFloat)max_point
                    OfPoint:(CGFloat)point
       OfMinIndefinitePoint:(CGFloat)min_indefinite_point
       OfMaxIndefinitePoint:(CGFloat)max_indefinite_point
          OfIndefinitePoint:(CGFloat)indefinite_point
{
    NSMutableDictionary *p = UpEditUserPointHigh;
    //[p setValue:[NSString stringWithFormat:@"%d", lotteryid] forKey:@"lotteryid"];
    min_point = min_point < 0 ? 0 : min_point;
    max_point = max_point < 0 ? 0 : max_point;
    point = point < 0?0:point;
    min_indefinite_point = min_indefinite_point < 0 ? 0 : min_indefinite_point;
    max_indefinite_point = max_indefinite_point < 0 ? 0 : max_indefinite_point;
    indefinite_point = indefinite_point < 0 ? 0 : indefinite_point;
    
    [p setValue:type forKey:@"type"];
    [p setValue:[NSString stringWithFormat:@"%ld", (long)pg] forKey:@"pg"];
    [p setValue:[NSString stringWithFormat:@"%.1f", min_point] forKey:@"min_point"];
    [p setValue:[NSString stringWithFormat:@"%.1f", max_point] forKey:@"max_point"];
    [p setValue:[NSString stringWithFormat:@"%.1f", point] forKey:@"point"];
    [p setValue:[NSString stringWithFormat:@"%.1f", min_indefinite_point] forKey:@"min_indefinite_point"];
    [p setValue:[NSString stringWithFormat:@"%.1f", max_indefinite_point] forKey:@"max_indefinite_point"];
    [p setValue:[NSString stringWithFormat:@"%.1f", indefinite_point] forKey:@"indefinite_point"];
    
    [_lotterys addObject:lotteryid];
    [_points addObject:p];
}

@end

@implementation UpEditUserModelLow

- (id)init{
    self = [super init];
    if (self) {
        [self clear];
    }
    return self;
}

- (void)clear
{
    _flag = @"insert";
    _accord_point = 0.f;
    _selectall = @"on";
    _points = [[NSMutableArray alloc] init];
    _method = [[NSMutableArray alloc] init];
}

- (void)addPointOfMethodid:(NSString *)methodid
                OfMinPoint:(CGFloat)minpoint
                OfMaxPoint:(CGFloat)maxpoint
                   OfPoint:(CGFloat)point
{
    minpoint = minpoint < 0 ? 0 : minpoint;
    maxpoint = maxpoint < 0 ? 0 : maxpoint;
    point = point < 0 ? 0 : point;
    
    NSMutableDictionary *p = UpEditUserPointLow;
    //[p setValue:[NSString stringWithFormat:@"%d", lotteryid] forKey:@"lotteryid"];
    [p setValue:methodid forKey:@"methodid"];
    [p setValue:[NSString stringWithFormat:@"%.1f", minpoint] forKey:@"minpoint"];
    [p setValue:[NSString stringWithFormat:@"%.1f", maxpoint] forKey:@"maxpoint"];
    [p setValue:[NSString stringWithFormat:@"%.1f", point] forKey:@"point"];
    
    [_method addObject:methodid];
    [_points addObject:p];
}

@end

#pragma mark - RQ implementation

@implementation RQRegisterUser

- (id)init
{
    self = [super init];
    if (self) {
        self.url = kUrlRegisterUser;
        [self setValue:@"insert" forField:@"flag"];
    }
    return self;
}

- (void)setUsername:(NSString *)username
{
    [_username release];
    _username=[username copy];
    [self setValue:_username forField:@"username"];
}

- (void)setUserpass:(NSString *)userpass
{
    [_userpass release];
    _userpass=[userpass copy];
    [self setValue:_userpass forField:@"userpass"];
}

- (void)setUsertype:(NSString *)usertype
{
    [_usertype release];
    _usertype=[usertype copy];
    [self setValue:_usertype forField:@"usertype"];
}

- (void)setNickname:(NSString *)nickname
{
    [_nickname release];
    _nickname=[nickname copy];
    [self setValue:_nickname forField:@"nickname"];
}

- (void)parse:(id)result
{
    Echo(@"%@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        self.status=[result stringForKey:@"status"];
        self.uid=[result stringForKey:@"uid"];
    }
}

@end


