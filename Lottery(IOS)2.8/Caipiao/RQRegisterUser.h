//
//  RQRegisterUser.h
//  Caipiao
//
//  Created by cYrus on 13-10-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

/*
 Request Model
 */

#define UpEditUserPointHigh [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"",@"pg":@"", @"min_point":@"", @"max_point":@"", @"point":@"", @"min_indefinite_point":@"", @"max_indefinite_point":@"", @"indefinite_point":@""}];
#define UpEditUserPointLow [NSMutableDictionary dictionaryWithDictionary:@{@"minpoint":@"", @"max_point":@"", @"point":@""}];

@interface UpEditUserModelHigh : NSObject

@property (copy , nonatomic) NSString *flag;
@property (copy , nonatomic) NSString *uid;
@property (assign , nonatomic) CGFloat accord_lottery_point;
@property (assign , nonatomic) CGFloat accord_indefinite_point;
@property (retain , nonatomic) NSMutableArray *lotterys;
@property (retain, nonatomic) NSMutableArray *points;

- (void)clear;
- (void)addPointOfLotteryid:(NSString *)lotteryid
                     OfType:(NSString *)type
                       OfPg:(NSInteger)pg
                 OfMinPoint:(CGFloat)min_point
                 OfMaxPoint:(CGFloat)max_point
                    OfPoint:(CGFloat)point
       OfMinIndefinitePoint:(CGFloat)min_indefinite_point
       OfMaxIndefinitePoint:(CGFloat)max_indefinite_point
          OfIndefinitePoint:(CGFloat)indefinite_point;

@end

@interface UpEditUserModelLow : NSObject

@property (copy , nonatomic) NSString *flag;
@property (copy , nonatomic) NSString *lotteryid;
@property (copy , nonatomic) NSString *uid;
@property (assign , nonatomic) CGFloat accord_point;

@property (assign , nonatomic) NSString * prizegroupselect;
@property (assign , nonatomic) NSString * prizegroup;

@property (retain , nonatomic) NSMutableArray *method;
@property (retain, nonatomic) NSMutableArray *points;

@property (assign , nonatomic) NSString *selectall;

- (void)clear;

- (void)addPointOfMethodid:(NSString *)methodid
                OfMinPoint:(CGFloat)minpoint
                OfMaxPoint:(CGFloat)maxpoint
                   OfPoint:(CGFloat)point;
@end


/*
 RQ Class
 */

@interface RQRegisterUser : RQBase

//Request
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *userpass;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *usertype;

//Reponse
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *uid;

@end

