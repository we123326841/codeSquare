//
//  SettingViewController.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "SettingViewController.h"
#import "Switch.h"
#import "BaseCell.h"
#import "ColorCell.h"
#import "BetManager.h"
#import "TableDataObject.h"
#import "SecurityPwdInputViewController.h"
#import "SecurityIssuesVC.h"
#import "OldFundViewController.h"
#import "PwdCreateSecPwdVC.h"
#import "CardListViewController.h"
#import "PwdChangeResultVC.h"
#import "RQOpenLinkList.h"
@interface SettingViewController ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (copy, nonatomic) NSString *upgradeUrl;
@property (nonatomic) BOOL pushOn;
@end

@implementation SettingViewController

- (void)dealloc{
    self.dataSource = nil;
    self.upgradeUrl = nil;
    MSNotificationCenterRemoveObserver();
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.pushOn = ![[NSUserDefaults standardUserDefaults] boolForKey:@"pushOff"];
    self.tableSetting.tableFooterView = _footerView;
    [_logoutButton setTitleColor:Color(@"LoginButtonTextColor") forState:UIControlStateNormal];
    [_logoutButton setTitle:[NSString stringWithFormat:@"登出(%@)",[SharedModel shared].nickname]
                   forState:UIControlStateNormal];
    
    self.dataSource = [NSMutableArray array];
    {
        TableDataObject *sec = [TableDataObject objectWithIcon:nil subject:@"账户安全" controller:@""];
        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"修改登录密码" controller:@"PwdViewController"]];
        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"修改安全密码" controller:@"SecPwdViewController"]];
        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"安全问题" controller:@"SecurityIssuesVC"]];

        [self.dataSource addObject:sec];
    }
    {
        TableDataObject *sec = [TableDataObject objectWithIcon:nil subject:@"账户安全" controller:@""];
        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"银行卡管理" controller:@"SecurityPwdInputViewController"]];
        [self.dataSource addObject:sec];
    }
    
    {
        TableDataObject *sec =[TableDataObject objectWithIcon:nil subject:@"奖金详情" controller:@""];
        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"奖金详情" controller:@"OAPrizeDetailVC"]];
        [self.dataSource addObject:sec];
        
        
        
        

    }
    
    
    {
        TableDataObject *sec = [TableDataObject objectWithIcon:nil subject:@"账户安全" controller:@""];
        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"元角模式" controller:nil]];
        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"通知设置" controller:nil]];
        [self.dataSource addObject:sec];
    }
    {
        TableDataObject *sec = [TableDataObject objectWithIcon:nil subject:@"版本信息" controller:@""];
        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"版本更新" controller:nil]];
        [self.dataSource addObject:sec];
    }
//    资金转移 隐藏 2015-05-18
//    if([[[CDUserInfo user]source]floatValue]==3.0) {
//        TableDataObject *sec = [TableDataObject objectWithIcon:nil subject:@"" controller:@""];
//        [sec addChild:[TableDataObject objectWithIcon:nil subject:@"查看旧版网站资金" controller:@"SecurityPwdInputViewController"]];
//        [self.dataSource addObject:sec];
//    }
//    [self retrieveVersion];
    [self retrieveSwitchStatus];
    MSNotificationCenterAddObserver(@selector(bindAction:),@"kCardBindSetSecuritySuccessNoti");

}


-(void)requestData
{
    RQOpenLinkList *rq = [[RQOpenLinkList alloc]init];
    self.rq = rq;
  //  __block OpenAccountVC *blockself = self;
    [rq startPostWithBlock:^(RQOpenLinkList* rq_, NSError *error_, id rqSender_) {
//        [blockself.tableview reloadData];
//        if (rq_.isEmpty==YES) {
//            _noOAMsgV.hidden = NO;
//        }else
//        {
//            _noOAMsgV.hidden = YES;
//        }
        
    } sender:nil];
    [rq release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - TableViewDelegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TableDataObject *secObj = [self.dataSource objectAtIndex:section];
    return [[secObj children] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCustomCellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
    if (!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID] autorelease];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = [UIFont systemFontOfSize:16.f];
        cell.textLabel.textColor = Color(@"SettingTextColor");

        Switch *sw = [[Switch alloc] initWithFrame:CGRectMake(250, 8, 80, 28) style:kSwitchStyleBall];
        sw.tag = 100;
        [sw addTarget:self action:@selector(onSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:sw];
        [sw release];
    }
    
    TableDataObject *secObj = [self.dataSource objectAtIndex:indexPath.section];
    TableDataObject *rowObj = [secObj childAtIndex:indexPath.row];
    cell.textLabel.text = rowObj.subjectText;

    Switch *sw = (Switch *)[cell.contentView viewWithTag:100];
    sw.hidden = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([rowObj.subjectText isEqualToString:@"通知设置"]){
        sw.hidden = NO;
        sw.layer.name = rowObj.subjectText;
        cell.accessoryType = UITableViewCellAccessoryNone;
        sw.on = _pushOn;
        _pushSwitch = sw;
        
    } else if ([rowObj.subjectText isEqualToString:@"元角模式"]){
        
        ModeSwitch *msw = [[ModeSwitch alloc] initWithFrame:sw.frame style:kSwitchStyleBall];
        [cell.contentView addSubview:msw];
        msw.layer.name = rowObj.subjectText;
        msw.on = [BetManager mode] == kModeYuan;
        [msw addTarget:self action:@selector(onSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
    }
    
    if ([rowObj.subjectText isEqualToString:@"版本更新"] && self.upgradeUrl){
        UIImageView *label = [[UIImageView alloc] initWithFrame:CGRectMake(250, 12, 61, 20)];
        label.image = ResImage(@"新版本.png");
        [cell.contentView addSubview:label];
        [label release];
    }
//    资金转移 隐藏 2015-05-18
//    if ([rowObj.subjectText isEqualToString:@"查看旧版网站资金"])
//    {
//        NSString *str = [NSString stringWithFormat:@"MyAccountSettingDot%@",[CDUserInfo user].userid];
//        id needdot = [[NSUserDefaults standardUserDefaults]objectForKey:str];
//        if (!needdot)
//        {
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(216, 12,90, 20)];
//            label.textColor = [UIColor whiteColor];
//            label.text=@"  老用户关注";
//            label.tag=0x8899;
//            label.backgroundColor=RGBAi(255, 204, 106, 255);
//            label.font=[UIFont systemFontOfSize:14];
//            [cell.contentView addSubview:label];
//            [label release];
//        }else  [[cell.contentView viewWithTag:0x8899] removeFromSuperview];
//
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        
//        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(295, 17, 8, 12)];
//        arrow.image = needdot?ResImage(@"arrow-right@2x.png"):ResImage(@"arrow-white@2x.png");
//        arrow.tag = 0x9988;
//        [cell.contentView addSubview:arrow];
//        [arrow release];
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    TableDataObject *secObj = [self.dataSource objectAtIndex:indexPath.section];
    TableDataObject *rowObj = [secObj childAtIndex:indexPath.row];
    if ([rowObj.subjectText isEqualToString:@"版本更新"]){
        [self retrieveVersion];
    }
    else if (rowObj.controllerClass){
//        资金转移 隐藏 2015-05-18
//        if ([rowObj.subjectText isEqualToString:@"查看旧版网站资金"]){
//
//            SecurityPwdInputViewController *vc = [[SecurityPwdInputViewController alloc] init];
//            vc.isOldB=YES;
//            [vc setViewDidLoadBlock:^(SecurityPwdInputViewController *c) {
//                c.title = @"查看资金";
//                c.pwdField.placeholder = @"输入旧版安全密码";
//            }];
//            [vc setCompleteBlock:^(SecurityPwdInputViewController *c, bool success) {
//                OldFundViewController *fund = [[OldFundViewController alloc] init];
//                fund.fundpwd=c.pwdField.text;
//                [c.navigationController pushViewController:fund animated:YES];
//                [fund release];
//            }];
//            [self.navigationController pushViewController:vc animated:YES];
//            [vc release];
//            
//             NSString *str = [NSString stringWithFormat:@"MyAccountSettingDot%@",[CDUserInfo user].userid];
//            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:str];
//            MSNotificationCenterPost(@"kMyAccountRemoveSettingDot");
//            [self.tableSetting reloadData];
//        } else
            if([rowObj.subjectText isEqualToString:@"银行卡管理"])
        {
            [self checkNeedSetSecurityPass];
            
            //Flurry Event
            FLEvent(kFLEventManageCard);
        }else {
            UIViewController *vc = [[NSClassFromString(rowObj.controllerClass) alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
    view.backgroundColor = self.view.backgroundColor;
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == [_dataSource count]-1 ? 20.f : 1.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
    view.backgroundColor = self.view.backgroundColor;
    if ([_dataSource count]-1 == section&& [[[CDUserInfo user]source]floatValue]==3.0){
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 300, 20)];
        lbl.font = [UIFont systemFontOfSize:12.f];
        lbl.textColor = [UIColor grayColor];
        lbl.text = @"旧版网站可以在这里查看资金情况";
        [view addSubview:lbl];
        [lbl release];
    }
    
    return view;
}


#pragma mark - Actions

- (void)retrieveVersion{
    HUDShowLoading(kStringLoading, nil);
    __block SettingViewController *self_ = self;
    RQVersion *rq = [[RQVersion alloc] init];
    rq.appType = kAPPVersionType;
    [rq startPostWithBlock:^(RQVersion *rq_, NSError *error_, id rqSender_) {
        HUDHide();
        NSString *currentVersion = [NSBundle appVersion];
        if ([rq.version compare:currentVersion] == NSOrderedDescending) {
            self_.upgradeUrl = rq_.downloadUrl;
            NSString *cancelTitle = rq_.mustUpgrade ? nil : @"取消";
             NSString *msg = [NSString stringWithFormat:@"发现新版本！\n便于您更好体验服务，请进行更新"];
            MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:@"新版更新"
                                                                      message:msg
                                                                     delegate:nil
                                                            cancelButtonTitle:cancelTitle
                                                            otherButtonTitles:@"更新", nil];
            [alert show];
            [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
                if ([[a buttonTitleAtIndex:index] isEqualToString:@"更新"]){
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rq_.downloadUrl]];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ShowIntro"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [SharedModel signOut];
                    abort();
                }
            }];
            
        } else {
            NSString *currentVersion = [NSBundle appVersion];
            HUDShowMessage(([NSString stringWithFormat:@"当前已是最新版本(v%@)",currentVersion]), nil);
        }
        
        [rq_ release];
    } sender:nil];
}

- (void)retrieveSwitchStatus{
    RQPushSwitchInfo *si = [[RQPushSwitchInfo alloc] init];
    self.rq = si;
    si.userId = [SharedModel shared].userid;
    [si startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQPushSwitchInfo *q = (RQPushSwitchInfo *)rq_;
        [[NSUserDefaults standardUserDefaults] setBool:!q.isOpen forKey:@"pushOff"];
        self.pushOn = q.isOpen;
        [self.tableSetting reloadData];
        [rq_ release];
    } sender:nil];
}

- (IBAction)onSwitchValueChange:(Switch *)sender{
    if ([sender.layer.name isEqualToString:@"通知设置"]){
        
        RQPushSwitchSet *set = [[RQPushSwitchSet alloc] init];
        self.rq = set;
        set.userId = [SharedModel shared].userid;
        set.isOpen = sender.on;
        [set startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            [[NSUserDefaults standardUserDefaults] setBool:!sender.on forKey:@"pushOff"];
            [rq_ release];
        } sender:nil];
        
    } else {
        [BetManager setMode:!sender.on ? kModeJiao : kModeYuan];
        
        //Flurry Event
        FLEvent(kFLEventMoneyMode);
    }
}

- (IBAction)logout:(id)sender{
    MSNotificationCenterPost(kSettingViewControllerLoginOutNotification);
    [SharedModel signOut];
    [[AppDelegate shared] backToLogin];
}


#ifdef DEBUG
#import "RQLogin.h"
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [SharedModel signOut];
    [[AppDelegate shared] backToLogin];
}

#endif

@end
