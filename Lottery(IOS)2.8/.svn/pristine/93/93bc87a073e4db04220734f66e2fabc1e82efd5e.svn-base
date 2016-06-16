//
//  BallItem.h
//  Caipiao-号码球数据对象
//
//  Created by danal-rich on 14-2-10.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kBallStyleDefault = 0,
    kBallStyleRoundedRect,
    kBallStyleRed,      //红球
    kBallStyleBlue      //蓝球
} BallStyle;

#define kStandardBallWidth 36.f
#define kDefaultSize CGSizeMake(36.f, 36.f)
#define kRoundedSize CGSizeMake(62.f, 36.f)
#define kRoundedBigSize CGSizeMake(175.f, 87.f)

@interface BallItem : NSObject
@property (nonatomic) BallStyle style;
@property (nonatomic) BOOL selected;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *value;
 
/**
 * 号码球的大小
 */
@property (nonatomic) CGSize frameSize;

/**
 * 数字文本格式，只有当号码为纯数字时需要设置此参数
 */
@property (copy, nonatomic) NSString *numberFormat;

/**
 * 初始化
 * @param style 球的样式
 * @param text 球上显示的文本
 * @parma value 球对应的值
 * @return 实例
 */
- (id)initWithStyle:(BallStyle)style text:(NSString *)text value:(NSString *)value;

@end
