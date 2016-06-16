//
//  MethodMenuItem+Factory.h
//  Caipiao
//
//  Created by danal on 13-9-2.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MethodMenuItem.h"

//Sort
@interface MethodMenuItem (Sort)
+ (NSArray *)menuItemTitles:(int)lotteryId channelId:(int)chid;
@end

//山东11选5胆拖
@interface SD11X5DT5 : MethodMenuItem
@end

//山东 前三直选
@interface SD11X5QSZX : MethodMenuItem
@end

//11x5定位胆
@interface SD11X5DWD : MethodMenuItem
@end


//重庆 五星组选 60|30
@interface CQSSC5XZuXuan : MethodMenuItem
@end

//五星组120，每个号码用,号分隔
@interface SSC5XZuXuan120 : MethodMenuItem
@end

//四星直选
@interface SSC4XZhiXuan : MethodMenuItem
@end

//后三直选
@interface SSCHSZhiXuan : MethodMenuItem
@end

//后三直选-跨度
typedef SSC5XZuXuan120 SSCHSZhiXuanKD;

//后三组六
typedef SSC5XZuXuan120 SSCHSZuLiu;

//后三组选和值
typedef SSC5XZuXuan120 CCSHSZuXuanHeZhi;

//前三直选
@interface SSCQSZhiXuan : MethodMenuItem
@end

//后二直选
@interface SSCHEZhiXuan : MethodMenuItem
@end

//前二直选
@interface SSCQEZhiXuan : MethodMenuItem
@end

//一星定位胆
@interface SSC1XDWD : MethodMenuItem
@end

//只能选一个球的玩法
@interface SSCXuan1 : MethodMenuItem
@end

//大小单双
@interface SSCDaXiaoDanShuang : MethodMenuItem

/**
 * @param name 玩法名
 * @param weights  权位数组，如"万，千，百"
 * @param tips 玩法提示
 * @param minimum 最少选球数
 */
+ (id)itemWithName:(NSString *)name
           weights:(NSArray *)weights
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;

@end

//特殊号
@interface SSCTeSuHao : MethodMenuItem
/**
 * @param name 玩法名
 * @param tips 玩法提示
 * @param minimum 最少选球数
 */
+ (id)itemWithName:(NSString *)name
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;
@end

//五码趣味三星
@interface SSCQuWeiSanXing : MethodMenuItem
/**
 * @param name 玩法名
 * @param tips 玩法提示
 * @param minimum 最少选球数
 */
+ (id)itemWithName:(NSString *)name
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;
@end

//3D
@interface MethodMenuItem3D : MethodMenuItem
@end

//3D 直选
@interface ZhiXuan3D : MethodMenuItem
@end

//3D 组选
@interface ZuXuanHZ3D : MethodMenuItem
@end

//3D一码不定位
@interface YMBDW3D : MethodMenuItem
@end

//3D 定位胆
@interface DWD3D : MethodMenuItem
@end

//3D 直选和值
@interface ZhiXuanHeZhi3D : MethodMenuItem
@end

//3D 组三、组六
@interface Zu3Zu63D : MethodMenuItem
@end

//3D大小单双
@interface DXDS3D : SSCDaXiaoDanShuang
@end

//前二直选
@interface QEZhiXuan3D : MethodMenuItem
@end

//后二直选
@interface HEZhiXuan3D : MethodMenuItem
@end

//P5H2_FS
@interface P5H2_FS_Item:MethodMenuItem

@end

//P3QE_FS
@interface P3QE_FS_Item:MethodMenuItem

@end

//P3HE_FS
@interface P3HE_FS_Item : MethodMenuItem

@end

//P5HE_ZXBD
@interface P5HE_ZXBD_Item:MethodMenuItem

@end
//P3SX_ZXBD
@interface P3SX_ZXBD_Item:MethodMenuItem

@end
//P3QE_ZXBD
@interface P3QE_ZXBD_Item:MethodMenuItem

@end
//P3HE_ZXBD
@interface P3HE_ZXBD_Item:MethodMenuItem

@end

//P5YX_DWD
@interface P5YX_DWD_Item:MethodMenuItem

@end

//JSKS_ITEM
@interface JSKS_ITEM : MethodMenuItem

@end


//二同号复选
@interface JSKS_ETHFX_Item:MethodMenuItem
/**
 * @param name 玩法名
 * @param tips 玩法提示
 * @param minimum 最少选球数
 */
+ (id)itemWithName:(NSString *)name
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;
@end
//二同号单选
@interface JSKS_ETHDX_Item : MethodMenuItem
+ (id)itemWithName:(NSString *)name
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;
@end

//三连号通选
@interface JSKS_SLHTX_Item:MethodMenuItem

+ (id)itemWithName:(NSString *)name
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;
@end


//三同号单选
@interface JSKS_STHDX_Item:MethodMenuItem

+ (id)itemWithName:(NSString *)name
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;

@end


//三同号通选
@interface JSKS_STHTX_Item:MethodMenuItem
+ (id)itemWithName:(NSString *)name
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;

@end
//三不同号胆拖
@interface JSKS_SBTHDT_Item : MethodMenuItem

@end
//二不同号胆拖
@interface JSKS_EBTHDT_Item : MethodMenuItem

@end