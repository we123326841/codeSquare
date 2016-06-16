//
//  BaseCell.h
//  Caipiao
//
//  Created by danal on 13-1-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kCellPositionDefault = 0,
    kCellPositionTop = 2,
    kCellPositionBottom = 2 << 1,
    kCellPositionSingle,
} CellPosition ;

@interface BaseCell : UITableViewCell

@property (assign, nonatomic) NSInteger row;
@property (assign, nonatomic) NSInteger numberOfRows;
@property (copy, nonatomic) NSString *identifier;
@property (assign, nonatomic) CellPosition pos;
@end
