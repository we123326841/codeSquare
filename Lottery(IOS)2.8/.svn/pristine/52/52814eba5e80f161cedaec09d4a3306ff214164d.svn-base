//
//  BetItem.h
//  Caipiao
//  投注界面每一位的Item对象
//  Created by danal on 13-1-21.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MaxNumber 10

@class BetView;
@protocol BetItemDelegate;

typedef enum {
    kBetItemOptionNone = 0,
    kBetItemOptionQuan,
    kBetItemOptionDa,
    kBetItemOptionXiao,
    kBetItemOptionDan,
    kBetItemOptionShuang,
} BetItemOption;

//号码盘类型
typedef enum {
    kBetItemTypeNumber = 0,     //纯数字盘
    kBetItemTypeWords,              //文字盘
    kBetItemTypeImage,    //图片盘
} BetItemType;

/*
 *  BetItem contains the select states of numbers
 */
@interface BetItem : NSObject
{
    NSMutableArray *_historyNumberList;     //号码选择历史
}
@property (assign, nonatomic) id<BetItemDelegate> delegate;
@property (assign, nonatomic) BetItemType type;
@property (copy, nonatomic) NSString *weight;           //权位
@property (copy, nonatomic) NSString *numberFormat;           //号码格式
@property (strong, nonatomic) NSArray *ballItems;           //号码球BallItem对象
@property (copy, nonatomic) NSString *lastBall;                 //上一次选择的球号
@property (assign, nonatomic) int startBall;                 //起始球
@property (assign, nonatomic) int endBall;                 //结尾球
@property (readonly, nonatomic) int ballCount;                //有几个球
@property (assign, nonatomic) int minimumBallCount;     //最少选择球数
@property (nonatomic,assign)int maxBallCount;
@property (assign, nonatomic) BetView *attachedBetView;     //相关联的BetView
@property (assign, nonatomic) int startRandomNum;                 //机选起始个数
@property (assign, nonatomic) int endRandomNum;                 //机选结束个数
@property (assign, nonatomic) int selectedBallCount;            //选中的数量

@property (nonatomic) BOOL disableWeightOption;     //禁用选项功能

/**
 * 创建一个选项对象
 * @param weight 权位
 * @param ballItems 号码球BallItem对象
 * @param minimumBallCount 最少选球数量
 * @return 实例对象
 */
- (id)initWithWeight:(NSString *)weight ballItems:(NSArray *)ballItems minimumBallCount:(int)minimum;

/**
 * 创建一个纯数字选项
 * @param weight 权位
 * @param startBall 起始球号
 * @parma endBall 结束球号
 * @param format 号码格式
 * @param minimumBallCount 最少选球数量
 * @return 实例对象
 */
- (id)initWithWeight:(NSString *)weight startBall:(int)startBall endBall:(int)endBall numberFormat:(NSString *)format minimumBallCount:(int)minimum;
- (id)initWithWeight:(NSString *)weight startBall:(int)startBall endBall:(int)endBall numberFormat:(NSString *)format minimumBallCount:(int)minimum maxBallCount:(int)maxCount;

/**
 * 手选号码调用下面两个方法
 * @param number 号码字符串
 */
- (void)manuallySelectNumber:(NSString *)number;
- (void)manuallyDeselectNumber:(NSString *)number;

/**
 * 选择/取消号码
 * @param number 整型数值号码，如：5
 */
- (void)selectNumber:(NSUInteger)number;
- (void)deselectNumber:(NSUInteger)number;

/**
 * 选择/取消号码
 * @param number 号码字符，如：5，05，大
 */
- (void)selectNumberS:(NSString *)number;
- (void)deselectNumberS:(NSString *)number;

/**
 * 判断号码是否选中
 * @param number 整型数值号码
 * @return true or false
 */
- (BOOL)numberSelected:(NSUInteger)number;

/**
 * 判断号码是否选中
 * @param number 号码字符
 * @return true or false
 */
- (BOOL)numberSelectedS:(NSString *)numberText;

/**
 * 清空重置
 */
- (void)reset;      //clear and notify changes
- (void)clear;
- (void)onChanges;  //Call the delegate
/**
 * 机选
 */
- (void)random;

/**
 * 机选N注
 * @param count 注数
 */
- (void)randomN:(int)count;

/**
 * 机选N注
 * @param count 注数
 * @param exceptedNumbers 排除的号码数组
 */
- (void)randomN:(int)count exceptedNumbers:(NSArray *)exceptedNumbers;

/**
 * 选择大小单双等
 */
- (void)selectAll;
- (void)selectBig;
- (void)selectSmall;
- (void)selectOdd;
- (void)selectEven;


/**
 * 限制选号数为length
 * @param length 限制到长度
 * 对于最多只能选择某个数量的BetItem 用这个去掉超出的选择
 */
- (void)trimSelectionsToLength:(int)length;

/**
 * 序列化选中的号码为字符串
 * @return 号码串
 */
- (NSString *)serialize;

/**
 * 比较
 * @param another 要比较的BetItem
 * @param equ 是否相等
 * @param intersect 是否相交
 * @param sameCount 相同球的数量 
 * @param differentCount 不同球的数量
 */
- (void)compareTo:(BetItem *)another
          isEqual:(BOOL *)equ
      isIntersect:(BOOL *)intersect
        sameCount:(NSInteger *)sameCount
   differentCount:(NSInteger *)differentCount;

/**
 * @return 选择了几个球
 */
- (int)count;

/**
 * @return 生成一个随机的BetItem
 */
+ (BetItem *)randomBetItem;

/**
 * 生成BetItems
 * @param weights 权位字符串数组
 * @return BetItems
 */
+ (NSArray *)makeBetItemsForWeights:(NSArray *)weights;

/**
 * 获取多个BetItem里选中的相同球的数量
 * @param items BetItems
 * @return 相同球的数量
 */
+ (int)sameCountInBetItems:(NSArray *)items;

@end

@interface BetItem (NSStringExtended)
- (void)selectNumberStr:(NSString *)numberStr;
- (NSArray *)selectedNumbers;
@end


@protocol BetItemDelegate <NSObject>
@optional
- (void)onBetItemChanges:(BetItem *)item option:(BetItemOption)option;
@end
