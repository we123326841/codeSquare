//
//  LotteryCustomController.h
//  Caipiao - 彩种自定义
//
//  Created by danal-rich on 7/17/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "CD.h"

@class LotteryNorthView, LotterySouthView;
@interface LotteryCustomController : BaseViewController
{
    IBOutlet LotteryNorthView *_northView;
    IBOutlet LotterySouthView *_southView;
    IBOutlet UILabel *_textLbl;
}
@end


@class LotteryCircle;
@interface LotteryNorthView : UIView
{
    LotteryCircle  *_movingItem;
    CGSize          _itemSize;
    CGPoint         _itemMargin;
    CGFloat         _tick;
}
/* LotteryCircle grids, would be sorted with tag ascending */
@property (strong, nonatomic) NSMutableArray *grids;
@property (assign, nonatomic) NSInteger rowCount, colCount;
@property (copy, nonatomic) BOOL (^onLotteryGridClick)(CDLottery *lot);

- (NSInteger)lotteryCount;
- (void)addLotterys:(NSArray *)lots;
- (void)addLottery:(CDLottery *)lot;
- (void)update;

@end



@interface LotterySouthView : UIScrollView {
    NSMutableArray  *_grids;
    CALayer         *_gridLayer;
}
@property (copy, nonatomic) BOOL (^onLotteryGridClick)(CDLottery *lot);

- (void)addLotterys:(NSArray *)lots;
- (void)addLottery:(CDLottery *)lot;
- (void)update;
@end


@interface LotteryCircle : UIButton
{
    UIButton *_cornerButton;
    UIImageView *_newImageView;
}
@property (nonatomic, assign) NSInteger row, col;
@property (strong, nonatomic) id userData;
@property (nonatomic, assign) NSInteger style;
@property (nonatomic, assign) BOOL isNewLottery;
@end

typedef enum {
    kLotteryCircleStyleDefault = 0,
    kLotteryCircleStyleAdd,
    kLotteryCircleStyleDelete,
} LotteryCircleStyle;


#define kNotificationHotLotterysUpdates @"NotificationHotLotterysUpdates"
