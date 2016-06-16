//
//  MethodMenuItem+JSK3.m
//  Caipiao
//
//  Created by GroupRich on 15/6/17.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "MethodMenuItem+JSK3.h"

@implementation MethodMenuItem (JSK3)

+ (NSArray *)generateMethodMenuItemsForJSK3:(NSInteger)lotteryId
{
    
    NSMutableArray *all = [[[NSMutableArray alloc] init] autorelease];
    
    //@"猜1个号就中奖"
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"猜一个号";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [JSKS_ITEM itemWithName:JSK3_CYGHJZJ
                                                         rule:@"选号|1-6|1"
                                                         tips:@"选择1个您认为一定会开出的号码，所选号码在开奖号码中出现，即中奖金4元"
                                                      minimum:1];
            item.lotteryId = lotteryId;
            item.methodId = 11;
            item.methodPrice=4;
            item.simpleName = @"猜1个号就中奖";
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (int i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
    }
    
    //   和值
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"和值";
        [all addObject:cat];
        [cat release];
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:JSK3_HZ
                                                           rule:@"选号|3-18|1"
                                                           tips:@"至少选择1个和值（3个号码之和）进行投注，所选和值与开奖的3个号码的和值相同即中奖，最高可中360元"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.methodId = 1;
            item.methodPrice=360;
            item.simpleName = @"和值";
            item.numbersStyle = kMethodNumbersStyle2;
            
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_)
            {
                NSInteger minMultiple = 23529;
                for (int i = 0; i < [betItems_ count]; i++)
                {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                    
                    NSArray *selectedNums = [item selectedNumbers];
                    for (NSNumber *num in selectedNums)
                    {
                            NSInteger curM = 23529;
                            switch (num.integerValue)
                            {
                                case 3:
                                case 18:
                                    curM=1111;
                                    break;
                                case 4:
                                case 17:
                                    curM=3333;
                                    break;
                                case 5:
                                case 16:
                                   curM=6667;
                                    break;
                                case 6:
                                case 15:
                                   curM=11111;
                                    break;
                                case 7:
                                case 14:
                                    curM=16667;
                                    break;
                                case 13:
                                case 8:
                                    curM=23529;
                                    break;
                                case 9:
                                case 12:
                                    curM=28571;
                                    break;
                                case 10:
                                case 11:
                                    curM=30769;
                                    break;
                                default:
                                    break;
                            }
                        if (curM<minMultiple)
                        {
                            minMultiple = curM;
                        }

                   }
                
               
                }

                item.limitMultiple = minMultiple;
            }];
            [cat addObject:item];
        }
    }
    //三不同号
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"三不同号";
        [all addObject:cat];
        [cat release];
        
        {
            MethodMenuItem *item0 = [MethodMenuItem itemWithName:JSK3_SBTH rule:@"" tips:@"" minimum:1];
            item0.lotteryId = lotteryId;
            item0.simpleName = @"三不同号";;
            item0.subItems = [NSMutableArray array];
            {
                MethodMenuItem *item = [MethodMenuItem itemWithName:@"三不同号标准"
                                                               rule:@"选号|1-6|3"
                                                               tips:@"从1～6中任选3个或多个号码，所选号码与开奖号码的3个号码相同即中奖，单注奖金60元"
                                                            minimum:3];
                item.lotteryId = lotteryId;
                item.methodId = 4;
                item.methodPrice=60;
                item.simpleName = @"三不同号标准";
                item.numbersStyle = kMethodNumbersStyle2;
                for (BetItem *one in item.betItems){
                    one.disableWeightOption = YES;
                }
                [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                    BetItem *item = [betItems_ objectAtIndex:0];
                    *betCount_ = MathC(item.count, 3);
                }];
                [item0.subItems addObject:item];
            }
            {
                MethodMenuItem *item = [JSKS_SBTHDT_Item itemWithName:@"三不同号胆拖"
                                                                 rule:@"胆码|1-6|1~2,拖码|1-6|1~5"
                                                                 tips:@"选1～2个胆码，选1～5个拖码，胆码加拖码不少于3个；选号与奖号相同即中奖，单注奖金60元"
                                                              minimum:3];
                item.lotteryId = lotteryId;
                item.simpleName = @"三不同号胆拖";
                item.methodId = 5;
                item.methodPrice=60;
                item.numbersStyle = kMethodNumbersStyle3;
                for (BetItem *one in item.betItems){
                    one.disableWeightOption = YES;
                }
                [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                    BetItem *itemDan = [betItems_ objectAtIndex:0];
                    BetItem *itemTuo = [betItems_ objectAtIndex:1];
                    int n1 = [itemDan count];
                    int n2 = [itemTuo count];
                    *betCount_ = MathC(n2, 3-n1) ;
                }];
                [item0.subItems addObject:item];
            }
            [cat addObject:item0];
        }
        
    }
    
    //三同号单选
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"三同号单选";
        [all addObject:cat];
        [cat release];
        {
//            MethodMenuItem *item = [MethodMenuItem itemWithName:JSK3_STHDX
//                                                          rule:@"选号|1-6|1"
//                                                          tips:@"对所有相同的三个号码（111、222、333、444、555、666） 进行投注，任意号码开出即中奖，单注奖金60元"
//                                                       minimum:1];
            JSKS_STHDX_Item *item = [JSKS_STHDX_Item itemWithName:JSK3_STHDX tips:@"对相同的三个号码（111、222、333、444、555、666）中的任意一个进行投注，所选号码开出即中奖，单注奖金360元" minimum:1];
            item.lotteryId = lotteryId;
            item.methodId = 3;
            item.methodPrice=360;
            item.simpleName = @"三同号单选";
            item.numbersStyle = kMethodNumbersStyle2;
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                
                for (NSInteger i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
    }
 
    
    //三同号通选
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"三同号通选";
        [all addObject:cat];
        [cat release];
        
        {
//            MethodMenuItem *item = [MethodMenuItem itemWithName:JSK3_STHTX
//                                                           rule:@"选号|1-6|1"
//                                                           tips:@"对所有相同的三个号码（111、222、333、444、555、666） 进行投注，任意号码开出即中奖，单注奖金60元"
//                                                        minimum:1];
         JSKS_STHTX_Item *item = [JSKS_STHTX_Item itemWithName:JSK3_STHTX tips:@"对所有相同的三个号码（111、222、333、444、555、666）进行投注，任意号码开出即中奖，单注奖金60元" minimum:1];
            item.simpleName = @"三同号通选";
            item.lotteryId = lotteryId;
            item.methodId = 2;
            item.methodPrice=60;
            item.numbersStyle = kMethodNumbersStyle2;
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (NSInteger i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
    }
      //三连号通选
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"三连号通选";
        [all addObject:cat];
        [cat release];
        //
        {
//            MethodMenuItem *item = [MethodMenuItem itemWithName:JSK3_SLHTX
//                                                           rule:@"选号|0-4|1"
//                                                           tips:@"对所有3个相连的号码（123、234、345、456）进行投注，任意号码开出即中奖，单注奖金15元"
//                                                        minimum:1];
            JSKS_SLHTX_Item *item = [JSKS_SLHTX_Item itemWithName:JSK3_SLHTX tips:@"对所有3个相连的号码（123、234、345、456）进行投注，任意号码开出即中奖，单注奖金15元" minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"三连号通选";
            item.methodId = 6;
            item.methodPrice=15;
            item.numbersStyle = kMethodNumbersStyle2;
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (NSInteger i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
    }
    // 二不同号
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"二不同号";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item0 = [MethodMenuItem itemWithName:JSK3_EBTH rule:@"" tips:@"" minimum:1];
            item0.lotteryId = lotteryId;
            item0.simpleName = @"二不同号";
            item0.subItems = [NSMutableArray array];
            //
            {
                MethodMenuItem *item = [MethodMenuItem itemWithName:@"二不同号标准"
                                                               rule:@"选号|1-6|2"
                                                               tips:@"从1～6中任选2个或多个号码，所选号码与开奖号码任意2个号码相同，即中奖12元"
                                                            minimum:2];
                item.lotteryId = lotteryId;
                item.simpleName = @"二不同号标准";
                item.methodId = 9;
                item.methodPrice=12;
                item.numbersStyle = kMethodNumbersStyle2;
                for (BetItem *one in item.betItems){
                    one.disableWeightOption = YES;
                }
                [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                    BetItem *item = [betItems_ objectAtIndex:0];
                    *betCount_ = MathC(item.count, 2);
                }];
                [item0.subItems addObject:item];
            }
            {
                JSKS_EBTHDT_Item *item = [JSKS_EBTHDT_Item itemWithName:@"二不同号胆拖"
                                                                   rule:@"胆码|1-6|1~1,拖码|1-6|1~5"
                                                                   tips:@"选1个胆码，选1～5个拖码，胆码加拖码不少于2个；选号与奖号任意2号相同即中奖，单注奖金12元"
                                                                minimum:2];
                item.lotteryId = lotteryId;
                item.simpleName = @"二不同号胆拖";
                item.methodId = 10;
                item.methodPrice=12;
                item.numbersStyle = kMethodNumbersStyle3;
                for (BetItem *one in item.betItems){
                    one.disableWeightOption = YES;
                }
                [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                    BetItem *item = [betItems_ objectAtIndex:0];
                    BetItem *item1 = [betItems_ objectAtIndex:1];
                    *betCount_ *= [item count]*[item1 count];
                }];
                [item0.subItems addObject:item];
            }
            
            [cat addObject:item0];
            
        }
    }
    //  二同号复选
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"二同号复选";
        [all addObject:cat];
        [cat release];
        //
        {
//            MethodMenuItem *item = [JSKS_ETHFX_Item itemWithName:JSK3_ETHFX
//                                                         rule:@"选号|1-6|1"
//                                                         tips:@"从11～66中任选1个或多个号码，选号与奖号（包含11～66，不限顺序）相同，即中奖22元"
//                                                      minimum:1];
            MethodMenuItem *item = [JSKS_ETHFX_Item itemWithName:JSK3_ETHFX tips:@"从11～66中任选1个或多个号码，选号与奖号（包含11～66，不限顺序）相同，即中奖22元" minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"二同号复选";
            item.methodId = 7;
            item.methodPrice=22;
            item.numbersStyle = kMethodNumbersStyle2;
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (NSInteger i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
    }
    //   二同号单选
    {
        
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"二同号单选";
        [all addObject:cat];
        [cat release];
        
        {
//            MethodMenuItem *item = [MethodMenuItem itemWithName:JSK3_ETHDX
//                                                           rule:@"同号|1-6|1,不同号|1-6|1"
//                                                           tips:@"选择1对相同号码（11,22,33,44,55,66）和1个不同号码(1,2,3,4,5,6)投注，选号与奖号相同，即中奖120元"
//                                                        minimum:2];
            JSKS_ETHDX_Item *item = [JSKS_ETHDX_Item itemWithName:JSK3_ETHDX tips:@"选择1对相同号码（11,22,33,44,55,66）和1个不同号码(1,2,3,4,5,6)投注，选号与奖号相同（顺序不限），即中奖120元" minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"二同号单选";
            item.methodId = 8;
            item.methodPrice=120;
            item.numbersStyle = kMethodNumbersStyle3;
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item0 = [betItems_ objectAtIndex:0];
                BetItem *item1= [betItems_ objectAtIndex:1];

                *betCount_ = [item0 count] *[item1 count];
            }];
            [cat addObject:item];
        }
    }

    
    return all;
}

@end
