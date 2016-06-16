//
//  MethodMenuItem+Low_3D.m
//  Caipiao
//
//  Created by cYrus_c on 14-3-5.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MethodMenuItem+Low_3D.h"
#import "MethodMenuItem+Factory.h"

@implementation MethodMenuItem (Low_3D)

+ (NSArray *)generateMethodMenuItemsForLow3D:(NSInteger)lotteryId
{
    NSMutableArray *all = [[[NSMutableArray alloc] init] autorelease];
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"直选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [ZhiXuan3D itemWithName:Low3D_ZX
                                                      rule:@"百|0-9|1,十|0-9|1,个|0-9|1"
                                                      tips:@"每位选1个号码为1注"
                                                   minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"直选";
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
            MethodMenuItem *item = [ZhiXuanHeZhi3D itemWithName:Low3D_ZXHZ
                                                           rule:@"和值|0-27|1"
                                                           tips:@"开奖3位数的和值"
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
    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"组选";
        [all addObject:cat];
        [cat release];
        //
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:Low3D_ZS
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
            MethodMenuItem *item = [MethodMenuItem itemWithName:Low3D_ZL
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
            MethodMenuItem *item = [ZuXuanHZ3D itemWithName:Low3D_ZuXHZ
                                                       rule:@"组选和值|1-26|1"
                                                       tips:@"开奖3位数的和值(不含豹子号)"
                                                    minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选和值";
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

    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"不定位";
        [all addObject:cat];
        [cat release];
        //
        {
            MethodMenuItem *item = [YMBDW3D itemWithName:Low3D_YMBDW
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
            MethodMenuItem *item = [MethodMenuItem itemWithName:Low3D_EMBDW
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
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"二码";
        [all addObject:cat];
        [cat release];
        //
        {
            MethodMenuItem *item = [QEZhiXuan3D itemWithName:Low3D_QEZX
                                                             rule:@"百|0-9|1,十|0-9|1"
                                                             tips:@"各选1个号码为1注"
                                                          minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"前二直选";
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
            MethodMenuItem *item = [MethodMenuItem itemWithName:Low3D_QEZuX
                                                             rule:@"选|0-9|2"
                                                             tips:@"任意2个号码为1注"
                                                          minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"前二组选";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }
        //
        {
            MethodMenuItem *item = [HEZhiXuan3D itemWithName:Low3D_HEZX
                                                             rule:@"十|0-9|1,个|0-9|1"
                                                             tips:@"各选1个号码为1注"
                                                          minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"后二直选";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (int i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:Low3D_HEZuX
                                                             rule:@"选|0-9|2"
                                                             tips:@"任意2个号码为1注"
                                                          minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"后二组选";
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }

    }
//    {
//        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
//        cat.categoryName = @"大小单双";
//        [all addObject:cat];
//        [cat release];
//        {
//            MethodMenuItem *item = [DXDS3D itemWithName:Low3D_QEDXDS
//                                                weights:@[@"百",@"十"]
//                                                   tips:@"选择百位、十位的形态"
//                                                minimum:1];
//            item.simpleName = @"前二大小单双";
//            item.lotteryId = lotteryId;
//            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//                for (int i = 0; i < [betItems_ count]; i++) {
//                    BetItem *item = [betItems_ objectAtIndex:i];
//                    *betCount_ *= [item count];
//                }
//            }];
//            [cat addObject:item];
//        }
//        {
//            MethodMenuItem *item = [DXDS3D itemWithName:Low3D_HEDXDS
//                                                weights:@[@"十",@"个"]
//                                                   tips:@"选择十位、个位的形态"
//                                                minimum:1];
//            item.simpleName = @"后二大小单双";
//            item.lotteryId = lotteryId;
//            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//                for (int i = 0; i < [betItems_ count]; i++) {
//                    BetItem *item = [betItems_ objectAtIndex:i];
//                    *betCount_ *= [item count];
//                }
//            }];
//            [cat addObject:item];
//        }
//
//    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"定位胆";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [DWD3D itemWithName:Low3D_DWDBW
                                                  rule:@"百|0-9|1"
                                                  tips:@"选择百位中奖号码"
                                               minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"百位";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                *betCount_ = 0;
                for (int i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ += [item count];
                }
            }];
            [cat addObject:item];
        }
        //
        {
            MethodMenuItem *item = [DWD3D itemWithName:Low3D_DWDSW
                                                  rule:@"十|0-9|1"
                                                  tips:@"选择十位中奖号码"
                                               minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"十位";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                *betCount_ = 0;
                for (int i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ += [item count];
                }
            }];
            [cat addObject:item];
        }
        //
        {
            MethodMenuItem *item = [DWD3D itemWithName:Low3D_DWDGW
                                                  rule:@"个|0-9|1"
                                                  tips:@"选择个位中奖号码"
                                               minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"个位";
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                *betCount_ = 0;
                for (int i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ += [item count];
                }
            }];
            [cat addObject:item];
        }

    }
    
    return all;
}

@end
