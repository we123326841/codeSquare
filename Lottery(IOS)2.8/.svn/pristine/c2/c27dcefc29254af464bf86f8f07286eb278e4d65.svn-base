//
//  TransferSuccessVC.m
//  Caipiao
//
//  Created by GroupRich on 14-12-18.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "TransferSuccessVC.h"

@interface TransferSuccessVC ()

@end

@implementation TransferSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title  = @"转移资金";
    
    _transferedCountL.text = _transferedText;
    _remainCountL.text = _remainText ;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_transferedCountL release];
    [_remainCountL release];
    self.transferedText=nil;
    self.remainText=nil;
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTransferedCountL:nil];
    [self setRemainCountL:nil];
    [super viewDidUnload];
}
- (IBAction)btnclicked:(id)sender {
    
    switch ([sender tag]) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
        {
            UIViewController *vc = [[NSClassFromString(@"FundsViewController") alloc] initWithNibName:@"FundsViewController" bundle:nil];
            [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
            //    [[AppDelegate shared].nav pushViewController:vc animated:YES];
            [vc release];
            FLEvent(kFLEventFundDetail);
        }
            break;
        default:
            break;
    }
    
}
@end
