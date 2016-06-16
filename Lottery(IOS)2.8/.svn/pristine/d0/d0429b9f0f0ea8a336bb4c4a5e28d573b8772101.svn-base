//
//  TransferFundVC.m
//  Caipiao
//
//  Created by GroupRich on 14-10-28.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "TransferFundVC.h"
#import "TransferNoti.h"
#import "TransferAlert.h"
#import "RQMigrate.h"
#import "TransferSuccessVC.h"
@interface TransferFundVC ()

@end

@implementation TransferFundVC

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
    self.title=@"转移资金";
    // Do any additional setup after loading the view from its nib.
    _amountL.text = [SharedModel formattedOldBalance];
    _scrollView.contentSize = CGSizeMake(320, ([UIScreen mainScreen].bounds.size.height>480?568:650));
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _amountL.text = [SharedModel formattedOldBalance];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_amountL release];
    [_transferField release];
    [_scrollView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setAmountL:nil];
    [self setTransferField:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (IBAction)transferfund:(id)sender {
    
    if ([_transferField.text floatValue] > [[SharedModel shared].oldBalance floatValue]) {
        [HUDView showMessageToView:KEY_WINDOW msg:@"转移金额不能大于总金额" subtitle:nil];
        return;
    }
    
    RQMigrate *rq = [[RQMigrate alloc]init];
    self.rq = rq;
    rq.fundpassword=_fundpwd;
    rq.amount=[_transferField.text floatValue];
    [HUDView showLoadingToView:KEY_WINDOW msg:@"正在转移..." subtitle:nil];
    [rq startPostWithBlock:^(id rq_, NSError *error_, id rqSender_) {
        HUDHide();
        if ([[rq_ status] isEqualToString:@"success"]) {
//            MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil message:@"资金转移成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
//            [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
//            }];
//            [alert show];
            TransferSuccessVC *vc = [[TransferSuccessVC alloc]init];
            vc.transferedText = [NSString stringWithFormat:@"成功转移资金 %@ 元",[SharedModel formatBalance: [NSString stringWithFormat:@"%f",[(RQMigrate*)self.rq amount]]]];
            [SharedModel shared].oldBalance = [NSString stringWithFormat:@"%f",[[SharedModel shared].oldBalance floatValue]-[(RQMigrate*)self.rq amount]];
            vc.remainText =[NSString stringWithFormat:@"您的账户还可转移资金 %@ 元",[SharedModel formatBalance: [SharedModel shared].oldBalance]]; ;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];

        }else{
            MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle: @"资金转移失败" message:[rq_ msg] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
            [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
            }];
            [alert show];
        }
    } sender:nil];
    [rq release];
}

- (IBAction)laterSay:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString * eStr = [NSMutableString stringWithString:textField.text];
    [eStr  insertString:string atIndex:range.location];
    
    NSInteger flag=0;
    const NSInteger limited = 2;
    for (NSInteger i = eStr.length-1; i>=0; i--) {
        
        if ([eStr characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                return NO;
            }
            
            break;
        }
        flag++;
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
