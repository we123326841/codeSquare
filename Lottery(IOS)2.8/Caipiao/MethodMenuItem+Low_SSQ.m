//
//  MethodMenuItem+Low_SSQ.m
//  Caipiao
//
//  Created by danal-rich on 3/11/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BallItem.h"
#import "MethodMenuItem+Low_SSQ.h"

@implementation MethodMenuItem (SSQ)

+ (NSArray *)generateMethodMenuItemsForSSQ:(NSInteger)lotteryId{
    NSMutableArray *all = [[[NSMutableArray alloc] init] autorelease];
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"复式";
        [all addObject:cat];
        [cat release];
        //复式
        {
            MethodMenuItem *item = [SSQFuShi itemWithName:LowSSQ_FS
                                                     rule:@"红球|1-33|6|%02d,蓝球|1-16|1|%02d"
                                                     tips:@"选择6个红球1个蓝球"
                                                  minimum:7];
            item.lotteryId = lotteryId;
            item.simpleName = @"复式";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *itemRed = [betItems_ objectAtIndex:0];
                BetItem *itemBlue = [betItems_ objectAtIndex:1];
                int n1 = [itemRed count];
                int n2 = [itemBlue count];
                if (n2*n1 > 0)
                    *betCount_ = MathC(n1, 6) * MathC(n2, 1);
                else
                    *betCount_ = 0;
            }];
            [cat addObject:item];
        }
    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"胆拖";
        [all addObject:cat];
        [cat release];
        //胆拖
        {
            MethodMenuItem *item = [SSQDanTuo itemWithName:LowSSQ_DT
                                                      rule:@"胆码|1-33|1|%02d,拖码|1-33|1|%02d,蓝球|1-16|1|%02d"
                                                      tips:@"1~5胆码+11~7拖码+1篮球"
                                                   minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"胆拖";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *itemDan = [betItems_ objectAtIndex:0];
                BetItem *itemTuo = [betItems_ objectAtIndex:1];
                BetItem *itemBlue = [betItems_ objectAtIndex:2];
                int n1 = [itemDan count];
                int n2 = [itemTuo count];
                int n3 = [itemBlue count];
                if (n3*n2*n1 > 0)
                    *betCount_ = MathC(n2, 6-n1) * MathC(n3, 1);
                else
                    *betCount_ = 0;
            }];
            [cat addObject:item];
        }
    }
    
    return all;
}

@end


static NSString *randCode(int length){
    static char table[10] = "1234567890";
    NSMutableString *str = [NSMutableString string];
    int n = 0;
    while (n < length) {
        [str appendFormat:@"%c",table[arc4random()%10]];
        n++;
    }
    return str;
}

/*
  "红球区、蓝球区
 （红球最少6个、最多12个、机选范围为6～12）
 （蓝球最少1个、最多8个、机选范围为1～8）"
 */
@implementation SSQFuShi

- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    BetItem *itemRed = [self.betItems objectAtIndex:0];
    BetItem *itemBlue = [self.betItems objectAtIndex:1];

    if (item == itemRed){    //6~12
        [item trimSelectionsToLength:12];
    }
    else if(item == itemBlue){  //1~8
        [item trimSelectionsToLength:8];
    }
    
    [super onBetItemChanges:item option:option];
}

- (int)random1{
    int weight = 1;
    BetItem *itemRed = [self.betItems objectAtIndex:0];
    BetItem *itemBlue = [self.betItems objectAtIndex:1];
    
    [itemRed randomN:6];
    [itemBlue randomN:1];
    if (self.delegate){
        [self.delegate onMethodMenuItemChanges:self];
    }
    return weight;
}

- (NSString *)jointedNumbers{
    BetItem *itemRed = [self.betItems objectAtIndex:0];
    BetItem *itemBlue = [self.betItems objectAtIndex:1];
    
    NSString *numberRed = [itemRed serialize];
    NSString *numberBlue = [itemBlue serialize];
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"%@+%@",numberRed,numberBlue];
    return [str stringByReplacingOccurrencesOfString:@"&" withString:@","];;
}

- (void)configBetItems{
    BetItem *itemRed = [self.betItems objectAtIndex:0];
    itemRed.startRandomNum = 6;
    itemRed.endRandomNum = 12;
    BetItem *itemBlue = [self.betItems objectAtIndex:1];
    itemBlue.startRandomNum = 1;
    itemBlue.endRandomNum = 8;
    for (BallItem *bi in itemBlue.ballItems){
        bi.style = kBallStyleBlue;
    }
}

@end

/*
 "红球胆码区、红球拖码区、蓝球区
 （胆码最少1个、最多5个、没有机选功能）
 （拖码最少1个、机选范围为1～5）
 （胆码加拖码最少6个、最多12个）
 （蓝球最少1个、最多8个、机选范围为1～8）
    胆跟拖的号码不能重复
    机选已一注为主 "
 
 */
@implementation SSQDanTuo


- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    BetItem *itemDan = [self.betItems objectAtIndex:0];
    BetItem *itemTuo = [self.betItems objectAtIndex:1];
    BetItem *itemBlue = [self.betItems objectAtIndex:2];
    [itemBlue trimSelectionsToLength:8];

    if (option != kBetItemOptionNone && item == itemTuo) {
        //全大小单双时清空
        [itemDan reset];
    } else {
        if ([itemDan selectedBallCount] > 5){
            [itemDan trimSelectionsToLength:5];
        }
        if ([itemTuo selectedBallCount] > 11){
            [itemTuo trimSelectionsToLength:11];
        }
        
        //清空重复的号
        if (item == itemTuo){
            for (int n = itemTuo.startBall; n <= itemTuo.endBall; n++) {
                if ([itemTuo numberSelected:n]){
                    if ([itemDan numberSelected:n]){
                        [itemDan deselectNumber:n];
                    }
                }
            }
        }   //else
        else if(item == itemDan){
            for (int n = itemDan.startBall; n <= itemDan.endBall; n++) {
                if ([itemDan numberSelected:n]){
                    if ([itemTuo numberSelected:n]){
                        [itemTuo deselectNumber:n];
                    }
                }
            }
        }
    }

    
    if ([itemDan selectedBallCount] + [itemTuo selectedBallCount] > 12) {
        if ([itemDan selectedBallCount] > 0) {
            [itemTuo trimSelectionsToLength:12 - [itemDan selectedBallCount]];
        }else if ([itemTuo selectedBallCount] > 0) {
            [itemDan trimSelectionsToLength:12 - [itemTuo selectedBallCount]];
        }
    }

    [super onBetItemChanges:item option:option];
    Echo(@"SSQ_DT %d | %d", [itemDan selectedBallCount], [itemTuo selectedBallCount]);
}

- (int)random1{
    int weight = [self random1Unique];
    BetItem *itemDan = [self.betItems objectAtIndex:0];
    BetItem *itemTuo = [self.betItems objectAtIndex:1];
    NSArray *exceptNumbers = [itemDan selectedNumbers];
    [itemTuo randomN:5 exceptedNumbers:exceptNumbers];
    if (self.delegate){
        [self.delegate onMethodMenuItemChanges:self];
    }
    return weight;
}

- (NSString *)jointedNumbers{
    BetItem *itemDan = [self.betItems objectAtIndex:0];
    BetItem *itemTuo = [self.betItems objectAtIndex:1];
    BetItem *itemBlue = [self.betItems objectAtIndex:2];
    
    NSString *numberDan = [itemDan serialize];
    NSString *numberTuo = [itemTuo serialize];
    NSString *numberBlue = [itemBlue serialize];
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"D:%@_T:%@+%@",numberDan,numberTuo,numberBlue];
    return [str stringByReplacingOccurrencesOfString:@"&" withString:@","];
}

- (void)configBetItems{
    BetItem *itemDan = [self.betItems objectAtIndex:0];
    itemDan.startRandomNum = 1;
    itemDan.endRandomNum = 5;
    BetItem *itemTuo = [self.betItems objectAtIndex:1];
    itemTuo.startRandomNum = 5;
    itemTuo.endRandomNum = 11;
    BetItem *itemBlue = [self.betItems objectAtIndex:2];
    for (BallItem *bi in itemBlue.ballItems){
        bi.style = kBallStyleBlue;
    }
    itemBlue.startRandomNum = 1;
    itemBlue.endRandomNum = 8;
}

@end