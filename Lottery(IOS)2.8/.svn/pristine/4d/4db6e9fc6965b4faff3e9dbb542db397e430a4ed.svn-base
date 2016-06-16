//
//  RechargeResultViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RechargeResultViewController.h"
#import "View+Factory.h"

#import "RQBankRecharge.h"

@interface RechargeResultViewController ()

@end

@implementation RechargeResultViewController

- (void)dealloc{
    [_fullBankName release];
    [_commitRequest release];
    [emailView release];
    [otherInfoView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSString *bankName = NSLocalizedStringFromTable(self.fullBankName, @"Bank", nil);
    Echo(@"bankName=%@",bankName);
    self.title = [NSString stringWithFormat:@"%@充值申请",bankName];
    
    _orderLbl.text = [_orderLbl.text stringByAppendingFormat:@"%@",_commitRequest.key];
    _amountLbl.text = [SharedModel formatBalancef:[_commitRequest.amount floatValue]];
    
//    _emailLbl.text = [_emailLbl.text stringByAppendingFormat:@"%@", _commitRequest.bankName];
    _emailLbl.text =  _commitRequest.email?_commitRequest.email:@"";
    if ([self.fullBankName rangeOfString:@"工商"].location==NSNotFound) {
        CGRect frame = otherInfoView.frame;
        frame.origin.y = 130;
        otherInfoView.frame = frame;
        
        emailView.hidden=YES;
    }else
    {
        CGRect frame = otherInfoView.frame;
        frame.origin.y = 166;
        otherInfoView.frame = frame;
        
        emailView.hidden=NO;
    }
    _nameLbl.text = [_nameLbl.text stringByAppendingFormat:@"%@",_commitRequest.accountName];
    _accountLbl.text = [_accountLbl.text stringByAppendingFormat:@"%@", _commitRequest.account];
    _accountBankLbl.text = [_accountBankLbl.text stringByAppendingFormat:@"%@",_commitRequest.bankName];
    
    if ([_commitRequest.account rangeOfString:@"@"].length > 0){
        _accountLbl.text = [@"收款E-mail地址：" stringByAppendingFormat:@"%@", _commitRequest.account];
    }
    _tipLbl.text = @"附言区分大小写，请正确输入";
    
    if ([_commitRequest.key length] == 0) {
        _tipLbl.hidden = YES;
        _orderLbl.hidden = YES;
        _orderTagLbl.hidden = YES;
        _copyButton.hidden = YES;
    }
    
    _seconds = 1800;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    {
        _orderLbl.textColor = Color(@"RechargeResultOrderColor");
        _orderTagLbl.textColor = Color(@"RechargeResultOrderTagColor");
        _tipLbl.textColor =
        _tip1Lbl.textColor =
        _tip2Lbl.textColor = Color(@"RechargeResultTipColor");
        _amountLbl.textColor = Color(@"RechargeResultAmountColor");
        _amountTagLbl.textColor = Color(@"RechargeResultAmountTagColor");

        _bankTagLbl.textColor =
        _nameTagLbl.textColor =
        _accountTagLbl.textColor =
        _accountBankTagLbl.textColor = Color(@"RechargeResultBankTagColor");
        
        _emailLbl.textColor =
        _nameLbl.textColor =
        _accountLbl.textColor =
        _accountBankLbl.textColor = Color(@"RechargeResultBankColor");
        
        _minuteLbl1.textColor =
        _minuteLbl2.textColor =
        _secondLbl1.textColor =
        _secondLbl2.textColor = Color(@"RechargeResultTimeColor");
    }
//    UIButton *rightButton = [UIButton barButtonWithTitle:@"注意事项"];
//    rightButton.frame = CGRectMake(0, 0, 76, rightButton.bounds.size.height);
//    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self setRightBarButton:rightButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)rightButtonAction{
//    RechargeAttentionViewController *vc = [[RechargeAttentionViewController alloc] init];
//    vc.bankName = _commitRequest.bankName;
//    vc.fullBankName = self.fullBankName;
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc release];
//}

- (void)updateTime
{
    _seconds--;
    NSString *min = [NSString stringWithFormat:@"%02d",_seconds/60];
    NSString *sec = [NSString stringWithFormat:@"%02d",_seconds%60];
    
    _minuteLbl1.text = [min substringWithRange:NSMakeRange(0, 1)];
    _minuteLbl2.text = [min substringWithRange:NSMakeRange(1, 1)];
    _secondLbl1.text = [sec substringWithRange:NSMakeRange(0, 1)];
    _secondLbl2.text = [sec substringWithRange:NSMakeRange(1, 1)];
    
    if (_seconds == 0) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (IBAction)copyInfo:(id)sender
{
    NSString *copyStr = [_commitRequest.key length] == 0 ? @"" : _commitRequest.key;
    [[UIPasteboard generalPasteboard] setString:copyStr];
    HUDShowMessage(@"复制成功", nil);
}

- (IBAction)finish:(id)sender
{
    [self backAction:nil];
}

- (void)viewDidUnload {
    [emailView release];
    emailView = nil;
    [otherInfoView release];
    otherInfoView = nil;
    [super viewDidUnload];
}
@end


//@implementation RechargeAttentionViewController
//
//- (void)dealloc{
//    [_bankName release];
//    [_fullBankName release];
//    [super dealloc];
//}
//
//- (void)viewDidLoad{
//    [super viewDidLoad];
//    
//    NSString *key = [NSString stringWithFormat:@"%@注意事项", _fullBankName];
//    self.title = [NSString stringWithFormat:@"%@注意事项", _bankName];
//    
//    NSString *text = //NSLocalizedString(key, nil);
//    [[NSBundle mainBundle] localizedStringForKey:key value:self.fullBankName table:@"Bank"];
//    
//    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 20)];
//    titleLbl.backgroundColor = [UIColor clearColor];
//    titleLbl.textColor = kYellowTextColor;
//    titleLbl.text = @"注意事项：";
//    titleLbl.font = [UIFont boldSystemFontOfSize:15.f];
//    [self.view addSubview:titleLbl];
//    [titleLbl release];
//    
//    CGRect rect = CGRectMake(20, titleLbl.frame.origin.y + titleLbl.frame.size.height + 20, 280, 100);
//    UILabel *lbl = [[UILabel alloc] initWithFrame:rect];
//    lbl.backgroundColor = [UIColor clearColor];
//    lbl.textColor = kYellowTextColor;
//    lbl.numberOfLines = 0;
//    lbl.font = [UIFont systemFontOfSize:14.f];
//    lbl.text = text;
//    CGSize size = [text sizeWithFont:lbl.font constrainedToSize:CGSizeMake(rect.size.width, NSIntegerMax)];
//    rect.size.height = size.height;
//    lbl.frame = rect;
//    
//    RoundedBlackView *blackView = [[RoundedBlackView alloc] initWithFrame:CGRectInset(rect, -10, -10)];
//    [self.view addSubview:blackView];
//    [self.view addSubview:lbl];
//    [blackView release];
//    [lbl release];
//}
//
//
//@end

