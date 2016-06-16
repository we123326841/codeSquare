//
//  LinkDetailCellView.h
//  Caipiao
//
//  Created by danal-rich on 4/2/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"


@interface LinkDetailCellView : UIView
{
}
@property (assign, nonatomic) IBOutlet UILabel *typeLbl;
@property (assign, nonatomic) IBOutlet UILabel *point1Lbl;
@property (assign, nonatomic) IBOutlet UILabel *point2Lbl;
@property (nonatomic) CellPosition pos;

@end
