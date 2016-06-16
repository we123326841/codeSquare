//
//  ChargeViewController.m
//  Caipiao
//
//  Created by danal on 13-10-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "ChargeViewController.h"
#import "UserTransationViewController.h"
#import "RQAgentMember.h"

@interface ChargeViewController ()

@end

@implementation ChargeViewController

- (void)viewDidLoad
{
    self.title = @"用户充值";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textFiled.delegate = self;
    self.textFiled.leftViewMode = UITextFieldViewModeAlways;
    self.textFiled.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)] autorelease];
    
    /*
    SharedModel *model = [SharedModel shared];
    self.accountLbl1.text = [NSString stringWithFormat:@"%@(%@)",model.userAccout, model.username];
    self.bankBalanceLbl.text = [SharedModel formatBalance:[model teamBalanceBank] prefix:@"银行余额：" subfix:@"元"];
    self.accountLbl2.text = self.member.name;
    self.bankHallBalanceLbl.text = [SharedModel formatBalance:self.member.bankBalance prefix:@"银行余额：" subfix:@"元"];
    */
    
    RQChargeData *rq = [[[RQChargeData alloc] init] autorelease];
    rq.uid = self.member.uid;
    [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        
        if (rq_.msgType == kMessageTypeError){
            MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil
                                                                      message:rq_.msgContent
                                                                     delegate:nil
                                                            cancelButtonTitle:nil
                                                            otherButtonTitles:NSLocalizedString(@"OK", nil),nil];
            [alert setClickBlock:^(MSBlockAlertView *a, NSInteger buttonIndex) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert show];
            [alert release];
            
            return;
        }
        
        RQChargeData *q = (RQChargeData *)rq_;
        self.accountLbl1.text = [NSString stringWithFormat:@"%@",q.ownUsername];
        self.bankBalanceLbl.text = [SharedModel formatBalance:[NSString stringWithFormat:@"%f",q.ownBalance] prefix:@"银行余额：" subfix:@"元"];
        self.accountLbl2.text = q.receiverUsername;
        self.bankHallBalanceLbl.text = [SharedModel formatBalance:[NSString stringWithFormat:@"%f",q.receiverBalance] prefix:@"银行余额：" subfix:@"元"];
        
    } sender:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextAction:(id)sender{
    if ([self.textFiled.text length] > 0){
        [self.textFiled resignFirstResponder];
        self.member.money = self.textFiled.text;
        ChargePasswordViewController *vc = [[ChargePasswordViewController alloc] init];
        vc.member = self.member;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rect = self.view.frame;
    rect.origin.y = -120;
    self.view.frame = rect;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    self.view.frame = rect;
    [textField resignFirstResponder];
    return YES;
}

@end


@implementation ChargePasswordViewController

- (void)viewDidLoad
{
    self.title = @"用户充值";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textFiled.delegate = self;
    self.textFiled.leftViewMode = UITextFieldViewModeAlways;
    self.textFiled.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)] autorelease];
    
    self.accountLbl.text = [NSString stringWithFormat:@"用户账号：%@",self.member.name];
    self.amountLbl.text = [SharedModel formatBalance:self.member.money prefix:@"充值金额：" subfix:@"元"];
    self.amountZhLbl.text = [NSString stringWithFormat:@"金额：%@元整", [SharedModel zhHantRMB:self.member.money]];
    
}

- (IBAction)confirmAction:(id)sender{
    if ([self.textFiled.text length] > 0){
        self.member.password = self.textFiled.text;
        RQCharge *rq = [[[RQCharge alloc] init] autorelease];
        rq.uid = self.member.uid;
        rq.money = self.member.money;
        rq.password = self.member.password;
        [rq startPostWithDelegate:self];
        self.rq = rq;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rect = self.view.frame;
    rect.origin.y = -60;
    self.view.frame = rect;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    self.view.frame = rect;
    [textField resignFirstResponder];
    return YES;
}

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    if (error){
        
    } else if (rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
    } else {
        ChargeResultViewController *vc = [[ChargeResultViewController alloc] init];
        vc.member = self.member;
        vc.charge = (RQCharge *)rq;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}

- (void)onRQStart:(RQBase *)rq{
    [HUDView showLoading:self.view];
}

@end

@implementation ChargeResultViewController

- (void)dealloc{
    [_charge release];
    [super dealloc];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"充值成功";
    self.titleLbl.font = [UIFont boldSystemFontOfSize:20.f];
    self.accountLbl.text = [NSString stringWithFormat:@"用户账号：%@", _charge.username];
    self.amountLbl.text = [SharedModel formatBalance:[NSString stringWithFormat:@"%d",_charge.responedMoney]  prefix:@"充值金额：" subfix:@"元"];
    self.amountZhLbl.text = [NSString stringWithFormat:@"金额：%@元整", _charge.rmbMoney];
}

- (IBAction)userlistButtonAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)transactionButtonAction:(id)sender{
    UserTransationViewController *vc = [[UserTransationViewController alloc] init];
    vc.uid = self.member.uid;
    vc.username = self.member.name;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

@end