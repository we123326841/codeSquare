//
//  CardBindConfirmViewController.h
//  Caipiao
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
@class BankModel;

@interface CardBindConfirmViewController : BaseViewController
{
    IBOutlet UILabel *_bankNameLbl;
    IBOutlet UILabel *_provinceLbl;
    IBOutlet UILabel *_cityLbl;
    IBOutlet UILabel *_branchLbl;
    IBOutlet UILabel *_nameLbl;
    IBOutlet UILabel *_bankAccountLbl;
    IBOutlet UIButton *_button;
}
@property (strong, nonatomic) BankModel *bank;

- (IBAction)submitAction:(id)sender;
@end
