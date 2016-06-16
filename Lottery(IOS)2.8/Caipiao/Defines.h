//
//  Defines.h
//  Caipiao
//
//  Created by danal-rich on 13-11-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#ifndef Caipiao_Defines_h
#define Caipiao_Defines_h


typedef NS_ENUM(NSInteger,UserType) {
    kUserTypePlayer =  0,
    kUserTypeTopAgent = 1,
    kUserTypeAgent = 2,
} ;

typedef NS_ENUM(NSInteger,PasswordType) {
    kPasswordTypeLogin,
    kPasswordTypeSecCreate,
    kPasswordTypeSecChange
} ;

typedef NS_ENUM(NSInteger,CoverType) {
    kCoverTypeNone,
    kCoverTypeChunjie,
    kCoverTypeYuanxiao
} ;

typedef NS_ENUM(NSInteger,Channel) {
    kChannelLow = 1,
    kChannelHigh = 4
} ;


//Strings
#define kStringNetworkErrorTips     NSLocalizedString(@"Network error tips",nil)
#define kStringNoDataTips           NSLocalizedString(@"No data tips",nil)
#define kStringLoading              NSLocalizedString(@"Loading...",nil)
#define kStringWaiting              NSLocalizedString(@"Waiting...",nil)

//Comment this line to disable the debug codes
//#define METHOD_MENU_DEBUG 1


//Fonts
#define kFontProximaNovaBold        @"ProximaNova-Semibold"
#define kFontProximaNoveReg         @"ProximaNova-Regular"


//Colors
#define RGBAHex(hex_)               [UIColor rgbColorWithHex:hex_]
#define RGBAi(r_,g_,b_,a_)          [UIColor colorWithRed:r_/255.f green:g_/255.f blue:b_/255.f alpha:a_/255.f]

#define kDarkGrayTextColor          [UIColor darkGrayColor]
#define kLightGrayTextColor         [UIColor lightGrayColor]
#define kLightGrayBGColor           RGBAHex(@"EEEEEE")
#define kYellowColor                [UIColor yellowColor]
#define kNavTitleColor              [UIColor rgbColorWithHex:@"#D77400"]
#define kNavTitleShadowColor        [UIColor rgbColorWithHex:@"#ffde56"]
#define kButtonTitleColor           [UIColor orangeColor]
#define kWhiteTextColor             [UIColor whiteColor]
#define kYellowTextColor            [UIColor rgbColorWithHex:@"#FFCB00"]       //FFE200
#define kYellowWhiteTextColor       [UIColor rgbColorWithHex:@"#ffd734"]
#define kMenuTextColor              [UIColor rgbColorWithHex:@"#FFD025"]         //FFD027
#define kDarkGreenColor             [UIColor rgbColorWithHex:@"#022818"]
#define kGreenBGColor               [UIColor colorWithRed:3/255.0 green:58/255.0 blue:34/255.0 alpha:1.0]
#define kBlackTranslucentColor      [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]
#define kGrayTipsTextColor          [UIColor lightGrayColor]
#define kBlackButtonTitleColor      [UIColor colorWithRed:0 green:35.f/255 blue:17.f/255 alpha:1.f]


//format

#define  JXIntToString(value) [NSString stringWithFormat:@"%d",value]

#define  JXFloatToString(value) [NSString stringWithFormat:@"%.2f%@",value,@"%"]


#define  JXDoubleToString(value) [NSString stringWithFormat:@"%.2f",value]

#define  JXLongToString(value) [NSString stringWithFormat:@"%lld",value]

//Notifications
#define kNotificationUserInfoUpdated            @"NotificationUserInfoUpdated"
#define kNotificationIssueNumberUpdated         @"NotificationIssueNumberUpdated"
#define kNotificationPublicHistoryUpdated       @"NotificationPublicHistoryUpdated"
#define kNotificationUserPointUpdated           @"NotificationUserPointUpdated"
#define kNotificationLastOpenCodeUpdated        @"NotificationLastOpenCodeUpdated"

#define kUserDefaultsLastUpdateUserPointDate    @"LastUpdateUserPointDate"
#define kUserDefaultsZhuiHaoChannelIsLowGame    @"ZhuiHaoChannelIsLowGame"
#define kUserDefaultsGameHistoryChannelIsLowGame @"GameHistoryChannelIsLowGame"
#define kUserDefaultsTransRecordChannelIsLowGame @"TransRecordChannelIsLowGame"
#define kMyAccountRecordReqFinish @"MyAccountRecordReqFinish"
#define kHomeViewControllerNewInfo    @"HomeViewControllerNewInfo"
#define kSettingViewControllerLoginOutNotification @"kSettingViewControllerLoginOutNotification"
//Shortcuts
#define Color(key_) [AppDelegate color:key_]
#define Res(file_) (@"Resources.bundle/"file_)

static inline UIImage* ResImage(NSString *file){
    return [UIImage imageNamed:[NSString stringWithFormat:@"Resources.bundle/%@",file]];
}

#define IPHONE4         ([[UIScreen mainScreen] bounds].size.height == 480.f ? YES : NO)
#define IPHONE5         ([[UIScreen mainScreen] bounds].size.height > 480.f ? YES : NO)
#define IOS7            [[[UIDevice currentDevice] systemVersion] intValue] >= 7
#define KEY_WINDOW      [[UIApplication sharedApplication] keyWindow]

#define GLOBAL_QUEUE    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MAIN_QUEUE      dispatch_get_main_queue()


#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

//Constants
#define kAdAutoScrollTime 5.0f

#define kWXAppID @"wxd0574bb8bb6f00d9"
#define kWXAppKey @"f245dede54a6321e42212184c95fa3a5"

#define kQQAPPID	@"1104813302"
#define kQQAPPKEY	@"DtuiknQIw6uXmj30"



//======Flurry event trace=======
#define kFlurryAPPKey       @"YFJS8YPRVTSD2J9RBPJK"
#define FLEvent(eventName)  [Flurry logEvent:eventName timed:NO];

#define  kFLEventRecharge       @"账户－充值按钮"
#define  kFLEventWithdraw       @"账户－提现按钮"
#define  kFLEventFundDetail     @"账户－资金明细"
//#define  kFLEventShortcuts      @"快捷入口"
//#define  kFLEventGotoBet        @"精彩推荐－去投注"
#define  kFLEventADClick        @"活动区域"


//2.3.2 VERSION NEEDS
#define  kFLEventShortcuts      @"精彩推荐-导航"
#define  kFLEventGotoBet        @"精彩推荐－去投注"

#define  kFLEventHallP5         @"购彩大厅-排五"
#define  kFLEventHallJLFFC      @"购彩大厅-吉利分分彩"
#define  kFLEventHallLLSSC      @"购彩大厅-乐利时时彩"
#define  kFLEventHallCQSSC      @"购彩大厅-重庆时时彩"
#define  kFLEventPublicHistoryP5BetNow          @"开奖走势-排5立即投注"
#define  kFLEventPublicHistoryDetailsP5BetNow   @"开奖走势詳情-排5立即投注"
#define  kFLEventUserMail       @"我的账户-站内信"
#define  kFLEventSetting        @"我的账户-设置"
#define  kFLEventManageCard     @"我的账户-设置银行卡管理"
#define  kFLEventMoneyMode      @"我的账户-元角模式"
#define  kFLEventLL11x5Video    @"乐利11选5-视频"
#define  kFLEventP5Bet          @"排列5-投注"


//Deprecated
#define kFLEventHall @"购彩大厅"
#define kFLEventChannelTransfer @"频道转账"
#define kFLEventGameHistory @"游戏记录"
#define kFLEventZhuiHaoHistory @"查看追号"
#define kFLEventPublickHistory @"开奖信息"
#define kFLEventTransactionHistory @"账变列表"
#define kFLEventInformationList @"公告列表"
#define kFLEventSetting @"设置"
#define kFLEventLogout @"退出"
#define kFLEventRefreshBalacne @"刷新余额"
#define kFLEventEditBetList @"编辑注单"
#define kFLEventGoOnSelecting @"继续选"
#define kFLEventRandomN @"机选N注"
#define kFLEventChangePlayType @"切换玩法"
#define kFLEventRandom @"机选"
#define kFLEventClosePlayTips @"关闭玩法提示"
#define kFLEventWeightMenu @"选"
#define kFLEventChangeMode @"切换元角模式"
#define kFLEventClearNumber @"清空号码"

#define kFLEventBetHistoryNumber @"投注-往期号码"
#define kFLEventBetWithMultiple @"投注-倍投"
#define kFLEventBetAdd @"投注-添加"
#define kFLEventBetToList @"投注-加入号码篮"
#define kFLEventBetTrace @"投注-追号"
#define kFLEventBetStartIssue @"投注-起始期"
#define kFLEventBetTimeup @"投注时间到"
#define kFLEventNetworkError @"网络不稳定"
#define kFLEventBetConfirmCancel @"投注确认-取消"
#define kFLEventBetConfirmOK @"投注确认-确定"
#define kFLEventLollyVideo @"乐利视频"



//Headers
#import "AppDelegate.h"
#import "LoadingAlertView.h"
#import "UIButton+Additions.h"
#import "UIAlertView+Additions.h"
#import "BetManager.h"
#import "AlertHUD.h"
#import "Flurry.h"


#endif
