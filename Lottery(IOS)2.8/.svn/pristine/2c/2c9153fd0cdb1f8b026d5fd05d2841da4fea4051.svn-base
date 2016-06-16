//
//  BetCell.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "WeightMenu.h"
#import "BetItem.h"

#define kNotificationBetBallUpdated @"NotificationBetBallUpdated"

@class BetCell;

@interface BetView : UIView
<BallDelegate,WeightMenuDelegate>
{
    NSMutableArray *_ballList;
    UILabel *_weightLbl;
}
@property (strong, nonatomic) WeightMenu *weightMenu;
@property (strong, nonatomic) BetItem *betItem;
@property (assign, nonatomic) UIImageView *ballContainer;

- (id)initWithFrame:(CGRect)frame item:(BetItem *)item;
- (void)selectBall:(NSString *)numberText;
- (void)deselectBall:(NSString *)numberText;
- (void)reload;

+ (void)removeMask;
+ (float)height;
+ (float)heightForBetItem:(BetItem *)betItem;
@end

/**
 * 大小单双等文字bet view
 */
@interface WordsBetView : BetView
- (id)initWithFrame:(CGRect)frame item:(BetItem *)item;
@end

/**
 * ColorBall bet view
 */
@interface SSQBetView : BetView

@property (strong, nonatomic) YellowDropBox *dropBox;
@property (strong, nonatomic) UILabel *numLbl;

- (id)initWithFrame:(CGRect)frame item:(BetItem *)item;

@end



#pragma mark - =========BetCell============

@interface BetCell : UITableViewCell
@property (strong, nonatomic) NSArray *betItems;

+ (float)height;
+ (float)heightForBetItems:(NSArray *)betItems;
@end

@interface SSQBetCell : UITableViewCell

@property (strong, nonatomic) NSArray *betItems;

+ (float)height;
+ (float)heightForBetItems:(NSArray *)betItems;

@end


@interface BetScrollView : UIScrollView
{
    CGFloat _bottomY;
}
- (void)addBetView:(BetView *)betView;
- (void)clear;
- (void)reload;
@end

@interface JSKSBetScrollView : BetScrollView
@property (nonatomic,assign)UIImageView* bgView;

@end