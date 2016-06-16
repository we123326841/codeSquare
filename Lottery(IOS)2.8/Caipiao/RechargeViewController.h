//
//  RechargeViewController.h
//  Caipiao
//
//  Created by danal-rich on 13-11-25.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "BankModel.h"
#import "CardNotBindView.h"

typedef void(^Selected)(NSIndexPath* index);

@interface RechargeViewController : BaseViewController<UITextFieldDelegate>

@property (assign, nonatomic) IBOutlet UIView *wrapView;
@property (strong, nonatomic) CardNotBindView *noticeView;
@property (assign, nonatomic) IBOutlet UILabel *amoutLbl;
@property (assign, nonatomic) IBOutlet UITextField *amoutField;
@property (assign, nonatomic) IBOutlet UILabel *tipLbl;
@property (retain, nonatomic) IBOutlet UITableView *quickRechargeTable;
@property (retain, nonatomic) IBOutlet UILabel *chooseBankLbl;
PSTRONG NSIndexPath *lastIndexPath;
PCOPY Selected selected;
@property (retain, nonatomic) IBOutlet UIView *rechargeView;


@end

@interface RechargeAlertView : UIView

@property (copy, nonatomic) NSString *amount;
@property (strong, nonatomic) BankModel *bank;
@property (assign, nonatomic) IBOutlet UIView *mainView;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;
@property (assign, nonatomic) IBOutlet UITextField *pwdField;
@property (copy, nonatomic) void(^confirmBlock)(RechargeAlertView *view);

@end