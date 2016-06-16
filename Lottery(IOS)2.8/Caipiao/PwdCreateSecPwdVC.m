//
//  PwdCreateSecPwdVC.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "PwdCreateSecPwdVC.h"
#import "View+Factory.h"
#import "RQPwd.h"
#import "PwdChangeResultVC.h"

@interface PwdCreateSecPwdVC ()
@property (assign, nonatomic) IBOutlet UIButton *checkBox;
@property (assign, nonatomic) BOOL checked;

- (IBAction)commit:(id)sender;

@end

@implementation PwdCreateSecPwdVC

-(void)dealloc
{
    [_resultSuccess release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置安全密码";
    self.view.backgroundColor = kLightGrayBGColor;
    
    [self.checkBox addTarget:self action:@selector(checkBoxAction) forControlEvents:UIControlEventTouchUpInside];
    MSNotificationCenterAddObserver(@selector(textfieldChangeNotification:), UITextFieldTextDidChangeNotification);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MSNotificationCenterRemoveObserver();
}

- (void)checkBoxAction
{
    self.checked=!self.checked;
    [self.checkBox setImage:[UIImage imageNamed:self.checked?@"checkbox_on.png":@"checkbox_off.png"] forState:UIControlStateNormal];
    [self resignAll];
    if (self.checked) {

    }else {
    }
}

- (void)resignAll
{
    [self.view endEditing:YES];
}

- (IBAction)commit:(id)sender
{
    if ([_passwdFied1.text length] != 0 && [_passwdFied2.text length] != 0) {
        
        if ([_passwdFied2.text isEqualToString:_passwdFied2.text]) {
            
            if ([self passwordRuleForString:_passwdFied2.text]) {
                
                [self resignAll];
                [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
                
                RQPwd *rq = [[RQPwd alloc] init];
                rq.passwordType = kPasswordTypeSecCreate;
                rq.pwd = _passwdFied1.text;
                [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
                    
                    [HUDView dismissCurrent];
                    if (rq_.msgContent) {
                        [self showAlertMessage:rq_.msgContent];
                    }else {
                        //设置成功后更新标记，返回上一层
                        [HUDView showMessageToView:KEY_WINDOW msg:@"密码设置成功" subtitle:nil];
                        CDUserInfo *u = [CDUserInfo user];
                        u.needSetSecurityPass = @(NO);
                        [u save];
                        if(_resultSuccess){
                        __block PwdCreateSecPwdVC *blockSelf = self;
                            _resultSuccess(blockSelf);}
                        /*
                        PwdChangeResultVC *vc = [[PwdChangeResultVC alloc] initWithNibName:@"PwdChangeResultVC" bundle:nil];
                        vc.title = @"设置安全密码";
                        vc.passwordType = kPasswordTypeSecCreate;
                        [self.navigationController pushViewController:vc animated:YES];
                        [vc release];
                         */
                    }
                    
                } sender:nil];
                
            }else {
                [self showAlertMessage:@"密码由字母和数字组成6-16个字符；且必须包含数字和字母，不允许连续三位相同"];
            }
        }else {
            [self showAlertMessage:@"新密码两次输入不一致"];
        }
    }else {
        [self showAlertMessage:@"请输入密码"];
    }
}

- (BOOL)passwordRuleForString:(NSString *)pwd
{
    NSString *regex = @"^(?=.*\\d+)(?=.*[a-zA-Z]+)(?!.*?(\\w+?)\\1\\1).{6,16}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:pwd];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (void)textfieldChangeNotification:(NSNotification *)notification
{
}

-(void)backAction:(id)sender
{
    [self prepareToBack];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if ([self.navi.viewControllers count] > 1){
        [self.navi popToRootViewControllerAnimated:YES];
    } else {
        [self.navi.navi popViewControllerAnimated:YES];
    }
}
@end
