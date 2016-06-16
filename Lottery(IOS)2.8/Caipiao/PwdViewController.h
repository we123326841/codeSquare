//
//  PwdViewController.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface PwdViewController : BaseViewController <UITextFieldDelegate>
{
    IBOutlet UIView         *_wrapView;
    IBOutlet UITextField    *_oldPasswdField;
    IBOutlet UITextField    *_passwdField;
    IBOutlet UITextField    *_passwdField2;
    IBOutlet UILabel        *_footerLbl;
}
@property (assign, nonatomic) PasswordType passwordType;
@end


@interface LoginPwdViewController : PwdViewController

@end

@interface SecPwdViewController : PwdViewController

@end