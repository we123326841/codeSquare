//
//  AgentDetailViewController.m
//  Caipiao
//
//  Created by danal on 13-10-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "AgentDetailViewController.h"
#import "ChargeViewController.h"
#import "UserTransationViewController.h"
#import "RQAgentMember.h"

@interface AgentDetailViewController ()

@end

@implementation AgentDetailViewController

- (void)dealloc{
    [_member release];
    [super dealloc];
}

- (void)viewDidLoad
{
    self.title = @"查看下级";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameLbl.text = self.member.name;
    if (!_high){
        self.balance2Lbl.text = @"低频团队余额：";
    }
    [self requestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)requestData{
    //团队余额
    RQUserBankBalance *rq = [[[RQUserBankBalance alloc] init] autorelease];
    rq.uid = self.member.uid;
    [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQBankBalance *bank = (RQBankBalance *)rq_;
        self.balance1Lbl.text = [NSString stringWithFormat:@"银行团队余额：%@元", [SharedModel formatBalance:bank.balance]];
        self.nameLbl.text = bank.username;
        self.member.bankBalance = bank.balance;
    } sender:nil];
    
    RQUserTeamBalance *rqTeam = [[[RQUserTeamBalance alloc] init] autorelease];
    rqTeam.high = _high;
    rqTeam.uid = self.member.uid;
    [rqTeam startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQTeamBalance *q = (RQTeamBalance *)rq_;
        self.nameLbl.text = q.username;
        if (_high){
            self.balance2Lbl.text = [NSString stringWithFormat:@"高频团队余额：%@元",  [SharedModel formatBalance:q.balance]];
        } else {
            self.balance2Lbl.text = [NSString stringWithFormat:@"低频团队余额：%@元", [SharedModel formatBalance:q.balance]];
        }
    } sender:nil];

    //下级
    RQAgentMemberCount *rqMember = [[[RQAgentMemberCount alloc] init] autorelease];
    rqMember.high = _high;
    rqMember.uid = self.member.uid;
    [rqMember startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQAgentMemberCount *q = (RQAgentMemberCount *)rq_;
        self.agentCountLlb.text = [NSString stringWithFormat:@"该用户二级代理：%d", q.agentCount];
        self.playerCountLlb.text  = [NSString stringWithFormat:@"该用户下级玩家：%d", q.memberCount];
    } sender:nil];
}

- (IBAction)transactionButtonAction:(id)sender{
    UserTransationViewController *vc = [[UserTransationViewController alloc] init];
    vc.uid = self.member.uid;
    vc.username = self.member.name;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)chargeButtonAction:(id)sender{
    ChargeViewController *vc = [[ChargeViewController alloc] init];
    vc.member = self.member;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)editButtonAction:(id)sender{
    
}
@end
