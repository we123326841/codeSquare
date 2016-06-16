//
//  ChargeViewController.h
//  Caipiao-充值
//
//  Created by danal on 13-10-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "RQCharge.h"
@class AgentMember;

@interface ChargeViewController : BaseViewController<UITextFieldDelegate>
@property (assign, nonatomic) IBOutlet UITextField *textFiled;
@property (assign, nonatomic) IBOutlet UILabel *bankBalanceLbl;
@property (assign, nonatomic) IBOutlet UILabel *bankHallBalanceLbl;
@property (assign, nonatomic) IBOutlet UILabel *accountLbl1;
@property (assign, nonatomic) IBOutlet UILabel *accountLbl2;

@property (strong, nonatomic) AgentMember *member;
- (IBAction)nextAction:(id)sender;
@end


@interface ChargePasswordViewController : BaseViewController
<RQBaseDelegate,UITextFieldDelegate>
@property (assign, nonatomic) IBOutlet UITextField *textFiled;
@property (assign, nonatomic) IBOutlet UILabel *accountLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountZhLbl;

@property (strong, nonatomic) AgentMember *member;
- (IBAction)confirmAction:(id)sender;
@end

@interface ChargeResultViewController : BaseViewController
@property (strong, nonatomic) AgentMember *member;
@property (strong, nonatomic) RQCharge *charge;

@property (assign, nonatomic) IBOutlet UILabel *titleLbl;
@property (assign, nonatomic) IBOutlet UILabel *accountLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountZhLbl;

- (IBAction)userlistButtonAction:(id)sender;
- (IBAction)transactionButtonAction:(id)sender;
@end