//
//  WithdrawCashConfirmVC.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "BankModel.h"
#import "RQWithdrawCash.h"

@interface WithdrawCashConfirmVC : BaseViewController <UITextFieldDelegate>

@property (strong, nonatomic) RQWithdrawCashCheck *rqCheck;

@end

@interface WithdrawAlertView : UIView

@property (copy, nonatomic) NSString *amount;
@property (strong, nonatomic) BankModel *bank;
@property (assign, nonatomic) IBOutlet UIView *mainView;
@property (assign, nonatomic) IBOutlet UITextField *pwdField;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;
@property (copy, nonatomic) void(^confirmBlock)(WithdrawAlertView *view);

@end
