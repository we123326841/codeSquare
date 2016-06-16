//
//  TransferViewController.h
//  Caipiao
//
//  Created by danal on 13-5-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"
#import "RQTransfer.h"

@interface TransferViewController : BaseViewController
<DropDownMenuDelegate,UITextFieldDelegate,RQBaseDelegate>
{
    NSString *_bankBalance;
    NSString *_highBalance;
    NSString *_lowBalance;
    int _toChannelIndex;
    
    IBOutlet UILabel *_nameLbl;
    IBOutlet UILabel *_bankBalanceLbl;
    IBOutlet UILabel *_highBalanceLbl;
    IBOutlet UILabel *_lowBalanceLbl;
    IBOutlet UILabel *_availableAmountLbl;
    IBOutlet UILabel *_amountTagLbl;
    IBOutletCollection(UILabel) NSArray *_tagLbls;
}

@property (assign, nonatomic) IBOutlet DropDownMenu *menu;
@property (assign, nonatomic) IBOutlet UITextField *amountInputField;
@property (assign, nonatomic) IBOutlet UILabel *accountLbl;
@property (assign, nonatomic) IBOutlet UIButton *confirmButton;

- (IBAction)confirmAction:(id)sender;

@end
