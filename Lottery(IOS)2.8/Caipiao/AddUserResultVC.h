//
//  AddUserResultVC.h
//  Caipiao
//
//  Created by cYrus on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>

@interface AddUserResultVC : BaseViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (copy, nonatomic) NSString *userAccount;
@property (copy, nonatomic) NSString *userType;
@property (copy, nonatomic) NSString *userPwd;
@property (copy, nonatomic) NSString *userNickname;

- (IBAction)copyInfo:(id)sender;
- (IBAction)forward:(id)sender;
- (IBAction)gotoUserList:(id)sender;
- (IBAction)addNewUser:(id)sender;

@end
