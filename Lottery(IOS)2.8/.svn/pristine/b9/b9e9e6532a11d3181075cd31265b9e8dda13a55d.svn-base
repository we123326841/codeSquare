//
//  PublicDetailCell.h
//  Caipiao
//
//  Created by CYRUS on 14-8-5.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PublicBall;

typedef enum {
    kCellPositionDefault = 0,
    kCellPositionTop = 2,
    kCellPositionBottom = 2 << 1,
    kCellPositionSingle,
} CellPosition ;

@interface PublicDetailCell : UITableViewCell

@property (assign, nonatomic) IBOutlet UILabel *issueLbl;
@property (copy, nonatomic) NSString *codes;
@property (copy, nonatomic) NSString *preCodes;
@property (nonatomic,copy)NSString*lotteryName;
@property (retain, nonatomic) IBOutlet UILabel *sumL;
@property (nonatomic,assign)NSInteger sum;
//@property (assign, nonatomic) CellPosition pos;

+ (NSString *)numFormatter:(NSString *)codes;

@end
