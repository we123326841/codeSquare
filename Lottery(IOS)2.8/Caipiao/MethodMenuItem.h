//
//  MethodMenuItem.h
//  Caipiao
//  玩法菜单对象
//  Created by danal on 13-8-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CDMenuItem;
@class MenuItemModel;

typedef NSString WeightRule;

/* 投注类型type */
typedef NSString MethodBetType;
typedef NSInteger MethodNumbersStyle;

static NSString * const kMethodBetTypeDigital = @"digital";     //数字类型，缺省
static NSString * const kMethodBetTypeDxds = @"dxds";           //大小单双类型

static NSInteger const kMethodNumbersStyle1 = 1 << 1;   //e.g. 123,34,5 多位复选
static NSInteger const kMethodNumbersStyle2 = 1 << 2;   //e.g. 1,2,3 只有一位的情况
static NSInteger const kMethodNumbersStyle3 = 1 << 3;   //e.g. 12 23 34 单式用空格分割

@protocol MethodMenuItemDelegate;

@interface MethodMenuItem : NSObject <BetItemDelegate>
@property (assign, nonatomic) id<MethodMenuItemDelegate> delegate;
@property (assign, nonatomic) NSInteger sortIndex;    //排序
/*
 *  由lotteryName和methodName唯一确定一条item
 */
@property (nonatomic, copy) NSString *lotteryName;
@property (nonatomic, copy) NSString *methodName;       //玩法名
@property (nonatomic, copy) NSString *simpleName;       //简短名
@property (nonatomic, copy) NSString *category;         //分类
@property (nonatomic, copy) NSString *tips;
/*
 * WeightRule
 * 代表了投注界面每一位上的显示格式,将这个格式解析到BetItem对象上使用
 *  e.g. 百|10-1,十|10-1,个|10-1 表示百十个位上各有10个球，每位上最少得选择1个球
 */
@property (nonatomic, copy) WeightRule *weightRule;
@property (nonatomic, assign) NSInteger lotteryId;
@property (nonatomic, assign) NSInteger methodId;
@property (nonatomic, assign) CGFloat methodPrice;
@property (nonatomic, assign) CGFloat limitBonus;
@property (nonatomic, assign) CGFloat limitMultiple;//限制的倍数
/*
 *  minimumBallCount 
 *  BetItem上有效球数计算 count = MIN(1,count)
 *  统计方法 投注添加号码时，将所有BetItem上count相加所得与minimum比较
 */
@property (nonatomic, assign) NSInteger minimumBallCount;
@property (nonatomic,assign) NSInteger maxBallCount;
/*
 * 投注相关项
*/
@property (nonatomic, copy) MethodBetType *betType;      //投注类型type
@property (nonatomic, strong) NSArray *betItems;    //投注项
@property (nonatomic, assign) NSInteger betMultiple;           //倍数
@property (nonatomic, readonly) NSInteger betCount;           //注数
@property (nonatomic, copy) void(^betCountBlock)(NSInteger *betCount_, NSArray *betItems_);   //计算注数的block
//@property (nonatomic, readonly) float betAmount;       //投注金额
@property (nonatomic, assign) MethodNumbersStyle numbersStyle;
@property (nonatomic, retain) NSMutableArray *subItems;

- (NSInteger)betItemsUpdated;            //注单发生变化,返回betCount
- (BOOL)isValidBet;                  //验证是否是有效的注单
- (void)resetBet;                       //清空注单
- (int)random1;                         //随机产生一注, 返回最后一个有选球权位的index
- (int)random1Unique;               //同上机选一注，但各位上的号不重复
- (void)configBetItems;             //实现这此方法来配置betItem
- (NSString *)jointedNumbers;       //格式化所选号码,用于投注的格式
- (NSString *)originalNumbers;      //用&和|连接的原始格式的号码
- (NSUInteger)selectedNumberCount;  //选中的号码个数量
+ (NSArray *)randomN:(int)n;        //随机产生N注该玩法注单

//创建一个包含基本信息的对象
+ (id)itemWithName:(NSString *)methodName
              rule:(WeightRule *)weightRule
              tips:(NSString *)tips
           minimum:(int)minimumBallCount;

//必须使用下面的方法来获得包含完整信息的对象
//+ (MethodMenuItem *)itemFromCDMenuItem:(CDMenuItem *)cdMenuItem;
+ (MethodMenuItem *)itemFromMenuItemModel:(MenuItemModel *)model;
+ (MethodMenuItem *)itemFromMethodName:(NSString *)methodName lottery:(NSInteger)lotteryId channelId:(NSInteger)chid;
+ (MethodMenuItem *)itemFromMethodId:(NSInteger)methodId lottery:(NSInteger)lotteryId channelId:(NSInteger)chid ;

//从玩法格式字符串解析出规则
+ (NSArray *)betItemsFromWeightRule:(NSString *)weightRule;

@end

#pragma mark - Method Category

@interface MethodMenuItemCategory : NSObject
@property (copy, nonatomic) NSString *categoryName;
@property (strong,readonly,nonatomic) NSMutableArray *methodMenuItems;
- (void)addObject:(MethodMenuItem *)item;
@end

#pragma mark - Factory

@interface MethodMenuItem (Factory)
+ (NSArray *)getAll:(NSInteger)lotteryId channelId:(NSInteger)channelId;
@end

#pragma mark - MethodMenuItemDelegate
@protocol MethodMenuItemDelegate <NSObject>
- (void)onMethodMenuItemChanges:(MethodMenuItem *)methodMenuItem;
@end