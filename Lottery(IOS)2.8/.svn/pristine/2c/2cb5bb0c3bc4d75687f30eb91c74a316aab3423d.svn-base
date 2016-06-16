//
//  AddUserViewController.m
//  Caipiao
//
//  Created by cYrus on 13-10-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "AddUserViewController.h"
#import "View+Factory.h"
#import "RQRegisterUser.h"
#import "LoadingAlertView.h"
#import "AddUserResultVC.h"

@interface AddUserViewController ()

@property (assign, nonatomic) IBOutlet UILabel *typeLabel;
@property (assign, nonatomic) IBOutlet InRectTextField *accountTextField;
@property (assign, nonatomic) IBOutlet InRectTextField *pwdTextField;
@property (assign, nonatomic) IBOutlet InRectTextField *nickNameTextField;
@property (assign, nonatomic) IBOutlet UIButton *checkBox;
@property (assign, nonatomic) BOOL checked;
@property (assign, nonatomic) IBOutlet UIView *typeBg;
@property (assign, nonatomic) IBOutlet UILabel *typeTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *accountTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *pwdTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *nickNameTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *checkLbl;
@property (assign, nonatomic) IBOutlet UIButton *button;
@property (assign, nonatomic) IBOutlet UIScrollView *scroll;

@end

@implementation AddUserViewController

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
    self.scroll.contentSize=CGSizeMake(320, 504);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAll)];
    [self.scroll addGestureRecognizer:tap];
    
    UIColor *yellowColor=kYellowTextColor;
    for (id obj in [self.scroll subviews]) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *lbl=(UILabel *)obj;
            if (lbl.tag != 1000) {
                lbl.textColor = yellowColor;
            }else {
                lbl.textColor = [UIColor rgbColorWithHex:@"#858585"];
            }
        }
    }
    
    self.typeBg.layer.cornerRadius=8;
    self.typeBg.layer.masksToBounds=YES;
    self.typeBg.layer.borderColor=yellowColor.CGColor;
    self.typeBg.layer.borderWidth=2;
    
    [self.button setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
//    [self.button setBackgroundColor:kYellowTextColor];
    self.button.layer.cornerRadius=4;
    self.button.layer.masksToBounds=YES;
    
    [self.checkBox addTarget:self action:@selector(checkBoxAction) forControlEvents:UIControlEventTouchUpInside];
    [self.button addTarget:self action:@selector(commitRegister) forControlEvents:UIControlEventTouchUpInside];
    
    self.accountTextField.textfield.delegate=self;
    self.pwdTextField.textfield.delegate=self;
    self.pwdTextField.textfield.secureTextEntry=YES;
    self.nickNameTextField.textfield.delegate=self;
    
    self.userType = @"0";
    self.typeLabel.text=@"会    员";
    /*
    if ([self.userType intValue]==0) {
        self.typeLabel.text=@"会    员";
    }else {
        self.typeLabel.text=@"代    理";
    }
     */
    
    MSNotificationCenterAddObserver(@selector(textfieldChangeNotification:), UITextFieldTextDidChangeNotification);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkBoxAction
{
    self.checked=!self.checked;
    [self.checkBox setImage:[UIImage imageNamed:self.checked?@"checkbox_on.png":@"checkbox_off.png"] forState:UIControlStateNormal];
    [self.pwdTextField.textfield resignFirstResponder];
//    [self.scroll setContentOffset:CGPointMake(0, self.scroll.contentOffset.y-200) animated:YES];
    if (self.checked) {
        self.pwdTextField.textfield.secureTextEntry=NO;
    }else {
        self.pwdTextField.textfield.secureTextEntry=YES;
    }
}

- (void)resignAll
{
    [self.accountTextField.textfield resignFirstResponder];
    [self.nickNameTextField.textfield resignFirstResponder];
    [self.pwdTextField.textfield resignFirstResponder];
    
    self.scroll.contentSize=CGSizeMake(320, 504);
    [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)commitRegister
{
    [self resignAll];
    self.scroll.contentSize=CGSizeMake(320, 504);

    if (self.accountTextField.textfield.text!=nil && self.pwdTextField.textfield.text!=nil && self.nickNameTextField.textfield.text!=nil && ![self.accountTextField.textfield.text isEqualToString:@""] && ![self.pwdTextField.textfield.text isEqualToString:@""] && ![self.nickNameTextField.textfield.text isEqualToString:@""]) {
        
        [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
        
        RQRegisterUser *rq = [[[RQRegisterUser alloc] init] autorelease];
        rq.username=self.accountTextField.textfield.text;
        rq.userpass=self.pwdTextField.textfield.text;
        rq.usertype=self.userType;
        rq.nickname=self.nickNameTextField.textfield.text;
        [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            
            if (!rq_.msgContent) {
                [HUDView dismissCurrent];
                
                AddUserResultVC *vc=[[AddUserResultVC alloc] initWithNibName:@"AddUserResultVC" bundle:nil];
                vc.title=@"增加用户";
                vc.userAccount=self.accountTextField.textfield.text;
                vc.userPwd=self.pwdTextField.textfield.text;
                vc.userNickname=self.nickNameTextField.textfield.text;
                vc.userType=[self.userType intValue]==0?@"普通用户":@"代理用户";
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
                
            }else {
                [HUDView dismissCurrent];
                [self showAlertViewWithTitle:rq_.msgContent];
            }
        } sender:nil];
        self.rq = rq;
    }else {
        [self showAlertViewWithTitle:@"请输入内容"];
    }
}

- (void)showAlertViewWithTitle:(NSString *)title
{
    HUDShowMessage(title, nil);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    InRectTextField *tf = (InRectTextField *)textField.superview;
    if ([textField.text length] > 0) {
        tf.clearButton.alpha = 1;
    }
    
    if (textField==self.accountTextField.textfield) {
        [self.scroll setContentOffset:CGPointMake(0, 100) animated:YES];
    }else if (textField==self.pwdTextField.textfield) {
        [self.scroll setContentOffset:CGPointMake(0, 200) animated:YES];
    }else if (textField==self.nickNameTextField.textfield) {
        [self.scroll setContentOffset:CGPointMake(0, 300) animated:YES];
    }
    self.scroll.contentSize=CGSizeMake(320, 504 + 214);

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    InRectTextField *tf = (InRectTextField *)textField.superview;
    tf.clearButton.alpha = 0;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.accountTextField.clearButton.alpha = 0;
    self.pwdTextField.clearButton.alpha = 0;
    self.nickNameTextField.clearButton.alpha = 0;

    self.scroll.contentSize=CGSizeMake(320, 504);
    [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
    
    return YES;
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
