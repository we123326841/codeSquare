//
//  RechargeResultViewController.h
//  Caipiao 充值信息/结果 &  注意事项
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
@class RQBankRechargeCommit;

@interface RechargeResultViewController : BaseViewController
{
    IBOutlet UILabel *_orderTagLbl;
    IBOutlet UILabel *_orderLbl;
    IBOutlet UILabel *_tipLbl;
    IBOutlet UILabel *_tip1Lbl;
    IBOutlet UILabel *_tip2Lbl;
    IBOutlet UILabel *_amountLbl;
    IBOutlet UILabel *_amountTagLbl;
    IBOutlet UILabel *_emailLbl;
    IBOutlet UILabel *_nameLbl;
    IBOutlet UILabel *_accountLbl;
    IBOutlet UILabel *_accountBankLbl;
    IBOutlet UILabel *_bankTagLbl;
    IBOutlet UILabel *_nameTagLbl;
    IBOutlet UILabel *_accountTagLbl;
    IBOutlet UILabel *_accountBankTagLbl;
    IBOutlet UILabel *_minuteLbl1;
    IBOutlet UILabel *_minuteLbl2;
    IBOutlet UILabel *_secondLbl1;
    IBOutlet UILabel *_secondLbl2;
    IBOutlet UIButton *_copyButton;

    IBOutlet UIView *emailView;
    IBOutlet UIView *otherInfoView;
    
    NSTimer *_timer;
    int _seconds;
}

@property (strong, nonatomic) RQBankRechargeCommit *commitRequest;
@property (copy, nonatomic) NSString *fullBankName;
@end

//@interface RechargeAttentionViewController : BaseViewController
//@property (copy, nonatomic) NSString *bankName;     //shortname
//@property (copy, nonatomic) NSString *fullBankName;
//@end


