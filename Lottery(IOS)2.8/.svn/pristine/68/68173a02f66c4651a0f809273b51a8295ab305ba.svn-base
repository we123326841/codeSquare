//
//  CDLottery.h
//  Caipiao
//
//  Created by danal on 13-8-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StoredModel.h"

@interface CDLottery : StoredModel

@property (nonatomic, retain) NSNumber * lotteryId;
@property (nonatomic, retain) NSNumber * sortIndex;     //用于界面显示排序
@property (nonatomic, retain) NSNumber * curmid;         //菜单id,what does it mean...
@property (nonatomic, retain) NSNumber * totalIssue;         //可追最大奖期数
@property (nonatomic, retain) NSString * logo;               //logo文件
@property (nonatomic, retain) NSString * logoHot;               //logo文件
@property (nonatomic, retain) NSString * name;              //名称
@property (nonatomic, retain) NSString * abbreviation;      //英文简写
@property (nonatomic, retain) NSString * apiUrl;              //接口Url
@property (nonatomic, retain) NSString * issue;               //期号
@property (nonatomic, retain) NSString * endTime;
@property (nonatomic, retain) NSString * startTime;
@property (nonatomic, retain) NSString * introduction;      //简介
@property (nonatomic, retain) NSNumber *paused;          //停止销售
@property (nonatomic, retain) NSString * rtmpUrl;           //直播url
@property (nonatomic, retain) NSNumber *maxTrace;           //最大追号数
@property (nonatomic, retain) NSNumber *channelid;
@property (nonatomic, retain) NSNumber *limitBonus;         //限额
@property (nonatomic, retain) NSNumber *lastMethodId;         //上一次进入的玩法
@property (nonatomic, retain) NSString *cornerTitle;        //右上角标题
@property (nonatomic, retain) NSString *lastOpenCode;        //上一期开奖号码
@property (nonatomic, retain) NSNumber *enable;         //是否启用
@property (nonatomic, retain) NSString *issueCode;        //奖期code
@property (nonatomic, retain) NSNumber *backOutStartFee; //金额超过此数目才收手续费
@property (nonatomic, retain) NSNumber *backOutRadio;    //手续费收的比例
@property (nonatomic, retain) NSNumber *isNewLottery; //是否新彩种
@end

/* 彩种简写
 重庆时时彩
 lot.abbreviation = @"CQSSC";
 黑龙江时时彩
 lot.abbreviation = @"HLJSSC";
 江西时时彩
 lot.abbreviation = @"JX-SSC";
 上海时时乐
 lot.abbreviation = @"SSL";
 山东11选5
 lot.abbreviation = @"SD11Y";
 新疆时时彩
 lot.abbreviation = @"XJSSC";
 江西11选5
 lot.abbreviation = @"JX11-5";
 广东11选5
 lot.abbreviation = @"GD11-5";
 北京快乐8
 lot.abbreviation = @"BJKL8";
 重庆11选5
 lot.abbreviation = @"CQ11-5";
 乐利时时彩
 lot.abbreviation = @"LLSSC";
 天津时时彩
 lot.abbreviation = @"TJSSC";
 乐利11选5
 lot.abbreviation = @"LL11-5";
 吉利分分彩
 lot.abbreviation = @"JLFFC";
 3D
 lot.abbreviation = @"3D";
 P5
 lot.abbreviation = @"P5";
 双色球
 lot.abbreviation = @"colorball";
*/
