//
//  ZhuiHaoDetailCell.h
//  Caipiao
//
//  Created by Cyrus on 13-6-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "GreenOddEvenCell.h"

@interface ZhuiHaoDetailCell : UITableViewCell

@property (assign, nonatomic) IBOutlet UILabel *numberLbl;
@property (assign, nonatomic) IBOutlet UILabel *multipleLbl;
@property (assign, nonatomic) IBOutlet UILabel *statusLbl;
@property (assign, nonatomic) IBOutlet UIButton *selectionButton;
@property (assign) BOOL isSelected;

@end
