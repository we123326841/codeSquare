//
//  HigherNumTableViewCell.h
//  Caipiao
//
//  Created by 王浩 on 15/11/19.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HigherChaseModel.h"
#import "KeyBoardAccess.h"
#import "BeiShuField.h"
@class HigherNumTableViewCell;
@protocol HigherNumTableViewCellDelagete<NSObject>
-(void)tableViewCell:(HigherNumTableViewCell*)cell textFieldDidChange:(int)value;
@end
@interface HigherNumTableViewCell : UITableViewCell<UITextFieldDelegate,KeyBoardAccessDelegate>
@property (retain, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet BeiShuField *textField;
@property (retain, nonatomic) IBOutlet UILabel *serialNumLabel;
@property (retain, nonatomic) IBOutlet UILabel *issueLabel;
@property (retain, nonatomic) IBOutlet UILabel *totalLabel;
@property (retain, nonatomic) IBOutlet UILabel *payOffLabel;
@property (retain, nonatomic) IBOutlet UILabel *payOffRateLabel;
@property (nonatomic,strong)HigherChaseModel *model;
@property (nonatomic,weak)id<HigherNumTableViewCellDelagete>delegate;
@end
