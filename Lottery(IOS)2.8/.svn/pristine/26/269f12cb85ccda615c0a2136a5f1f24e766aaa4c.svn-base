//
//  SignViewController.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "IconInputTextField.h"
#import "RQLogin.h"


@class CheckBox;

@interface SignViewController : BaseViewController
<UITextFieldDelegate,RQBaseDelegate>
{
    IBOutlet UIImageView    *_avatarView;
    IBOutlet UIPickerView   *_picker;
    IBOutlet UIButton       *_loginButton;
    IBOutlet UIView         *_accoutView;
    IBOutlet UIView         *_passwdView;
    BOOL                    _panelOpened;
    IBOutlet CheckBox       *_checkBox;
    
    IBOutletCollection(UILabel) NSArray *_labels;
}
@property (nonatomic, assign) IBOutlet UITextField *accountField;
@property (nonatomic, assign) IBOutlet UITextField *passwdField;
@property (nonatomic, assign) BOOL isAutoLogin;
+ (void)setRememberedAccount:(NSString *)account;
+ (NSString *)remeberedAccount;

- (IBAction)openAccountPanel:(id)sender;
- (IBAction)switchPasswdEntry:(id)sender;

@end
