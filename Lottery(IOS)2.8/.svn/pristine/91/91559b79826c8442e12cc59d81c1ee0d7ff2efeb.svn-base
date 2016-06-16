//
//  CardBindConfirmViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CardBindConfirmViewController.h"
#import "CardBindSucessViewController.h"

#import "RQCardBinding.h"

#define FILL_LABEL_TAIL(lbl_, format_,...) lbl_.text = [lbl_.text stringByAppendingFormat:__VA_ARGS__]

@interface CardBindConfirmViewController ()<RQBaseDelegate>

@end

@implementation CardBindConfirmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"卡号绑定";
    _bankNameLbl.text = [_bankNameLbl.text stringByAppendingFormat:@"%@",_bank.bank_name];
    _provinceLbl.text = [_provinceLbl.text stringByAppendingFormat:@"%@", _bank.province];
    _cityLbl.text = [_cityLbl.text stringByAppendingFormat:@"%@", _bank.city];
    _branchLbl.text = [_branchLbl.text stringByAppendingFormat:@"%@", _bank.branch];
    _nameLbl.text =  [_nameLbl.text stringByAppendingFormat:@"%@", _bank.account_name];
    _bankAccountLbl.text = [_bankAccountLbl.text stringByAppendingFormat:@"%@",_bank.account];
    
    [_button setTitleColor:kBlackButtonTitleColor forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitAction:(id)sender{
//    //先验证
//    [LoadingAlertView showLoading];
//    RQCardConfirm *cardConfirm = [[[RQCardConfirm alloc] init] autorelease];
//    cardConfirm.bankId = _bank.bank_id;
//    cardConfirm.bankAccount =  _bank.account;
//    cardConfirm.bankAccountName = _bank.account_name;
//    [cardConfirm startPostWithDelegate:self];
//    self.rq = cardConfirm;
    //直接提交
    RQCardCommit *commit = [[[RQCardCommit alloc] init] autorelease];
    commit.bankId = _bank.bank_id;
    commit.bankName = _bank.bank_name;
    commit.provinceId = _bank.provinceId;
    commit.provinceName = _bank.province;
    commit.cityId = _bank.cityId;
    commit.cityName = _bank.city;
    commit.branch = _bank.branch;
    commit.account = _bank.account;
    commit.accountName = _bank.account_name;
    commit.secPass = [SharedModel shared].securityPasswd;
    [HUDView showLoading:self.view];
    [commit startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        [HUDView dismissCurrent];
        if (rq_.msgContent){
            HUDShowMessage(rq_.msgContent,nil);
        } else {
            //提交成功
            CardBindSucessViewController *vc = [[CardBindSucessViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
    } sender:nil];

}

#pragma mark - Request

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    if ([rq isKindOfClass:[RQCardConfirm class]]){
        [HUDView dismissCurrent];
        RQCardConfirm *cardConfirm = (id)rq;
        if (cardConfirm.msgContent){
            HUDShowMessage(cardConfirm.msgContent, nil);
        } else {
        }{
            //验证通过再提交
            RQCardCommit *commit = [[[RQCardCommit alloc] init] autorelease];
            commit.bankId = _bank.bank_id;
            commit.bankName = _bank.bank_name;
            commit.provinceId = _bank.provinceId;
            commit.provinceName = _bank.province;
            commit.cityId = _bank.cityId;
            commit.cityName = _bank.city;
            commit.branch = _bank.branch;
            commit.account = _bank.account;
            commit.accountName = _bank.account_name;
            commit.secPass = [SharedModel shared].securityPasswd;
            [HUDView showLoading:self.view];
            [commit startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
                [HUDView dismissCurrent];
                if (rq_.msgContent){
                    HUDShowMessage(rq_.msgContent, nil);
                } else {
                    //提交成功
                    CardBindSucessViewController *vc = [[CardBindSucessViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                }
            } sender:nil];
        }
    }
}

@end
