//
//  CDBetList.m
//  Caipiao
//
//  Created by danal on 13-1-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CDBetList.h"
#import "CDMenuItem.h"
#import "CDLottery.h"
#import "BetCell.h"
#import "BetManager.h"
#import "MethodMenuItem.h"


@implementation CDBetList
@dynamic userAccount;
@dynamic userId;
@dynamic name, type, methodId;
@dynamic playType, number;
@dynamic count,multiple,amount,mode;
@dynamic bid;
@dynamic desc;
@dynamic origNumberStr;
@dynamic betType;
@dynamic channelId;
@dynamic limitbet;
@synthesize lotteryId = _lotteryId;

- (void)dealloc{
    [super dealloc];
}

- (void)setLotteryId:(NSNumber *)lotteryId{
    self.type = [NSString stringWithFormat:@"%@",lotteryId];
}

- (NSNumber *)lotteryId{
    return [NSNumber numberWithInt:[self.type intValue]];
}

+ (void)betListFromBetNumbers:(NSString *)numbers forPlayType:(int)playType{
    //由号码串生成原始投注item
    NSMutableArray *betItems = [NSMutableArray array];
    NSArray *weights = [numbers componentsSeparatedByString:@"|"];
    for (NSString *w in weights){   //位上的号码
        if (w.length == 0) {
            BetItem *betItem = [[BetItem alloc] init];
            [betItems addObject:betItem];
            [betItem release];
        } else {
            BetItem *betItem = [[BetItem alloc] init];
            NSArray *nums = [w componentsSeparatedByString:@"&"];
            for (NSString *nStr in nums){   //统计号码
                if([nStr length] > 0)
                    [betItem selectNumberS:nStr];
            }
            [betItems addObject:betItem];
            [betItem release];
        }
    }
    
    //检测号码是否已加入列表
    {
        CDBetList *bet = [CDBetList findFirst:@"number = '%@'",numbers];
        if (bet) return;
    }
    
    //加入列表
    NSArray *menuItems = [BetManager menuTitleItems];
    CDMenuItem *menuItem = [menuItems objectAtIndex:playType];
    
    CDBetList *bet = [CDBetList new];
    bet.playType = [NSNumber numberWithInt:playType];  //playType;
    bet.name = menuItem.menuName;
    bet.userAccount = [SharedModel shared].username;        //user account
//    bet.userId = [NSNumber numberWithInt:0];                    //user id
    bet.methodId = menuItem.methodid;                               //玩法
//    bet.type = MSIntToStr([RQInitData lotteryId]);                  //彩种：default 1
    bet.bid = [NSNumber numberWithInt:0];
    bet.number = numbers;                                                    //号码
    bet.origNumberStr = numbers;                                        //原始号码格式，必须和投注时的格式一天致
    NSInteger betCount = [BetManager betCountWithBetItems:betItems andPlayType:playType];
    bet.count = [NSNumber numberWithInteger:betCount];      //注数，后台可以按公式计算出
    bet.amount = [NSNumber numberWithFloat:[BetManager amountWithBetCount:betCount multile:1]];    //[NSNumber numberWithInt:2*betCount];               //金额，后台可以计算出
    bet.multiple = MSIntToNumber(1);
    bet.mode = MSIntegerToNumber([BetManager mode]);
    bet.desc = [NSString stringWithFormat:@"[%@]%@",menuItem.menuName,[CDBetList numbersToDesc:numbers]];
    [bet save];
    [bet release];
}

+ (NSMutableArray *)betListForAccount:(NSString *)account{
    return [CDBetList find:@"userAccount = '%@'",[SharedModel shared].username];
}

+ (void)deleteBetListForAccount:(NSString *)account{
    NSMutableArray *list = [self betListForAccount:account];
    for (CDBetList *one in list){
        [one destroy];
    }
}

/*
+ (void)randomListN:(int)betListCount forPlayType:(int)playType{
    int nc = 0;
    TipsType tt = 0 ;
    //产生投注项用于机选号码
    NSArray *betItems = [BetManager betItemsForType:playType tips:nil tipsType:&tt numberCount:nil];
    //检查球的数量
    switch (tt) {
        case kTipsType2:
            nc = 2;
            break;
        case kTipsType3:
            nc = 3;
            break;
        case kTipsType1Any:
            nc = 1;
            break;
        case kTipsType1PW:
        default:
            nc = 1;
            break;
    }
    
    float balance = [[SharedModel shared].balance floatValue];

    for (int i = 0 ; i < betListCount; i++) {
        CDMenuItem *item = [[BetManager menuTitleItems] objectAtIndex:playType];
        CDBetList *bet = [CDBetList new];
        bet.name = item.menuName;
        bet.methodId = item.methodid;
        bet.type = MSIntToStr([RQInitData lotteryId]);                  //彩种：default 1
        bet.userAccount = [SharedModel shared].username;
        bet.multiple = MSIntToNumber(1);
        bet.mode = MSIntToNumber([BetManager mode]);
        bet.playType = MSIntToNumber(playType);
        
        if (tt == kTipsType1Any) {  //只产生一位上的号码
            BetItem *betItem = [betItems objectAtIndex:arc4random_uniform([betItems count])];
            [betItem randomN:nc];
        }
        else {  //产生每一位上的号码
            
            for (int i = 0; i < [betItems count] ; i++) {
                BetItem *betItem = [betItems objectAtIndex:i];
                [betItem randomN:nc];
            }
        }
        
        int betCount = [BetManager betCountWithBetItems:betItems andPlayType:playType];
        float amount =  [BetManager mode] == kModeYuan ? 2.0*betCount : 0.2*betCount;
        bet.count = [NSNumber numberWithInt:betCount];         //注数
        bet.amount = [NSNumber numberWithFloat:amount];
      
        NSString *numberStr = [BetManager jointedNumbers:betItems];
        bet.number = numberStr;
        bet.origNumberStr = numberStr;
        bet.desc  = [CDBetList numbersToDesc:bet.number];
        
        [bet save];
        [bet release];
        
        balance -= [bet.amount floatValue];         //检查余额
        if (balance < amount) {
            break;
        }
        //重置
        for (int i = 0; i < [betItems count] ; i++) {
            BetItem *betItem = [betItems objectAtIndex:i];
            [betItem reset];
        }
    }
}
*/

+ (void)randomListN:(NSInteger)count forMethodName:(NSString *)methodName lottery:(NSInteger)lotteryId channelId:(NSInteger)chid{
    CGFloat balance = [[SharedModel shared].balance floatValue];
    MethodMenuItem *mmItem = [MethodMenuItem itemFromMethodName:methodName lottery:lotteryId channelId:chid];
    for (int i = 0; i < count; i++){
        [mmItem random1];

        CDBetList *bet = [CDBetList new];
        bet.name = methodName;
        bet.betType = mmItem.betType;
        bet.methodId = [NSNumber numberWithInteger:mmItem.methodId];
//        bet.type = MSIntToStr([RQInitData lotteryId]);                  //彩种：default 1
        bet.userAccount = [SharedModel shared].username;
        bet.multiple = MSIntToNumber(1);
        bet.mode = MSIntegerToNumber([BetManager mode]);
        bet.playType = MSIntToNumber([BetManager playTypeForMethodName:methodName]);
        
        NSInteger betCount = mmItem.betCount;
        CGFloat amount =  [BetManager mode] == kModeYuan ? 2.0*betCount : 0.2*betCount;
        bet.count = [NSNumber numberWithInteger:betCount];         //注数
        bet.amount = [NSNumber numberWithFloat:amount];
        balance -= [bet.amount floatValue];
        
        NSString *numberStr = [mmItem jointedNumbers];
        bet.number = numberStr;
        bet.origNumberStr = numberStr;
        bet.desc  = [CDBetList numbersToDesc:bet.number];
        [bet save];
        [bet release];
        
        if (balance < amount) {        //检查余额,当余额不足够购买一注时停止
            break;
        }

    }
}

+ (NSString *)numbersToDesc:(NSString *)numbers{
    return [numbers stringByReplacingOccurrencesOfString:@"|" withString:@","];
}

+ (NSString *)numbersForShow:(NSString *)numbers lotteryId:(NSInteger)lotId channelId:(NSInteger)channelId{
    //两种情况：直选 12|3|4|5 组选 1&2&3，通过'|‘来判断是哪种情况
    CDLottery *lot = [CDLottery findLotteryById:lotId andChannelId:channelId];
    NSString *separator = @"";
    if ([lot.name isEqualToString:SD11X5]){
        separator = @" ";
    }
        
    if ([numbers rangeOfString:@"|"].length > 0) {  //直选
        NSString *s = [numbers stringByReplacingOccurrencesOfString:@"|" withString:@","];
        s = [s stringByReplacingOccurrencesOfString:@"&" withString:separator];
        return s;
    }
    else {
//        NSString *s = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@","];
        NSString *s = [numbers stringByReplacingOccurrencesOfString:@"&" withString:@""];

        return s;
    }
}

- (NSDictionary *)toDict{
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
//    [d setObject:self.name forKey:@"name"];
//    [d setObject:self.betType forKey:@"type"];
//    [d setObject:@"digital" forKey:@"type"];
    [d setObject:self.methodId forKey:@"methodid"];
    [d setObject:self.number forKey:@"codes"];
    [d setObject:self.count forKey:@"nums"];
    [d setObject:self.multiple forKey:@"times"];
    [d setObject:self.amount  forKey:@"money"];
    [d setObject:self.mode forKey:@"mode"];
//    [d setObject:self.desc forKey:@"desc"];
    return d;
}

- (NSString *)numbersForShow{
    return [CDBetList numbersForShow:self.number lotteryId:[self.lotteryId intValue] channelId:[self.channelId intValue]];
}

//重写save方法，在save前检查是否有相同的项，如有则不存储
- (BOOL)save{
    NSArray *items = [CDBetList find:@"number = '%@' and playType = %d", self.number, self.playType.intValue];
    Echo(@"[NUMBER]:%@ (%ld) [PLAYTYPE]:%d",self.number, (long)[items count],self.playType.intValue);
    
    if ([items count] > 1) {
        [self destroy];
        return NO;
    } else{
        return [super save];
    }
}

@end
