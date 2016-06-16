//
//  WithdrawCashVC.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "WithdrawCashVC.h"
#import "RQWithdrawCash.h"
#import "View+Factory.h"
#import "BankModel.h"
#import "WithdrawCashConfirmVC.h"
#import "SecurityPwdInputViewController.h"
#import "BankCardCell.h"
#import "NotSetSecurityPwdVC.h"
#import "PwdCreateSecPwdVC.h"
#import "Musou.h"
#import "SecuritySettingResultVC.h"
#import "SecurityIssuesVC.h"
#import "CardListViewController.h"
@interface WithdrawCashVC ()

@end

@implementation WithdrawCashVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    Echo(@"%s",__func__);
    [_header release];
    _amoutField.delegate = nil;
    MSNotificationCenterRemoveObserver();
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提现";
    
    UIButton *btn = [UIButton barButtonWithTitle:@"新增绑卡"];
    btn.frame = CGRectMake(0, 0, 76, btn.bounds.size.height);
    [btn addTarget:self action:@selector(addNewCard:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];
    
    _amoutField.delegate = self;
    _cardMenu.delegate = self;
    
    _noticeView = (id)[CardNotBindView loadFromNib];
    _noticeView.hidden = YES;
    [_noticeView.bindButton addTarget:self action:@selector(gotoBindingCard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_noticeView];

    for (UIView *v in [_wrapView subviews]) {
        v.hidden = YES;
    }
    _selectedBankIndex = 0;
    MSNotificationCenterAddObserver(@selector(textfieldChangeNotification:), UITextFieldTextDidChangeNotification);
    
    for (UILabel *l in _tagLbls) {
        l.textColor = Color(@"WithdrawTagColor");
    }
    _userLbl.textColor = _availableCashLbl.textColor = Color(@"WithdrawHeadColor");
    _amountTagLbl.textColor = Color(@"WithdrawAmountTagColor");
    
    MSNotificationCenterAddObserver(@selector(bindAction:),@"kCardBindSetSecuritySuccessNoti");

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([SharedModel userType] == kUserTypeTopAgent) {
        HUDShowMessage(@"提现请到平台操作。", nil);
        [self backAction:nil];
        self.navigationItem.rightBarButtonItem = nil;
    }else {
        [self readyToLoadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MSNotificationCenterRemoveObserver();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_cardMenu close];
}

- (void)readyToLoadData
{
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, -100.f, 320.f, 100.f) atTop:YES];
    [self.view addSubview:loadingView];
    self.header = loadingView;
    [loadingView release];
    
    CGRect rect = self.header.frame;
    rect.origin.y = -40.f;
    [UIView animateWithDuration:.3f
                          delay:.1f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.header.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         self.header.state = kPRStateLoading;
                         [self performSelector:@selector(loadData) withObject:nil afterDelay:.3f];
                     }];
}

- (void)loadData
{
    RQWithdrawCashInit *rq = [[RQWithdrawCashInit alloc] init];
    [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        
        RQWithdrawCashInit *withdrawInit = (RQWithdrawCashInit *)rq_;
        CGRect rect = self.header.frame;
        rect.origin.y = -100.f;
        self.header.state = kPRStateNormal;
        [UIView animateWithDuration:.3f animations:^{
            self.header.frame = rect;
        } completion:^(BOOL finished) {
        }];
        
        if (rq_.msgContent){
            if (rq_.msgType == 8) {
                //未绑卡
                self.noticeView.hidden = NO;
                self.navigationItem.rightBarButtonItem = nil;
                
            }else if (rq_.msgType == 2) {
                _noticeView.hidden = NO;
                _noticeView.image.hidden = YES;
                _noticeView.bindButton.hidden = YES;
                _noticeView.textLbl.text = rq_.msgContent;
                self.navigationItem.rightBarButtonItem = nil;
            }else {
                HUDShowMessage(rq_.msgContent, nil);
                _noticeView.hidden = YES;
                
                __block WithdrawCashVC *blockSelf = self;
                if ([[CDUserInfo user] needSetSecurityPass]) {
                    NotSetSecurityPwdVC *vc = [[NotSetSecurityPwdVC alloc]init];
                    vc.clickedBlock = ^(NotSetSecurityPwdVC*novc){
                        SecurityPwdInputViewController *vc = [[SecurityPwdInputViewController alloc]init];
                        [blockSelf.navigationController pushViewController:vc animated:YES];
                        [vc release];
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                    
                    return;
                }
                
                //[self backAction:nil];
            }
        }else {
            if ([withdrawInit.banksList count] == 0){
                //未绑卡
                self.noticeView.hidden = NO;
                self.navigationItem.rightBarButtonItem = nil;
            } else {
                for (UIView *v in [_wrapView subviews]) {
                    v.hidden = NO;
                }
                _noticeView.hidden = YES;
                
                [_cardMenu.dataList removeAllObjects];
                [_cardMenu.dataList addObjectsFromArray:withdrawInit.banksList];
                [_cardMenu reloadData];
                
                BankModel *model = [_cardMenu.dataList objectAtIndex:0];
                BankCardCell *cell = (BankCardCell *)[BankCardCell loadFromNib];
                cell.bankIcon.image = ResImage(model.bank_name);
                cell.bankNameLbl.text = model.bank_name;
                cell.bankAccountLbl.text = model.account;
                [_cardMenu.mainView addSubview:cell.contentView];
                
//                self.userLbl.text = rq.userName;
                self.userLbl.text = [CDUserInfo user].account;
                self.availableCashLbl.text = [SharedModel formatBalancef:rq.availableBalance];
//                self.timesLbl.text = [NSString stringWithFormat:@"已提现%d次，今天还可以提现%d次", rq.count, rq.times-rq.count];
                self.timesLbl.text = [NSString stringWithFormat:@"提现最低%ld元,最高%@元,今天还可以提现%ld次",(long)rq.lowLimit,[SharedModel formatBalancef:rq.upLimit],(rq.times-rq.count)];
                self.amoutField.placeholder = [NSString stringWithFormat:@"本次可提现%.2f元",rq.maxWithdrawMoney];
                self.rq = rq;
            }
        }
        
    } sender:nil];
}

- (IBAction)nextStep:(id)sender
{
    if ([self.amoutField.text length] != 0) {
        if ([self.amoutField.text intValue] >= 100) {
            [self.view endEditing:YES];
            [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
            
            RQWithdrawCashCheck *rq = [[RQWithdrawCashCheck alloc] init];
            rq.money = self.amoutField.text;
            RQWithdrawCashInit *tmpRq=(RQWithdrawCashInit *)self.rq;
            BankModel *model =[tmpRq.banksList objectAtIndex:_selectedBankIndex];
            rq.bankModel=model;
            rq.bankInfo = [NSString stringWithFormat:@"%d#%d",model.b_id, model.bank_id];
            [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
                
                [HUDView dismissCurrent];
                if (rq_.msgType == 8) {
                    //未绑卡
                    self.noticeView.hidden = NO;
                    self.navigationItem.rightBarButtonItem = nil;
                    
                }else if (rq_.msgContent && rq_.msgType != 8) {
                    [self showAlertMessage:rq_.msgContent];
                }else {
                    WithdrawCashConfirmVC *vc = [[WithdrawCashConfirmVC alloc] initWithNibName:@"WithdrawCashConfirmVC" bundle:nil];
                    vc.title = @"提现申请";
                    vc.rqCheck = rq;
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                }
                
            } sender:nil];
            
        }else {
            [self showAlertMessage:@"单笔最低提现金额为100元"];
        }
    }else {
        [self showAlertMessage:@"请输入提现金额"];
    }
    
}

- (void)addNewCard:(id)sender
{
//    SecurityPwdInputViewController *vc = [[SecurityPwdInputViewController alloc] initWithNibName:@"SecurityPwdInputViewController" bundle:nil];
//    vc.title = @"卡号绑定";
//    vc.bindRightNow = NO;
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc release];
    
    [self checkNeedSetSecurityPass];

}
- (IBAction)bindAction:(id)sender{
    [self checkNeedSetSafeQuest];
}
-(void)checkNeedSetSecurityPass
{
    if ([[[CDUserInfo user] needSetSecurityPass] boolValue])
    {
        PwdCreateSecPwdVC *pwdvc = [[PwdCreateSecPwdVC alloc] initWithNibName:@"PwdCreateSecPwdVC" bundle:nil];
        pwdvc.title = @"设置安全密码";
        pwdvc.resultSuccess = ^(id obj){
            [self checkNeedSetSafeQuest];
        };
        [self.navigationController pushViewController:pwdvc animated:YES];
        [pwdvc release];
        return;
    }else
    {
        [self checkNeedSetSafeQuest];
    }
}
-(void)checkNeedSetSafeQuest{
    
    if ([[[CDUserInfo user]needSetSafeQuest]boolValue]) {
        
        SecuritySettingResultVC *vc = [[SecuritySettingResultVC alloc]init];
        vc.type = ResultTypeNO;
        vc.clicked = ^(NSUInteger index){
            if (index==1) {
                SecurityIssuesVC *vc2 = [[SecurityIssuesVC alloc]init];
                vc2.type=ComeTypeCardBing;
                [vc.navigationController pushViewController:vc2 animated:YES];
                [vc2 release];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        return;
    }else{
        CardListViewController *vc = [[CardListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}


- (IBAction)gotoBindingCard:(id)sender
{
    SecurityPwdInputViewController *vc = [[SecurityPwdInputViewController alloc] initWithNibName:@"SecurityPwdInputViewController" bundle:nil];
    vc.title = @"卡号绑定";
    vc.bindRightNow = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark - DropDownMenuDelegate

- (UITableViewCell *)dropDownMenu:(DropDownMenu *)menu cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankCardCell *cell = [menu.tableView dequeueReusableCellWithIdentifier:@"BankCardCell"];
    if (!cell) {
        cell = (BankCardCell *)[BankCardCell loadFromNib];
    }
    
    BankModel *model = [_cardMenu.dataList objectAtIndex:indexPath.row];
    cell.bankIcon.image = ResImage(model.bank_name);
    cell.bankNameLbl.text = model.bank_name;
    cell.bankAccountLbl.text = model.account;
    
    return cell;
}

- (void)dropDownMenu:(DropDownMenu *)menu selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (UIView *view in [_cardMenu.mainView subviews]) {
        [view removeFromSuperview];
    }
    BankModel *model = [_cardMenu.dataList objectAtIndex:indexPath.row];
    BankCardCell *cell = (BankCardCell *)[BankCardCell loadFromNib];
    cell.bankIcon.image = ResImage(model.bank_name);
    cell.bankNameLbl.text = model.bank_name;
    cell.bankAccountLbl.text = model.account;
    [_cardMenu.mainView addSubview:cell.contentView];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)textfieldChangeNotification:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    RQWithdrawCashInit *rq = (RQWithdrawCashInit *)self.rq;
    if ([textField.text floatValue] > rq.availableBalance) {
        textField.text = [NSString stringWithFormat:@"%.2f",rq.maxWithdrawMoney];
    }
}

@end
