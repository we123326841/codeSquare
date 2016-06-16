//
//  PwdViewController.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "PwdViewController.h"
#import "PwdChangePwdVC.h"
#import "PwdCreateSecPwdVC.h"
#import "RQPwd.h"
#import "CDUserInfo.h"

@interface PwdViewController ()

@end

@implementation PwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _passwordType == kPasswordTypeSecChange ? @"修改安全密码" : @"修改登录密码";
    self.view.backgroundColor =
    _wrapView.backgroundColor = kLightGrayBGColor;
    
    UIButton *done = [UIButton barButtonWithTitle:@"完成"];
    done.frame = CGRectMake(0, 0, 40, 30);
    [done addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:done];
    
    _footerLbl.text = @"(由字母和数字组成6-16个字符；且必须包含数字和字母，不允许连续三位相同，不能和安全密码相同)";
    if (_passwordType!=kPasswordTypeLogin) {
        _footerLbl.text = @"安全密码由字母和数字组成，包含6-16个字符，不允许连续三位相同，不能和登录密码相同";
    }

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CDUserInfo *u = [CDUserInfo user];
    if (_passwordType == kPasswordTypeSecChange && [u.needSetSecurityPass boolValue]) {
        PwdCreateSecPwdVC *vc = [[PwdCreateSecPwdVC alloc] initWithNibName:@"PwdCreateSecPwdVC" bundle:nil];
        vc.title = @"设置安全密码";
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender{
    [self.view endEditing:YES];
    if ([_oldPasswdField.text length] * [_passwdField.text length] * [_passwdField2.text length] > 0){
        if ([_passwdField.text isEqualToString:_passwdField2.text]){
            
            if ([self passwordRuleForString:_passwdField.text]){
                [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
                
                RQPwd *rq = [[[RQPwd alloc] init] autorelease];
                rq.passwordType = _passwordType;
                rq.oldPwd = _oldPasswdField.text;
                rq.pwd = _passwdField.text;
                [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
                    
                    [HUDView dismissCurrent];
                    if (rq_.msgType == kMessageTypeCommon){
                        if (self.passwordType == kPasswordTypeLogin){
                            [HUDView showMessageToView:KEY_WINDOW msg:@"登录密码修改成功" subtitle:nil];
                            [[AppDelegate shared] backToLogin];
                        } else if (self.passwordType == kPasswordTypeSecChange){
                            [HUDView showMessageToView:KEY_WINDOW msg:@"安全密码修改成功" subtitle:nil];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }
                    else if (rq_.msgContent) {
                        [HUDView showMessageToView:KEY_WINDOW msg:rq_.msgContent subtitle:nil];
                    }
                    
                } sender:nil];
                self.rq = rq;

            } else {
                HUDShowMessage(_footerLbl.text, nil);
            }
            
        } else {
            HUDShowMessage(@"两次输入的新密码不一致", nil);
        }
    }
    else {
        NSString *msg  = @"由字母和数字组成6-16个字符；且必须包含数字和字母，不允许连续三位相同，不能和安全密码相同";
        if (_passwordType!=kPasswordTypeLogin) {
            msg = @"安全密码由字母和数字组成，包含6-16个字符，不允许连续三位相同，不能和登录密码相同";
        }
        MSShowMessage(msg);
    }
}

- (BOOL)passwordRuleForString:(NSString *)pwd
{
    NSString *regex = @"^(?=.*\\d+)(?=.*[a-zA-Z]+)(?!.*?(\\w+?)\\1\\1).{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:pwd];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

@end



@implementation LoginPwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:@"PwdViewController" bundle:nibBundleOrNil];
    if (self){
        self.passwordType = kPasswordTypeLogin;
    }
    return self;
}

@end

@implementation SecPwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:@"PwdViewController" bundle:nibBundleOrNil];
    if (self){
        self.passwordType = kPasswordTypeSecChange;
    }
    return self;
}

@end