//
//  SharedModel.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "SharedModel.h"
#import "CDUserInfo.h"
#import "BetManager.h"
#import "RQGameHistory.h"
#import "RQTransactionHistory.h"
#import "RQPublicHistory.h"

@implementation SharedModel
@synthesize errorCode, errorMessage;
@synthesize userAccout = _userAccout;
@synthesize userid = _userid;
@synthesize token = _token;
@synthesize traceStartIssue = _traceStartIssue;
@synthesize username = _username;
@synthesize nickname = _nickname;
@synthesize balance = _balance;
@synthesize totalAmountInSelect = _totalAmountInSelect;
@synthesize pushStartClock, pushEndClock;

static SharedModel *_sharedModel = nil;

- (void)dealloc{
    [_securityPasswd release];
    [_userid  release];
    [_userAccout release];
    [_balance release];
    [_token release];
    [_traceStartIssue release];
    [_username release];
    [_teamBalanceBank release];
    [_teamBalanceHigh release];
    [_teamBalanceLow release];
    [errorMessage release];
    [_oldBalance release];
    [super dealloc];
}

+ (SharedModel *)shared{
    @synchronized(self){
        if (_sharedModel == nil) {
            _sharedModel = [[SharedModel alloc] init];
        }
        return _sharedModel;
    }
}

+ (NSString *)CGISESSID{
    //md5(UnixTime+ip+IMIE)
    return nil;
}

+ (int)userType{
    CDUserInfo *u = [CDUserInfo user];
    if (u){
         return  [u.userType intValue];
    }
    return -1;
}

+ (BOOL)userIsSignedin{
    CDUserInfo *u = [CDUserInfo user];
    return [u.token length] > 0;
}

+ (void)signOut{
//    [SharedModel shared].username = nil;
//    [SharedModel shared].balance = nil;
//    [SharedModel shared].token = nil;;
//    [SharedModel shared].userAccout = nil;
//    [SharedModel shared].userid = nil;
//    [CDUserInfo deleteAll];
    
    CDUserInfo *u = [CDUserInfo user];
    u.token = nil;
    u.userid = nil;
    u.balance = nil;
    u.nickname = nil;
    u.logined = @(0);
    u.unread = @(0);
    [u save];
    
    //Clear caches
    [RQGameHistory clearCache];
    [RQTransactionHistory clearCache];
    [RQPublicHistory clearCache];
}

+ (BOOL)shoudShowTipsForMethod:(int)methodId lottery:(int)lotteryId{
    NSString *path = [NSBundle pathInDocuments:@"TipsCfg.plist"];
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSString *key = [NSString stringWithFormat:@"Ball_TIPS_%d%d", lotteryId,methodId];
    id value = [d objectForKey:key];
    return [value intValue] == 1 ? NO : YES;
}

+ (void)closeTipsForMethod:(int)methodId lottery:(int)lotteryId{
    NSString *path = [NSBundle pathInDocuments:@"TipsCfg.plist"];
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!d) {
        d = [NSMutableDictionary dictionary];
    }
    NSString *key = [NSString stringWithFormat:@"Ball_TIPS_%d%d",lotteryId,methodId];
    [d setObject:[NSNumber numberWithInt:1] forKey:key];
    [d writeToFile:path atomically:YES];
}

+ (void)resetAllMethodTips{
    NSString *path = [NSBundle pathInDocuments:@"TipsCfg.plist"];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (NSString *)balance{
    return [SharedModel shared].balance;
}
+ (NSString *)formattedOldBalance{
    NSString *balance = [SharedModel shared].oldBalance;
    
    return [self formatBalance:balance];
    //    return balance;
}
+ (NSString *)formattedBalance{
    NSString *balance = [SharedModel shared].balance;
    return [self formatBalance:balance];
//    return balance;
}

+ (NSString *)formattedLowBalance
{
    CDUserInfo *u = [[SharedModel shared] userInfo];
    NSString *balance = u.lowBalance;
    return [self formatBalance:balance];
}

+ (NSString *)formatBalance:(NSString *)balance {
    if (!balance) return @"";
    
    NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
    formatter.numberStyle = NSNumberFormatterRoundFloor;
    [formatter setPositiveFormat:@"#,##0.00"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:[balance floatValue]]];
    
    /*
    if (!balance) return @"";
    
    NSRange range = [balance rangeOfString:@"."];
    //Find point's location
    if (range.length > 0){
        NSString *head = [balance substringWithRange:NSMakeRange(0, range.location)];
        NSString *tail = [balance substringWithRange:NSMakeRange(range.location, 3)];//[balance substringFromIndex:range.location];
        NSMutableArray *nums = [NSMutableArray array];
//        Echo(@"%@|%@",head,tail);
        int len = [head length];
        int loc = len > 3 ? len%3 : len;
        if (loc > 0) {
            [nums addObject:[head substringWithRange:NSMakeRange(0, loc)]];
        }
        if (len > 3) {
            for (int i = loc; i <= len - 3; i += 3) {
                [nums addObject:[head substringWithRange:NSMakeRange(i, 3)]];
            }
        }
        
        //joint
        NSString *s = [nums componentsJoinedByString:@","];
        s = [NSString stringWithFormat:@"%@%@",s,tail];
        return s;
    }
    //No point found
    else {
        NSString *head = balance;
        NSMutableArray *nums = [NSMutableArray array];
        int len = [head length];
        int loc = len > 3 ? len%3 : len;
        if (loc > 0) {
            [nums addObject:[head substringWithRange:NSMakeRange(0, loc)]];
        }
        if (len > 3) {
            for (int i = loc; i <= len - 3; i += 3) {
                [nums addObject:[head substringWithRange:NSMakeRange(i, 3)]];
            }
        }
        
        //joint
        NSString *s = [nums componentsJoinedByString:@","];
        return s;
    }
    return balance;
     */
}

+ (NSString *)formatBalancef:(float)balance{
    NSString *str = [NSString stringWithFormat:@"%f",balance];
    //取4位小数
    str = [str substringToIndex:[str length] - 2];
    return [self formatBalance:str];
}

+ (NSString *)formatBalance:(NSString *)balance prefix:(NSString *)prefix subfix:(NSString *)subfix{
    if (prefix)
        return [NSString stringWithFormat:@"%@%@%@",prefix,[self formatBalance:balance], subfix];
    else
        return [NSString stringWithFormat:@"%@%@",[self formatBalance:balance], subfix];
}

+ (NSString *)zhHantRMB:(NSString *)amount{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = kCFNumberFormatterSpellOutStyle;
    nf.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant"];
    NSString *s = [nf stringFromNumber:[NSNumber numberWithFloat:[amount floatValue]]];
    //    零、壹、贰、叁、肆、伍、陆、柒、捌、玖、拾、佰、仟、万、亿
    s = [s stringByReplacingOccurrencesOfString:@"〇" withString:@"零"];
    s = [s stringByReplacingOccurrencesOfString:@"一" withString:@"壹"];
    s = [s stringByReplacingOccurrencesOfString:@"二" withString:@"貳"];
    s = [s stringByReplacingOccurrencesOfString:@"三" withString:@"叁"];
    s = [s stringByReplacingOccurrencesOfString:@"四" withString:@"肆"];
    s = [s stringByReplacingOccurrencesOfString:@"五" withString:@"伍"];
    s = [s stringByReplacingOccurrencesOfString:@"六" withString:@"陆"];
    s = [s stringByReplacingOccurrencesOfString:@"七" withString:@"柒"];
    s = [s stringByReplacingOccurrencesOfString:@"八" withString:@"捌"];
    s = [s stringByReplacingOccurrencesOfString:@"九" withString:@"玖"];
    s = [s stringByReplacingOccurrencesOfString:@"十" withString:@"拾"];
    s = [s stringByReplacingOccurrencesOfString:@"百" withString:@"佰"];
    [nf release];
    return s;
}

+ (NSString *)zhHantDecimalRMB:(NSString *)amount{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = kCFNumberFormatterSpellOutStyle;
    nf.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hant"];
    
    BOOL hasPoint = [amount rangeOfString:@"."].location == NSNotFound ? NO : YES;
    NSArray *septArr = [amount componentsSeparatedByString:@"."];
    NSString *oriDecStr = [septArr lastObject];

    //整数部分
    NSString *iAmount = [septArr objectAtIndex:0];
    iAmount = [nf stringFromNumber:[NSNumber numberWithDouble:[iAmount doubleValue]]];
    
    
    if (hasPoint && [oriDecStr intValue] != 0) {
        iAmount = [iAmount stringByAppendingString:@"元"];
    }else {
        iAmount = [iAmount stringByAppendingString:@"元整"];
    }
    
    //小数部分
    NSMutableString *mStr = [[NSMutableString alloc] init];
    if (hasPoint && [oriDecStr intValue] != 0) {
        NSArray *numArr = @[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
        
        for (int i = 0; i < [oriDecStr length]; ++i) {
            int lt = [[oriDecStr substringWithRange:NSMakeRange(i, 1)] intValue];
            [mStr appendString:[numArr objectAtIndex:lt]];
        }
        
        NSString *decAmount = mStr;
        
        if ([decAmount length] == 2) {
            NSString *j = [decAmount substringToIndex:1];
            NSString *f = [decAmount substringFromIndex:1];
            if ([[oriDecStr substringFromIndex:1] intValue] == 0) {
                decAmount = [NSString stringWithFormat:@"%@角",j];
            }else if ([[oriDecStr substringToIndex:1] intValue] == 0) {
                decAmount = [NSString stringWithFormat:@"%@分",f];
            }else {
                decAmount = [NSString stringWithFormat:@"%@角%@分",j,f];
            }
            
        }else if ([decAmount length] == 1) {
            decAmount = [decAmount stringByAppendingString:@"角"];
        }
        iAmount = [iAmount stringByAppendingString:decAmount];
    }
    
    //    零、壹、贰、叁、肆、伍、陆、柒、捌、玖、拾、佰、仟、万、亿
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"〇" withString:@"零"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"一" withString:@"壹"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"二" withString:@"貳"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"三" withString:@"叁"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"四" withString:@"肆"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"五" withString:@"伍"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"六" withString:@"陆"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"七" withString:@"柒"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"八" withString:@"捌"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"九" withString:@"玖"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"十" withString:@"拾"];
    iAmount = [iAmount stringByReplacingOccurrencesOfString:@"百" withString:@"佰"];
    
    [mStr release];
    [nf release];
    return iAmount;
}

- (CDUserInfo *)userInfo{
    CDUserInfo *u = [CDUserInfo user];
//    if (u == nil) {
//        u = [[CDUserInfo new] autorelease];
//    }
    return u;
}

- (NSString *)username{
    CDUserInfo *u = [self userInfo];
    return u.account;
}

- (void)setUsername:(NSString *)username{
    CDUserInfo *u = [self userInfo];
    u.account = username;
    [u save];
    MSNotificationCenterPost(kNotificationUserInfoUpdated);
}

- (void)setNickname:(NSString *)nickname{
    CDUserInfo *u = [self userInfo];
    u.nickname = nickname;
    [u save];
}

- (NSString *)nickname{
    CDUserInfo *u = [self userInfo];
    return u.nickname;
}

- (NSString *)userAccout{
    return [self username];
}

- (NSString *)userid{
    CDUserInfo *u = [self userInfo];
    return u.userid;
}

- (void)setUserid:(NSString *)userid{
    CDUserInfo *u = [self userInfo];
    u.userid = userid;
    [u save];
}

- (void)setUserAccout:(NSString *)userAccout{
    [self setUsername:userAccout];
}

- (NSString *)balance{
    CDUserInfo *u = [self userInfo];
    NSString *s = u.balance;    //MSStrForKey(@"balance");
    return s == nil ? @"0.0000" : s;
}

- (void)setBalance:(NSString *)balance{
//    float f = [balance floatValue];
//    MSSetStrForKey([NSString stringWithFormat:@"%.04f", f], @"balance");
//    MSSetStrForKey(balance, @"balance");
#ifdef DEBUG
//    balance = @"10.0000";
#endif
    CDUserInfo *u = [self userInfo];
    u.balance = balance;
    [u save];
    MSNotificationCenterPost(kNotificationUserInfoUpdated);
}

- (void)setLowBalance:(NSString *)lowBalance
{
    [_lowBalance release];
    _lowBalance = [lowBalance retain];
    
    CDUserInfo *u = [self userInfo];
    u.lowBalance = lowBalance;
    [u save];
}

- (void)setToken:(NSString *)token{
//    MSSetStrForKey(token, @"token");
    CDUserInfo *u = [self userInfo];
    u.token = token;
    [u save];
}

- (NSString *)token{
//    return MSStrForKey(@"token");
    CDUserInfo *u = [self userInfo];
    return u.token;
}

- (void)setPushStartClock:(NSInteger)pushStartClock_{
    MSSetIntForKey(pushStartClock_, @"pushStartClock");
}

- (NSInteger)pushStartClock{
    return MSIntForKey(@"pushStartClock");
}

- (void)setPushEndClock:(NSInteger)pushEndClock_{
    MSSetIntForKey(pushEndClock_, @"pushEndClock");
}

- (NSInteger)pushEndClock{
    return MSIntForKey(@"pushEndClock");
}

@end
