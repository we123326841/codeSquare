//
//  MethodMenuItem+LeLiSSC.m
//  Caipiao
//
//  Created by danal-rich on 14-1-21.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MethodMenuItem+LeLiSSC.h"

@implementation MethodMenuItem (LeLiSSC)

enum LeiLiSSCSort {
    kLeiLiSSCDWD = 1,
    kLeLiSSCWXZX,
    kLeiLiSSCWXZuXuan120,
    
    kLeiLiSSCWXZuXuan60,
    kLeiLiSSCWXZuXuan30,
    kLeiLiSSCWXZuXuan20,
    
    kLeiLiSSCWXZuXuan10,
    kLeiLiSSCWXZuXuan5,
    kLeiLiSSCWXSMBDW,
    
    kLeiLiSSCWXEMBDW,
    kLeiLiSSCWMQWSX,
    kLeiLiSSCSXZX,
    
    kLeiLiSSCSXZuXuan24,
    kLeiLiSSCSXZuXuan12,
    kLeiLiSSCSXEMBDW,
    
    kLeiLiSSCQSZX,
    kLeiLiSSCQSZuSan,
    kLeiLiSSCQSZuLiu,
    
    kLeiLiSSCQSDXDS,
    kLeiLiSSCQSEMBDW,
    kLeiLiSSCQSYMBDW,
    
    kLeiLiSSCQSZuXuan_HZ,
    kLeiLiSSCQSZuXuan_BD,
    kLeiLiSSCHSZuXuan_BD,
    
    kLeiLiSSCHSZX,
    kLeiLiSSCHSZuSan,
    kLeiLiSSCHSZuLiu,
    
    kLeiLiSSCHSEMBDW,
    kLeiLiSSCHSYMBDW,
    kLeiLiSSCHSZuXuan_HZ,
    
    kLeiLiSSCHSDXDS,
    kLeiLiSSCHSZXKD,
    kLeiLiSSCHSHZWS,
    
    kLeiLiSSCHSTSH,
    kLeiLiSSCQEZX,
    kLeiLiSSCQEZuXuan,
    
    kLeiLiSSCQEZXKD,
    kLeiLiSSCHEZX,
    kLeiLiSSCHEZuXuan,
    
    kLeiLiSSCHEZXKD,
    kLeiLiSSCHEZXHZ,
    kLeiLiSSCHEDXDS,
    
    kLeiLiSSCYFFS,
    kLeiLiSSCHSCS,
    kLeiLiSSCSXBX,
    
    kLeiLiSSCSJFC,
};

+ (NSArray *)generateMethodMenuItemsForLeLiSSC:(NSInteger)lotteryId{
    NSMutableArray *all = [[[NSMutableArray alloc] init] autorelease];
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"五星直选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"五星直选"
                                                           rule:@"万|0-9|1,千|0-9|1,百|0-9|1,十|0-9|1,个|0-9|1"
                                                           tips:@"每位选1个号码为1注"
                                                        minimum:5];
            item.lotteryId = lotteryId;
            item.simpleName = @"复式";
            item.sortIndex = kLeLiSSCWXZX;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                for (NSInteger i = 0; i < [betItems_ count]; i++) {
                    BetItem *item = [betItems_ objectAtIndex:i];
                    *betCount_ *= [item count];
                }
            }];
            [cat addObject:item];
        }

    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"五星组选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SSC5XZuXuan120 itemWithName:@"五星组选120"
                                                           rule:@"选|0-9|5"
                                                           tips:@"任意5个号码为1注"
                                                        minimum:5];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选120";
            item.sortIndex = kLeiLiSSCWXZuXuan120;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 5);
            }];
            [cat addObject:item];
        }

        {
            MethodMenuItem *item = [CQSSC5XZuXuan itemWithName:@"五星组选60"
                                                          rule:@"二重|0-9|1,单|0-9|3"
                                                          tips:@"1个二重和3个单号为1注"
                                                       minimum:4];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选60";
            item.sortIndex = kLeiLiSSCWXZuXuan60;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                
                BetItem *itemChong = [betItems_ objectAtIndex:0];
                BetItem *itemDan = [betItems_ objectAtIndex:1];
                //            NSInteger chongCount = [itemChong selectedBallCount];
                NSInteger danCount = [itemDan selectedBallCount];
                
                BOOL equ = NO, intersect = NO;
                NSInteger sameCount = 0, differentCount = 0;
                [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
                
                Echo(@"danCount :%ld same:%ld diff:%ld", (long)danCount, (long)sameCount,(long)differentCount);
                NSInteger result = 0;
                //m 二重号, n 单号
                if (equ) {
                    Echo(@"equ");
                    //combin(m同,1)*combin(n-1,3)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 3);
                    
                } else if(intersect){
                    Echo(@"intersect");
                    //combin(m同,1)*combin(n-1,3)+combin(m异,1)*combin(n,3)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 3) + MathC(differentCount, 1)*MathC(danCount, 3);
                    
                } else {
                    Echo(@"no intersect");
                    //combin(m异,1)*combin(n,3)
                    result = MathC(differentCount, 1)*MathC(danCount, 3);
                    
                }
                
                *betCount_ = result;
                
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [CQSSC5XZuXuan itemWithName:@"五星组选30"
                                                          rule:@"二重|0-9|2,单|0-9|1"
                                                          tips:@"2个二重和1个单号为1注"
                                                       minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选30";
            item.sortIndex = kLeiLiSSCWXZuXuan30;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                
                BetItem *itemChong = [betItems_ objectAtIndex:0];
                BetItem *itemDan = [betItems_ objectAtIndex:1];
                NSInteger chongCount = [itemChong selectedBallCount];
                //            NSInteger danCount = [itemDan selectedBallCount];
                
                BOOL equ = NO, intersect = NO;
                NSInteger sameCount = 0, differentCount = 0;
                [itemDan compareTo:itemChong isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
                
                Echo(@"chongCount :%ld same:%ld diff:%ld", (long)chongCount, (long)sameCount,(long)differentCount);
                NSInteger result = 0;
                //m 二重号, n 单号
                if (equ) {
                    Echo(@"equ");
                    //combin(n同,1)*combin(m-1,2)
                    result = MathC(sameCount, 1)*MathC(chongCount-1, 2);
                    
                } else if(intersect){
                    Echo(@"intersect");
                    //combin(n同,1)*combin(m-1,2)+combin(n异,1)*combin(m,2)
                    result = MathC(sameCount, 1)*MathC(chongCount-1, 2) + MathC(differentCount, 1)*MathC(chongCount, 2);
                } else {
                    Echo(@"no intersect");
                    //combin(n异,1)*combin(m,2)
                    result = MathC(differentCount, 1)*MathC(chongCount, 2);
                }
                
                *betCount_ = result;
            }];
            [cat addObject:item];
        }
       {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"五星组选20"
                                                           rule:@"三重|0-9|1,单|0-9|2"
                                                           tips:@"1个三重和2个单号为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选20";
            item.sortIndex = kLeiLiSSCWXZuXuan20;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *itemChong = [betItems_ objectAtIndex:0];
                BetItem *itemDan = [betItems_ objectAtIndex:1];
                //            NSInteger chongCount = [itemChong selectedBallCount];
                NSInteger danCount = [itemDan selectedBallCount];
                
                BOOL equ = NO, intersect = NO;
                NSInteger sameCount = 0, differentCount = 0;
                [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
                
                Echo(@"danCount :%ld same:%ld diff:%ld", (long)danCount, (long)sameCount,(long)differentCount);
                NSInteger result = 0;
                //m/b 重号, n/a 单号
                if (equ) {
                    Echo(@"equ");
                    //COMBIN(b同,1)*COMBIN(a-1,2)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 2);
                    
                } else if(intersect){
                    Echo(@"intersect");
                    //COMBIN(b同,1)*COMBIN(b异,0)*COMBIN(a-1,2)+COMBIN(b同,0)*COMBIN(b异,1)*COMBIN(a-0,2)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 2) + MathC(differentCount, 1)*MathC(danCount, 2);
                    
                } else {
                    Echo(@"no intersect");
                    //COMBIN(b异,1)*COMBIN(a,2)
                    result = MathC(differentCount, 1)*MathC(danCount, 2);
                    
                }
                
                *betCount_ = result;
                
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"五星组选10"
                                                           rule:@"三重|0-9|1,二重|0-9|1"
                                                           tips:@"1个三重和1个二重为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选10";
            item.sortIndex = kLeiLiSSCWXZuXuan10;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *itemChong = [betItems_ objectAtIndex:0];
                BetItem *itemDan = [betItems_ objectAtIndex:1];
                //            NSInteger chongCount = [itemChong selectedBallCount];
                NSInteger danCount = [itemDan selectedBallCount];
                
                BOOL equ = NO, intersect = NO;
                NSInteger sameCount = 0, differentCount = 0;
                [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
                
                Echo(@"danCount :%ld same:%ld diff:%ld", (long)danCount, (long)sameCount,(long)differentCount);
                NSInteger result = 0;
                //m/b 重号, n/a 单号
                if (equ) {
                    Echo(@"equ");
                    //COMBIN(b同,1)*COMBIN(a-1,1)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 1);
                    
                } else if(intersect){
                    Echo(@"intersect");
                    //COMBIN(b同,1)*COMBIN(b异,0)*COMBIN(a-1,1)+COMBIN(b同,0)*COMBIN(b异,1)*COMBIN(a-0,1)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 1) + MathC(differentCount, 1)*MathC(danCount, 1);
                    
                } else {
                    Echo(@"no intersect");
                    //COMBIN(b,1)*COMBIN(a,1)
                    result = MathC(differentCount, 1)*MathC(danCount, 1);
                    
                }
                
                *betCount_ = result;
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"五星组选5"
                                                           rule:@"四重|0-9|1,单|0-9|1"
                                                           tips:@"1个四重和1个单号为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选5";
            item.sortIndex = kLeiLiSSCWXZuXuan5;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *itemChong = [betItems_ objectAtIndex:0];
                BetItem *itemDan = [betItems_ objectAtIndex:1];
                NSInteger chongCount = [itemChong selectedBallCount];
                NSInteger danCount = [itemDan selectedBallCount];
                
                BOOL equ = NO, intersect = NO;
                NSInteger sameCount = 0, differentCount = 0;
                [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
                
                Echo(@"danCount :%ld same:%ld diff:%ld", (long)danCount, (long)sameCount,(long)differentCount);
                NSInteger result = 0;
                //m/b 重号, n/a 单号
                if (equ) {
                    Echo(@"equ");
                    //COMBIN(b同,1)*COMBIN(a-1,1)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 1);
                    
                } else if(intersect){
                    Echo(@"intersect");
                    //COMBIN(b同,1)*COMBIN(b异,0)*COMBIN(a-1,1)+COMBIN(b同,0)*COMBIN(b异,1)*COMBIN(a-0,1)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 1) + MathC(differentCount, 1)*MathC(danCount, 1);
                    
                } else {
                    Echo(@"no intersect");
                    //COMBIN(b,1)*COMBIN(a,1)
                    result = MathC(chongCount, 1)*MathC(danCount, 1);
                    
                }
                
                *betCount_ = result;
            }];
            [cat addObject:item];
        }

    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"四星直选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SSC4XZhiXuan itemWithName:@"四星直选"
                                                           rule:@"千|0-9|1,百|0-9|1,十|0-9|1,个|0-9|1"
                                                           tips:@"每位选1个号码为1注"
                                                        minimum:4];
            item.lotteryId = lotteryId;
            item.simpleName = @"复式";
            item.sortIndex = kLeiLiSSCSXZX;
            [cat addObject:item];
        }
    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"四星组选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"四星组选24"
                                                           rule:@"选|0-9|4"
                                                           tips:@"任意4个号码为1注"
                                                        minimum:4];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选24";
            item.sortIndex = kLeiLiSSCSXZuXuan24;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 4);
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"四星组选12"
                                                           rule:@"二重|0-9|1,单|0-9|2"
                                                           tips:@"1个二重和2个单号为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选12";
            item.sortIndex = kLeiLiSSCSXZuXuan12;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *itemChong = [betItems_ objectAtIndex:0];
                BetItem *itemDan = [betItems_ objectAtIndex:1];
                NSInteger chongCount = [itemChong selectedBallCount];
                NSInteger danCount = [itemDan selectedBallCount];
                
                BOOL equ = NO, intersect = NO;
                NSInteger sameCount = 0, differentCount = 0;
                [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
                
                Echo(@"danCount :%ld same:%ld diff:%ld", (long)danCount, (long)sameCount,(long)differentCount);
                NSInteger result = 0;
                //m/b 重号, n/a 单号
                if (equ) {
                    Echo(@"equ");
                    //combin(b同,1)*combin(a-1,2)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 2);
                    
                } else if(intersect){
                    Echo(@"intersect");
                    //COMBIN(b同,1)*COMBIN(b异,0)*COMBIN(a-1,2)+COMBIN(b同,0)*COMBIN(b异,1)*COMBIN(a-0,2)
                    result = MathC(sameCount, 1)*MathC(danCount-1, 2) + MathC(differentCount, 1)*MathC(danCount, 2);
                    
                } else {
                    Echo(@"no intersect");
                    //combin(b,1)*combin(a,2)
                    result = MathC(chongCount, 1)*MathC(danCount, 2);
                    
                }
                
                *betCount_ = result;
                
            }];
            [cat addObject:item];
        }
    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"前三直选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SSCQSZhiXuan itemWithName:@"前三直选"
                                                           rule:@"万|0-9|1,千|0-9|1,百|0-9|1"
                                                           tips:@"每位选1个号码为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"复式";
            item.sortIndex = kLeiLiSSCQSZX;
            [cat addObject:item];
        }
    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"前三组选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"前三组三"
                                                           rule:@"选|0-9|2"
                                                           tips:@"任选2个号码为2注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"组三";
            item.sortIndex = kLeiLiSSCQSZuSan;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,2)*2;
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"前三组六"
                                                           rule:@"选|0-9|3"
                                                           tips:@"任选3个号码为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"组六";
            item.sortIndex = kLeiLiSSCQSZuLiu;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = *betCount_ < 3 ? 0 : MathC(*betCount_, 3);
            }];
            [cat addObject:item];
        }
        {
            //前三组选_和值
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"前三组选_和值"
                                                           rule:@"组选和值|1-26|1"
                                                           tips:@"万、千、百位的和值(不含豹子号)"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选和值";
            item.sortIndex = kLeiLiSSCQSZuXuan_HZ;
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
        {
            //前三组选_包胆
            MethodMenuItem *item = [SSCXuan1 itemWithName:@"前三组选_包胆"
                                                     rule:@"选|0-9|1"
                                                     tips:@"任选1个包胆号(不含豹子号)"
                                                  minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"包胆";
            item.sortIndex = kLeiLiSSCQSZuXuan_BD;
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
        cat.categoryName = @"后三直选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SSCHSZhiXuan itemWithName:@"后三直选"
                                                           rule:@"百|0-9|1,十|0-9|1,个|0-9|1"
                                                           tips:@"每位选1个号码为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"复式";
            item.sortIndex = kLeiLiSSCHSZX;
            [cat addObject:item];
        }
        {
            //后三直选_跨度
            MethodMenuItem *item = [SSCHSZhiXuanKD itemWithName:@"后三直选_跨度"
                                                           rule:@"选|0-9|1"
                                                           tips:@"选择最大与最小数的差值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"跨度";
            item.sortIndex = kLeiLiSSCHSZXKD;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    if ([num intValue] == 0) {
                        *betCount_ += 10;
                    }else if ([num intValue] == 1) {
                        *betCount_ += 54;
                    }else if ([num intValue] == 2) {
                        *betCount_ += 96;
                    }else if ([num intValue] == 3) {
                        *betCount_ += 126;
                    }else if ([num intValue] == 4) {
                        *betCount_ += 144;
                    }else if ([num intValue] == 5) {
                        *betCount_ += 150;
                    }else if ([num intValue] == 6) {
                        *betCount_ += 144;
                    }else if ([num intValue] == 7) {
                        *betCount_ += 126;
                    }else if ([num intValue] == 8) {
                        *betCount_ += 96;
                    }else {
                        *betCount_ += 54;
                    }
                }
            }];
            [cat addObject:item];
        }

    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"后三组选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"后三组三"
                                                           rule:@"选|0-9|2"
                                                           tips:@"任选2个号码为2注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"组三";
            item.sortIndex = kLeiLiSSCHSZuSan;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_,2)*2;
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [SSCHSZuLiu itemWithName:@"后三组六"
                                                           rule:@"选|0-9|3"
                                                           tips:@"任选3个号码为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"组六";
            item.sortIndex = kLeiLiSSCHSZuLiu;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = *betCount_ < 3 ? 0 : MathC(*betCount_, 3);
            }];
            [cat addObject:item];
        }
        {
            //后三组选_和值
            MethodMenuItem *item = [CCSHSZuXuanHeZhi itemWithName:@"后三组选_和值"
                                                           rule:@"组选和值|1-26|1"
                                                           tips:@"百、十、个位的和值(不含豹子号)"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"组选和值";
            item.sortIndex = kLeiLiSSCHSZuXuan_HZ;
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
        {
            //后三组选_包胆
            MethodMenuItem *item = [SSCXuan1 itemWithName:@"后三组选_包胆"
                                                     rule:@"选|0-9|1"
                                                     tips:@"任选1个包胆号(不含豹子号)"
                                                  minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"包胆";
            item.sortIndex = kLeiLiSSCHSZuXuan_BD;
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
//        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
//        cat.categoryName = @"后三其它";
//        [all addObject:cat];
//        [cat release];
//        {
//            //后三_和值尾数
//            MethodMenuItem *item = [MethodMenuItem itemWithName:@"后三_和值尾数"
//                                                           rule:@"选|0-9|1"
//                                                           tips:@"选择百、十、个之和的尾数"
//                                                        minimum:1];
//            item.lotteryId = lotteryId;
//            item.simpleName = @"和值尾数";
//            item.sortIndex = kLeiLiSSCHSHZWS;
//            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//                BetItem *item = [betItems_ objectAtIndex:0];
//                *betCount_ = [item count];
//            }];
//            [cat addObject:item];
//        }
        {
//            //后三特殊号
//            MethodMenuItem *item = [SSCTeSuHao itemWithName:@"后三特殊号"
//                                                       tips:@"选择特殊号码"
//                                                    minimum:1];
//            item.lotteryId = lotteryId;
//            item.simpleName = @"特殊号码";
//            item.sortIndex = kLeiLiSSCHSTSH;
//            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//                BetItem *item = [betItems_ objectAtIndex:0];
//                *betCount_ = [item count];
//            }];
//            [cat addObject:item];
        }
    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"二星直选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SSCHEZhiXuan itemWithName:@"后二直选"
                                                           rule:@"十|0-9|1,个|0-9|1"
                                                           tips:@"每位选1个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"后二(复式)";
            item.sortIndex = kLeiLiSSCHEZX;
            [cat addObject:item];
        }
        {
            //后二直选和值
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"后二直选和值"
                                                           rule:@"选|0-18|1"
                                                           tips:@"选择十、个位的和值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"后二和值";
            item.sortIndex = kLeiLiSSCHEZXHZ;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    if ([num intValue] == 0 || [num intValue] == 18) {
                        *betCount_ += 1;
                    }else if ([num intValue] == 1 || [num intValue] == 17) {
                        *betCount_ += 2;
                    }else if ([num intValue] == 2 || [num intValue] == 16) {
                        *betCount_ += 3;
                    }else if ([num intValue] == 3 || [num intValue] == 15) {
                        *betCount_ += 4;
                    }else if ([num intValue] == 4 || [num intValue] == 14) {
                        *betCount_ += 5;
                    }else if ([num intValue] == 5 || [num intValue] == 13) {
                        *betCount_ += 6;
                    }else if ([num intValue] == 6 || [num intValue] == 12) {
                        *betCount_ += 7;
                    }else if ([num intValue] == 7 || [num intValue] == 11) {
                        *betCount_ += 8;
                    }else if ([num intValue] == 8 || [num intValue] == 10) {
                        *betCount_ += 9;
                    }else if ([num intValue] == 9) {
                        *betCount_ += 10;
                    }
                }
            }];
            [cat addObject:item];
        }
        {
            //后二直选跨度
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"后二直选跨度"
                                                           rule:@"选|0-9|1"
                                                           tips:@"后两位最大与最小数的差值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"后二跨度";
            item.sortIndex = kLeiLiSSCHEZXKD;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    if ([num intValue] == 0) {
                        *betCount_ += 10;
                    }else if ([num intValue] == 1) {
                        *betCount_ += 18;
                    }else if ([num intValue] == 2) {
                        *betCount_ += 16;
                    }else if ([num intValue] == 3) {
                        *betCount_ += 14;
                    }else if ([num intValue] == 4) {
                        *betCount_ += 12;
                    }else if ([num intValue] == 5) {
                        *betCount_ += 10;
                    }else if ([num intValue] == 6) {
                        *betCount_ += 8;
                    }else if ([num intValue] == 7) {
                        *betCount_ += 6;
                    }else if ([num intValue] == 8) {
                        *betCount_ += 4;
                    }else {
                        *betCount_ += 2;
                    }
                }
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [SSCQEZhiXuan itemWithName:@"前二直选"
                                                           rule:@"万|0-9|1,千|0-9|1"
                                                           tips:@"每位选1个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"前二(复式)";
            item.sortIndex = kLeiLiSSCQEZX;
            [cat addObject:item];
        }
        {
            //前二直选跨度
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"前二直选跨度"
                                                           rule:@"选|0-9|1"
                                                           tips:@"前两位最大与最小数的差值"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"前二跨度";
            item.sortIndex = kLeiLiSSCQEZXKD;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                NSArray *selectedNums = [item selectedNumbers];
                *betCount_ = 0;
                for (NSNumber *num in selectedNums) {
                    
                    if ([num intValue] == 0) {
                        *betCount_ += 10;
                    }else if ([num intValue] == 1) {
                        *betCount_ += 18;
                    }else if ([num intValue] == 2) {
                        *betCount_ += 16;
                    }else if ([num intValue] == 3) {
                        *betCount_ += 14;
                    }else if ([num intValue] == 4) {
                        *betCount_ += 12;
                    }else if ([num intValue] == 5) {
                        *betCount_ += 10;
                    }else if ([num intValue] == 6) {
                        *betCount_ += 8;
                    }else if ([num intValue] == 7) {
                        *betCount_ += 6;
                    }else if ([num intValue] == 8) {
                        *betCount_ += 4;
                    }else {
                        *betCount_ += 2;
                    }
                }
            }];
            [cat addObject:item];
        }

    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"二星组选";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"后二组选"
                                                           rule:@"选|0-9|2"
                                                           tips:@"选2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"后二(复式)";
            item.sortIndex = kLeiLiSSCHEZuXuan;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"前二组选"
                                                           rule:@"选|0-9|2"
                                                           tips:@"选2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"前二(复式)";
            item.sortIndex = kLeiLiSSCQEZuXuan;
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
        cat.categoryName = @"定位胆";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [SSC1XDWD itemWithName:@"定位胆"
                                                           rule:@"万|0-9|0,千|0-9|0,百|0-9|0,十|0-9|0,个|0-9|0"
                                                           tips:@"任意位选1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"定位胆";
            item.sortIndex = kLeiLiSSCDWD;
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
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"三星不定位";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"后三一码不定位"
                                                           rule:@"选|0-9|1"
                                                           tips:@"任选1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"后三一码不定位";
            item.sortIndex = kLeiLiSSCHSYMBDW;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
            }];
            [cat addObject:item];
        }
        {
            //后三二码不定位
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"后三二码不定位"
                                                           rule:@"选|0-9|2"
                                                           tips:@"任选2个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"后三二码不定位";
            item.sortIndex = kLeiLiSSCHSEMBDW;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"前三一码不定位"
                                                           rule:@"选|0-9|1"
                                                           tips:@"任选3个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"前三一码不定位";
            item.sortIndex = kLeiLiSSCQSYMBDW;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"前三二码不定位"
                                                           rule:@"不定位|0-9|2"
                                                           tips:@"任选2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"前三二码不定位";
            item.sortIndex = kLeiLiSSCQSEMBDW;
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
        cat.categoryName = @"四星不定位";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"四星二码不定位"
                                                           rule:@"不定位|0-9|2"
                                                           tips:@"任选2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"四星二码不定位";
            item.sortIndex = kLeiLiSSCSXEMBDW;
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
        cat.categoryName = @"五星不定位";
        [all addObject:cat];
        [cat release];
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"五星二码不定位"
                                                           rule:@"不定位|0-9|2"
                                                           tips:@"任选2个号码为1注"
                                                        minimum:2];
            item.lotteryId = lotteryId;
            item.simpleName = @"五星二码不定位";
            item.sortIndex = kLeiLiSSCWXEMBDW;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 2);
            }];
            [cat addObject:item];
        }
        {
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"五星三码不定位"
                                                           rule:@"不定位|0-9|3"
                                                           tips:@"任选3个号码为1注"
                                                        minimum:3];
            item.lotteryId = lotteryId;
            item.simpleName = @"五星三码不定位";
            item.sortIndex = kLeiLiSSCWXSMBDW;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
                *betCount_ = MathC(*betCount_, 3);
            }];
            [cat addObject:item];
        }

    }
    {
//        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
//        cat.categoryName = @"大小单双";
//        [all addObject:cat];
//        [cat release];
//        {
//            MethodMenuItem *item = [SSCDaXiaoDanShuang itemWithName:@"后二大小单双"
//                                                            weights:@[@"十",@"个"]
//                                                               tips:@"选择每1位的形态"
//                                                            minimum:2];
//            item.lotteryId = lotteryId;
//            item.simpleName = @"后二大小单双";
//            item.sortIndex = kLeiLiSSCHEDXDS;
//            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//                *betCount_ = 1;
//                for (NSInteger i = 0; i < [betItems_ count]; i++) {
//                    BetItem *item = [betItems_ objectAtIndex:i];
//                    *betCount_ *= [item count];
//                }
//            }];
//            [cat addObject:item];
//        }
//        {
//            //后三大小单双
//            MethodMenuItem *item = [SSCDaXiaoDanShuang itemWithName:@"后三大小单双"
//                                                            weights:@[@"百",@"十",@"个"]
//                                                               tips:@"选择每1位的形态"
//                                                            minimum:3];
//            item.lotteryId = lotteryId;
//            item.simpleName = @"后三大小单双";
//            item.sortIndex = kLeiLiSSCHSDXDS;
//            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//                BetItem *item1 = [betItems_ objectAtIndex:0];
//                BetItem *item2 = [betItems_ objectAtIndex:1];
//                BetItem *item3 = [betItems_ objectAtIndex:2];
//                *betCount_ = [item1 count] * [item2 count] * [item3 count];
//            }];
//            [cat addObject:item];
//        }
//        {
//            MethodMenuItem *item = [SSCDaXiaoDanShuang itemWithName:@"前三大小单双"
//                                                            weights:@[@"万",@"千",@"百"]
//                                                               tips:@"选择每1位的形态"
//                                                            minimum:3];
//            item.lotteryId = lotteryId;
//            item.simpleName = @"前三大小单双";
//            item.sortIndex = kLeiLiSSCQSDXDS;
//            [cat addObject:item];
//        }
    }
    {
//        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
//        cat.categoryName = @"趣味";
//        [all addObject:cat];
//        [cat release];
//        {
//            MethodMenuItem *item = [SSCQuWeiSanXing itemWithName:@"五码趣味三星"
//                                                            tips:@"每位选择1个为1注"
//                                                         minimum:5];
//            item.lotteryId = lotteryId;
//            item.simpleName = @"五码趣味三星";
//            item.sortIndex = kLeiLiSSCWMQWSX;
//            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//                *betCount_ = 1;
//                for (BetItem *item in betItems_){
//                    *betCount_ *= [item count];
//                }
//            }];
//            [cat addObject:item];
//        }
    }
    {
        MethodMenuItemCategory *cat = [[MethodMenuItemCategory alloc] init];
        cat.categoryName = @"特殊";
        [all addObject:cat];
        [cat release];
        {
            //一帆风顺
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"一帆风顺"
                                                           rule:@"选|0-9|1"
                                                           tips:@"任选1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"一帆风顺";
            item.sortIndex = kLeiLiSSCYFFS;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
            }];
            [cat addObject:item];
        }
        {
            //好事成双
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"好事成双"
                                                           rule:@"二重|0-9|1"
                                                           tips:@"任选1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"好事成双";
            item.sortIndex = kLeiLiSSCHSCS;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
            }];
            [cat addObject:item];
        }
        {
            //三星报喜
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"三星报喜"
                                                           rule:@"三重|0-9|1"
                                                           tips:@"任选1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"三星报喜";
            item.sortIndex = kLeiLiSSCSXBX;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
            }];
            [cat addObject:item];
        }
        {
            //四季发财
            MethodMenuItem *item = [MethodMenuItem itemWithName:@"四季发财"
                                                           rule:@"四重|0-9|1"
                                                           tips:@"任选1个号码为1注"
                                                        minimum:1];
            item.lotteryId = lotteryId;
            item.simpleName = @"四季发财";
            item.sortIndex = kLeiLiSSCSJFC;
            item.numbersStyle = kMethodNumbersStyle2;
            [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
                BetItem *item = [betItems_ objectAtIndex:0];
                *betCount_ = [item count];
            }];
            [cat addObject:item];
        }
        

    }

    return all;
}


@end
