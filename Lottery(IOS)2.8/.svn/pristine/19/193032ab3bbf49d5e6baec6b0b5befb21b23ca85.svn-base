//
//  MethodMenuItem.m
//  Caipiao
//
//  Created by danal on 13-8-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "MethodMenuItem.h"
#import "CDMenuItem.h"
#import "BetItem.h"
#import "CDLottery.h"
#import "MenuItemModel.h"

@interface MethodMenuItem()
@end

@implementation MethodMenuItem

- (void)dealloc{
    self.betCountBlock = nil;
    [_methodName release];
    [_simpleName release];
    [_weightRule release];
    [_category release];
    [_tips release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        self.betType = kMethodBetTypeDigital;
        self.numbersStyle = kMethodNumbersStyle1;
    }
    return self;
}

- (void)setWeightRule:(NSString *)weightRule{
    [_weightRule release];
    _weightRule = [weightRule copy];
    NSArray *arr = [[self class] betItemsFromWeightRule:_weightRule];
    self.betItems = [NSArray arrayWithArray:arr];
    for (BetItem *item in self.betItems){
        item.delegate = self;
    }
    [self configBetItems];
}

- (void)configBetItems{
    //Do nothing here
}

- (NSUInteger)selectedNumberCount{
    NSUInteger count = 0;
    for (int i = 0; i < _betItems.count; i++) {
        BetItem *item = [_betItems objectAtIndex:i];
        count += [item selectedBallCount];
    }
    return count;
}

- (NSString *)jointedNumbers{
    NSMutableString *number = [NSMutableString string];
    NSInteger count = [_betItems count];
    for (NSInteger i = 0; i < count; i++) {
        BetItem *item = [_betItems objectAtIndex:i];
        if (i == count - 1){
            [number appendFormat:@"%@", [item serialize]];
        } else {
            [number appendFormat:@"%@,", [item serialize]];
        }
    }
    if (_numbersStyle == kMethodNumbersStyle1){
        [number replaceOccurrencesOfString:@"&" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, number.length)];
    } else if (_numbersStyle == kMethodNumbersStyle2) {
        [number replaceOccurrencesOfString:@"&" withString:@"," options:NSCaseInsensitiveSearch range:NSMakeRange(0, number.length)];
    }
    Echo(@"jointed:%@",number);
    return number;
}

- (NSString *)originalNumbers{
    NSMutableString *number = [NSMutableString string];
    NSInteger count = [_betItems count];
    for (int i = 0; i < count; i++) {
        BetItem *item = [_betItems objectAtIndex:i];
        if (i == count - 1){
            [number appendFormat:@"%@", [item serialize]];
        } else {
            [number appendFormat:@"%@|", [item serialize]];
        }
    }
    Echo(@"originalNumbers:%@",number);
    return number;
}

- (NSInteger)betItemsUpdated{
    if(self.betCountBlock != NULL){
        _betCount = 1;
        _betCountBlock(&_betCount, _betItems);
    }
    return _betCount;
}

- (BOOL)isValidBet{
    int ballCount = 0;
    //统计选了几个球
    for (int i = 0; i < [self.betItems count]; i++) {
        BetItem *item = [self.betItems objectAtIndex:i];
        ballCount += MIN([item count], MAX(item.minimumBallCount,1));       //minimumBallCount为0时，则与1比较
    }
    Echo(@"isValidBet ball count:%ld, minimum :%ld", (long)ballCount, (long)self.minimumBallCount);
    BOOL valid = ballCount >= self.minimumBallCount;
    //有的玩法会有在重号的规则下注数为0
    if (valid){
        valid = _betCount > 0;
    }
    return valid;
}

- (void)resetBet{
    //reset
    for (int i = 0; i < [self.betItems count]; i++) {
        BetItem *item = [self.betItems objectAtIndex:i];
        [item reset];
    }
    _betCount = 0;
}

- (int)random1{
    int weight = 0;
    int totalMinimum = 0;
    for (BetItem *item in self.betItems) {
        totalMinimum += item.minimumBallCount;
    }
    
    if (totalMinimum < self.minimumBallCount){  //像定位胆这样的玩法，有的位上可以不选号
        weight = arc4random_uniform([self.betItems count]);
        for (int i = 0; i < [self.betItems count]; i++) {
            BetItem *item = [self.betItems objectAtIndex:i];
            if (i == weight) {
                [item random];
            } else {
                [item reset];
            }
        }

    } else {        //其他玩法，每位都得选号
        for (int i = 0; i < [self.betItems count]; i++) {
            BetItem *item = [self.betItems objectAtIndex:weight];
            [item randomN:item.minimumBallCount];
            weight++;
        }
    }
    [self betItemsUpdated];
    
    if (_delegate){
        [_delegate onMethodMenuItemChanges:self];
    }
    return weight;
}

- (int)random1Unique{
    int weight = 0;
    int totalMinimum = 0;
    for (BetItem *item in self.betItems) {
        totalMinimum += item.minimumBallCount;
    }
    
    NSMutableArray *exceptedNumbers = [NSMutableArray array];
    for (int i = 0; i < [self.betItems count]; i++) {
        BetItem *item = [self.betItems objectAtIndex:weight];
        [item randomN:item.minimumBallCount exceptedNumbers:exceptedNumbers];
        weight++;
        
        [exceptedNumbers addObjectsFromArray:[item selectedNumbers]];
    }
    
    [self betItemsUpdated];
    if (self.delegate){
        [self.delegate onMethodMenuItemChanges:self];
    }
    return weight;
}

- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option{
    if (_delegate){
        [_delegate onMethodMenuItemChanges:self];
    }
}

+ (NSArray *)randomN:(int)n{
    return nil;
}

#pragma mark - Class methods

+ (id)itemWithName:(NSString *)methodName
              rule:(WeightRule *)weightRule
              tips:(NSString *)tips
           minimum:(int)minimumBallCount{
    MethodMenuItem *item = [[[self alloc] init] autorelease];
    item.methodName = methodName;
    item.weightRule = weightRule;
    item.minimumBallCount = minimumBallCount;
    item.tips = tips;
    //Default  bet count calculating block
    [item setBetCountBlock:^(NSInteger *betCount_, NSArray *betItems_) {
        for (int i = 0; i < [betItems_ count]; i++) {
            BetItem *item = [betItems_ objectAtIndex:i];
            *betCount_ *= [item count];
        }
    }];
    return item;
}
/*
+ (id)methodCfgForMethodName:(NSString *)methodName lotteryId:(int)lotteryId{

    NSArray *list = [self getAll:lotteryId];
    for (MethodMenuItem *one in list){
        if ([one.methodName isEqualToString:methodName]){
            return one;
        }
    }

    return nil;
}


+ (MethodMenuItem *)itemFromCDMenuItem:(CDMenuItem *)cdMenuItem{
    if (cdMenuItem == nil) return nil;
    
    id cfg = [self methodCfgForMethodName:cdMenuItem.menuName lotteryId:[cdMenuItem.lotteryId intValue]];
    
//    if ([cfg isKindOfClass:[NSDictionary class]]){
//        MethodMenuItem *item = [[[MethodMenuItem alloc] init] autorelease];
//        item.methodName = cdMenuItem.menuName;
//        item.methodId = [cdMenuItem.methodid intValue];
//        item.limitBonus = [cdMenuItem.limitBonus floatValue];
//        item.methodPrice = [cdMenuItem.methodPrice floatValue];
//        Echo(@"cfg for %@\n%@", item.methodName, cfg);
//        
//        item.minimumBallCount = [cfg intForKey:@"minimumBallCount"];
//        item.tips = [cfg stringForKey:@"tips"];
//        item.weightRule = [cfg stringForKey:@"weightRule"];
//        return item;
//        return nil;
//    } else
        if([cfg isKindOfClass:[MethodMenuItem class]]){
        CDLottery *lot = [CDLottery lotteryForValue:cdMenuItem.lotteryId ofProperty:@selector(lotteryId)];
        MethodMenuItem *item = cfg;
        item.lotteryName = lot.name;
        item.methodName = cdMenuItem.menuName;
        item.methodId = [cdMenuItem.methodid intValue];
        item.limitBonus = [cdMenuItem.limitBonus floatValue];
        item.methodPrice = [cdMenuItem.methodPrice floatValue];

//        item.minimumBallCount = [(MethodMenuItem *)cfg minimumBallCount];
//        item.tips = [(MethodMenuItem *)cfg tips];
//        item.weightRule = [(MethodMenuItem *)cfg weightRule];
        return item;
    }
    
    return nil;
}
*/
+ (MethodMenuItem *)itemFromMethodName:(NSString *)methodName lottery:(NSInteger)lotteryId channelId:(NSInteger)chid{
//  Deprecated in v1.7
//    CDMenuItem *cdMenuItem = [BetManager menuItemForMethodName:methodName lottery:lotteryId];
//    return [self itemFromCDMenuItem:cdMenuItem];
    MenuItemModel *model = [BetManager menuItemModelForMethodName:methodName lottery:lotteryId channelId:chid];
    return [self itemFromMenuItemModel:model];
 }

+ (MethodMenuItem *)itemFromMenuItemModel:(MenuItemModel *)model
{
    if (model == nil) return nil;
    
    id cfg = nil;
    NSArray *list = [self getAll:model.lotteryId.intValue channelId:model.channel_id.intValue];
    for (MethodMenuItemCategory *cat in list){
        for (MethodMenuItem *one in cat.methodMenuItems){
            if ([one.methodName isEqualToString:model.showName]){
                cfg = one;
                break;
            }
        }
    }
    if([cfg isKindOfClass:[MethodMenuItem class]]){
        CDLottery *lot = [CDLottery findLotteryById:model.lotteryId.intValue andChannelId:model.channel_id.intValue];
        MethodMenuItem *item = cfg;
        item.lotteryName = lot.name;
        item.methodName = model.showName;
        item.methodId = [model.methodid intValue];
        item.limitBonus = [lot.limitBonus floatValue];
        item.methodPrice = [model.methodPrize floatValue];
        return item;
    }
    
    return nil;
}
+ (MethodMenuItem *)itemFromMethodId:(NSInteger)methodId lottery:(NSInteger)lotteryId channelId:(NSInteger)chid{
    /*
     Deprecated in v1.7
    CDMenuItem *cdMenuItem = [BetManager menuItemForMethodId:methodId lottery:lotteryId];
    return [self itemFromCDMenuItem:cdMenuItem];
     */
    MenuItemModel *model = [BetManager menuItemModelForMethodId:methodId lottery:lotteryId channelId:chid];
    
    return [self itemFromMenuItemModel:model];
}

/*
 *  格式： 万|0-9|1|%d  表示：万位；号码从0到9；最少选择1个号码;  数字格式:%d,%02d(如无此项则缺省为%d)
 */
+ (NSArray *)betItemsFromWeightRule:(WeightRule *)weightRule{
    if (weightRule == nil) return nil;
    
    NSMutableArray *list = [NSMutableArray array];
    NSArray *components = [weightRule componentsSeparatedByString:@","];
    for (NSString *compo in components){
        
        NSArray *weightComponents = [compo componentsSeparatedByString:@"|"];
        if ([weightComponents count] >= 3 ) {
            
            NSString *weight = [weightComponents objectAtIndex:0];      //权位
            int startBall = 0, endBall = 0, minimum = 0;
            
            NSArray *ballComponents = [(NSString *)[weightComponents objectAtIndex:1] componentsSeparatedByString:@"-"];        //号码
            if ([ballComponents count] == 2) {          //e.g. 0-10
                startBall = [[ballComponents objectAtIndex:0] intValue];
                endBall = [[ballComponents objectAtIndex:1] intValue];
            }
            
            NSString *condition = [weightComponents objectAtIndex:2];       //最少选择限制
            minimum = [condition intValue];
            
            NSString *format = nil;
            if ([weightComponents count] == 4){
                format = [weightComponents objectAtIndex:3];          //数字格式
//                betItem.numberFormat = format;
            }
            
            BetItem *betItem = [[BetItem alloc] initWithWeight:weight startBall:startBall endBall:endBall numberFormat:format minimumBallCount:minimum];
            [list addObject:betItem];
            [betItem release];
        }
    }
    
    return list;
}

@end


#pragma mark - Method Category

@implementation MethodMenuItemCategory

- (void)dealloc{
    [_methodMenuItems release];
    [_categoryName release];
    [super dealloc];
}

- (void)addObject:(MethodMenuItem *)item{
    if(!_methodMenuItems){
        _methodMenuItems = [[NSMutableArray alloc] init];
    }
    [_methodMenuItems addObject:item];
}


@end
