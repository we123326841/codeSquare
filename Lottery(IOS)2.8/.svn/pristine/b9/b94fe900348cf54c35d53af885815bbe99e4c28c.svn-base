//
//  WithdrawCashConfirmVC.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "WithdrawCashConfirmVC.h"
#import "View+Factory.h"
#import "WithdrawCashResultVC.h"
#import "AuthenticationAlertView.h"
#import "MSUIView+Additions.h"
#import "SecuritySettingResultVC.h"
#import "SecurityIssuesVC.h"
#import "MSBlockAlertView.h"
#import "NotSetSecurityPwdVC.h"
#import "PwdCreateSecPwdVC.h"

@interface WithdrawCashConfirmVC ()
{
    IBOutletCollection(UILabel) NSArray *_tagLbls;
    IBOutlet UILabel *amountTagLbl;
}

@property (assign, nonatomic) IBOutlet UILabel *bankNameLbl;
@property (assign, nonatomic) IBOutlet UILabel *bankProvinceLbl;
@property (assign, nonatomic) IBOutlet UILabel *bankCityLbl;
@property (assign, nonatomic) IBOutlet UILabel *bankUserNameLbl;
@property (assign, nonatomic) IBOutlet UILabel *bankAccountLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;

- (IBAction)confirm:(id)sender;

@end

@implementation WithdrawCashConfirmVC

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
    
    _bankNameLbl.text = [_bankNameLbl.text stringByAppendingFormat:@"  %@",([_rqCheck.bankModel.bank_name isKindOfClass:[NSNull class]]||!_rqCheck.bankModel.bank_name)?@"":_rqCheck.bankModel.bank_name
];
    _bankProvinceLbl.text = [_bankProvinceLbl.text stringByAppendingFormat:@"  %@",([_rqCheck.bankModel.province isKindOfClass:[NSNull class]]||!_rqCheck.bankModel.province)?@"":_rqCheck.bankModel.province];
    
    _bankCityLbl.text = [_bankCityLbl.text stringByAppendingFormat:@"  %@",([_rqCheck.bankModel.city isKindOfClass:[NSNull class]]||!_rqCheck.bankModel.city)?@"":_rqCheck.bankModel.city];
    
    _bankUserNameLbl.text = [_bankUserNameLbl.text stringByAppendingFormat:@"  %@",([_rqCheck.bankModel.account_name isKindOfClass:[NSNull class]]||!_rqCheck.bankModel.account_name)?@"":_rqCheck.bankModel.account_name];
    
    _bankAccountLbl.text = [_bankAccountLbl.text stringByAppendingFormat:@"  %@",([_rqCheck.bankModel.account isKindOfClass:[NSNull class]]||!_rqCheck.bankModel.account)?@"":_rqCheck.bankModel.account];
    
    _amountLbl.text = [SharedModel formatBalance:_rqCheck.money_resp];
    
    {
        for (UILabel *l in _tagLbls) {
            l.textColor = Color(@"WithdrawHeadColor");
        }
        _bankAccountLbl.textColor=_bankCityLbl.textColor=_bankNameLbl.textColor=_bankProvinceLbl.textColor=_bankUserNameLbl.textColor=Color(@"WithdrawTagColor");
        _amountLbl.textColor = Color(@"WithdrawAmountColor");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirm:(id)sender
{
//    WithdrawAlertView *alert = (WithdrawAlertView *)[WithdrawAlertView loadFromNib];
//    alert.bank = _rqCheck.bankModel;
//    alert.amount = _amountLbl.text;
    
    __block WithdrawCashConfirmVC *blkVc = self;
    
    AuthenticationAlertView *alert = (AuthenticationAlertView *)[AuthenticationAlertView loadFromNib];
    QuestEntity *q = _rqCheck.questions[0];
    [alert.pwdField becomeFirstResponder];
    alert.issuseL.text = [NSString stringWithFormat:@"回答安全问题:%@",q.question];
    [alert setCompleteBlock:^(AuthenticationAlertView *av){
        //[HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
        
        RQWithdrawCashConfirm *rq = [[RQWithdrawCashConfirm alloc] init];
        rq.money = blkVc.rqCheck.money_resp;
//        rq.bank_id = blkVc.rqCheck.bankModel.bankno;
        rq.cardid = blkVc.rqCheck.bankModel.b_id;
        rq.secpwd = av.pwdField.text;
        rq.questionpwd = av.issueField.text;
        NSInteger  qid = -1;
        for (QuestEntity *q in _rqCheck.questions) {
            if ([av.issuseL.text rangeOfString:q.question].location != NSNotFound) {
                qid = q.qid;
            }
        }
        rq.questionId=qid;
        [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            
            [HUDView dismissCurrent];
            if (rq_.msgContent) {
                [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:rq_.msgContent subtitle:nil];
            }else {
                [av removeFromSuperview];

                WithdrawCashResultVC *vc = [[WithdrawCashResultVC alloc] initWithNibName:@"WithdrawCashResultVC" bundle:nil];
                vc.title = @"提现申请";
                vc.rqCheck = blkVc.rqCheck;
                
                NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                [controllers removeAllObjects];
                [controllers addObject:vc];
                [blkVc.navigationController setViewControllers:controllers animated:YES];
                [vc release];
            }
            
        } sender:nil];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    
    /*
    [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];

    RQWithdrawCashConfirm *rq = [[RQWithdrawCashConfirm alloc] init];
    rq.money = _rqCheck.money_resp;
    rq.bank_id = _rqCheck.bankModel.bank_id;
    rq.cardid = _rqCheck.bankModel.b_id;
    rq.secpwd = _pwdTextField.textfield.text;
    [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        
        [HUDView dismissCurrent];
        if (rq_.msgContent) {
            [self showAlertMessage:rq_.msgContent];
        }else {
            WithdrawCashResultVC *vc = [[WithdrawCashResultVC alloc] initWithNibName:@"WithdrawCashResultVC" bundle:nil];
            vc.title = @"提现申请";
            vc.rqCheck = _rqCheck;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        
    } sender:nil];
     */
}

@end

@implementation WithdrawAlertView

- (void)dealloc
{
    Block_release(_confirmBlock);
    [super dealloc];
}

- (void)awakeFromNib
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    
    //Animated show
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 1.f)],
                  nil];
    kfa.duration = .1f;
    kfa.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_mainView.layer addAnimation:kfa forKey:nil];
}

- (void)setAmount:(NSString *)amount
{
    [_amount release];
    _amount = [amount copy];
    _amountLbl.text = [NSString stringWithFormat:@"您将要提现%@元",_amount];;
}

- (IBAction)cancel:(id)sender
{
    [self removeFromSuperview];
}

- (IBAction)confirm:(id)sender
{
    if ([_pwdField.text length] > 0){
        [HUDView showLoading:self];
        self.confirmBlock(self);
    }
}

@end


