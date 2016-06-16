//
//  WithdrawCashResultVC.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "WithdrawCashResultVC.h"
#import "View+Factory.h"
#import "WithdrawCashVC.h"

@interface WithdrawCashResultVC ()

@property (assign, nonatomic) IBOutlet UILabel *tipLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;


@end

@implementation WithdrawCashResultVC

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
    _amountLbl.text = [NSString stringWithFormat:@"成功从您的账户中提现%@元",[SharedModel formatBalance:_rqCheck.money_resp]];
    
    {
        _tipLbl.textColor = Color(@"WithdrawAmountTagColor");
        _amountLbl.textColor = Color(@"WithdrawTagColor");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finish:(id)sender
{
    [self backAction:nil];
}

@end
