//
//  WithdrawCashVC.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "DropDownMenu.h"
#import "CardNotBindView.h"

@interface WithdrawCashVC : BaseViewController <UITextFieldDelegate, DropDownMenuDelegate>
{
    int _selectedBankIndex;
    IBOutletCollection(UILabel) NSArray *_tagLbls;
    IBOutlet UILabel *_amountTagLbl;
}

@property (strong, nonatomic) LoadingView *header;
@property (assign, nonatomic) IBOutlet UILabel *tipLbl;
@property (assign, nonatomic) IBOutlet UILabel *userLbl;
@property (assign, nonatomic) IBOutlet UILabel *timesLbl;
@property (assign, nonatomic) IBOutlet UILabel *availableCashLbl;
@property (strong, nonatomic) CardNotBindView *noticeView;
@property (assign, nonatomic) IBOutlet UIView *wrapView;
@property (assign, nonatomic) IBOutlet UITextField *amoutField;
@property (assign, nonatomic) IBOutlet DropDownMenu *cardMenu;

@end
