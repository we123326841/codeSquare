//
//  MethodMenuItem+Factory.m
//  Caipiao
//
//  Created by danal on 13-8-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CDLottery.h"
#import "MethodMenuItem+Factory.h"
#import "MethodMenuItem+CQSSC.h"
#import "MethodMenuItem+SD11X5.h"
#import "MethodMenuItem+LeLiSSC.h"
#import "MethodMenuItem+LeLi11X5.h"
#import "MethodMenuItem+JLFFC.h"
#import "MethodMenuItem+Low_3D.h"
#import "MethodMenuItem+Low_SSQ.h"
#import "MethodMenuItem+JXSSC.h"
#import "MethodMenuItem+XJSSC.h"
#import "MethodMenuItem+TJSSC.m"
#import "MethodMenuItem+P5.h"
#import "MethodMenuItem+JSK3.h"
#import "BallItem.h"

@implementation MethodMenuItem (Sort)

+ (NSArray *)menuItemTitles:(int)lotteryId channelId:(int)chid{
    NSArray *all = [self getAll:lotteryId channelId:chid];
    //Sort
    NSArray *menuItems = [all sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        MethodMenuItem *a = obj1;
        MethodMenuItem *b = obj2;
        if (a.sortIndex == b.sortIndex)
            return NSOrderedSame;
        else if (a.sortIndex < b.sortIndex)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }];
    
    NSMutableArray *titles = [NSMutableArray array];
    for (MethodMenuItem *item in menuItems) {
        [titles addObject:item.methodName];
    }
    return titles;
}

@end

@implementation MethodMenuItem (Factory)

#pragma mark - Factory methods

static NSMutableDictionary *_methodCacheDict = nil;
/*
 * 生成所有玩法项
 * 调用此方法必须在init data完成后
 */
+ (NSArray *)getAll:(NSInteger)lotteryId channelId:(NSInteger)channelId{
//    if (!_methodCacheDict){
        [_methodCacheDict release];
        _methodCacheDict  = [[NSMutableDictionary alloc] init];
//    }
    
    NSString *key = [NSString stringWithFormat:@"LotKey%ld", (long)lotteryId];
    NSMutableArray *arr = [_methodCacheDict objectForKey:key];
    if (arr) return (NSArray *)arr;
    
    CDLottery *lot = [CDLottery findLotteryById:lotteryId andChannelId:channelId];
    //重庆时时彩
    if ([lot.name isEqualToString:CQSSC]) {
        NSArray *all = [self generateMethodMenuItemsForCQSSC:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //山东11选5
    else if([lot.name isEqualToString:SD11X5]){
        NSArray *all = [self generateMethodMenuItemsForSD11X5:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //乐利时时彩
    else if([lot.name isEqualToString:LLSSC]){
        NSArray *all = [self generateMethodMenuItemsForLeLiSSC:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //乐利11选5
    else if([lot.name isEqualToString:LL11X5]){
        NSArray *all = [self generateMethodMenuItemsForLL11X5:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //吉利分分彩
    else if ([lot.name isEqualToString:JLFFC]){
        NSArray *all = [self generateMethodMenuItemsForJiLiFFC:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //3D
    else if ([lot.name isEqualToString:LOW_3D]){
        NSArray *all = [self generateMethodMenuItemsForLow3D:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //双色球
    else if ([lot.name isEqualToString:LOW_SSQ]){
        NSArray *all = [self generateMethodMenuItemsForSSQ:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //江西时时彩
    else if ([lot.name isEqualToString:JXSSC])
    {
        NSArray *all = [self generateMethodMenuItemsForJXSSC:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //新疆时时彩
    else if ([lot.name isEqualToString:XJSSC])
    {
        NSArray *all = [self generateMethodMenuItemsForXJSSC:lotteryId];
        [_methodCacheDict setObject:all forKey:key];

    }
    //天津时时彩
    else if ([lot.name isEqualToString:TJSSC])
    {
        NSArray *all = [self generateMethodMenuItemsForTJSSC:lotteryId];
        [_methodCacheDict setObject:all forKey:key];

    }
    //P5
    else if([lot.name isEqualToString:LOW_P5])
    {
        NSArray *all = [self generateMethodMenuItemsForP5:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
    //江苏快三
    else if([lot.name isEqualToString:JSK3])
    {
        NSArray *all = [self generateMethodMenuItemsForJSK3:lotteryId];
        [_methodCacheDict setObject:all forKey:key];
    }
//    [[_methodCacheDict objectForKey:key] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        MethodMenuItemCategory *m = (MethodMenuItemCategory*)obj;
//        NSLog(@"******%@ ",m.categoryName);
//        [m.methodMenuItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            MethodMenuItem *m = (MethodMenuItem*)obj;
//           NSLog(@"%@ %@",m.methodName ,m.simpleName);
//            
//        }];
//    }];
    return (NSArray *)[_methodCacheDict objectForKey:key];
}


@end


#pragma mark - Subclasses
@implementation SD11X5DT5

/*
 胆马最多只能选4个
 拖马最多只能选10个
 胆马选01   此时要是选拖马01  则把胆马的01给取消
 */
- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
     
    BetItem *itemDan = [self.betItems objectAtIndex:0];
    BetItem *itemTuo = [self.betItems objectAtIndex:1];
    
    if (option != kBetItemOptionNone && item == itemTuo) {
        //全大小单双时清空
        [itemDan reset];
    } else {
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
    Echo(@"SD11X5DT5 %d | %d", [itemDan selectedBallCount], [itemTuo selectedBallCount]);
    if ([itemDan selectedBallCount] > 4){
        [itemDan trimSelectionsToLength:4];
    }
    if ([itemTuo selectedBallCount] > 10){
        [itemTuo trimSelectionsToLength:10];
    }
    
    [super onBetItemChanges:item option:option];
}

- (void)configBetItems{
    BetItem *itemDan = [self.betItems objectAtIndex:0];
    itemDan.disableWeightOption = YES;
}

- (int)random1{
    return [self random1Unique];
}

- (NSString *)jointedNumbers{
    //[胆 01] 02,03,04,05
    NSString *numbers = [super originalNumbers];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@","];
    NSArray *comps = [numbers componentsSeparatedByString:@"|"];
    return [NSString stringWithFormat:@"[胆 %@] %@",comps[0],comps[1]];
}

@end

@implementation SD11X5QSZX

//三个位不能重号
- (int)random1{
    return [self random1Unique];
}

- (NSString *)jointedNumbers{
    NSString *numbers = [super originalNumbers];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@" "];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"|" withString:@","];
    numbers = [numbers stringByAppendingString:@",-,-"];
    return numbers;
}

@end

@implementation SD11X5DWD

- (NSString *)jointedNumbers{
    NSMutableString *number = [NSMutableString string];
    for (BetItem *item in self.betItems){
        NSString *str = [item serialize];
        if (str.length == 0) str = @"-";
        else str = [str stringByReplacingOccurrencesOfString:@"&" withString:@" "];
        [number appendFormat:@",%@",str];
    }
    [number deleteCharactersInRange:NSMakeRange(0, 1)];
    [number appendString:@",-,-"];
    return number;
}

@end


@implementation CQSSC5XZuXuan

- (int)random1{
    return [self random1Unique];
}

@end

@implementation SSC5XZuXuan120

- (NSString *)jointedNumbers{
    NSString *number = [super originalNumbers];
    number = [number stringByReplacingOccurrencesOfString:@"&" withString:@","];
    return number;
}

@end

@implementation SSC4XZhiXuan

- (NSString *)jointedNumbers{
    NSString *number = [super jointedNumbers];
    number = [NSString stringWithFormat:@"-,%@",number];
    return number;
}

@end

@implementation SSCHSZhiXuan

- (NSString *)jointedNumbers{
    NSString *number = [super jointedNumbers];
    number = [NSString stringWithFormat:@"-,-,%@",number];
    return number;
}

@end

@implementation SSCQSZhiXuan

- (NSString *)jointedNumbers{
    NSString *number = [super jointedNumbers];
    number = [NSString stringWithFormat:@"%@,-,-",number];
    return number;
}

@end

@implementation SSCHEZhiXuan

- (NSString *)jointedNumbers{
    NSString *number = [super jointedNumbers];
    number = [NSString stringWithFormat:@"-,-,-,%@",number];
    return number;
}

@end

@implementation SSCQEZhiXuan

- (NSString *)jointedNumbers{
    NSString *number = [super jointedNumbers];
    number = [NSString stringWithFormat:@"%@,-,-,-",number];
    return number;
}

@end

@implementation SSC1XDWD

- (NSString *)jointedNumbers{
    NSMutableString *number = [NSMutableString string];
    for (BetItem *item in self.betItems){
        NSString *str = [item serialize];
        if (str.length == 0) str = @"-";
        else str = [str stringByReplacingOccurrencesOfString:@"&" withString:@""];
        [number appendFormat:@",%@",str];
    }
    [number deleteCharactersInRange:NSMakeRange(0, 1)];
    return number;
}

@end

@implementation SSCDaXiaoDanShuang

+ (id)itemWithName:(NSString *)name weights:(NSArray *)weights tips:(NSString *)tips minimum:(int)minimumBallCount{
    SSCDaXiaoDanShuang *instance = [[[self alloc] init] autorelease];
    instance.methodName = name;
    instance.minimumBallCount = minimumBallCount;
    instance.tips = tips;
//    instance.betType = kMethodBetTypeDxds;
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *w in weights) {
        NSArray *ballItems = @[
                                      [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"大" value:@"大"] autorelease],
                                    [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"小" value:@"小"] autorelease],
                                    [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"单" value:@"单"] autorelease],
                                    [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"双" value:@"双"] autorelease],
                                      ];
//        for (BallItem *one in ballItems){
//            one.frameSize = CGSizeMake(55.f, kDefaultSize.height);
//        }
        BetItem *betItem = [[BetItem alloc] initWithWeight:w
                                                     ballItems:ballItems
                                          minimumBallCount:1];
//        betItem.type = kBetItemTypeWords;
        betItem.delegate = instance;
        [items addObject:betItem];
    }
    instance.betItems = items;
    
    //Default  bet count calculating block
    [instance setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
        *betCount_ = 1;
        for (int i = 0; i < [betItems_ count]; i++) {
            BetItem *item = [betItems_ objectAtIndex:i];
            *betCount_ *= [item count];
        }
    }];
    return instance;
}

@end

@implementation SSCTeSuHao

+ (id)itemWithName:(NSString *)name tips:(NSString *)tips minimum:(int)minimumBallCount{
    SSCTeSuHao *instance = [[[SSCTeSuHao alloc] init] autorelease];
    instance.methodName = name;
    instance.minimumBallCount = minimumBallCount;
    instance.tips = tips;
    instance.betType = kMethodBetTypeDxds;
    
    NSMutableArray *items = [NSMutableArray array];
    NSArray *ballItems = @[
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"豹子" value:@"豹子"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"顺子" value:@"顺子"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"对子" value:@"对子"] autorelease]
                           ];
    for (BallItem *one in ballItems){
        one.frameSize = kRoundedSize;
    }
    BetItem *betItem = [[BetItem alloc] initWithWeight:@" "
                                             ballItems:ballItems
                                      minimumBallCount:1];
    betItem.type = kBetItemTypeWords;
    betItem.delegate = instance;
    [items addObject:betItem];

    instance.betItems = items;
    return instance;
}

@end

@implementation SSCQuWeiSanXing

+ (id)itemWithName:(NSString *)name tips:(NSString *)tips minimum:(int)minimumBallCount{
    SSCQuWeiSanXing *instance = [[[SSCQuWeiSanXing alloc] init] autorelease];
    instance.methodName = name;
    instance.minimumBallCount = minimumBallCount;
    instance.tips = tips;
//    instance.betType = kMethodBetTypeDxds;
    
    NSMutableArray *items = [NSMutableArray array];
    //万
    {
        NSArray *ballItems = @[
                               [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"小" value:@"小"] autorelease],
                               [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"大" value:@"大"] autorelease]
                               ];
//        for (BallItem *one in ballItems){
//            one.frameSize = CGSizeMake(100.f, 35.f);
//        }
        BetItem *betItem = [[BetItem alloc] initWithWeight:@"万"
                                                 ballItems:ballItems
                                          minimumBallCount:1];
//        betItem.type = kBetItemTypeWords;
        betItem.delegate = instance;
        [items addObject:betItem];
    }
    //千
    {
        NSArray *ballItems = @[
                               [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"小" value:@"小"] autorelease],
                               [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"大" value:@"大"] autorelease]
                               ];
//        for (BallItem *one in ballItems){
//            one.frameSize = CGSizeMake(100.f, 35.f);
//        }
        BetItem *betItem = [[BetItem alloc] initWithWeight:@"千"
                                                 ballItems:ballItems
                                          minimumBallCount:1];
//        betItem.type = kBetItemTypeWords;
        betItem.delegate = instance;
        [items addObject:betItem];
    }
    //百
    {
        BetItem *betItem = [[BetItem alloc] initWithWeight:@"百" startBall:0 endBall:9 numberFormat:nil minimumBallCount:1];
        betItem.delegate = instance;
        [items addObject:betItem];
    }
    //十
    {
        BetItem *betItem = [[BetItem alloc] initWithWeight:@"十" startBall:0 endBall:9 numberFormat:nil minimumBallCount:1];
        betItem.delegate = instance;
        [items addObject:betItem];
    }
    //个
    {
        BetItem *betItem = [[BetItem alloc] initWithWeight:@"个" startBall:0 endBall:9 numberFormat:nil minimumBallCount:1];
        betItem.delegate = instance;
        [items addObject:betItem];
    }
       
    instance.betItems = items;
    return instance;
}

@end

@implementation MethodMenuItem3D

- (NSString *)jointedNumbers{
    return [super jointedNumbers];
    
    NSMutableString *result = [NSMutableString string];
    for (BetItem *item in self.betItems){
        [result appendString:@"|"];
        NSString *numbers = [item serialize];
        numbers = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@""];
        [result appendString:numbers];
    }
    [result deleteCharactersInRange:NSMakeRange(0, 1)];
    return result;
}

@end

@implementation ZhiXuan3D

- (NSString *)jointedNumbers{
    NSString *result = [super jointedNumbers];
    result = [result stringByReplacingOccurrencesOfString:@"&" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"|" withString:@","];
    return result;
    /*
    BetItem *bai = [self.betItems objectAtIndex:0];
    BetItem *shi = [self.betItems objectAtIndex:1];
    BetItem *ge = [self.betItems objectAtIndex:2];
    NSArray *baiNumbers = [[bai serialize] componentsSeparatedByString:@"&"];
    NSArray *shiNumbers = [[shi serialize] componentsSeparatedByString:@"&"];
    NSArray *geNumbers = [[ge serialize] componentsSeparatedByString:@"&"];
    
    NSMutableString *result = [NSMutableString string];
    for (NSString *b in baiNumbers){
        for (NSString *s in shiNumbers){
            for (NSString *g in geNumbers){
                [result appendFormat:@"|%@%@%@",b,s,g];
            }
        }
    }
    if ([result length] > 0){
        [result deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    return result;
    */
}

@end


@implementation ZuXuanHZ3D

- (NSString *)jointedNumbers{
    NSMutableString *result = [NSMutableString string];
    for (BetItem *item in self.betItems){
        [result appendString:@"|"];
        NSString *numbers = [item serialize];
        numbers = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@","];
        [result appendString:numbers];
    }
    [result deleteCharactersInRange:NSMakeRange(0, 1)];
    return result;
}

@end

@implementation YMBDW3D

- (NSString *)jointedNumbers{
    BetItem *item = [self.betItems objectAtIndex:0];
    NSString *numbers = [item serialize];
    return [numbers stringByReplacingOccurrencesOfString:@"&" withString:@","];
}

@end

@implementation DWD3D
- (NSString *)jointedNumbers{
    BetItem *item = [self.betItems objectAtIndex:0];
    NSString *numbers = [item serialize];
    if ([item.weight isEqualToString:@"百"]) {
        numbers = [NSString stringWithFormat:@"%@,-,-",numbers];
    }
    if ([item.weight isEqualToString:@"十"]) {
        numbers = [NSString stringWithFormat:@"-,%@,-",numbers];
    }
    if ([item.weight isEqualToString:@"个"]) {
        numbers = [NSString stringWithFormat:@"-,-,%@",numbers];
    }
    return [numbers stringByReplacingOccurrencesOfString:@"&" withString:@""];
}

@end

@implementation ZhiXuanHeZhi3D

- (NSString *)jointedNumbers{
    return [super jointedNumbers];
    /*
    BetItem *item = [self.betItems objectAtIndex:0];
    NSArray *numbers = [[item serialize] componentsSeparatedByString:@"&"];
    NSMutableString *result = [NSMutableString string];
    for (NSString *str in numbers){
        int sum = [str intValue];
        for (int i = 0 ; i <= 9; i++) {
            for (int j = 0; j<= 9; j++) {
                for (int k = 0; k <= 9 ; k++) {
                    if (i+j+k == sum)
                        [result appendFormat:@"|%d%d%d",i,j,k];
                }
            }
        }
    }
    if ([result length] > 0)
        [result deleteCharactersInRange:NSMakeRange(0, 1)];
    return result;
     */
}

@end

@implementation Zu3Zu63D

- (NSString *)jointedNumbers{
    BetItem *item = [self.betItems objectAtIndex:0];
    NSString *numbers = [item serialize];
    return [numbers stringByReplacingOccurrencesOfString:@"&" withString:@""];
}

@end

@implementation DXDS3D

- (NSString *)jointedNumbers{
    NSMutableString *result = [NSMutableString string];
    for (BetItem *item in self.betItems){
        [result appendString:@","];
        NSString *numbers = [item serialize];
        numbers = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@""];
        [result appendString:numbers];
    }
    [result deleteCharactersInRange:NSMakeRange(0, 1)];
    return result;
}

@end


@implementation SSCXuan1

- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    if (item.selectedBallCount > 1){
        [item reset];
        [item selectNumberS:item.lastBall];
    }
    
    [super onBetItemChanges:item option:option];
}

@end


@implementation QEZhiXuan3D

- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    numbers = [numbers stringByAppendingFormat:@",-"];
    return numbers;
}


@end

@implementation HEZhiXuan3D

- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    numbers = [NSString stringWithFormat:@"-,%@",numbers];
    return numbers;
}

@end

@implementation P5H2_FS_Item

- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    numbers = [@"-,-,-," stringByAppendingFormat:@"%@",numbers];
    return numbers;
}
@end

@implementation P3QE_FS_Item

- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    numbers = [numbers stringByAppendingFormat:@"%@",@",-"];
    return numbers;
}
@end

@implementation P3HE_FS_Item

- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    numbers = [@"-," stringByAppendingFormat:@"%@",numbers];
    return numbers;
}

@end

@implementation P5HE_ZXBD_Item
//只能选一个
- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    if (item.selectedBallCount > 1){
        [item reset];
        [item selectNumberS:item.lastBall];
    }
    
    [super onBetItemChanges:item option:option];
}
@end


@implementation P3SX_ZXBD_Item
//只能选一个
- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    if (item.selectedBallCount > 1){
        [item reset];
        [item selectNumberS:item.lastBall];
    }
    
    [super onBetItemChanges:item option:option];
}
@end
@implementation P3QE_ZXBD_Item
//只能选一个
- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    if (item.selectedBallCount > 1){
        [item reset];
        [item selectNumberS:item.lastBall];
    }
    
    [super onBetItemChanges:item option:option];
}
@end
@implementation P3HE_ZXBD_Item
//只能选一个
- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    if (item.selectedBallCount > 1){
        [item reset];
        [item selectNumberS:item.lastBall];
    }
    
    [super onBetItemChanges:item option:option];
}
@end


@implementation P5YX_DWD_Item

- (NSString *)jointedNumbers{
    NSMutableString *number = [NSMutableString string];
    for (BetItem *item in self.betItems){
        NSString *str = [item serialize];
        if (str.length == 0) str = @"-";
        else str = [str stringByReplacingOccurrencesOfString:@"&" withString:@""];
        [number appendFormat:@",%@",str];
    }
    [number deleteCharactersInRange:NSMakeRange(0, 1)];
    return number;
}
@end

//
@implementation JSKS_ITEM
- (NSString *)jointedNumbers{
    BetItem *item = [self.betItems objectAtIndex:0];
    NSString *numbers = [item serialize];
    return [numbers stringByReplacingOccurrencesOfString:@"&" withString:@","];

}
@end



//二同号复选
@implementation JSKS_ETHFX_Item

+ (id)itemWithName:(NSString *)name tips:(NSString *)tips minimum:(int)minimumBallCount{
    JSKS_ETHFX_Item *instance = [[[JSKS_ETHFX_Item alloc] init] autorelease];
    instance.methodName = name;
    instance.minimumBallCount = minimumBallCount;
    instance.tips = tips;
    instance.betType = kMethodBetTypeDxds;
    
    NSMutableArray *items = [NSMutableArray array];
    NSArray *ballItems = @[
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"11*" value:@"11*"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"22*" value:@"22*"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"33*" value:@"33*"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"44*" value:@"44*"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"55*" value:@"55*"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"66*" value:@"66*"] autorelease],

                           ];
    for (BallItem *one in ballItems){
        one.frameSize = kRoundedSize;
    }
    BetItem *betItem = [[BetItem alloc] initWithWeight:@"选号"
                                             ballItems:ballItems
                                      minimumBallCount:1];
    betItem.type = kBetItemTypeWords;
    betItem.delegate = instance;
    [items addObject:betItem];
    
    instance.betItems = items;
    return instance;
}


@end

@implementation JSKS_ETHDX_Item
- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    if ([numbers containsString:@","]) {
        numbers = [numbers stringByReplacingOccurrencesOfString:@"," withString:@"#"];
    }
    numbers = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@" "];
    
    return numbers;
    
}
+ (id)itemWithName:(NSString *)name tips:(NSString *)tips minimum:(int)minimumBallCount{
    JSKS_ETHDX_Item *instance = [[[JSKS_ETHDX_Item alloc] init] autorelease];
    instance.methodName = name;
    instance.minimumBallCount = minimumBallCount;
    instance.tips = tips;
    instance.betType = kMethodBetTypeDigital;
    
    NSMutableArray *items = [NSMutableArray array];
    
    NSArray *ballItems = @[
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"11" value:@"11"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"22" value:@"22"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"33" value:@"33"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"44" value:@"44"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"55" value:@"55"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"66" value:@"66"] autorelease],
                           
                           ];
    for (BallItem *one in ballItems){
        one.frameSize = kDefaultSize;
    }
    BetItem *betItem = [[BetItem alloc] initWithWeight:@"同号"
                                             ballItems:ballItems
                                      minimumBallCount:1];
    betItem.type = kBetItemTypeNumber;
    betItem.delegate = instance;
    
    
    NSArray *ballItems2 = @[
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"1" value:@"1"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"2" value:@"2"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"3" value:@"3"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"4" value:@"4"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"5" value:@"5"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleDefault text:@"6" value:@"6"] autorelease],
                           
                           ];
    for (BallItem *one in ballItems2){
        one.frameSize = kDefaultSize;
    }
    BetItem *betItem2 = [[BetItem alloc] initWithWeight:@"不同号"
                                             ballItems:ballItems2
                                      minimumBallCount:1];
    betItem2.type = kBetItemTypeNumber;
    betItem2.delegate = instance;
    
    [items addObject:betItem];
    [items addObject:betItem2];

    instance.betItems = items;
    return instance;
}
- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    BetItem *itemTH = [self.betItems objectAtIndex:0];
    BetItem *itemBTH = [self.betItems objectAtIndex:1];
    
    if (option != kBetItemOptionNone && item == itemBTH) {
        //全大小单双时清空
        [itemTH reset];
    } else {
        //清空重复的号
        if (item == itemBTH){
            for (BallItem *it in itemBTH.ballItems) {
                if ([itemBTH numberSelectedS:it.text]){
                    if ([itemTH numberSelectedS:[NSString stringWithFormat:@"%@%@",it.text,it.text]]){
                        [itemTH deselectNumberS:[NSString stringWithFormat:@"%@%@",it.text,it.text]];
                    }
                }
            }
        }   //else
        else if(item == itemTH){
            for (BallItem *it in itemTH.ballItems) {
                if ([itemTH numberSelectedS:it.text]){
                    if ([itemBTH numberSelectedS:[it.text substringToIndex:1]]){
                        [itemBTH deselectNumberS:[it.text substringToIndex:1]];
                    }
                }
            }
        }
    }
    [super onBetItemChanges:item option:option];
}
- (int)random1
{
    int weight = 0;
    BetItem *itemT = [self.betItems objectAtIndex:weight];
    [itemT randomN:1 exceptedNumbers:nil];
    
    weight++;
    
    BetItem *itemBT = [self.betItems objectAtIndex:weight];
    [itemBT randomN:1 exceptedNumbers:@[[itemT.selectedNumbers[0] substringToIndex:1]]];
    
    [self betItemsUpdated];
    
    if (self.delegate){
        [self.delegate onMethodMenuItemChanges:self];
    }
    return weight;
}
@end

//三连号通选
@implementation JSKS_SLHTX_Item
- (NSString*)jointedNumbers
{
  return @"123 234 345 456";
}
+ (id)itemWithName:(NSString *)name tips:(NSString *)tips minimum:(int)minimumBallCount{
    JSKS_SLHTX_Item *instance = [[[JSKS_SLHTX_Item alloc] init] autorelease];
    instance.methodName = name;
    instance.minimumBallCount = minimumBallCount;
    instance.tips = tips;
    instance.betType = kMethodBetTypeDxds;
    
    NSMutableArray *items = [NSMutableArray array];
    NSArray *ballItems = @[
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"slhtx_bg_n@2x.png" value:@"slhtx_bg_h@2x.png"] autorelease],
                           ];
    for (BallItem *one in ballItems){
        one.frameSize = kRoundedBigSize;
    }
    BetItem *betItem = [[BetItem alloc] initWithWeight:@"选号"
                                             ballItems:ballItems
                                      minimumBallCount:1];
    betItem.type = kBetItemTypeImage;
    betItem.delegate = instance;
    [items addObject:betItem];
    
    instance.betItems = items;
    return instance;
}

@end


//三同号单选
@implementation JSKS_STHDX_Item

- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    return [numbers stringByReplacingOccurrencesOfString:@"," withString:@" "];
    
}

+ (id)itemWithName:(NSString *)name tips:(NSString *)tips minimum:(int)minimumBallCount{
    JSKS_STHDX_Item *instance = [[[JSKS_STHDX_Item alloc] init] autorelease];
    instance.methodName = name;
    instance.minimumBallCount = minimumBallCount;
    instance.tips = tips;
    instance.betType = kMethodBetTypeDxds;
    
    NSMutableArray *items = [NSMutableArray array];
    NSArray *ballItems = @[
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"111" value:@"111"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"222" value:@"222"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"333" value:@"333"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"444" value:@"444"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"555" value:@"555"] autorelease],
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"666" value:@"666"] autorelease],
                           
                           ];
    for (BallItem *one in ballItems){
        one.frameSize = kRoundedSize;
    }
    BetItem *betItem = [[BetItem alloc] initWithWeight:@"选号"
                                             ballItems:ballItems
                                      minimumBallCount:1];
    betItem.type = kBetItemTypeWords;
    betItem.delegate = instance;
    [items addObject:betItem];
    
    instance.betItems = items;
    return instance;
}


@end


//三同号通选
@implementation JSKS_STHTX_Item
- (NSString *)jointedNumbers{
    return @"111 222 333 444 555 666";
    
}
+ (id)itemWithName:(NSString *)name tips:(NSString *)tips minimum:(int)minimumBallCount{
    JSKS_STHTX_Item *instance = [[[JSKS_STHTX_Item alloc] init] autorelease];
    instance.methodName = name;
    instance.minimumBallCount = minimumBallCount;
    instance.tips = tips;
    instance.betType = kMethodBetTypeDxds;
    
    NSMutableArray *items = [NSMutableArray array];
    NSArray *ballItems = @[
                           [[[BallItem alloc] initWithStyle:kBallStyleRoundedRect text:@"sthtx_bg_n@2x.png" value:@"sthtx_bg_h@2x.png"] autorelease],
                           ];
    for (BallItem *one in ballItems){
        one.frameSize = kRoundedBigSize;
    }
    BetItem *betItem = [[BetItem alloc] initWithWeight:@"选号"
                                             ballItems:ballItems
                                      minimumBallCount:1];
    betItem.type = kBetItemTypeImage;
    betItem.delegate = instance;
    [items addObject:betItem];
    
    instance.betItems = items;
    return instance;
}


@end

@implementation JSKS_SBTHDT_Item

- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"," withString:@"_T:"];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@","];

    return [@"D:" stringByAppendingString:numbers];
    
}

+ (NSArray *)betItemsFromWeightRule:(WeightRule *)weightRule{
    if (weightRule == nil) return nil;
    
    NSMutableArray *list = [NSMutableArray array];
    NSArray *components = [weightRule componentsSeparatedByString:@","];
    for (NSString *compo in components){
        
        NSArray *weightComponents = [compo componentsSeparatedByString:@"|"];
        if ([weightComponents count] >= 3 ) {
            
            NSString *weight = [weightComponents objectAtIndex:0];      //权位
            int startBall = 0, endBall = 0, minimum = 0,max=0;
            
            NSArray *ballComponents = [(NSString *)[weightComponents objectAtIndex:1] componentsSeparatedByString:@"-"];        //号码
            if ([ballComponents count] == 2) {          //e.g. 0-10
                startBall = [[ballComponents objectAtIndex:0] intValue];
                endBall = [[ballComponents objectAtIndex:1] intValue];
            }
            
            NSArray *countComponents = [(NSString *)[weightComponents objectAtIndex:2] componentsSeparatedByString:@"~"];   //最少选择限制
            minimum = [countComponents[0] intValue];
            max = [countComponents[1] intValue];
            
            BetItem *betItem = [[BetItem alloc] initWithWeight:weight startBall:startBall endBall:endBall numberFormat:nil minimumBallCount:minimum maxBallCount:max];
            [list addObject:betItem];
            [betItem release];
        }
    }
    
    return list;
}

- (BOOL)isValidBet{
    int ballCount = 0;
    //统计选了几个球
    for (int i = 0; i < [self.betItems count]; i++) {
        BetItem *item = [self.betItems objectAtIndex:i];
        if ([item count]<item.minimumBallCount) {
            return NO;
        }
        ballCount += [item count];
    }
    BOOL valid = ballCount >= self.minimumBallCount;
    //有的玩法会有在重号的规则下注数为0
    if (valid){
        valid = self.betCount > 0;
    }
    return valid;
}

- (int)random1
{
    int weight = 0;
    NSInteger totalMinimum = 3;//总的最少选择数量
    NSMutableArray *selectedBall = [NSMutableArray array];//已经选择好的 用于排除
    //其他玩法，每位都得选号
    BetItem *itemDan = [self.betItems objectAtIndex:weight];
    NSInteger count = arc4random_uniform((itemDan.maxBallCount-itemDan.minimumBallCount+1))+itemDan.minimumBallCount;
    [itemDan randomN:count exceptedNumbers:nil];
    [selectedBall addObjectsFromArray:itemDan.selectedNumbers];
    
    weight++;
    
    BetItem *itemTuo = [self.betItems objectAtIndex:weight];
    count = totalMinimum - selectedBall.count;
    [itemTuo randomN:count exceptedNumbers:selectedBall];
    
    [self betItemsUpdated];
    
    if (self.delegate){
        [self.delegate onMethodMenuItemChanges:self];
    }
    return weight;
}

//- (int)random1
//{
//    int weight = 0;
//    NSInteger totalMinimum = 3;//总的最少选择数量
//    NSInteger selectedCount = 0;//已经选择的总的数量
//    NSInteger optionalCount = 0;//每次选择可以选择的最大的数量
//    NSMutableArray *selectedBall = [NSMutableArray array];//已经选择好的 用于排除
//    //其他玩法，每位都得选号
//    for (NSInteger i = 0; i < [self.betItems count]; i++)
//    {
//        BetItem *item = [self.betItems objectAtIndex:weight];
//        optionalCount = item.ballCount - selectedBall.count;
//        NSInteger count = 0;
//        while (1) {
//            count = arc4random_uniform((item.maxBallCount-item.minimumBallCount+1))+item.minimumBallCount;
//            if (count<=optionalCount) {
//                break;
//            }
//        }
//        if (i==self.betItems.count-1) {
//            if (selectedCount+count<totalMinimum) {
//                count = totalMinimum-selectedCount;
//            }
//        }
//        [item randomN:count exceptedNumbers:[selectedBall copy]];
//        [selectedBall addObjectsFromArray:item.selectedNumbers];
//        weight++;
//        selectedCount+=item.selectedNumbers.count;
//    }
//    
//    [self betItemsUpdated];
//    
//    if (self.delegate){
//        [self.delegate onMethodMenuItemChanges:self];
//    }
//    return weight;
//}

- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    BetItem *itemDan = [self.betItems objectAtIndex:0];
    BetItem *itemTuo = [self.betItems objectAtIndex:1];
    
    if (option != kBetItemOptionNone && item == itemTuo) {
        //全大小单双时清空
        [itemDan reset];
    } else {
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
    
    if ([itemDan selectedBallCount] > 2){
        [itemDan trimSelectionsToLength:2];
    }
    if ([itemTuo selectedBallCount] > 5){
        [itemTuo trimSelectionsToLength:5];
    }
    
    [super onBetItemChanges:item option:option];
}


@end
//二不同号胆拖
@implementation JSKS_EBTHDT_Item

- (NSString *)jointedNumbers{
    NSString *numbers = [super jointedNumbers];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"," withString:@"_T:"];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@","];
    
    return [@"D:" stringByAppendingString:numbers];
    
}
+ (NSArray *)betItemsFromWeightRule:(WeightRule *)weightRule{
    if (weightRule == nil) return nil;
    
    NSMutableArray *list = [NSMutableArray array];
    NSArray *components = [weightRule componentsSeparatedByString:@","];
    for (NSString *compo in components){
        
        NSArray *weightComponents = [compo componentsSeparatedByString:@"|"];
        if ([weightComponents count] >= 3 ) {
            
            NSString *weight = [weightComponents objectAtIndex:0];      //权位
            int startBall = 0, endBall = 0, minimum = 0,max=0;
            
            NSArray *ballComponents = [(NSString *)[weightComponents objectAtIndex:1] componentsSeparatedByString:@"-"];        //号码
            if ([ballComponents count] == 2) {          //e.g. 0-10
                startBall = [[ballComponents objectAtIndex:0] intValue];
                endBall = [[ballComponents objectAtIndex:1] intValue];
            }
            
            NSArray *countComponents = [(NSString *)[weightComponents objectAtIndex:2] componentsSeparatedByString:@"~"];   //最少选择限制
            minimum = [countComponents[0] intValue];
            max = [countComponents[1] intValue];
            
            BetItem *betItem = [[BetItem alloc] initWithWeight:weight startBall:startBall endBall:endBall numberFormat:nil minimumBallCount:minimum maxBallCount:max];
            [list addObject:betItem];
            [betItem release];
        }
    }
    
    return list;
}


- (int)random1
{
    int weight = 0;
    NSInteger totalMinimum = 2;//总的最少选择数量
    NSMutableArray *selectedBall = [NSMutableArray array];//已经选择好的 用于排除
    //其他玩法，每位都得选号
    BetItem *itemDan = [self.betItems objectAtIndex:weight];
    NSInteger count = arc4random_uniform((itemDan.maxBallCount-itemDan.minimumBallCount+1))+itemDan.minimumBallCount;
    [itemDan randomN:count exceptedNumbers:nil];
    [selectedBall addObjectsFromArray:itemDan.selectedNumbers];
    
    weight++;
    
    BetItem *itemTuo = [self.betItems objectAtIndex:weight];
    count = totalMinimum - selectedBall.count;
    [itemTuo randomN:count exceptedNumbers:selectedBall];
    
    [self betItemsUpdated];
    
    if (self.delegate){
        [self.delegate onMethodMenuItemChanges:self];
    }
    return weight;
}

- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    
    BetItem *itemDan = [self.betItems objectAtIndex:0];
    BetItem *itemTuo = [self.betItems objectAtIndex:1];
    
    if (option != kBetItemOptionNone && item == itemTuo) {
        //全大小单双时清空
        [itemDan reset];
    } else {
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
    
    if ([itemDan selectedBallCount] > 1){
        [itemDan trimSelectionsToLength:1];
    }
    if ([itemTuo selectedBallCount] > 5){
        [itemTuo trimSelectionsToLength:5];
    }
    
    [super onBetItemChanges:item option:option];
}
@end
