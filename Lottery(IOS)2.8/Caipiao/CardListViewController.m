//
//  CardListViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-11-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CardListViewController.h"
#import "CardDeleteViewController.h"
#import "CardPwdInputViewController.h"
#import "AddCardViewController.h"
#import "SecurityPwdInputViewController.h"
#import "RCLabel.h"
#import "CardCellView.h"
#import "RQCardBinding.h"
#import "Musou.h"
#import "SecuritySettingResultVC.h"
#import "SecurityIssuesVC.h"

@interface CardListViewController () <RQBaseDelegate>
@property (strong, nonatomic) NSArray *cardList;
@property (assign, nonatomic) RCLabel *richLbl;
@property (assign, nonatomic) NSInteger bindedCardNumber;
@property (retain, nonatomic) RQCardBindingInit *rqInit;
@end

@implementation CardListViewController

- (void)dealloc{
    [_cardList release];
    [_rqInit release];
    MSNotificationCenterRemoveObserver();
    [_descriptionLbl release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"卡号绑定";
    self.view.backgroundColor = RGBAHex(@"EEEEEE");
    
    _tableView.frame = self.view.bounds;
    _tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = _footerView;
    
    NSString *text = @"您还可以绑定<font color=black>0</font>张银行卡";
    RCLabel *tipLbl = [[RCLabel alloc] initWithFrame:_tipsLbl.frame];
    tipLbl.font = [UIFont systemFontOfSize:13.f];
    tipLbl.textColor = [UIColor grayColor];
    RTLabelComponentsStructure *component = [RCLabel extractTextStyle:text];
    [tipLbl setComponentsAndPlainText:component];
    [_tipsLbl.superview addSubview:tipLbl];
    [tipLbl release];
    self.richLbl = tipLbl;
    [_tipsLbl removeFromSuperview];

    UIButton *edit = [UIButton barButtonWithTitle:@"编辑"];
    edit.frame = CGRectMake(0, 0, 40, 32);
    [edit addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:edit];
    
    MSNotificationCenterAddObserver(@selector(bindAction:),@"kCardBindSetSecuritySuccessNoti");

}
-(void)bankCardIsLocked:(BOOL)islocked
{
    self.navigationItem.rightBarButtonItem.customView.hidden = islocked;
    self.navigationItem.rightBarButtonItem.enabled = !islocked;
        _bindButton.enabled=!islocked;
    [_bindButton setBackgroundImage:ResImage(@"btn_600_80_down.png") forState:UIControlStateDisabled];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self showLoadingView];
    
    __block CardListViewController *this_ = self;
    RQCardBindingInit *bindingInit = [[[RQCardBindingInit alloc] init] autorelease];
    [bindingInit startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        if (rq_.msgContent){
            HUDShowMessage(rq_.msgContent, nil);
            double delayInSeconds = .5f;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [this_.navigationController popViewControllerAnimated:YES];
                this_ = nil;
            });
            return;
        }
        RQCardBindingInit *q = (id)rq_;
        [self bankCardIsLocked:q.isLocked];
        NSString *text =  [NSString stringWithFormat:@"您还可以绑定<font color=black>%ld</font>张银行卡", (long)q.restNumber];
        self.bindedCardNumber = q.availableNumber;
        [self.richLbl setComponentsAndPlainText:[RCLabel extractTextStyle:text]];
        [self hideLoadingView];
        
        _descriptionLbl.text = q.isLocked ?
                        @"您的银行卡已经锁定，不能进行银行卡信息增加或删除。 如若您需要增加绑定或者删除银行卡，请联系在线客服"
                     :  @"首次绑定后的1个小时内您可继续绑定与删除银行卡的权限，超过1个小时后将锁定银行卡绑定与删除功能,如需解锁或者删除银行卡，请联系在线客服";
        
        this_.rqInit=q;
        RQCardList *cardList = [[[RQCardList alloc] init] autorelease];
        [cardList startPostWithBlock:^(RQBase *rq1_, NSError *error1_, id rqSender1_) {
            RQCardList *q1 = (id)rq1_;
            [q1.cardList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                BankModel *m = (BankModel*)obj;
                [q.bankList enumerateObjectsUsingBlock:^(id obj1, NSUInteger idx1, BOOL *stop1) {
                    BankModel *m1 = (BankModel*)obj1;
                    if (m.bank_id == m1.bank_id) {
                        m.bank_name = m1.bank_name;
                    }
                }];
            }];
            self.cardList = q1.cardList;
            [self hideLoadingView];
            [_tableView reloadData];
            
//                    [self showCardList:q.cardList];
        } sender:nil];
    } sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)deleteCardAction:(UIButton *)sender{
    @try {
        BankModel *card = [self.cardList objectAtIndex:sender.tag];
        SecurityPwdInputViewController *vc = [[SecurityPwdInputViewController alloc] init];
        vc.completeBlock = ^(SecurityPwdInputViewController *c, bool success){
            RQCardDelete *cardDelete = [[[RQCardDelete alloc] init] autorelease];
            cardDelete.bankId = card.bindId;
            cardDelete.Id  = card.bank_id;
            [cardDelete startPostWithBlock:^(RQCardDelete* rq_, NSError *error_, id rqSender_) {
                if (rq_.statusOK){
                    [HUDView showMessageToView:KEY_WINDOW msg:@"绑卡删除成功" subtitle:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                } else if (cardDelete.msgContent){
                    HUDShowMessage(cardDelete.msgContent, nil);
                    [HUDView showMessageToView:KEY_WINDOW msg:cardDelete.msgContent subtitle:nil];
                }
            } sender:nil];
            c.completeBlock = nil;
        };
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    @catch (NSException *exception) {
    }
}

- (IBAction)bindAction:(id)sender{
    [self checkNeedSetSafeQuest];
}
-(void)bindBankCard
{
    if (self.bindedCardNumber < 0){
        CardPwdInputViewController *vc = [[CardPwdInputViewController alloc] init];
        vc.bankCard = [self.cardList objectAtIndex:0];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    } else {
        AddCardViewController *vc = [[AddCardViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
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
                MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil message:@"放弃设置安全问题意味着放弃绑定银行卡，您确定放弃？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
                    if (index == 1){
                        [ [AppDelegate shared].nav popToRootViewControllerAnimated:YES];
                    }
                }];
                [alert show];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        return;
    }else{
        [self bindBankCard];
    }
}

- (IBAction)editAction:(UIButton *)sender{
    _editing = !_editing;
    [_tableView reloadData];
    [sender setTitle:_editing ? @"完成" : @"编辑" forState:UIControlStateNormal];
}

#pragma mark - TableViewDelegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.cardList.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        static NSString *cellId = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CardCellView *view = (id)[CardCellView loadFromNib];
            [view.deleteButton addTarget:self action:@selector(deleteCardAction:) forControlEvents:UIControlEventTouchUpInside];
            view.tag = 100;
            [cell.contentView addSubview:view];
        }
        BankModel *bank = self.cardList[indexPath.row];
        CardCellView *view = (id)[cell.contentView viewWithTag:100];
        view.bankLbl.text = bank.bank_name;
        view.detailLbl.text = [NSString stringWithFormat:@"%@ %@",[CardCellView secrectCard:bank.account],([bank.account_name isKindOfClass:[NSNull class]]||!bank.account_name)?@"":bank.account_name];
        NSArray *banks = [self.rqInit bankList];
        for (BankModel *b in banks) {
            if (b.bank_id == bank.bank_id) {
                bank.bank_name = b.bank_name;
                break;
            }
        }
        view.iconView.image = ResImage(bank.bank_name);
        view.deleteButton.hidden = !_editing;
        view.deleteButton.tag = indexPath.row;
        view.linePos = indexPath.row == self.cardList.count-1 ? LineAtTopAndBottom : LineAtTop;
        return cell;
    }
    else {
        static NSString *cellId = @"cellBind";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = self.view.backgroundColor;
//            _bindButton.center = CGPointMake(160.f, 28.f);
//            [cell.contentView addSubview:_bindButton];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 56.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

//Remove bottom lines
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)] autorelease];
    return view;
}


- (void)viewDidUnload {
    [_descriptionLbl release];
    _descriptionLbl = nil;
    [super viewDidUnload];
}
@end
