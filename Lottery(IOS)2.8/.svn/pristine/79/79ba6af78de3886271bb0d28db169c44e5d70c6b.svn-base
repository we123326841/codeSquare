//
//  SecuritySettingResultVC.m
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "SecuritySettingResultVC.h"
#import "SecurityIssuesVC.h"
@interface SecuritySettingResultVC ()

@end

@implementation SecuritySettingResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置安全问题";
   
    [self layoutWithType:_type];
}

-(void)layoutWithType:(ResultType)type
{
    switch (type) {
        case ResultTypeNO:
        {
            _resultV.frame = CGRectMake((self.view.bounds.size.width-456/2)/2, 20, 456/2, 368/2);
            [_resultV setImage:[UIImage imageNamed: Res(@"cash_no_setting_security_waring.png")]];
            
            _topBtn.frame = CGRectMake(10, _resultV.frame.origin.y+_resultV.frame.size.height+20, 300, 41);
            [_topBtn setImage:[UIImage imageNamed:Res(@"cash_setting_security_btn.png")] forState:UIControlStateNormal];
            
            _bottomBtn.frame = CGRectMake(10, _topBtn.frame.origin.y+_topBtn.frame.size.height+20, 300, 41);
            [_bottomBtn setImage:[UIImage imageNamed:Res(@"cash_later_say_btn.png")] forState:UIControlStateNormal];
        }
            break;
        case ResultTypeCashSuccess:
        {
            _resultV.frame = CGRectMake((self.view.bounds.size.width-527/2)/2, 20, 527/2, 369/2);
            [_resultV setImage:[UIImage imageNamed: Res(@"cash_sectury_issues_setting_sucess.png")]];
            
            _topBtn.frame = CGRectMake(10, _resultV.frame.origin.y+_resultV.frame.size.height+20, 300, 41);
            [_topBtn setImage:[UIImage imageNamed:Res(@"continue_cash_btn.png")] forState:UIControlStateNormal];
            
            _bottomBtn.frame = CGRectMake(10, _topBtn.frame.origin.y+_topBtn.frame.size.height+20, 300, 41);
            [_bottomBtn setImage:[UIImage imageNamed:Res(@"come_back_myAccount.png")] forState:UIControlStateNormal];
        }
            break;

        case ResultTypeSettingSuccess:
        {
            
            _resultV.frame = CGRectMake((self.view.bounds.size.width-527/2)/2, 20, 527/2, 369/2);
            [_resultV setImage:[UIImage imageNamed: Res(@"cash_sectury_issues_setting_sucess.png")]];

            _topBtn.frame = CGRectMake(10, _resultV.frame.origin.y+_resultV.frame.size.height+20, 300, 41);
            [_topBtn setImage:[UIImage imageNamed:Res(@"come_back_myAccount.png")] forState:UIControlStateNormal];
            _bottomBtn.hidden = YES;
        }
            break;
        case ResultTypeCardBingSuccess:
        {
            
            _resultV.frame = CGRectMake((self.view.bounds.size.width-527/2)/2, 20, 527/2, 369/2);
            [_resultV setImage:[UIImage imageNamed: Res(@"cash_sectury_issues_setting_sucess.png")]];
            
            _topBtn.frame = CGRectMake(10, _resultV.frame.origin.y+_resultV.frame.size.height+20, 300, 41);
            [_topBtn setImage:[UIImage imageNamed:Res(@"")] forState:UIControlStateNormal];
            [_topBtn setBackgroundImage:[UIImage imageNamed:Res(@"securityBtn.png")] forState:UIControlStateNormal];
            [_topBtn setTitle:@"继续绑定银行卡" forState:UIControlStateNormal];
            [_topBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            _bottomBtn.frame = CGRectMake(10, _topBtn.frame.origin.y+_topBtn.frame.size.height+20, 300, 41);
            [_bottomBtn setImage:[UIImage imageNamed:Res(@"come_back_myAccount.png")] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_resultV release];
    [_topBtn release];
    [_bottomBtn release];
    Block_release(_clicked);
    [super dealloc];
}
- (void)viewDidUnload {
    [self setResultV:nil];
    [self setTopBtn:nil];
    [self setBottomBtn:nil];
    [super viewDidUnload];
}
- (IBAction)btnClicked:(id)sender {
    
    switch (_type) {
        case ResultTypeSettingSuccess:
           [ [AppDelegate shared].nav popToRootViewControllerAnimated:YES];
            break;
        case ResultTypeCashSuccess:
            
            if ([sender tag]==1)
            {
                UIViewController *vc = [[NSClassFromString(@"WithdrawCashVC") alloc] initWithNibName:@"WithdrawCashVC" bundle:nil];
                NSMutableArray *controllers = [self.navigationController.viewControllers mutableCopy];
                [controllers removeAllObjects];
                [controllers addObject:vc];
                [self.navigationController setViewControllers:controllers animated:YES];
                [controllers release];
                [vc release];
                FLEvent(kFLEventWithdraw);
                
            }else{
             [ [AppDelegate shared].nav popToRootViewControllerAnimated:YES];
            }
            break;
        case ResultTypeNO:
            _clicked([sender tag]);
            break;
            case ResultTypeCardBingSuccess:
            if ([sender tag]==1) {
                MSNotificationCenterPost(@"kCardBindSetSecuritySuccessNoti");
            }else{
              [ [AppDelegate shared].nav popToRootViewControllerAnimated:YES];
            }
            break;
        default:
            break;
    }
}

@end
