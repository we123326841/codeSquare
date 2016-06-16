//
//  RechargeDetailViewController.m
//  Caipiao
//
//  Created by MDD on 5/26/15.
//  Copyright (c) 2015 yz. All rights reserved.
//

#import "RechargeDetailViewController.h"

@interface RechargeDetailViewController ()

@end

@implementation RechargeDetailViewController

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
    self.title = @"充值详情";
    
    [self loadData];
}

-(void)loadData{
    _rechargeBankLbl.text = _model.type;
    _orderIdLbl.text =_model.orderId;
    _rechargeAmountLbl.text =[NSString stringWithFormat: @"%.2f", _model.applyMoney];
    _rechargeTimeLbl.text =_model.time;
    switch (_model.status) {
        case 1:
            _statusLbl.text = @"支付中";
            break;
        case 2:
            _statusLbl.text = @"支付成功";
            break;
        case 3:
            _statusLbl.text = @"订单关闭";
            break;
        case 4:
            _statusLbl.text = @"用户关闭";
            break;
        case 5:
            _statusLbl.text = @"管理员关闭";
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_rechargeBankLbl release];
    [_orderIdLbl release];
    [_rechargeAmountLbl release];
    [_rechargeTimeLbl release];
    [_statusLbl release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setRechargeBankLbl:nil];
    [self setOrderIdLbl:nil];
    [self setRechargeAmountLbl:nil];
    [self setRechargeTimeLbl:nil];
    [self setStatusLbl:nil];
    [super viewDidUnload];
}
@end
