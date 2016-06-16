//
//  MethodMenuItem+CQSSC.m
//  Caipiao
//
//  Created by danal-rich on 14-1-21.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MethodMenuItem+CQSSC.h"
#import "MethodMenuItem+LeLiSSC.h"

@implementation MethodMenuItem (CQSSC)

+ (NSArray *)generateMethodMenuItemsForCQSSC:(NSInteger)lotteryId{
    return [self generateMethodMenuItemsForLeLiSSC:lotteryId];
    ///////////////////////////////////////////////////////////////////
    /*
    NSMutableArray *all = [[[NSMutableArray alloc] init] autorelease];
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:WXZX
                                                       rule:@"万|0-9|1,千|0-9|1,百|0-9|1,十|0-9|1,个|0-9|1"
                                                       tips:@"每位至少选择一个号"
                                                    minimum:5];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            for (int i = 0; i < [betItems_ count]; i++) {
                BetItem *item = [betItems_ objectAtIndex:i];
                *betCount_ *= [item count];
            }
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [CQSSC5XZuXuan itemWithName:WXZuXuan60
                                                      rule:@"二重|0-9|1,单|0-9|3"
                                                      tips:@"从二重号选择一个号码，单号中选择三个号码组成一注"
                                                   minimum:4];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            
            BetItem *itemChong = [betItems_ objectAtIndex:0];
            BetItem *itemDan = [betItems_ objectAtIndex:1];
            //            int chongCount = [itemChong selectedBallCount];
            int danCount = [itemDan selectedBallCount];
            
            BOOL equ = NO, intersect = NO;
            int sameCount = 0, differentCount = 0;
            [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
            
            Echo(@"danCount :%d same:%d diff:%d", danCount, sameCount,differentCount);
            int result = 0;
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
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [CQSSC5XZuXuan itemWithName:WXZuXuan30
                                                      rule:@"二重|0-9|2,单|0-9|1"
                                                      tips:@"从二重号选择两个号码，单号中选择一个号码组成一注"
                                                   minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            
            BetItem *itemChong = [betItems_ objectAtIndex:0];
            BetItem *itemDan = [betItems_ objectAtIndex:1];
            int chongCount = [itemChong selectedBallCount];
            //            int danCount = [itemDan selectedBallCount];
            
            BOOL equ = NO, intersect = NO;
            int sameCount = 0, differentCount = 0;
            [itemDan compareTo:itemChong isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
            
            Echo(@"chongCount :%d same:%d diff:%d", chongCount, sameCount,differentCount);
            int result = 0;
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
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:SXZX
                                                       rule:@"千|0-9|1,百|0-9|1,十|0-9|1,个|0-9|1"
                                                       tips:@"每位至少选择一个号"
                                                    minimum:4];
        item.lotteryId = lotteryId;
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:QSZX
                                                       rule:@"万|0-9|1,千|0-9|1,百|0-9|1"
                                                       tips:@"每位至少选择一个号"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:HSZX
                                                       rule:@"百|0-9|1,十|0-9|1,个|0-9|1"
                                                       tips:@"每位至少选择一个号"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:DWD
                                                       rule:@"万|0-9|0,千|0-9|0,百|0-9|0,十|0-9|0,个|0-9|0"
                                                       tips:@"任意位置选择1个或1个以上号码"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            *betCount_ = 0;
            for (int i = 0; i < [betItems_ count]; i++) {
                BetItem *item = [betItems_ objectAtIndex:i];
                *betCount_ += [item count];
            }
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:QSZuSan
                                                       rule:@"选|0-9|2"
                                                       tips:@"任意选择2个或2个以上号码"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_,2)*2;
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:HSZuLiu
                                                       rule:@"选|0-9|3"
                                                       tips:@"任意选择3个或3个以上号码"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = *betCount_ < 3 ? 0 : MathC(*betCount_, 3);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:HEZX
                                                       rule:@"十|0-9|1,个|0-9|1"
                                                       tips:@"每位各选1个号码组成一注"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:QEZX
                                                       rule:@"万|0-9|1,千|0-9|1"
                                                       tips:@"每位各选1个号码组成一注"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:QSZuLiu
                                                       rule:@"选|0-9|3"
                                                       tips:@"任意选择3个或3个以上号码"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = *betCount_ < 3 ? 0 : MathC(*betCount_, 3);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:HSZuSan
                                                       rule:@"选|0-9|2"
                                                       tips:@"任意选择2个或2个以上号码"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_,2)*2;
        }];
        [all addObject:item];
    }
//    {
//        MethodMenuItem *item = [MethodMenuItem itemWithName:QSZuSan
//                                                       rule:@"选|0-9|2"
//                                                       tips:@"任意选择2个或2个以上号码"
//                                                    minimum:2];
//        item.lotteryId = lotteryId;
//        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//            BetItem *item = [betItems_ objectAtIndex:0];
//            *betCount_ = [item count];
//            *betCount_ = MathC(*betCount_,2)*2;
//        }];
//        [all addObject:item];
//    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:HEZuXuan
                                                       rule:@"选|0-9|2"
                                                       tips:@"任意选择2个或2个以上号码"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 2);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:QEZuXuan
                                                       rule:@"选|0-9|2"
                                                       tips:@"任意选择2个或2个以上号码"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 2);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:HSYMBDW
                                                       rule:@"选|0-9|1"
                                                       tips:@"任意选择1个以上号码"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:QSYMBDW
                                                       rule:@"选|0-9|1"
                                                       tips:@"任意选择1个以上号码"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
        }];
        [all addObject:item];
    }
//    {
//        MethodMenuItem *item = [MethodMenuItem itemWithName:DEFAULT1    //其他只有一个betItem的玩法
//                                                       rule:@"选|0-9|1"
//                                                       tips:@"任意选择1个以上号码"
//                                                    minimum:1];
//        item.lotteryId = lotteryId;
//        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//            BetItem *item = [betItems_ objectAtIndex:0];
//            *betCount_ = [item count];
//        }];
//        [all addObject:item];
//    }
    
    //v1.6
#pragma mark - Part 1
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:WXZuXuan120
                                                       rule:@"选|0-9|5"
                                                       tips:@"从0-9中选择5个号码组成一注"
                                                    minimum:5];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 5);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:WXZuXuan20
                                                       rule:@"三重|0-9|1,单|0-9|2"
                                                       tips:@"从“三重号”选择一个号码，“单号”中选择两个号码组成一注"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *itemChong = [betItems_ objectAtIndex:0];
            BetItem *itemDan = [betItems_ objectAtIndex:1];
            //            int chongCount = [itemChong selectedBallCount];
            int danCount = [itemDan selectedBallCount];
            
            BOOL equ = NO, intersect = NO;
            int sameCount = 0, differentCount = 0;
            [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
            
            Echo(@"danCount :%d same:%d diff:%d", danCount, sameCount,differentCount);
            int result = 0;
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
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:WXZuXuan10
                                                       rule:@"三重|0-9|1,二重|0-9|1"
                                                       tips:@"从“三重号”选择一个号码，“二重号”中选择一个号码组成一注"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *itemChong = [betItems_ objectAtIndex:0];
            BetItem *itemDan = [betItems_ objectAtIndex:1];
            //            int chongCount = [itemChong selectedBallCount];
            int danCount = [itemDan selectedBallCount];
            
            BOOL equ = NO, intersect = NO;
            int sameCount = 0, differentCount = 0;
            [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
            
            Echo(@"danCount :%d same:%d diff:%d", danCount, sameCount,differentCount);
            int result = 0;
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
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:WXZuXuan5
                                                       rule:@"四重|0-9|1,单|0-9|1"
                                                       tips:@"从“四重号”选择一个号码，“单号”中选择一个号码组成一注"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *itemChong = [betItems_ objectAtIndex:0];
            BetItem *itemDan = [betItems_ objectAtIndex:1];
            int chongCount = [itemChong selectedBallCount];
            int danCount = [itemDan selectedBallCount];
            
            BOOL equ = NO, intersect = NO;
            int sameCount = 0, differentCount = 0;
            [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
            
            Echo(@"danCount :%d same:%d diff:%d", danCount, sameCount,differentCount);
            int result = 0;
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
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:WXSMBDW
                                                       rule:@"不定位|0-9|3"
                                                       tips:@"从0-9中任意选择3个以上号码"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 3);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:WXEMBDW
                                                       rule:@"不定位|0-9|2"
                                                       tips:@"从0-9中任意选择2个以上号码"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 2);
        }];
        [all addObject:item];
    }
    {
//        MethodMenuItem *item = [SSCQuWeiSanXing itemWithName:WMQWSX
//                                                        tips:@"分别从万位与千位中各选择一个大小号属性，并从百位、十位、个位中至少各选1个号码组成一注"
//                                                     minimum:5];
//        item.lotteryId = lotteryId;
//        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//            *betCount_ = 1;
//            for (BetItem *item in betItems_){
//                *betCount_ *= [item count];
//            }
//        }];
//        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:SXZuXuan24
                                                       rule:@"选|0-9|4"
                                                       tips:@"从0-9中选择4个号码组成一注"
                                                    minimum:4];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 4);
        }];
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:SXZuXuan12
                                                       rule:@"二重|0-9|1,单|0-9|2"
                                                       tips:@"从“二重号”选择一个号码，“单号”中选择两个号码组成一注"
                                                    minimum:3];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *itemChong = [betItems_ objectAtIndex:0];
            BetItem *itemDan = [betItems_ objectAtIndex:1];
            int chongCount = [itemChong selectedBallCount];
            int danCount = [itemDan selectedBallCount];
            
            BOOL equ = NO, intersect = NO;
            int sameCount = 0, differentCount = 0;
            [itemChong compareTo:itemDan isEqual:&equ isIntersect:&intersect sameCount:&sameCount differentCount:&differentCount];
            
            Echo(@"danCount :%d same:%d diff:%d", danCount, sameCount,differentCount);
            int result = 0;
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
        [all addObject:item];
    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:SXEMBDW
                                                       rule:@"不定位|0-9|2"
                                                       tips:@"从0-9中任意选择2个以上号码"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 2);
        }];
        [all addObject:item];
    }
//    {
//        MethodMenuItem *item = [SSCDaXiaoDanShuang itemWithName:QSDXDS
//                                                        weights:@[@"万",@"千",@"百"]
//                                                           tips:@"从万位、千位、百位中的“大、小、单、双”中至少各选一个组成一注"
//                                                        minimum:3];
//        item.lotteryId = lotteryId;
//        [all addObject:item];
//    }
    {
        MethodMenuItem *item = [MethodMenuItem itemWithName:QSEMBDW
                                                       rule:@"不定位|0-9|2"
                                                       tips:@"从0-9中任意选择2个以上号码"
                                                    minimum:2];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 2);
        }];
        [all addObject:item];
    }
    
#pragma mark - Part 2
    {
        //前三组选_和值
        MethodMenuItem *item = [MethodMenuItem itemWithName:QSZX_HZ
                                                       rule:@"组选和值|1-26|1"
                                                       tips:@"从1-26中选择1个号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
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
        [all addObject:item];
    }
    {
        //前三组选_包胆
        MethodMenuItem *item = [SSCXuan1 itemWithName:QSZX_BD
                                                 rule:@"选|0-9|1"
                                                 tips:@"从0-9中选择1个号码。"
                                              minimum:1];
        item.lotteryId = lotteryId;
        for (BetItem *one in item.betItems){
            one.disableWeightOption = YES;
        }
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count] * 54;
        }];
        [all addObject:item];
    }
    {
        //后三组选_包胆
        MethodMenuItem *item = [SSCXuan1 itemWithName:HSZX_BD
                                                 rule:@"选|0-9|1"
                                                 tips:@"从0-9中选择1个号码。"
                                              minimum:1];
        item.lotteryId = lotteryId;
        for (BetItem *one in item.betItems){
            one.disableWeightOption = YES;
        }
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count] * 54;
        }];
        [all addObject:item];
    }
    {
        //后三二码不定位
        MethodMenuItem *item = [MethodMenuItem itemWithName:HSEMBDW
                                                       rule:@"选|0-9|2"
                                                       tips:@"从0-9中任意选择2个以上号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
            *betCount_ = MathC(*betCount_, 2);
        }];
        [all addObject:item];
    }
    {
        //后三组选_和值
        MethodMenuItem *item = [MethodMenuItem itemWithName:HSZX_HZ
                                                       rule:@"组选和值|1-26|1"
                                                       tips:@"从1-26中选择1个号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
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
        [all addObject:item];
    }
    {
//        //后三大小单双
//        MethodMenuItem *item = [SSCDaXiaoDanShuang itemWithName:HSDXDS
//                                                        weights:@[@"百",@"十",@"个"]
//                                                           tips:@"从百位、十位、个位中的“大、小、单、双”中至少各选一个组成一注。"
//                                                        minimum:3];
//        item.lotteryId = lotteryId;
//        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//            BetItem *item1 = [betItems_ objectAtIndex:0];
//            BetItem *item2 = [betItems_ objectAtIndex:1];
//            BetItem *item3 = [betItems_ objectAtIndex:2];
//            *betCount_ = [item1 count] * [item2 count] * [item3 count];
//        }];
//        [all addObject:item];
    }
    {
        //后三直选_跨度
        MethodMenuItem *item = [MethodMenuItem itemWithName:HSZX_KD
                                                       rule:@"选|0-9|1"
                                                       tips:@"从 0-9 中选择1个以上号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
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
        [all addObject:item];
    }
    {
//        //后三_和值尾数
//        MethodMenuItem *item = [MethodMenuItem itemWithName:HS_HZWS
//                                                       rule:@"选|0-9|1"
//                                                       tips:@"从0-9中选择1个号码。"
//                                                    minimum:1];
//        item.lotteryId = lotteryId;
//        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//            BetItem *item = [betItems_ objectAtIndex:0];
//            *betCount_ = [item count];
//        }];
//        [all addObject:item];
    }
    {
//        //后三特殊号
//        MethodMenuItem *item = [SSCTeSuHao itemWithName:HSTSH
//                                                   tips:@"选择一个号码形态。"
//                                                minimum:1];
//        item.lotteryId = lotteryId;
//        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//            BetItem *item = [betItems_ objectAtIndex:0];
//            *betCount_ = [item count];
//        }];
//        [all addObject:item];
    }
    {
        //前二直选跨度
        MethodMenuItem *item = [MethodMenuItem itemWithName:QEZXKD
                                                       rule:@"选|0-9|1"
                                                       tips:@"从0-9中选择1个号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
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
        [all addObject:item];
    }
    {
        //后二直选跨度
        MethodMenuItem *item = [MethodMenuItem itemWithName:HEZXKD
                                                       rule:@"选|0-9|1"
                                                       tips:@"从0-9中选择1个号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
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
        [all addObject:item];
    }
    {
        //后二直选和值
        MethodMenuItem *item = [MethodMenuItem itemWithName:HEZXHZ
                                                       rule:@"选|0-18|1"
                                                       tips:@"从0-18中任意选择1个或1个以上号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
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
        [all addObject:item];
    }
    {
//        MethodMenuItem *item = [SSCDaXiaoDanShuang itemWithName:HEDXDS
//                                                        weights:@[@"十",@"个"]
//                                                           tips:@"从十位、个位中的“大、小、单、双”中至少各选一个组成一注。"
//                                                        minimum:2];
//        item.lotteryId = lotteryId;
//        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
//            *betCount_ = 1;
//            for (int i = 0; i < [betItems_ count]; i++) {
//                BetItem *item = [betItems_ objectAtIndex:i];
//                *betCount_ *= [item count];
//            }
//        }];
//        [all addObject:item];
    }
    {
        //一帆风顺
        MethodMenuItem *item = [MethodMenuItem itemWithName:YFFS
                                                       rule:@"选|0-9|1"
                                                       tips:@"从0-9中任意选择1个以上号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
        }];
        [all addObject:item];
    }
    {
        //好事成双
        MethodMenuItem *item = [MethodMenuItem itemWithName:HSCS
                                                       rule:@"二重|0-9|1"
                                                       tips:@"从0-9中任意选择1个以上的二重号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
        }];
        [all addObject:item];
    }
    {
        //三星报喜
        MethodMenuItem *item = [MethodMenuItem itemWithName:SXBX
                                                       rule:@"三重|0-9|1"
                                                       tips:@"从0-9中任意选择1个以上的三重号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
        }];
        [all addObject:item];
    }
    {
        //四季发财
        MethodMenuItem *item = [MethodMenuItem itemWithName:SJFC
                                                       rule:@"四重|0-9|1"
                                                       tips:@"从0-9中任意选择1个以上的四重号码。"
                                                    minimum:1];
        item.lotteryId = lotteryId;
        [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
            BetItem *item = [betItems_ objectAtIndex:0];
            *betCount_ = [item count];
        }];
        [all addObject:item];
    }
    
    return all;
     */
}


@end
