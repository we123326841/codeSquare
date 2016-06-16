//
//  BetManager.m
//  Caipiao
//  1)直选玩法中，
//    每位均包含0-9十个数字
//    五星直选显示万、千、百、十、个
//    四星直选显示千、百、十、个
//    后三直选显示百、十、个
//    前三直选显示万、千、百
//    后二直选显示十、个
//    前二直选显示万、千
//    定位胆显示万、千、百、十、个
//
//    2)组选及不定位玩法中，由于选号没有定位要求，故只显示一组0-9的数字
//  Created by danal on 13-1-21.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetManager.h"
#import "CDMenuItem.h"


@implementation BetManager

+ (void)getPlayTypeFromMethodName:(NSString *)methodName playType:(PlayType *)playtype tipsType:(TipsType *)tipstype{
    
}

+ (NSArray *)betItemsForType:(PlayType)type
                        tips:(NSString **)tips
                    tipsType:(TipsType *)tipsType
                 numberCount:(NSInteger *)numberCount{
    NSString *tipsText = nil;
    TipsType tt = kTipsType1PW;
    NSInteger nc = 0;
    NSMutableArray *items = [NSMutableArray array];
    
    switch (type) {
        case kPlayTypeDWD:
        {
            tipsText = @"任意位置选择1个或1个以上号码";
            NSArray *weights = [NSArray arrayWithObjects:WAN,QIAN,BAI,SHI,GE, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1Any;
        }
            break;
        case kPlayTypeWXZX:
        {
            tipsText = @"每位各选1个号码组成一注";
            NSArray *weights = [NSArray arrayWithObjects:WAN,QIAN,BAI,SHI,GE, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1PW;
        }
            break;
        case kPlayTypeWXZuXuan60:
        {
            tipsText = @"从“二重号”选择一个号码，“单号”中选择三个号码组成一注";
            NSArray *weights = [NSArray arrayWithObjects:ER_CHONG_HAO,DAN_HAO, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1PW;
        }
            break;
        case kPlayTypeWXZuXuan30:
        {
            tipsText = @"从“二重号”选择两个号码，“单号”中选择一个号码组成一注";
            NSArray *weights = [NSArray arrayWithObjects:ER_CHONG_HAO,DAN_HAO, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1PW;
        }
            break;
         case kPlayTypeSXZX:
        {
            tipsText = @"每位各选1个号码组成一注";
            NSArray *weights = [NSArray arrayWithObjects:QIAN,BAI,SHI,GE, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1PW;
        }
            break;
        case kPlayTypeHSZX:
        {
            tipsText = @"每位各选1个号码组成一注";
            NSArray *weights = [NSArray arrayWithObjects:BAI,SHI,GE, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1PW;
        }
            break;
        case kPlayTypeHSZuLiu:
        {
            tipsText = @"任意选择3个或3个以上号码";
            NSArray *weights = [NSArray arrayWithObjects:@"选", nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = 3;
            tt = kTipsType3;
        }
            break;
        case kPlayTypeQSZX:
        {
            tipsText = @"每位各选1个号码组成一注";
            NSArray *weights = [NSArray arrayWithObjects:WAN,QIAN,BAI, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1PW;
        }
            break;
        case kPlayTypeHEZX:
        {
            tipsText = @"每位各选1个号码组成一注";
            NSArray *weights = [NSArray arrayWithObjects:SHI,GE, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1PW;
        }
            break;
        case kPlayTypeQEZX:
        {
            tipsText = @"每位各选1个号码组成一注";
            NSArray *weights = [NSArray arrayWithObjects:WAN,QIAN, nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = [weights count];
            tt = kTipsType1PW;
        }
            break;
        case kPlayTypeQSZuLiu:
        {
            tipsText = @"任意选择3个或3个以上号码";
            NSArray *weights = [NSArray arrayWithObjects:@"选", nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = 3;
            tt = kTipsType3;
        }
            break;
        case kPlayTypeHSZuSan:
        case kPlayTypeQSZuSan:
        {
            tipsText = @"任意选择2个或2个以上号码";
            NSArray *weights = [NSArray arrayWithObjects:@"选", nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = 2;
            tt = kTipsType2;
        }
            break;
        case kPlayTypeHEZuXuan:
        case kPlayTypeQEZuXuan:
        {
            tipsText = @"任意选择2个或2个以上号码";
            NSArray *weights = [NSArray arrayWithObjects:@"选", nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            nc = 2;
            tt = kTipsType2;
        }
            break;
        default:    //其他玩法
        {
            NSArray *weights = [NSArray arrayWithObjects:@"选", nil];
            [items addObjectsFromArray:[BetItem makeBetItemsForWeights:weights]];
            tipsText = @"任意选择1个以上号码";
            nc = 1;
            tt = kTipsType1;
        }
            break;
    }
    if (tips) {
        *tips = tipsText;
    }
    if (tipsType) {
        *tipsType = tt;
    }
    if (numberCount) {
        *numberCount = nc;
    }
    return items;
}


//顺序必须对应PlayType的各个索引,并且要重新启动APP才会更新顺序 Deprecated

+ (NSArray *)playTypeMenuTitles{
    /*
    static NSArray *_playTypes = nil;
    if (nil ==_playTypes) {
        _playTypes =  [[NSArray alloc] initWithObjects:
                       @"五星直选",@"四星直选",@"后三直选",
                       @"后三组三",@"后三组六",@"前三直选",
                       @"前三组三" ,@"前三组六" ,@"后二直选" ,
                       @"后二组选",@"前二直选" ,@"前二组选",
                       @"定位胆" ,@"后三一码不定位" ,@"前三一码不定位"
                       , nil];
    }
    return _playTypes;
    */
    NSArray *menuItems = [self menuTitleItems];
    NSMutableArray *titles = [NSMutableArray array];
    for (CDMenuItem *item in menuItems) {
        [titles addObject:item.menuName];
    }
    return titles;
}

//Deprecated
static NSArray *_menuTitleItems = nil;
+ (NSArray *)menuTitleItems{
    NSArray *items = [CDMenuItem findByOrder:@"sortIndex"];
#ifdef DEBUG
    for (CDMenuItem *item in items){
        Echo(@"%@ %@",item.sortIndex, item.menuName);
    }
#endif
    return items;
    
    if (_menuTitleItems == nil) {
        
        NSArray *types = [self playTypeMenuTitles];
        NSArray *menuItems =  [CDMenuItem all];
        NSMutableArray *titles = [NSMutableArray array];
        //按顺序找到各个MenuItem对象
        for (NSString *title in types){
            for (CDMenuItem *item in menuItems){
                if ([title isEqualToString:item.menuName]) {
                    [titles addObject:item];
                    break;
                }
            }
        }
        _menuTitleItems = [[NSArray alloc] initWithArray:titles];
    }
    return _menuTitleItems;
}

+ (CDMenuItem *)menuItemForMethodId:(NSInteger)methodId lottery:(NSInteger)lotteryId{
    return [CDMenuItem findFirst:@"methodid = %d AND lotteryId = %d", methodId, lotteryId];
}

+ (CDMenuItem *)menuItemForMethodName:(NSString *)methodName lottery:(NSInteger)lotteryId{
    return [CDMenuItem findFirst:@"menuName = '%@' AND lotteryId = %d", methodName, lotteryId];
}

+ (MenuItemModel *)menuItemModelForMethodId:(NSInteger)methodId lottery:(NSInteger)lotteryId channelId:(NSInteger)channelId
{
    NSDictionary *root = [AppDelegate shared].methodList;
    for (NSObject *key in root) {
        NSDictionary *d = [root objectForKey:key];
        if ([[d objectForKey:@"lottery_id"] intValue] == lotteryId
            && [[d objectForKey:@"channel_id"] intValue] == channelId) {
            
            NSArray *list = [d objectForKey:@"list"];
            for (NSDictionary * method in list) {
                if ([method intForKey:@"methodid"] == methodId) {
                    MenuItemModel *model = [[[MenuItemModel alloc] init] autorelease];
                    model.lotteryId = [NSNumber numberWithInteger:lotteryId];
                    model.showName = [method objectForKey:@"showname"];
                    model.methodid = [method objectForKey:@"methodid"];
                    model.channel_id = [method objectForKey:@"channel_id"];
                    model.methodPrize = [method objectForKey:@"method_prize"];
                    model.desc = [method objectForKey:@"desc"];
                    
                    return model;
                }
            }
        }
    }
    return nil;
}

+ (MenuItemModel *)menuItemModelForMethodName:(NSString *)methodName lottery:(NSInteger)lotteryId channelId:(NSInteger)channelId
{
    NSDictionary *root = [AppDelegate shared].methodList;
    for (NSObject *key in root) {
        NSDictionary *d = [root objectForKey:key];
        if ([[d objectForKey:@"lottery_id"] intValue] == lotteryId
            && [[d objectForKey:@"channel_id"] intValue] == channelId) {
            
            NSArray *list = [d objectForKey:@"list"];
            for (NSDictionary * method in list) {
                if ([[method objectForKey:@"showname"] isEqualToString:methodName]) {
                    MenuItemModel *model = [[[MenuItemModel alloc] init] autorelease];
                    model.lotteryId = [NSNumber numberWithInteger:lotteryId];
                    model.showName = [method objectForKey:@"showname"];
                    model.methodid = [method objectForKey:@"methodid"];
                    model.channel_id = [method objectForKey:@"channel_id"];
                    model.methodPrize = [method objectForKey:@"method_prize"];
                    model.desc = [method objectForKey:@"desc"];
                    
                    return model;
                }
            }
        }
    }
    return nil;
}

+ (MenuItemModel *)firstMenuItemModelForLottery:(NSInteger)lotteryId channelId:(NSInteger)channelId;{
    NSDictionary *root = [AppDelegate shared].methodList;
    for (NSObject *key in root) {
        NSDictionary *d = [root objectForKey:key];
        if ([[d objectForKey:@"lottery_id"] intValue] == lotteryId
            && [[d objectForKey:@"channel_id"] intValue] == channelId) {
            
            NSArray *list = [d objectForKey:@"list"];
            for (NSDictionary * method in list) {
                    MenuItemModel *model = [[[MenuItemModel alloc] init] autorelease];
                    model.lotteryId = [NSNumber numberWithInteger:lotteryId];
                    model.showName = [method objectForKey:@"showname"];
                    model.methodid = [method objectForKey:@"methodid"];
                    model.channel_id = [method objectForKey:@"channel_id"];
                    model.methodPrize = [method objectForKey:@"method_prize"];
                    model.desc = [method objectForKey:@"desc"];
                    return model;
            }
            break;
        }   //end if
    }
    return nil;
}

//TODO:下面几个方法待调整
+ (CDMenuItem *)menuItemForPlayType:(PlayType)playType{
    return [[self menuTitleItems] objectAtIndex:playType];
}


+ (PlayType)playTypeForMethodName:(NSString *)methodName{
    Echo(@"%s%@", __func__, methodName);
    PlayType type = 0;
    if ([methodName isEqualToString:@"五星直选"]) {
        type = kPlayTypeWXZX;
    } else if([methodName isEqualToString:@"四星直选"]){
        type = kPlayTypeSXZX;
    } else if([methodName isEqualToString:@"后三直选"]){
        type = kPlayTypeHSZX;
    } else if([methodName isEqualToString:@"后三组三"]){
        type = kPlayTypeHSZuSan;
    } else if([methodName isEqualToString:@"后三组六"]){
        type = kPlayTypeHSZuLiu;
    } else if([methodName isEqualToString:@"前三直选"]){
        type = kPlayTypeQSZX;
    } else if([methodName isEqualToString:@"前三组三"]){
        type = kPlayTypeQSZuSan;
    } else if([methodName isEqualToString:@"前三组六"]){
        type = kPlayTypeQSZuLiu;
    } else if([methodName isEqualToString:@"后二直选"]){
        type = kPlayTypeHEZX;
    } else if([methodName isEqualToString:@"后二组选"]){
        type = kPlayTypeHEZuXuan;
    } else if([methodName isEqualToString:@"前二直选"]){
        type = kPlayTypeQEZX;
    } else if([methodName isEqualToString:@"前二组选"]){
        type = kPlayTypeQEZuXuan;
    } else if([methodName isEqualToString:@"定位胆"]){
        type = kPlayTypeDWD;
    } else if([methodName isEqualToString:@"后三一码不定位"]){
        type = kPlayTypeHSYMBDW;
    } else if([methodName isEqualToString:@"前三一码不定位"]){
        type = kPlayTypeQSYMBDW;
    } else if([methodName isEqualToString:@"五星组选60"]){
        type = kPlayTypeWXZuXuan60;
    } else if([methodName isEqualToString:@"五星组选30"]){
        type = kPlayTypeWXZuXuan30;
    }
    
    return type;
}

+ (PlayType)playTypeForMethodId:(int)methodId methodName:(NSString **)methodName{
    int type = 0;
    NSString *menuName = nil;
    CDMenuItem *item = [CDMenuItem findFirst:@"methodid = %d",methodId];
    if (item) {
        menuName = item.menuName;
        *methodName = menuName;
        type = [self playTypeForMethodName:menuName];
    }
    return type;
}

+ (NSInteger)mode{
    NSInteger mode = MSIntForKey(@"BetMode");
    return mode == 0 ? kModeYuan : mode;    //Default is 1
}

+ (void)setMode:(int)mode{
    MSSetIntForKey(mode, @"BetMode");
}

+ (NSString *)modeName{
    return [self modeName:[self mode]];
}

+ (NSString *)modeName:(int)mode{
    return mode == kModeYuan ? @"元" : @"角";
}

+ (CGFloat)amountWithBetCount:(NSInteger)betCount multile:(NSInteger)multile{
    NSInteger mode = [self mode];
    CGFloat amount = betCount * 2.f * multile;
    return mode == kModeYuan ? amount : amount/10.f;    //角模式的时候转换为元
}

+ (CGFloat)amountWithBetCount:(NSInteger)betCount multile:(NSInteger)multile mode:(BetMode)mode{
    CGFloat amount = betCount * 2.f * multile;
    return mode == kModeYuan ? amount : amount/10.f;    //角模式的时候转换为元
}

+ (NSInteger)betCountWithBetItems:(NSArray *)betItems andPlayType:(int)type{
    NSString *tipsText = nil;
    NSInteger betCount = 1;
    switch (type) {
        case kPlayTypeDWD:
        {
            tipsText = @"任意位置上至少选择一个球";
            betCount = 0;
            for (int i = 0; i < [betItems count]; i++) {
                BetItem *item = [betItems objectAtIndex:i];
                betCount += [item count];
            }
        }
            break;
        case kPlayTypeWXZX:
        case kPlayTypeSXZX:
        case kPlayTypeHSZX:
        case kPlayTypeQSZX:
        case kPlayTypeQEZX:
        case kPlayTypeHEZX:
        {
            tipsText = @"每位至少选择一个号码";
            for (int i = 0; i < [betItems count]; i++) {
                BetItem *item = [betItems objectAtIndex:i];
                betCount *= [item count];
            }
        }
            break;
        case kPlayTypeHSZuLiu:         //组六算法
        case kPlayTypeQSZuLiu:
        {
            tipsText = @"至少选择三个号码";
            BetItem *item = [betItems objectAtIndex:0];
            betCount = [item count];
            betCount = betCount < 3 ? 0 : MathC(betCount, 3);
        }
            break;
        case kPlayTypeHSZuSan:        //组三算法
        case kPlayTypeQSZuSan:
        {
            tipsText = @"至少选择两个号码";
            BetItem *item = [betItems objectAtIndex:0];
            betCount = [item count];
            betCount = MathC(betCount,2)*2;
        }
            break;
        case kPlayTypeHEZuXuan:
        case kPlayTypeQEZuXuan:
        {
            tipsText = @"至少选择两个号码";
            BetItem *item = [betItems objectAtIndex:0];
            betCount = [item count];
            betCount = MathC(betCount, 2);
        }
            break;
        default:    //其他玩法
        {
            tipsText = @"至少选择一个号码";
            BetItem *item = [betItems objectAtIndex:0];
            betCount = [item count];
        }
            break;
    }
    tipsText = nil;
    return betCount;
}

+ (int)randomBallCountWithPlayType:(int)type{
    NSString *tipsText = nil;
    int betCount = 1;
    switch (type) {
        case kPlayTypeDWD:
        {
            tipsText = @"任意位置上至少选择一个球";
            betCount = 1;
        }
            break;
        case kPlayTypeWXZX:
        case kPlayTypeSXZX:
        case kPlayTypeHSZX:
        case kPlayTypeQSZX:
        case kPlayTypeQEZX:
        case kPlayTypeHEZX:
        {
            tipsText = @"每位至少选择一个号码";
            betCount = 1;
        }
            break;
        case kPlayTypeHSZuLiu:         //组六算法
        case kPlayTypeQSZuLiu:
        {
            tipsText = @"至少选择三个号码";
            betCount = 3;
        }
            break;
        case kPlayTypeHSZuSan:        //组三算法
        case kPlayTypeQSZuSan:
        {
            tipsText = @"至少选择两个号码";
            betCount = 2;
        }
            break;
        case kPlayTypeHEZuXuan:
        case kPlayTypeQEZuXuan:
        {
            tipsText = @"至少选择两个号码";
            betCount = 2;
        }
            break;
        default:    //其他玩法
        {
            tipsText = @"至少选择一个号码";
            betCount = 1;
        }
            break;
    }
    tipsText = nil;
    return betCount;
}

+ (NSArray *)randomNumbers:(int)count{
    NSMutableArray *numbers = [NSMutableArray array];
    int n = 0;
    for (int i = 0; i < count; i++) {
        while ((n = arc4random_uniform(MaxNumber)) > -1){
            BOOL added = NO;
            for (NSNumber *number in numbers){
                if ([number intValue] == n) {
                    added = YES;
                    break;      //added in, ignore it
                }
            }
            if (added == NO) {  //then add in,and break the while loop,start next loop
                [numbers addObject:[NSNumber numberWithInt:n]];
                break;
            }
        }
    }
    return [NSArray arrayWithArray:numbers];
}

+ (NSString *)jointedNumbers:(NSArray *)betItems{
    NSMutableString *number = [NSMutableString string];
    NSInteger count = [betItems count];
    for (int i = 0; i < count; i++) {
        BetItem *item = [betItems objectAtIndex:i];
        if (i == count - 1){
            [number appendFormat:@"%@", [item serialize]];
        } else {
            [number appendFormat:@"%@|", [item serialize]];
        }
    }
    Echo(@"jointed:%@",number);
    return number;
}

+ (NSString *)numberStringFromBetItems:(NSArray *)betItems{
    return [self jointedNumbers:betItems];
}

+ (void)parseNumberStringToBetItems:(NSString *)numberString betItems:(NSArray *)betItems{
    NSArray *weights = [numberString componentsSeparatedByString:@"|"];
//    NSMutableArray *betItems = [NSMutableArray array];
    for (int i = 0; i < [weights count]; i++) {
        NSString *weightNumberStr = [weights objectAtIndex:i];
        @try {
            BetItem *item = [betItems objectAtIndex:i];
            NSArray *numbers = [weightNumberStr componentsSeparatedByString:@"&"];
            
            for (NSString *nStr in numbers){
                if([nStr length] > 0)
                    [item selectNumberS:nStr];
            }            
        }
        @catch (NSException *exception) {
            
        }
    }
    Echo(@"%s %@",__func__ , numberString);
//    return betItems;
}

@end
//排列 A(n,m)=n(n-1)(n-2)……(n-m+1)= n!/(n-m)!
NSInteger MathA(NSInteger n, NSInteger m){
    if (n  == 0 || m == 0) return 1;
    
    NSInteger a = 1, b = 1;
    for (NSInteger i = n; i > 0; i--) {
        a *= i;
    }
    for (NSInteger i = (n - m); i > 0; i--) {
        b *= i;
    }
    return a/b;
}
//组合 C(n,m)=A(n,m)/m！
NSInteger MathC(NSInteger n, NSInteger m){
    if (n == 0) return 0;
    if (m == 0) return 1;
    
    NSInteger a = MathA(n, m);
    NSInteger b = 1;
    for (NSInteger i = m; i > 0; i--) {
        b *= i;
    }
    return a/b;
}