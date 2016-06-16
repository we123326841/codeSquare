//
//  MethodMenuItem+SD11X5.m
//  Caipiao
//
//  Created by danal-rich on 14-1-21.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MethodMenuItem+SD11X5.h"

@implementation MethodMenuItem (SD11X5)

+ (NSArray *)generateMethodMenuItemsForSD11X5:(NSInteger)lotteryId{
    NSMutableArray *all = [[[NSMutableArray alloc] init] autorelease];
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"三码";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SD11X5QSZX itemWithName:QSZX
                                                       rule:@"第一位|1-11|1|%02d,第二位|1-11|1|%02d,第三位|1-11|1|%02d"
                                                       tips:@"每位选1个号码为1注"
                                                    minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"前三直选复式";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                //            a*b*c-(D12*c+D13*b+D23*a)-T123*[(a-1)+(b-1)+(c-1)+1]
                *betCount_ = 0;
                BetItem *it1 = [betItems_ objectAtIndex:0];
                BetItem *it2 = [betItems_ objectAtIndex:1];
                BetItem *it3 = [betItems_ objectAtIndex:2];
                NSInteger a = [it1 selectedBallCount];
                NSInteger b = [it2 selectedBallCount];
                NSInteger c = [it3 selectedBallCount];
                //第一位和第二位重号:D12    就是第一位跟第二位 都选取的状况有几个(但是不包含第一第二第三都选取的情况); T123就是三个都选取的状况
                NSInteger d12 = 0, d13 = 0, d23 = 0, t123 = 0;
                t123 = [BetItem sameCountInBetItems:betItems_];
                [it1 compareTo:it2 isEqual:NULL isIntersect:NULL sameCount:&d12 differentCount:NULL];
                [it1 compareTo:it3 isEqual:NULL isIntersect:NULL sameCount:&d13 differentCount:NULL];
                [it2 compareTo:it3 isEqual:NULL isIntersect:NULL sameCount:&d23 differentCount:NULL];
                d12 -= t123;
                d13 -= t123;
                d23 -= t123;
                
                //d12=2 d13=5 d23=3 t123=0 || d12 = 0  d13 = 3  d23 = 1   T123 = 2
                Echo(@"a=%d b=%d c=%d d12=%d d13=%d d23=%d t123=%d",a,b,c,d12,d13,d23,t123);
                *betCount_ = (a*b*c - (d12*c + d13*b + d23*a) - t123*((a-1) + (b-1) + (c-1) + 1));
                *betCount_ = MAX(*betCount_, 0);
                
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:QSZuXuan
                                                           rule:@"选|1-11|3|%02d"
                                                           tips:@"任选3个号码为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"前三组选复式";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,3);
            }];
            [cat addObject:item];
        }

    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"定位胆";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SD11X5DWD itemWithName:DWD
                                                           rule:@"第一位|1-11|0|%02d,第二位|1-11|0|%02d,第三位|1-11|0|%02d"
                                                           tips:@"每位选择1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"定位胆";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                *betCount_  = 0;
                for (NSInteger i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ += [item count];
                }
            }];
            [cat addObject:item];
        }
    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"任选复式";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:RX1Z1
                                                           rule:@"选|1-11|1|%02d"
                                                           tips:@"任选1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"任选一中一";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,1);
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:RX2Z2
                                                           rule:@"选|1-11|2|%02d"
                                                           tips:@"任选2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"任选二中二";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,2);
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:RX3Z3
                                                           rule:@"选|1-11|3|%02d"
                                                           tips:@"任选3个号码为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"任选三中三";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,3);
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:RX4Z4
                                                           rule:@"选|1-11|4|%02d"
                                                           tips:@"任选4个号码为1注"
                                                        minimum:4];
            item.lotteryId = lotteryId;
            item.simpleName = @"任选四中四";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,4);
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:RX5Z5
                                                           rule:@"选|1-11|5|%02d"
                                                           tips:@"任选5个号码为1注"
                                                        minimum:5];
            item.lotteryId = lotteryId;
            item.simpleName = @"任选五中五";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,5);
            }];
            [cat addObject:item];
        }

    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"任选胆拖";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SD11X5DT5 itemWithName:RX5Z5DT
                                                      rule:@"胆码|1-11|1|%02d,拖码|1-11|4|%02d"
                                                      tips:@"1个胆码和4个拖码为1注"
                                                   minimum:5];
            item.lotteryId = lotteryId;
            item.simpleName = @"任选五中五";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *itemDan = [betItems_ objectAtIndex:0];
                BetItem *itemTuo = [betItems_ objectAtIndex:1];
                NSInteger m = [itemDan count];
                NSInteger n = [itemTuo count];
                NSInteger x = 5;
                *betCount_ = MathC(n,x-m);
                if (m <1 || n < 4 ) *betCount_ = 0;
            }];
            [cat addObject:item];
        }

    }
    
    return all;
}

@end
