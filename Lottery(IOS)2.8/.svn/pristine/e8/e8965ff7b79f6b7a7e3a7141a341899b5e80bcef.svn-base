//
//  CardDeleteViewController.h
//  Caipiao
//
//  Created by danal-rich on 13-12-2.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
@class BankModel;

@interface CardDeleteViewController : BaseViewController
<UITextFieldDelegate>
{
    IBOutlet UIView *_cardView;
    IBOutlet UITextField *_accountField;
    IBOutlet UITextField *_nameField;
    IBOutlet UIButton *_deleteButton;
    IBOutlet UIView *_contentView;
}
@property (strong, nonatomic) BankModel *bankCard;
@property (strong, nonatomic) BankModel *bankCardToDelete;

- (IBAction)deleteButtonAction:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
@end
