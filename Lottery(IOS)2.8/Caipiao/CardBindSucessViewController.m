//
//  CardBindSucessViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CardBindSucessViewController.h"

@interface CardBindSucessViewController ()

@end

@implementation CardBindSucessViewController

- (void)dealloc{
    self.detail = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"绑卡结果";
    _detailLbl.text = self.detail;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goonBinding:(id)sender{
    UIViewController *vc = [[NSClassFromString(@"AddCardViewController") alloc] init];
    NSMutableArray *controllers = [self.navigationController.viewControllers mutableCopy];
    [controllers insertObject:vc atIndex:[controllers count] - 2];
    [self.navigationController setViewControllers:controllers animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
    [controllers release];
    [vc release];
}
//改成立即提现
- (IBAction)rechargeNow:(id)sender{
    
    UIViewController *vc = [[NSClassFromString(@"WithdrawCashVC") alloc] init];
    NSMutableArray *controllers = [self.navigationController.viewControllers mutableCopy];
    [controllers removeAllObjects];
    [controllers addObject:vc];
    [self.navigationController setViewControllers:controllers animated:YES];
    [controllers release];
    [vc release];
    FLEvent(kFLEventWithdraw);

}

@end
