//
//  LowBetAccessoryView.h
//  Caipiao
//
//  Created by cYrus_c on 14-3-6.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseAccessoryView.h"

@interface LowBetAccessoryView : BaseAccessoryView

@property (assign, nonatomic) IBOutlet UITextField *issueTextfield;
@property (assign, nonatomic) IBOutlet UITextField *multipleTextfield;
@property (assign, nonatomic) IBOutlet UIButton *issueReduceButton;
@property (assign, nonatomic) IBOutlet UIButton *issueIncreaseButton;
@property (assign, nonatomic) IBOutlet UIButton *multipleReduceButton;
@property (assign, nonatomic) IBOutlet UIButton *multipleIncreaseButton;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;
@property (assign, nonatomic) IBOutlet UILabel *subLbl;
@property (copy, nonatomic) void(^numberChangeHandler)(LowBetAccessoryView *);

- (IBAction)multiplePlus:(id)sender;
- (IBAction)multipleMinus:(id)sender;
- (IBAction)issuePlus:(id)sender;
- (IBAction)issueMinus:(id)sender;
@end
