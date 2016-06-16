//
//  BetManager.h
//  Caipiao
//  用来获取玩法
//  Created by danal on 13-1-21.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BetItem.h"
#import "MenuItemModel.h"

@class CDMenuItem;

#define GE @"个"
#define SHI @"十"
#define BAI @"百"
#define QIAN @"千"
#define WAN @"万"
#define ER_CHONG_HAO @"二重号"
#define DAN_HAO @"单号"

/*
  增加彩种流程：
  1.增加彩种名与玩法缩写 
  2.更新CDLottery类setupForApp方法，增加大厅彩种入口
  3.检查是否需要更新simpleInit接口的请求
  4.MethodMenuItem+Factory中增加该彩种的玩法
*/
//彩种
static NSString *const CQSSC = @"重庆时时彩";
static NSString *const HLJSSC = @"黑龙江时时彩";
static NSString *const JXSSC = @"江西时时彩";
static NSString *const SHSSL = @"上海时时乐";
static NSString *const SD11X5 = @"山东11选5";
static NSString *const XJSSC = @"新疆时时彩";
static NSString *const JX11X5 = @"江西11选5";
static NSString *const GD11X5 = @"广东11选5";
static NSString *const BJKL8 = @"北京快乐8";
static NSString *const CQ11X5 = @"重庆11选5";
static NSString *const TJSSC = @"天津时时彩";
static NSString *const LLSSC = @"乐利时时彩";
static NSString *const LL11X5 = @"乐利11选5";
static NSString *const JLFFC = @"吉利分分彩";
static NSString *const JSK3 = @"江苏快三";
static NSString *const SHMMC =@"顺利秒秒彩";
static NSString *const LOW_3D = @"3D";
static NSString *const LOW_P5 = @"排列5";
static NSString *const LOW_SSQ = @"双色球";


//玩法
static NSString *const WXZX = @"五星直选";
static NSString *const WXZuXuan60 = @"五星组选60";
static NSString *const WXZuXuan30 = @"五星组选30";
static NSString *const WXZuXuan120 = @"五星组选120";
static NSString *const WXZuXuan20 = @"五星组选20";
static NSString *const WXZuXuan10 = @"五星组选10";
static NSString *const WXZuXuan5 = @"五星组选5";
static NSString *const WXSMBDW = @"五星三码不定位";
static NSString *const WXEMBDW = @"五星二码不定位";
static NSString *const WMQWSX = @"五码趣味三星";

static NSString *const SXZX = @"四星直选";
static NSString *const SXZuXuan24 = @"四星组选24";
static NSString *const SXZuXuan12 = @"四星组选12";
static NSString *const SXEMBDW = @"四星二码不定位";

static NSString *const QSDXDS = @"前三大小单双";
static NSString *const QSEMBDW = @"前三二码不定位";

static NSString *const HSZX = @"后三直选";
static NSString *const HSZuSan = @"后三组三";
static NSString *const HSZuLiu = @"后三组六";
static NSString *const QSZX = @"前三直选";
static NSString *const QSZuSan = @"前三组三";
static NSString *const QSZuLiu = @"前三组六";
static NSString *const HEZX = @"后二直选";
static NSString *const HEZuXuan = @"后二组选";
static NSString *const QEZX = @"前二直选";
static NSString *const QEZuXuan = @"前二组选";
static NSString *const DWD = @"定位胆";
static NSString *const HSYMBDW = @"后三一码不定位";
static NSString *const QSYMBDW = @"前三一码不定位";
static NSString *const DEFAULT1 = @"DEFAULT1";

static NSString *const QSZuXuan = @"前三组选";
static NSString *const RX1Z1 = @"任选一中一";
static NSString *const RX2Z2 = @"任选二中二";
static NSString *const RX3Z3 = @"任选三中三";
static NSString *const RX4Z4 = @"任选四中四";
static NSString *const RX5Z5 = @"任选五中五";
static NSString *const RX5Z5DT = @"任选五中五胆拖";
static NSString *const QSZX_HZ = @"前三组选_和值";
static NSString *const QSZX_BD = @"前三组选_包胆";
static NSString *const HSZX_BD = @"后三组选_包胆";
static NSString *const HSEMBDW = @"后三二码不定位";
static NSString *const HSZX_HZ = @"后三组选_和值";
static NSString *const HSDXDS = @"后三大小单双";
static NSString *const HSZX_KD = @"后三直选_跨度";
static NSString *const HS_HZWS = @"后三_和值尾数";
static NSString *const HSTSH = @"后三特殊号";
static NSString *const QEZXKD = @"前二直选跨度";
static NSString *const HEZXKD = @"后二直选跨度";
static NSString *const HEZXHZ = @"后二直选和值";
static NSString *const HEDXDS = @"后二大小单双";
static NSString *const YFFS = @"一帆风顺";
static NSString *const HSCS = @"好事成双";
static NSString *const SXBX = @"三星报喜";
static NSString *const SJFC = @"四季发财";

static NSString *const Low3D_ZX = @"直选";
static NSString *const Low3D_ZXHZ = @"直选和值";
static NSString *const Low3D_ZS = @"组三";
static NSString *const Low3D_ZL = @"组六";
static NSString *const Low3D_HHZX = @"混合组选";
static NSString *const Low3D_ZuXHZ = @"组选和值";
static NSString *const Low3D_YMBDW = @"一码不定位";
static NSString *const Low3D_EMBDW = @"二码不定位";
static NSString *const Low3D_QEZX = @"前二直选";
static NSString *const Low3D_QEZuX = @"前二组选";
static NSString *const Low3D_HEZX = @"后二直选";
static NSString *const Low3D_HEZuX = @"后二组选";
static NSString *const Low3D_QEDXDS = @"前二大小单双";
static NSString *const Low3D_HEDXDS = @"后二大小单双";
static NSString *const Low3D_DWDBW = @"定位胆百位";
static NSString *const Low3D_DWDSW = @"定位胆十位";
static NSString *const Low3D_DWDGW = @"定位胆个位";
static NSString *const LowSSQ_FS = @"复式";
static NSString *const LowSSQ_DT = @"胆拖";


static NSString *const P5H2_FS = @"P5后二直选";
static NSString *const P5H2_HZ = @"P5后二直选_和值";
static NSString *const P5H2_KD = @"P5后二直选_跨度";

static NSString *const P5H2_ZXFS = @"P5后二组选";
static NSString *const P5H2_ZXHZ = @"P5后二组选_和值";
static NSString *const P5H2_ZXBD = @"P5后二组选_包胆";

static NSString *const P5_DWD = @"定位胆";

static NSString *const P3SX_FS = @"P3直选";
static NSString *const P3SX_HZ = @"P3直选_和值";
static NSString *const P3SX_KD = @"P3直选_跨度";

static NSString *const P3SX_ZXHZ = @"P3组选_和值";
static NSString *const P3SX_Z3 = @"P3组三";
static NSString *const P3SX_Z6 = @"P3组六";
static NSString *const P3SX_ZXBD = @"P3组选_包胆";

static NSString *const P3SX_YMBDW = @"P3一码不定位";
static NSString *const P3SX_EMBDW = @"P3二码不定位";

static NSString *const P3QE_FS = @"P3前二直选";
static NSString *const P3QE_HZ = @"P3前二直选_和值";
static NSString *const P3QE_KD = @"P3前二直选_跨度";

static NSString *const P3QE_ZXFS = @"P3前二组选";
static NSString *const P3QE_ZXHZ = @"P3前二组选_和值";
static NSString *const P3QE_ZXBD = @"P3前二组选_包胆";

static NSString *const P3HE_FS = @"P3后二直选";
static NSString *const P3HE_HZ = @"P3后二直选_和值";
static NSString *const P3HE_KD = @"P3后二直选_跨度";

static NSString *const P3HE_ZXFS = @"P3后二组选";
static NSString *const P3HE_ZXHZ = @"P3后二组选_和值";
static NSString *const P3HE_ZXBD = @"P3后二组选_包胆";

static NSString *const JSK3_CYGHJZJ = @"猜1个号就中奖";
static NSString *const JSK3_HZ = @"和值";
static NSString *const JSK3_STHDX = @"三同号单选";
static NSString *const JSK3_SBTH = @"三不同号";
static NSString *const JSK3_STHTX = @"三同号通选";
static NSString *const JSK3_SLHTX = @"三连号通选";
static NSString *const JSK3_ETHFX = @"二同号复选";
static NSString *const JSK3_ETHDX = @"二同号单选";
static NSString *const JSK3_EBTH = @"二不同号";


typedef enum {
    kPlayTypeWXZX = 0,              //五星直选
    kPlayTypeWXZuXuan60,                //五星直选60
    kPlayTypeWXZuXuan30,                //五星直选30
    kPlayTypeSXZX,                      //四星直选
    kPlayTypeHSZX,                      //后三直选
    kPlayTypeHSZuSan,                  //后三组三
    kPlayTypeHSZuLiu,                  //后三组六
    kPlayTypeQSZX,                      //前三直选
    kPlayTypeQSZuSan,                  //前三组三
    kPlayTypeQSZuLiu,                  //前三组六
    kPlayTypeHEZX,                      //后二直选
    kPlayTypeHEZuXuan,              //后二组选
    kPlayTypeQEZX,                      //前二直选
    kPlayTypeQEZuXuan,              //前二组选
    kPlayTypeDWD,                       //定位胆
    kPlayTypeHSYMBDW,               //后三一码不定位
    kPlayTypeQSYMBDW,               //前三一码不定位
    kPlayTypeEnd
} PlayType;

typedef enum {
    kTipsType1PW = 0,    //1 Per weight
    kTipsType1,            //1 At least
    kTipsType2,             //2 At least
    kTipsType3,             //3 At least
    kTipsType1Any,      //1 At least for all weights
    
} TipsType;

typedef enum {
    kModeYuan = 1,
    kModeJiao = 2,
} BetMode;


@interface BetManager : NSObject

//模式配置
+ (NSInteger)mode;
+ (void)setMode:(int)mode;
+ (NSString *)modeName;
+ (NSString *)modeName:(int)mode;

+ (NSArray *)playTypeMenuTitles;
+ (NSArray *)menuTitleItems;
+ (CDMenuItem *)menuItemForMethodName:(NSString *)methodName lottery:(NSInteger)lotteryId;
+ (CDMenuItem *)menuItemForMethodId:(NSInteger)methodId lottery:(NSInteger)lotteryId;
+ (CDMenuItem *)menuItemForPlayType:(PlayType)type;
+ (MenuItemModel *)menuItemModelForMethodId:(NSInteger)methodId lottery:(NSInteger)lotteryId channelId:(NSInteger)channelId;
+ (MenuItemModel *)menuItemModelForMethodName:(NSString *)methodName lottery:(NSInteger)lotteryId channelId:(NSInteger)channelId;
+ (MenuItemModel *)firstMenuItemModelForLottery:(NSInteger)lotteryId channelId:(NSInteger)channelId;

+ (PlayType)playTypeForMethodName:(NSString *)methodName;
+ (PlayType)playTypeForMethodId:(int)methodId methodName:(NSString **)methodName;

//通过玩法名取得玩法类型和提示类型;用于初始化数据时
+ (void)getPlayTypeFromMethodName:(NSString *)methodName playType:(PlayType *)playtype tipsType:(TipsType *)tipstype;

//产生对应类型的BetItem对象列表 Deprecated
//+ (NSArray *)betItemsForType:(PlayType)type         //玩法
//                        tips:(NSString **)tips                      //提示
//                    tipsType:(TipsType *)tipsType               //提示类型
//                 numberCount:(int*)numberCount;           //有几个球位

//统计注数金额
+ (CGFloat)amountWithBetCount:(NSInteger)betCount multile:(NSInteger)multile;
+ (CGFloat)amountWithBetCount:(NSInteger)betCount multile:(NSInteger)multile mode:(BetMode)mode;

//统计选了几注 Deprecated
+ (NSInteger)betCountWithBetItems:(NSArray *)betItems andPlayType:(int)type;

//随机需要产生的最小球数   Deprecated
//+ (int)randomBallCountWithPlayType:(int)type;

//产生随机号码
+ (NSArray *)randomNumbers:(int)count;

//连接每一位上选中的号码
//+ (NSString *)jointedNumbers:(NSArray *)betItems;

//用统一的方法格式化投注项为号码串，用&连接数字，用|连接权位。(用于编辑投注项)
//+ (NSString *)numberStringFromBetItems:(NSArray *)betItems;     //等效于jointedNumbers:

//按顺序将格式化的号码串解析成对应权位投注项
+ (void)parseNumberStringToBetItems:(NSString *)numberString betItems:(NSArray *)betItems;

@end

NSInteger MathA(NSInteger subscript, NSInteger superscript);
NSInteger MathC(NSInteger subscript, NSInteger superscript);
