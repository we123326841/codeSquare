//
//  MethodMenuItem+P5.m
//  Caipiao
//
//  Created by GroupRich on 15/4/1.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "MethodMenuItem+P5.h"

@implementation MethodMenuItem (P5)
+ (NSArray *)generateMethodMenuItemsForP5:(NSInteger)lotteryId
{
    NSMutableArray *all = [[[NSMutableArray alloc] init] autorelease];
    
//@"P5后二(直选)"
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P5后二(直选)";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [P5H2_FS_Item itemWithName:P5H2_FS
                                                      rule:@"十|0-9|1,个|0-9|1"
                                                      tips:@"每位选1个号码为1注"
                                                   minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"直选复式";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (int i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P5H2_HZ
                                                           rule:@"和值|0-18|1"
                                                           tips:@"至少选择一个和值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"直选和值";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 0:
                        case 18:
                            *betCount_ += 1;
                            break;
                        case 1:
                        case 17:
                            *betCount_ += 2;
                            break;
                        case 2:
                        case 16:
                            *betCount_ += 3;
                            break;
                        case 3:
                        case 15:
                            *betCount_ += 4;
                            break;
                        case 4:
                        case 14:
                            *betCount_ += 5;
                            break;
                        case 5:
                        case 13:
                            *betCount_ += 6;
                            break;
                        case 6:
                        case 12:
                            *betCount_ += 7;
                            break;
                        case 7:
                        case 11:
                            *betCount_ += 8;
                            break;
                        case 8:
                        case 10:
                            *betCount_ += 9;
                            break;
                        case 9:
                            *betCount_ += 10;
                            break;
                        default:
                            break;
                    }
                }
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P5H2_KD
                                                           rule:@"选|0-9|1"
                                                           tips:@"后两位最大与最小数的差值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"跨度";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 0:
                            *betCount_ += 10;
                            break;
                        case 1:
                            *betCount_ += 18;
                            break;
                        case 2:
                            *betCount_ += 16;
                            break;
                        case 3:
                            *betCount_ += 14;
                            break;
                        case 4:
                            *betCount_ += 12;
                            break;
                        case 5:
                            *betCount_ += 10;
                            break;
                        case 6:
                            *betCount_ += 8;
                            break;
                        case 7:
                            *betCount_ += 6;
                            break;
                        case 8:
                            *betCount_ += 4;
                            break;
                        case 9:
                            *betCount_ += 2;
                            break;
                        default:
                            break;
                    }
                }

            }];
            [cat addObject:item];
        }
        
    }
    
//    @"P5后二(组选)";
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P5后二(组选)";
        [all addObject:cat];
        [cat release];
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P5H2_ZXFS
                                                           rule:@"选|0-9|2"
                                                           tips:@"任意2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选复式";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = 1*MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P5H2_ZXHZ
                                                           rule:@"选|1-17|1"
                                                           tips:@"从1-17中选择1个号码。"
                                                        minimum:1];
            item.simpleName = @"组选和值";
            item.lotteryId = lotteryId;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 1:
                        case 2:
                        case 16:
                        case 17:
                            *betCount_ += 1;
                            break;
                        case 3:
                        case 4:
                        case 14:
                        case 15:
                            *betCount_ += 2;
                            break;
                        case 5:
                        case 6:
                        case 12:
                        case 13:
                            *betCount_ += 3;
                            break;
                        case 7:
                        case 8:
                        case 10:
                        case 11:
                            *betCount_ += 4;
                            break;
                        case 9:
                            *betCount_ += 5;
                            break;
                        default:
                                break;
                        }
                    }
            }];
            [cat addObject:item];
        }
        {
            //组选包胆
            MethodMenuItem *item = [P5HE_ZXBD_Item itemWithName:P5H2_ZXBD
                                                     rule:@"选|0-9|1"
                                                     tips:@"从0-9中选择1个号码。"
                                                  minimum:1];
            item.simpleName=@"组选包胆";
            item.lotteryId = lotteryId;
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count] * 9;
            }];
            [cat addObject:item];
        }
    }
//定位胆
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P5一星";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [P5YX_DWD_Item itemWithName:P5_DWD
                                                     rule:@"万|0-9|0,千|0-9|0,百|0-9|0,十|0-9|0,个|0-9|0"
                                                     tips:@"任意位选1个号码为1注"
                                                  minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"定位胆";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                *betCount_ = 0;
                for (NSInteger i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ += [item count];
                }
            }];
            [cat addObject:item];
        }
    }
//P3三星直选复式
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P3三星(直选)";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3SX_FS
                                                           rule:@"万|0-9|1,千|0-9|1,百|0-9|1"
                                                           tips:@"每位选1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"直选复式";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (int i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
        
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3SX_HZ
                                                           rule:@"和值|0-27|1"
                                                           tips:@"至少选择一个和值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"直选和值";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 0:
                        case 27:
                            *betCount_ += 1;
                            break;
                        case 1:
                        case 26:
                            *betCount_ += 3;
                            break;
                        case 2:
                        case 25:
                            *betCount_ += 6;
                            break;
                        case 3:
                        case 24:
                            *betCount_ += 10;
                            break;
                        case 4:
                        case 23:
                            *betCount_ += 15;
                            break;
                        case 5:
                        case 22:
                            *betCount_ += 21;
                            break;
                        case 6:
                        case 21:
                            *betCount_ += 28;
                            break;
                        case 7:
                        case 20:
                            *betCount_ += 36;
                            break;
                        case 8:
                        case 19:
                            *betCount_ += 45;
                            break;
                        case 9:
                        case 18:
                            *betCount_ += 55;
                            break;
                        case 10:
                        case 17:
                            *betCount_ += 63;
                            break;
                        case 11:
                        case 16:
                            *betCount_ += 69;
                            break;
                        case 12:
                        case 15:
                            *betCount_ += 73;
                            break;
                        case 13:
                        case 14:
                            *betCount_ += 75;
                            break;
                        default:
                            break;
                    }
                }
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3SX_KD
                                                           rule:@"选|0-9|1"
                                                           tips:@"前三位最大与最小数的差值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.numbersStyle=kMethodNumbersStyle2;
            item.simpleName = @"跨度";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 0:
                            *betCount_ += 10;
                            break;
                        case 1:
                            *betCount_ += 54;
                            break;
                        case 2:
                            *betCount_ += 96;
                            break;
                        case 3:
                            *betCount_ += 126;
                            break;
                        case 4:
                            *betCount_ += 144;
                            break;
                        case 5:
                            *betCount_ += 150;
                            break;
                        case 6:
                            *betCount_ += 144;
                            break;
                        case 7:
                            *betCount_ += 126;
                            break;
                        case 8:
                            *betCount_ += 96;
                            break;
                        case 9:
                            *betCount_ += 54;
                            break;
                        default:
                            break;
                    }
                }
                
            }];
            [cat addObject:item];
        }

    }
//P3三星(组选)
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P3三星(组选)";
        [all addObject:cat];
        [cat release];

        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3SX_ZXHZ
                                                           rule:@"组选和值|1-26|1"
                                                           tips:@"从1-26中选择1个号码。"
                                                        minimum:1];
            item.simpleName = @"组选和值";
            item.lotteryId = lotteryId;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 1:
                        case 26:
                            *betCount_ += 1;
                            break;
                        case 2:
                        case 3:
                        case 24:
                        case 25:
                            *betCount_ += 2;
                            break;
                        case 4:
                        case 23:
                            *betCount_ += 4;
                            break;
                        case 5:
                        case 22:
                            *betCount_ += 5;
                            break;
                        case 6:
                        case 21:
                            *betCount_ += 6;
                            break;
                        case 7:
                        case 20:
                            *betCount_ += 8;
                            break;
                        case 8:
                        case 19:
                            *betCount_ += 10;
                            break;
                        case 9:
                        case 18:
                            *betCount_ += 11;
                            break;
                        case 10:
                        case 17:
                            *betCount_ += 13;
                            break;
                        case 11:
                        case 12:
                        case 15:
                        case 16:
                            *betCount_ += 14;
                            break;
                        case 13:
                        case 14:
                            *betCount_ += 15;
                            break;
                        default:
                            break;
                    }
                }
            }];
            [cat addObject:item];
        }
        
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3SX_Z3
                                                           rule:@"选|0-9|2"
                                                           tips:@"任意2个号码为2注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"组三";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = 2*MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3SX_Z6
                                                           rule:@"选|0-9|3"
                                                           tips:@"任意3个号码为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"组六";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 3);
            }];
            [cat addObject:item];
        }
        //
        {
            MethodMenuItem *item = [P3SX_ZXBD_Item itemWithName:P3SX_ZXBD
                                                     rule:@"选|0-9|1"
                                                     tips:@"任选1个包胆号(不含豹子号)"
                                                  minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选包胆";
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count] * 54;
            }];
            [cat addObject:item];
        }


    }
    
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"不定位";
        [all addObject:cat];
        [cat release];
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3SX_YMBDW
                                                    rule:@"选|0-9|1"
                                                    tips:@"任选1个号码为1注"
                                                 minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"一码不定位";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 1);
            }];
            [cat addObject:item];
        }
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3SX_EMBDW
                                                           rule:@"选|0-9|2"
                                                           tips:@"任意2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"二码不定位";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }
        
    }
//    @"P3前二(直选)"
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P3前二(直选)";
        [all addObject:cat];
        [cat release];
        //
        {
            MethodMenuItem *item = [P3QE_FS_Item itemWithName:P3QE_FS
                                                        rule:@"万|0-9|1,千|0-9|1"
                                                        tips:@"各选1个号码为1注"
                                                     minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"直选复式";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (int i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
//        //
//        {
//            MethodMenuItem *item = [MethodMenuItem itemWithName:P3QE_HZ
//                                                           rule:@"选|0-9|2"
//                                                           tips:@"任意2个号码为1注"
//                                                        minimum:2];
//            item.lotteryId = lotteryId;
//            item.simpleName = @"直选和值";
//            item.numbersStyle = kMethodNumbersStyle2;
//            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//                BetItem *item = [betItems_ objectAtIndex:0];
//                *betCount_ = [item count];
//                *betCount_ = MathC(*betCount_, 2);
//            }];
//            [cat addObject:item];
//        }
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3QE_HZ
                                                           rule:@"和值|0-18|1"
                                                           tips:@"至少选择一个和值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"直选和值";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 0:
                        case 18:
                            *betCount_ += 1;
                            break;
                        case 1:
                        case 17:
                            *betCount_ += 2;
                            break;
                        case 2:
                        case 16:
                            *betCount_ += 3;
                            break;
                        case 3:
                        case 15:
                            *betCount_ += 4;
                            break;
                        case 4:
                        case 14:
                            *betCount_ += 5;
                            break;
                        case 5:
                        case 13:
                            *betCount_ += 6;
                            break;
                        case 6:
                        case 12:
                            *betCount_ += 7;
                            break;
                        case 7:
                        case 11:
                            *betCount_ += 8;
                            break;
                        case 8:
                        case 10:
                            *betCount_ += 9;
                            break;
                        case 9:
                            *betCount_ += 10;
                            break;
                        default:
                            break;
                    }
                }
            }];
            [cat addObject:item];
        }
        
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3QE_KD
                                                           rule:@"选|0-9|1"
                                                           tips:@"后两位最大与最小数的差值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"跨度";
            item.numbersStyle=kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 0:
                            *betCount_ += 10;
                            break;
                        case 1:
                            *betCount_ += 18;
                            break;
                        case 2:
                            *betCount_ += 16;
                            break;
                        case 3:
                            *betCount_ += 14;
                            break;
                        case 4:
                            *betCount_ += 12;
                            break;
                        case 5:
                            *betCount_ += 10;
                            break;
                        case 6:
                            *betCount_ += 8;
                            break;
                        case 7:
                            *betCount_ += 6;
                            break;
                        case 8:
                            *betCount_ += 4;
                            break;
                        case 9:
                            *betCount_ += 2;
                            break;
                        default:
                            break;
                    }
                }
                
            }];
            [cat addObject:item];
        }

    }
//    P3前二(组选)
    {
    
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P3前二(组选)";
        [all addObject:cat];
        [cat release];

        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3QE_ZXFS
                                                           rule:@"选|0-9|2"
                                                           tips:@"任选2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选复式";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,2);
            }];
            [cat addObject:item];
        }
        
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3QE_ZXHZ
                                                           rule:@"选|1-17|1"
                                                           tips:@"从1-17中选择1个号码。"
                                                        minimum:1];
            item.simpleName = @"组选和值";
            item.lotteryId = lotteryId;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 1:
                        case 2:
                        case 16:
                        case 17:
                            *betCount_ += 1;
                            break;
                        case 3:
                        case 4:
                        case 14:
                        case 15:
                            *betCount_ += 2;
                            break;
                        case 5:
                        case 6:
                        case 12:
                        case 13:
                            *betCount_ += 3;
                            break;
                        case 7:
                        case 8:
                        case 10:
                        case 11:
                            *betCount_ += 4;
                            break;
                        case 9:
                            *betCount_ += 5;
                            break;
                        default:
                            break;
                    }
                }
            }];
            [cat addObject:item];
        }
        
        {
            MethodMenuItem *item = [P3QE_ZXBD_Item itemWithName:P3QE_ZXBD
                                                     rule:@"选|0-9|1"
                                                     tips:@"从0-9中选择1个号码。"
                                                  minimum:1];
            item.simpleName=@"组选包胆";
            item.lotteryId = lotteryId;
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count] * 9;
            }];
            [cat addObject:item];
        }
    }
//    P3后二(直选)
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P3后二(直选)";
        [all addObject:cat];
        [cat release];
        {
            //
            {
                MethodMenuItem *item = [P3HE_FS_Item itemWithName:P3HE_FS
                                                               rule:@"千|0-9|1,百|0-9|1"
                                                               tips:@"各选1个号码为1注"
                                                            minimum:1];
                item.lotteryId = lotteryId;
                item.simpleName = @"直选复式";
                [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                    for (int i = 0; i < [betItems_ count]; i++) {
                        BetItem *item = [betItems_ objectAtIndex:i];
                        *betCount_ *= [item count];
                    }
                }];
                [cat addObject:item];
            }
            //
            
            //
            {
                MethodMenuItem *item = [MethodMenuItem itemWithName:P3HE_HZ
                                                               rule:@"和值|0-18|1"
                                                               tips:@"至少选择一个和值"
                                                            minimum:1];
                item.lotteryId = lotteryId;
                item.simpleName = @"直选和值";
                item.numbersStyle = kMethodNumbersStyle2;
                [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                    BetItem *item = [betItems_ objectAtIndex:0];
                    NSArray *selectedNums = [item selectedNumbers];
                    *betCount_ = 0;
                    for (NSNumber *num in selectedNums) {
                        
                        switch ([num intValue]) {
                            case 0:
                            case 18:
                                *betCount_ += 1;
                                break;
                            case 1:
                            case 17:
                                *betCount_ += 2;
                                break;
                            case 2:
                            case 16:
                                *betCount_ += 3;
                                break;
                            case 3:
                            case 15:
                                *betCount_ += 4;
                                break;
                            case 4:
                            case 14:
                                *betCount_ += 5;
                                break;
                            case 5:
                            case 13:
                                *betCount_ += 6;
                                break;
                            case 6:
                            case 12:
                                *betCount_ += 7;
                                break;
                            case 7:
                            case 11:
                                *betCount_ += 8;
                                break;
                            case 8:
                            case 10:
                                *betCount_ += 9;
                                break;
                            case 9:
                                *betCount_ += 10;
                                break;
                            default:
                                break;
                        }
                    }
                }];
                [cat addObject:item];
            }
            
            
            {
                MethodMenuItem *item = [MethodMenuItem itemWithName:P3HE_KD
                                                               rule:@"选|0-9|1"
                                                               tips:@"后两位最大与最小数的差值"
                                                            minimum:1];
                item.lotteryId = lotteryId;
                item.simpleName = @"跨度";
                item.numbersStyle=kMethodNumbersStyle2;
                [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                    BetItem *item = [betItems_ objectAtIndex:0];
                    NSArray *selectedNums = [item selectedNumbers];
                    *betCount_ = 0;
                    for (NSNumber *num in selectedNums) {
                        
                        switch ([num intValue]) {
                            case 0:
                                *betCount_ += 10;
                                break;
                            case 1:
                                *betCount_ += 18;
                                break;
                            case 2:
                                *betCount_ += 16;
                                break;
                            case 3:
                                *betCount_ += 14;
                                break;
                            case 4:
                                *betCount_ += 12;
                                break;
                            case 5:
                                *betCount_ += 10;
                                break;
                            case 6:
                                *betCount_ += 8;
                                break;
                            case 7:
                                *betCount_ += 6;
                                break;
                            case 8:
                                *betCount_ += 4;
                                break;
                            case 9:
                                *betCount_ += 2;
                                break;
                            default:
                                break;
                        }
                    }
                    
                }];
                [cat addObject:item];
            }

        }
    }
//    P3后二(组选)
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"P3后二(组选)";
        [all addObject:cat];
        [cat release];
        
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3HE_ZXFS
                                                           rule:@"选|0-9|2"
                                                           tips:@"任意2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选复式";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }
        
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:P3HE_ZXHZ
                                                           rule:@"选|1-17|1"
                                                           tips:@"从1-17中选择1个号码。"
                                                        minimum:1];
            item.simpleName = @"组选和值";
            item.lotteryId = lotteryId;
            item.numbersStyle=kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    switch ([num intValue]) {
                        case 1:
                        case 2:
                        case 16:
                        case 17:
                            *betCount_ += 1;
                            break;
                        case 3:
                        case 4:
                        case 14:
                        case 15:
                            *betCount_ += 2;
                            break;
                        case 5:
                        case 6:
                        case 12:
                        case 13:
                            *betCount_ += 3;
                            break;
                        case 7:
                        case 8:
                        case 10:
                        case 11:
                            *betCount_ += 4;
                            break;
                        case 9:
                            *betCount_ += 5;
                            break;
                        default:
                            break;
                    }
                }
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [P3HE_ZXBD_Item itemWithName:P3HE_ZXBD
                                                     rule:@"选|0-9|1"
                                                     tips:@"从0-9中选择1个号码。"
                                                  minimum:1];
            item.simpleName = @"组选包胆";
            item.lotteryId = lotteryId;
            for (BetItem *one in item.betItems){
                one.disableWeightOption = YES;
            }
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count] * 9;
            }];
            [cat addObject:item];
        }
        
    }
    return all;
}
@end
