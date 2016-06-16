//
//  MethodMenuItem+LeLi11X5.m
//  Caipiao
//
//  Created by danal-rich on 14-1-21.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MethodMenuItem+LeLi11X5.h"
#import "MethodMenuItem+SD11X5.h"

@implementation MethodMenuItem (LeLi11X5)

+ (NSArray *)generateMethodMenuItemsForLL11X5:(NSInteger)lotteryId{
    return [self generateMethodMenuItemsForSD11X5:lotteryId];
    /*
    NSMutableArray *all = [[[NSMutableArray alloc] init] autorelease];
    
    {
        MethodMenuItem *item = [SD11X5QSZX itemWithName:QSZX
                                                   rule:@"第一位|1-11|1|%02d,第二位|1-11|1|%02d,第三位|1-11|1|%02d"
                                                   tips:@"从第一位、第二位、第三位中至少各选择1个号码"
                                                minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            //            a*b*c-(D12*c+D13*b+D23*a)-T123*[(a-1)+(b-1)+(c-1)+1]
            *betCount_ = 0;
            BetItem *it1 = [betItems_ objectAtIndex:0];
            BetItem *it2 = [betItems_ objectAtIndex:1];
            BetItem *it3 = [betItems_ objectAtIndex:2];
            int a = [it1 selectedBallCount];
            int b = [it2 selectedBallCount];
            int c = [it3 selectedBallCount];
            //第一位和第二位重号:D12    就是第一位跟第二位 都选取的状况有几个(但是不包含第一第二第三都选取的情况); T123就是三个都选取的状况
            int d12 = 0, d13 = 0, d23 = 0, t123 = 0;
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
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:QSZuXuan
                                                       rule:@"选|1-11|3|%02d"
                                                       tips:@"从01-11中任意选择3个或3个以上号码"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_,3);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:DWD
                                                       rule:@"第一位|1-11|0|%02d,第二位|1-11|0|%02d,第三位|1-11|0|%02d"
                                                       tips:@"从第一位，第二位，第三位任意位置上任意选择1个或1个以上号码"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            *betCount_  = 0;
            for (int i = 0; i < [betItems_ count]; i++) {
                BetItem *item = [betItems_ objectAtIndex:i];
                *betCount_ += [item count];
            }
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:RX1Z1
                                                       rule:@"选|1-11|1|%02d"
                                                       tips:@"从01-11中任意选择1个或1个以上号码"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_,1);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:RX2Z2
                                                       rule:@"选|1-11|2|%02d"
                                                       tips:@"从01-11中任意选择2个或2个以上号码"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_,2);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:RX3Z3
                                                       rule:@"选|1-11|3|%02d"
                                                       tips:@"从01-11中任意选择3个或3个以上号码"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_,3);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:RX4Z4
                                                       rule:@"选|1-11|4|%02d"
                                                       tips:@"从01-11中任意选择4个或4个以上号码"
                                                    minimum:4];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_,4);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:RX5Z5
                                                       rule:@"选|1-11|5|%02d"
                                                       tips:@"从01-11中任意选择5个或5个以上号码"
                                                    minimum:5];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_,5);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [SD11X5DT5 itemWithName:RX5Z5DT
                                                  rule:@"胆码|1-11|1|%02d,拖码|1-11|4|%02d"
                                                  tips:@"从01-11中，选取2个及以上的号码进行投注，每注需至少包括1个胆码及4个拖码"
                                               minimum:5];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *itemDan = [betItems_ objectAtIndex:0];
            BetItem *itemTuo = [betItems_ objectAtIndex:1];
            int m = [itemDan count];
            int n = [itemTuo count];
            int x = 5;
            *betCount_ = MathC(n,x-m);
            if (m <1 || n < 4 ) *betCount_ = 0;
        }];
        [all addObject:item];
    }
    return all;
     */
}


@end
