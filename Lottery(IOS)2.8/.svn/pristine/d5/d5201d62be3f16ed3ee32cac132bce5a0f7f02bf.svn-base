//
//  AuthenticationAlertView.h
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AuthenticationAlertView;
typedef void (^CompleteBlock)(AuthenticationAlertView *av);

@interface AuthenticationAlertView : UIView

PCOPY CompleteBlock completeBlock;
- (IBAction)btnClicked:(id)sender;
@property (assign, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UILabel *alertL;
@property (retain, nonatomic) IBOutlet UILabel *issuseL;
@property (retain, nonatomic) IBOutlet UITextField *pwdField;
@property (retain, nonatomic) IBOutlet UITextField *issueField;

@end
