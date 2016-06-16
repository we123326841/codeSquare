//
//  PwdChangePwdVC.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "PwdChangePwdVC.h"
#import "View+Factory.h"
#import "RQPwd.h"
#import "PwdChangeResultVC.h"

@interface PwdChangePwdVC ()

@property (assign, nonatomic) IBOutlet UIScrollView *scroll;
@property (assign, nonatomic) IBOutlet YellowLabel *oldPwdLbl;
@property (assign, nonatomic) IBOutlet YellowLabel *inputNewPwdLbl;
@property (assign, nonatomic) IBOutlet YellowLabel *confirmNewPwdLbl;
@property (assign, nonatomic) IBOutlet InRectTextField *oldPwdTextField;
@property (assign, nonatomic) IBOutlet InRectTextField *inputNewPwdTextField;
@property (assign, nonatomic) IBOutlet InRectTextField *confirmNewPwdTextField;
@property (assign, nonatomic) IBOutlet UIButton *checkBox;
@property (assign, nonatomic) IBOutlet UILabel *tipLbl;
@property (assign, nonatomic) BOOL checked;

- (IBAction)commit:(id)sender;

@end

@implementation PwdChangePwdVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _oldPwdTextField.textfield.delegate = self;
    _inputNewPwdTextField.textfield.delegate = self;
    _confirmNewPwdTextField.textfield.delegate = self;
    _oldPwdTextField.textfield.secureTextEntry = YES;
    _inputNewPwdTextField.textfield.secureTextEntry = YES;
    _confirmNewPwdTextField.textfield.secureTextEntry = YES;
    _oldPwdTextField.textfield.placeholder = @"输入文本";
    _inputNewPwdTextField.textfield.placeholder = @"输入文本";
    _confirmNewPwdTextField.textfield.placeholder = @"输入文本";

    if (_passwordType == kPasswordTypeLogin) {
        _oldPwdLbl.text = @"旧登录密码";
        _inputNewPwdLbl.text = @"新登录密码";
        _confirmNewPwdLbl.text = @"确认新登录密码";
        _tipLbl.text = @"(由字母和数字组成6-16个字符；且必须包含数字和字母，不允许连续三位相同，不能和安全密码相同)";
    }
    
    self.scroll.contentSize=CGSizeMake(320, 504);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAll)];
    [self.scroll addGestureRecognizer:tap];
    
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

- (void)resignAll
{
    [_oldPwdTextField.textfield resignFirstResponder];
    [_inputNewPwdTextField.textfield resignFirstResponder];
    [_confirmNewPwdTextField.textfield resignFirstResponder];
    
    self.scroll.contentSize=CGSizeMake(320, 504);
    [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)checkBoxAction
{
    self.checked=!self.checked;
    [self.checkBox setImage:[UIImage imageNamed:self.checked?@"checkbox_on.png":@"checkbox_off.png"] forState:UIControlStateNormal];
    [self resignAll];
    if (self.checked) {
        _oldPwdTextField.textfield.secureTextEntry=NO;
        _inputNewPwdTextField.textfield.secureTextEntry=NO;
        _confirmNewPwdTextField.textfield.secureTextEntry=NO;
    }else {
        _oldPwdTextField.textfield.secureTextEntry=YES;
        _inputNewPwdTextField.textfield.secureTextEntry=YES;
        _confirmNewPwdTextField.textfield.secureTextEntry=YES;
    }
}

- (IBAction)commit:(id)sender
{
    if ([_oldPwdTextField.textfield.text length] != 0 && [_inputNewPwdTextField.textfield.text length] != 0 && [_confirmNewPwdTextField.textfield.text length] != 0) {
        
        if ([_inputNewPwdTextField.textfield.text isEqualToString:_confirmNewPwdTextField.textfield.text]) {
            
            if ([self passwordRuleForString:_confirmNewPwdTextField.textfield.text]) {
                
                [self resignAll];
                [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
                
                RQPwd *rq = [[RQPwd alloc] init];
                rq.passwordType = self.passwordType;
                rq.oldPwd = _oldPwdTextField.textfield.text;
                rq.pwd = _inputNewPwdTextField.textfield.text;
                [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
                    
                    [HUDView dismissCurrent];
                    if (rq_.msgContent) {
                        
                        if (_passwordType == kPasswordTypeLogin) {
                            
                            if (rq_.msgType == 1) {
                                
                                PwdChangeResultVC *vc = [[PwdChangeResultVC alloc] initWithNibName:@"PwdChangeResultVC" bundle:nil];
                                vc.title = @"修改登录密码";
                                vc.passwordType = kPasswordTypeLogin;
                                [self.navigationController pushViewController:vc animated:YES];
                                [vc release];
                                
                            }else {
                                [self showAlertMessage:rq_.msgContent];
                            }
                            
                        }else {
                            [self showAlertMessage:rq_.msgContent];
                        }
                        
                    }else {
                        
                        if (_passwordType != kPasswordTypeLogin) {
                            PwdChangeResultVC *vc = [[PwdChangeResultVC alloc] initWithNibName:@"PwdChangeResultVC" bundle:nil];
                            vc.title = @"修改安全密码";
                            vc.passwordType = kPasswordTypeSecChange;
                            [self.navigationController pushViewController:vc animated:YES];
                            [vc release];
                        }
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    InRectTextField *tf = (InRectTextField *)textField.superview;
    if ([textField.text length] > 0) {
        tf.clearButton.alpha = 1;
    }
    
    if (textField==_oldPwdTextField.textfield) {
        [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (textField==_inputNewPwdTextField.textfield) {
        [self.scroll setContentOffset:CGPointMake(0, 100) animated:YES];
    }else if (textField==_confirmNewPwdTextField.textfield) {
        [self.scroll setContentOffset:CGPointMake(0, 200) animated:YES];
    }
    self.scroll.contentSize=CGSizeMake(320, 504 + 214);
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.scroll.contentSize=CGSizeMake(320, 504);
    [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    InRectTextField *tf = (InRectTextField *)textField.superview;
    tf.clearButton.alpha = 0;
}

- (void)textfieldChangeNotification:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    InRectTextField *tf = (InRectTextField *)textField.superview;
    if ([textField.text length] > 0) {
        tf.clearButton.alpha = 1;
    }else {
        tf.clearButton.alpha = 0;
    }
}

@end
