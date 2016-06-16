//
//  CD.m
//  Kefu
//
//  Created by danal-rich on 4/23/14.
//  Copyright (c) 2014 enjoy. All rights reserved.
//

#import "CD.h"

@implementation CDUserInfo (Ext)

+ (CDUserInfo *)user{
//    CDUserInfo *ui = [CDUserInfo findFirst];
    CDUserInfo *ui = [CDUserInfo findFirst:@"logined = 1"];
//    if (!ui){
//        ui = [[CDUserInfo new] autorelease];
//        ui.userid = 0;
//        [ui save];
//    }
    return ui;
}

- (BOOL)isLogined{
    return [self.token length] > 0;
}

- (NSString *)lastLotteryName{
    return self.lastLottery ? self.lastLottery : CQSSC;
}

@end

@implementation CDHotLottery (Ext)

+ (NSMutableArray *)allSorted{
    return [CDHotLottery findByOrder:@"sortIndex"];
}

- (CDLottery *)toLottery{
    CDLottery *lot = [CDLottery findFirst:@"lotteryId = %@ AND channelid = %@",self.lotteryId,self.channelid];
    return lot;
}

+ (void)addFromLottery:(CDLottery *)lot{
    CDHotLottery *maxSort = [CDHotLottery findFirstByOrder:@"sortIndex desc"];
    
    CDHotLottery *hot = [CDHotLottery new];
    hot.name = lot.name;
    hot.lotteryId = lot.lotteryId;
    hot.channelid = lot.channelid;
    hot.logo = lot.logo;
    hot.logoHot = lot.logoHot;
    hot.sortIndex = @(maxSort.sortIndex.integerValue+1);
    hot.isNewLottery = lot.isNewLottery;
    [hot save];
    [hot release];
}

@end


@implementation CDLottery (Ext)

+ (void)setupForApp{
    static NSInteger lastest = 150112;
    NSInteger ver = [[NSUserDefaults standardUserDefaults] integerForKey:@"LotVer"];
    if (ver - lastest < 0){
        [CDLottery deleteAll];
        [[NSUserDefaults standardUserDefaults] setInteger:lastest forKey:@"LotVer"];
    }
    NSInteger sort = 0;
    
    //顺利秒秒彩
    {
        CDLottery *lot = [CDLottery findLotteryByName:SHMMC];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = kUrlInit;
            lot.name = SHMMC;
            lot.abbreviation = @"SHMMC";
            lot.logo = @"SHMMC.png";
            lot.logoHot = @"SHMMC-hot.png";
            lot.introduction = @"自主开奖 秒赚万元";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:15];
            lot.curmid = [NSNumber numberWithInteger:50];
            lot.totalIssue = [NSNumber numberWithInteger:120];
            lot.maxTrace = [NSNumber numberWithInteger:120];
            lot.limitBonus = @400000;
            lot.enable = [NSNumber numberWithBool:YES];
            lot.cornerTitle=@"新彩种";
            lot.isNewLottery = @(YES);
            [lot save];
        }
        else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    
    
    
    
    
    //苏三
    {
        CDLottery *lot = [CDLottery findLotteryByName:JSK3];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = KUrlInit3D;
            lot.name = JSK3;
            lot.abbreviation = @"JSK3";
            lot.logo = @"jiangshu_icon2.png";
            lot.logoHot = @"jiangshu_icon1.png";
            lot.introduction = @"";
           // lot.isNewLottery = @(YES);
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:16];
            lot.curmid = [NSNumber numberWithInteger:0];
            lot.totalIssue = [NSNumber numberWithInteger:0];
            lot.maxTrace = [NSNumber numberWithInteger:120];
            lot.enable = [NSNumber numberWithBool:YES];
            lot.limitBonus = @400000;
           // lot.cornerTitle=@"新彩种";
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    //重庆时时彩
    {
        CDLottery *lot = [CDLottery findLotteryByName:CQSSC];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = kUrlInit;
            lot.name = CQSSC;
            lot.abbreviation = @"CQSSC";
            lot.logo = @"CQSSC.png";
            lot.logoHot = @"CQSSC-hot.png";
            lot.introduction = @"人气最高 各类玩法应有尽有";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:1];
            lot.curmid = [NSNumber numberWithInteger:50];
            lot.totalIssue = [NSNumber numberWithInteger:120];
            lot.maxTrace = [NSNumber numberWithInteger:120];
            lot.limitBonus = @400000;
            lot.enable = [NSNumber numberWithBool:YES];
            [lot save];
        }
        else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    //P5
    {
        CDLottery *lot = [CDLottery findLotteryByName:LOW_P5];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = KUrlInit3D;
            lot.name = LOW_P5;
            lot.abbreviation = @"P5";
            lot.logo = @"p5.png";
            lot.logoHot = @"p5-hot.png";
            lot.introduction = @"";
            lot.isNewLottery = @(NO);
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:1];
            lot.lotteryId = [NSNumber numberWithInteger:2];
            lot.curmid = [NSNumber numberWithInteger:0];
            lot.totalIssue = [NSNumber numberWithInteger:0];
            lot.maxTrace = [NSNumber numberWithInteger:20];
            lot.enable = [NSNumber numberWithBool:YES];
            lot.limitBonus = @200000;
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
             [lot save];
        }
    }
    //吉利分分彩
    {
        CDLottery *lot = [CDLottery findLotteryByName:JLFFC];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = KUrlInitJLFFC;
            lot.name = JLFFC;
            lot.abbreviation = @"JLFFC";
            lot.logo = @"JLFFC.png";
            lot.logoHot = @"JLFFC-hot.png";
            lot.introduction = @"分分投注 中奖不停！";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:14];
            lot.curmid = [NSNumber numberWithInteger:799];
            lot.totalIssue = [NSNumber numberWithInteger:1380];
            lot.maxTrace = [NSNumber numberWithInteger:720];
            lot.limitBonus = @400000;
            lot.cornerTitle = @"自主彩种";
            lot.enable = [NSNumber numberWithBool:YES];
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
             [lot save];
        }
    }
    //乐利时时彩
    {
        CDLottery *lot = [CDLottery findLotteryByName:LLSSC];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = kUrlInitLLSSC;
            lot.rtmpUrl = kUrlRTMP;
            lot.name = LLSSC;
            lot.abbreviation = @"LLSSC";
            lot.logo = @"LELISSC.png";
            lot.logoHot = @"LELISSC-hot.png";
            lot.introduction = @"单注投注 奖项高达50万";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:11];
            lot.curmid = [NSNumber numberWithInteger:531];
            lot.totalIssue = [NSNumber numberWithInteger:276];
            lot.maxTrace = [NSNumber numberWithInteger:276];
            lot.limitBonus = @400000;
            lot.cornerTitle = @"自主彩种";
            lot.enable = [NSNumber numberWithBool:YES];
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    //乐利11选5
    {
        CDLottery *lot = [CDLottery findLotteryByName:LL11X5];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = kUrlInitLL115;
            lot.rtmpUrl = kUrlRTMP_LL11X5;
            lot.name = LL11X5;
            lot.abbreviation = @"LL11X5";
            lot.logo = @"LELI115.png";
            lot.logoHot = @"LELI115-hot.png";
//            lot.introduction = @"奖池高达2000万";
            lot.introduction = @"熊猫独家 真人美女视频开奖";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:13];
            lot.curmid = [NSNumber numberWithInteger:753];
            lot.totalIssue = [NSNumber numberWithInteger:78];
            lot.maxTrace = [NSNumber numberWithInteger:276];
            lot.limitBonus = @400000;
            lot.cornerTitle = @"自主彩种";
            lot.enable = [NSNumber numberWithBool:YES];
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
   
    //山东11选5
    {
        CDLottery *lot = [CDLottery findLotteryByName:SD11X5];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = kUrlInitSD115;
            lot.name = SD11X5;
            lot.abbreviation = @"SD11x5";
            lot.logo = @"SD115.png";
            lot.logoHot = @"SD115-hot.png";
            lot.introduction = @"又名""11夺运金”猜对一个就中奖";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:5];
            lot.curmid = [NSNumber numberWithInteger:174];
            lot.totalIssue = [NSNumber numberWithInteger:78];
            lot.maxTrace = [NSNumber numberWithInteger:120];
            lot.limitBonus = @400000;
            lot.enable = [NSNumber numberWithBool:YES];
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    //江西时时彩
    {
        CDLottery *lot = [CDLottery findLotteryByName:JXSSC];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = kUrlInit;
            lot.name = JXSSC;
            lot.abbreviation = @"jxssc";
            lot.logo = @"JXSSC.png";
            lot.logoHot=@"JXSSC-hot.png";
            lot.introduction = @"10分钟一期 最高奖金18万";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:3];
            lot.curmid = [NSNumber numberWithInteger:50];
            lot.totalIssue = [NSNumber numberWithInteger:120];
            lot.maxTrace = [NSNumber numberWithInteger:120];
            lot.limitBonus = @400000;
            lot.enable = [NSNumber numberWithBool:YES];
            //lot.cornerTitle = @"新彩种";
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    //新疆时时彩
    {
        CDLottery *lot = [CDLottery findLotteryByName:XJSSC];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = kUrlInitSD115;
            lot.name = XJSSC;
            lot.abbreviation = @"xjssc";
            lot.logo = @"XJSSC.png";
            lot.logoHot=@"XJSSC-hot.png";
            lot.introduction = @"10分钟一期 开奖到凌晨2点";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:6];
            lot.curmid = [NSNumber numberWithInteger:50];
            lot.totalIssue = [NSNumber numberWithInteger:120];
            lot.maxTrace = [NSNumber numberWithInteger:120];
            lot.limitBonus = @400000;
            lot.enable = [NSNumber numberWithBool:YES];
            //lot.cornerTitle = @"新彩种";
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    //天津时时彩
    {
        CDLottery *lot = [CDLottery findLotteryByName:TJSSC];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = kUrlInitSD115;
            lot.name = TJSSC;
            lot.abbreviation = @"tjssc";
            lot.logo = @"TJSSC.png";
            lot.logoHot=@"TJSSC-hot.png";
            lot.introduction = @"10分钟一期 全天共84期";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:4];
            lot.lotteryId = [NSNumber numberWithInteger:12];
            lot.curmid = [NSNumber numberWithInteger:50];
            lot.totalIssue = [NSNumber numberWithInteger:120];
            lot.maxTrace = [NSNumber numberWithInteger:120];
            lot.limitBonus = @400000;
            lot.enable = [NSNumber numberWithBool:YES];
            //lot.cornerTitle = @"新彩种";
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
   //3D
    {
        CDLottery *lot = [CDLottery findLotteryByName:LOW_3D];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = KUrlInit3D;
            lot.name = LOW_3D;
            lot.abbreviation = @"3D";
            lot.logo = @"3D.png";
            lot.logoHot = @"3D-hot.png";
            lot.introduction = @"";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:1];
            lot.lotteryId = [NSNumber numberWithInteger:1];
            lot.curmid = [NSNumber numberWithInteger:65];
            lot.totalIssue = [NSNumber numberWithInteger:1];
            lot.maxTrace = [NSNumber numberWithInteger:20];
            lot.limitBonus = @200000;
            lot.enable = [NSNumber numberWithBool:YES];
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    //双色球
    {
        CDLottery *lot = [CDLottery findLotteryByName:LOW_SSQ];
        if (!lot){
            lot = [[CDLottery new] autorelease];
            lot.apiUrl = KUrlInitSSQ;
            lot.name = LOW_SSQ;
            lot.abbreviation = @"SSQ";
            lot.logo = @"SSQ.png";
            lot.logoHot = @"SSQ-hot.png";
            lot.introduction = @"";
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            lot.channelid = [NSNumber numberWithInteger:1];
            lot.lotteryId = [NSNumber numberWithInteger:3];
            lot.curmid = [NSNumber numberWithInteger:155];
            lot.totalIssue = [NSNumber numberWithInteger:1];
            lot.maxTrace = [NSNumber numberWithInteger:20];
            lot.limitBonus = [NSNumber numberWithInteger:NSIntegerMax];
            lot.enable = [NSNumber numberWithBool:YES];
            [lot save];
        }else
        {
            lot.sortIndex = [NSNumber numberWithInteger:sort++];
            [lot save];
        }
    }
    
    //黑龙江时时彩
    {
//        CDLottery *lot = [CDLottery findLotteryByName:HLJSSC];
//        if (!lot){
//            lot = [[CDLottery new] autorelease];
//            lot.apiUrl = kUrlInit;
//            lot.name = HLJSSC;
//            lot.abbreviation = @"HLJSSC";
//            lot.logo = @"";
//            lot.introduction = @"";
//            lot.sortIndex = [NSNumber numberWithInteger:sort++];
//            lot.channelid = [NSNumber numberWithInteger:4];
//            lot.lotteryId = [NSNumber numberWithInteger:2];
//            lot.curmid = [NSNumber numberWithInteger:0];
//            lot.totalIssue = [NSNumber numberWithInteger:0];
//            lot.maxTrace = [NSNumber numberWithInteger:0];
//            lot.limitBonus = @400000;
//            [lot save];
//        }
    }

    //上海时时乐
    {
//        CDLottery *lot = [CDLottery findLotteryByName:SHSSL];
//        if (!lot){
//            lot = [[CDLottery new] autorelease];
//            lot.apiUrl = kUrlInit;
//            lot.name = SHSSL;
//            lot.abbreviation = @"SSL";
//            lot.logo = @"";
//            lot.introduction = @"";
//            lot.sortIndex = [NSNumber numberWithInteger:sort++];
//            lot.channelid = [NSNumber numberWithInteger:4];
//            lot.lotteryId = [NSNumber numberWithInteger:4];
//            lot.curmid = [NSNumber numberWithInteger:0];
//            lot.totalIssue = [NSNumber numberWithInteger:0];
//            lot.maxTrace = [NSNumber numberWithInteger:0];
//            lot.limitBonus = @400000;
//            [lot save];
//        }
    }
 
    //江西11选5
    {
//        CDLottery *lot = [CDLottery findLotteryByName:JX11X5];
//        if (!lot){
//            lot = [[CDLottery new] autorelease];
//            lot.apiUrl = kUrlInitSD115;
//            lot.name = JX11X5;
//            lot.abbreviation = @"JX11-5";
//            lot.logo = @"";
//            lot.introduction = @"";
//            lot.sortIndex = [NSNumber numberWithInteger:sort++];
//            lot.channelid = [NSNumber numberWithInteger:4];
//            lot.lotteryId = [NSNumber numberWithInteger:7];
//            lot.curmid = [NSNumber numberWithInteger:0];
//            lot.totalIssue = [NSNumber numberWithInteger:0];
//            lot.maxTrace = [NSNumber numberWithInteger:0];
//            lot.limitBonus = @400000;
//            [lot save];
//        }
    }
    //广东11选5
    {
//        CDLottery *lot = [CDLottery findLotteryByName:GD11X5];
//        if (!lot){
//            lot = [[CDLottery new] autorelease];
//            lot.apiUrl = kUrlInitSD115;
//            lot.name = GD11X5;
//            lot.abbreviation = @"GD11-5";
//            lot.logo = @"";
//            lot.introduction = @"";
//            lot.sortIndex = [NSNumber numberWithInteger:sort++];
//            lot.channelid = [NSNumber numberWithInteger:4];
//            lot.lotteryId = [NSNumber numberWithInteger:8];
//            lot.curmid = [NSNumber numberWithInteger:0];
//            lot.totalIssue = [NSNumber numberWithInteger:0];
//            lot.maxTrace = [NSNumber numberWithInteger:0];
//            lot.limitBonus = @400000;
//            [lot save];
//        }
    }
    //北京快乐8
    {
//        CDLottery *lot = [CDLottery findLotteryByName:BJKL8];
//        if (!lot){
//            lot = [[CDLottery new] autorelease];
//            lot.apiUrl = kUrlInitSD115;
//            lot.name = BJKL8;
//            lot.abbreviation = @"BJKL8";
//            lot.logo = @"";
//            lot.introduction = @"";
//            lot.sortIndex = [NSNumber numberWithInteger:sort++];
//            lot.channelid = [NSNumber numberWithInteger:4];
//            lot.lotteryId = [NSNumber numberWithInteger:9];
//            lot.curmid = [NSNumber numberWithInteger:0];
//            lot.totalIssue = [NSNumber numberWithInteger:0];
//            lot.maxTrace = [NSNumber numberWithInteger:0];
//            lot.limitBonus = @400000;
//            [lot save];
//        }
    }
    //重庆11选5
    {
//        CDLottery *lot = [CDLottery findLotteryByName:CQ11X5];
//        if (!lot){
//            lot = [[CDLottery new] autorelease];
//            lot.apiUrl = kUrlInitSD115;
//            lot.name = CQ11X5;
//            lot.abbreviation = @"CQ11-5";
//            lot.logo = @"";
//            lot.introduction = @"";
//            lot.sortIndex = [NSNumber numberWithInteger:sort++];
//            lot.channelid = [NSNumber numberWithInteger:4];
//            lot.lotteryId = [NSNumber numberWithInteger:10];
//            lot.curmid = [NSNumber numberWithInteger:0];
//            lot.totalIssue = [NSNumber numberWithInteger:0];
//            lot.maxTrace = [NSNumber numberWithInteger:0];
//            lot.limitBonus = @400000;
//            [lot save];
//        }
    }
    
    //Hots
    NSString *introVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"IntroVersion"];
    if (introVersion == nil || [introVersion compare:[NSBundle appVersion]] != NSOrderedSame) {
        [CDHotLottery deleteAll];
    }

    
    if ([[CDHotLottery count] integerValue] == 0){
        [CDHotLottery addFromLottery:[CDLottery findLotteryByName:JLFFC]];
        [CDHotLottery addFromLottery:[CDLottery findLotteryByName:LLSSC]];
        [CDHotLottery addFromLottery:[CDLottery findLotteryByName:LL11X5]];
        [CDHotLottery addFromLottery:[CDLottery findLotteryByName:CQSSC]];
        //[CDHotLottery addFromLottery:[CDLottery findLotteryByName:SD11X5]];
        [CDHotLottery addFromLottery:[CDLottery findLotteryByName:SHMMC]];
    }

}

+ (CDLottery *)lotteryForValue:(id)value ofProperty:(SEL)sel{
    CDLottery *lot = nil;
    if ([value isKindOfClass:[NSNumber class]]){
        lot = [CDLottery findFirst:@"%@ = %@", NSStringFromSelector(sel), value];
    } else {
        lot = [CDLottery findFirst:@"%@ = '%@'", NSStringFromSelector(sel), value];
    }
    return lot;
}

+ (CDLottery *)findLotteryByName:(NSString *)lotName{
    return [CDLottery findFirst:@"name = '%@'", lotName];
}

+ (CDLottery *)findLotteryById:(NSInteger)lotteryId andChannelId:(NSInteger)channelId{
    return [CDLottery findFirst:@"lotteryId = %ld AND channelid = %ld", (long)lotteryId, (long)channelId];
}

+ (NSString *)findNameById:(NSInteger)lotteryId andChannelId:(NSInteger)channelId{
    CDLottery *lot = [CDLottery findFirst:@"lotteryId = %ld AND channelid = %ld", (long)lotteryId, (long)channelId];
    return lot.name;
}

+ (NSMutableArray *)allEnabled{
    return [CDLottery findByOrder:@"sortIndex" andQuery:@"enable = 1"];
}

+ (NSMutableArray *)allEnabledButHot{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSMutableArray *all = [self allEnabled];
    for (CDLottery *lot in all){
        if ([CDHotLottery findFirst:@"name = '%@'",lot.name]){
            [temp addObject:lot];
        }
    }
    for (CDLottery *lot in temp){
        [all removeObject:lot];
    }
    [temp removeAllObjects];
    [temp release];
    return all;
}

@end