//
//  QuickRechargeResultViewController.m
//  Caipiao
//
//  Created by MDD on 5/26/15.
//  Copyright (c) 2015 yz. All rights reserved.
//

#import "QuickRechargeResultViewController.h"
#import "FundsViewController.h"

@interface QuickRechargeResultViewController ()

@end

@implementation QuickRechargeResultViewController

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
     self.title = @"充值提醒";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToRecharge:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goToRechargeRecord:(id)sender {
    FundsViewController *vc = [[FundsViewController alloc] init];
    vc.isFromRecharge = true;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
