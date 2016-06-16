//
//  SecurityPwdInputViewController.h
//  Caipiao
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface SecurityPwdInputViewController : BaseViewController
{
    IBOutlet UIButton *_button;
    IBOutlet UITextField *_pwdField;
}
@property (assign, nonatomic) IBOutlet UITextField *pwdField;
@property (nonatomic) BOOL bindRightNow;    //立即绑卡
@property (nonatomic,assign)BOOL isOldB;
@property (copy, nonatomic) void(^viewDidLoadBlock)(SecurityPwdInputViewController *c);
@property (copy, nonatomic) void(^completeBlock)(SecurityPwdInputViewController *c, bool success);
- (IBAction)submitAction:(id)sender;

@end

@interface SecurityAlertView : UIView

@property (assign, nonatomic) IBOutlet UIView *mainView;
@property (copy, nonatomic) void(^cancelBlock)(SecurityAlertView *view);
@property (copy, nonatomic) void(^confirmBlock)(SecurityAlertView *view);


@end
