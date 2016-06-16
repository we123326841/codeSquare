//
//  UserListViewController.m
//  Caipiao
//
//  Created by danal on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UserListViewController.h"
#import "ColorCell.h"
#import "CheckAgentListViewController.h"
#import "SearchUserViewController.h"
#import "DropDownOptionView.h"
#import "RQAgentMember.h"

#define kYellowBackground [UIColor rgbColorWithHex:@"#c09703"]

@interface UserListViewController ()<RQBaseDelegate, ColorCellStateDelegate>
{
    int _agentCount;
    int _memberCount;
    BOOL _high;                     //缺省为高频
    CGRect _textFieldRect;      //原始frame
    UIButton *_cancelButton;
    UILabel *_tipsLbl;            //提示label
}
@property (strong, nonatomic) SearchUserViewController *searchController;
@end

@implementation UserListViewController

- (void)dealloc{
    Echo(@"%s",__func__);
    [_searchTableView release];
    [_searchController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameLbl.textColor =
    self.balance1Lbl.textColor =
    self.balance2Lbl.textColor = kYellowTextColor;
    self.nameLbl.text = [SharedModel shared].userAccout;
    self.balance1Lbl.text = @"银行团队余额：";
    self.balance2Lbl.text = @"高频团队余额：";
    
    self.northBackground.backgroundColor = kBlackTranslucentColor;
    self.northBackground.layer.cornerRadius = 4.f;
    
    self.textField.delegate = self;
    self.textField.placeholder  = @"搜索用户";
    self.textField.textColor = kYellowTextColor;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.clipsToBounds = NO;
    [self.textField addTarget:self action:@selector(onTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *magnifier = [UIButton buttonWithType:UIButtonTypeCustom];
    magnifier.frame = CGRectMake(0, 0, 38, 14);
    magnifier.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [magnifier setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [magnifier addTarget:self action:@selector(searchUser:) forControlEvents:UIControlEventTouchUpInside];
    self.textField.rightView = magnifier;
    self.textField.rightViewMode = UITextFieldViewModeAlways;

//    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
//    self.textField.leftView = leftView;
//    self.textField.leftViewMode = UITextFieldViewModeAlways;
//    [leftView release];
    DropDownOptionView *optionView = [[DropDownOptionView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    optionView.options = [NSArray arrayWithObjects:@"高频",@"低频", nil];
    optionView.textLbl.textColor = [UIColor whiteColor];
    [optionView setCallback:@selector(selectOption:) target:self];
    self.textField.leftView = optionView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    [optionView release];
    
    
    self.tableView.layer.cornerRadius = 4.f;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.clipsToBounds = YES;
    
    //底部提示
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x,
                                                               self.tableView.frame.origin.y + self.tableView.frame.size.height + 5.f,
                                                               self.tableView.bounds.size.width, 20)];
    _tipsLbl = label;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:10.f];
    label.textColor = kGrayTipsTextColor;
    label.text = @" 注：只显示直属下级代理和玩家";
    [self.view addSubview:label];
    [label release];
    
    _high = YES;
    
    [self requestBankBalance];
    [self startRequest:_high];
    
    //For searching
    _textFieldRect = self.textField.frame;
    self.searchController = [[[SearchUserViewController alloc] initWithNibName:@"SearchUserViewController" bundle:nil] autorelease];
    self.searchController.nav = self.navigationController;
    [self.view addSubview:self.searchController.view];
    self.searchController.view.hidden = YES;
    self.searchTableView = self.searchController.tableView;
    [self.searchTableView removeFromSuperview];
    [self.view addSubview:self.searchTableView];
    self.searchTableView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestBankBalance{
    RQBankBalance *rq = [[[RQBankBalance alloc] init] autorelease];
    rq.uid = self.uid > 0 ? self.uid : [[SharedModel shared].userid intValue];
    [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQBankBalance *bank = (RQBankBalance *)rq_;
        self.balance1Lbl.text = [NSString stringWithFormat:@"银行团队余额：%@元", [SharedModel formatBalance:bank.balance]];
        self.nameLbl.text = bank.username;
        [SharedModel shared].teamBalanceBank = bank.balance;
    } sender:nil];
}

- (void)startRequest:(BOOL)high{
    RQAgentMemberCount *rq = [[[RQAgentMemberCount alloc] init] autorelease];
    rq.high = high;
    rq.uid = self.uid > 0 ? self.uid : [[SharedModel shared].userid intValue];
    [rq startPostWithDelegate:self];
    self.rq = rq;
    
    RQTeamBalance *rqTeam = [[[RQTeamBalance alloc] init] autorelease];
    rqTeam.high = high;
    rqTeam.uid = self.uid > 0 ? self.uid : [[SharedModel shared].userid intValue];
    [rqTeam startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQTeamBalance *q = (RQTeamBalance *)rq_;
        self.nameLbl.text = q.username;
        if (high){
            self.balance2Lbl.text = [NSString stringWithFormat:@"高频团队余额：%@元",  [SharedModel formatBalance:q.balance]];
            [SharedModel shared].teamBalanceHigh = q.balance;
        } else {
             self.balance2Lbl.text = [NSString stringWithFormat:@"低频团队余额：%@元", [SharedModel formatBalance:q.balance]];
            [SharedModel shared].teamBalanceLow = q.balance;
        }
    } sender:nil];
}

#pragma mark - Actions

- (void)selectOption:(DropDownOptionView *)sender{
    _high = sender.selectedIndex == 0;
    [self startRequest:_high];
}

- (void)onTextChange:(UITextField *)sender{
    self.searchController.keyword = sender.text;
    self.searchController.textField.text = sender.text;
}

- (void)searchUser:(id)sender{
    [self.textField resignFirstResponder];
    NSString *keyword = self.textField.text;
    if ([keyword length] > 0){
        SearchUserViewController *vc =  self.searchController;
        vc.high = _high;
        vc.keyword = keyword;
        [vc launchRefreshing];
    }
    
}

- (void)beginSearch{
    //Hide others
    UIButton *cancelButton = [UIButton barButtonWithTitle:@"取消"];
    
    CGRect rect = _textFieldRect;
    rect.origin.y = 20.f;
    rect.size.width -= 60.f;
    rect.size.height = cancelButton.bounds.size.height;
    
    CGRect buttonRect = CGRectMake(self.view.bounds.size.width - 10.f - cancelButton.bounds.size.width, rect.origin.y, cancelButton.bounds.size.width, cancelButton.bounds.size.height);
    cancelButton.frame = buttonRect;
    [cancelButton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    cancelButton.alpha = 0.f;
    [_cancelButton removeFromSuperview];
    _cancelButton = cancelButton;
    
    [UIView animateWithDuration:.28f delay:.1f options:UIViewAnimationOptionCurveEaseOut animations:^{
        _textField.frame = rect;
        cancelButton.alpha = 1.f;
        self.tableView.hidden =
        self.nameLbl.hidden =
        self.balance1Lbl.hidden =
        self.balance2Lbl.hidden =
        self.northBackground.hidden =
         _tipsLbl.hidden = YES;
    } completion:^(BOOL finished) {
        float y =  rect.origin.y + rect.size.height + 10.f;
        self.searchTableView.frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y);
        self.searchTableView.hidden = NO;
    }];

}

- (void)cancelSearch{
    [self.view endEditing:YES];
    [UIView animateWithDuration:.28f delay:.1f options:UIViewAnimationOptionCurveEaseOut animations:^{
        _textField.frame = _textFieldRect;
        _cancelButton.alpha = 0.f;
        self.searchTableView.hidden = YES;
    } completion:^(BOOL finished) {
        [_cancelButton removeFromSuperview];
        _cancelButton = nil;
        self.tableView.hidden =
        self.nameLbl.hidden =
        self.balance1Lbl.hidden =
        self.balance2Lbl.hidden =
        self.northBackground.hidden =
        _tipsLbl.hidden = NO;
    }];
}

#pragma mark - Table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CELL";
    ColorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [ColorCell blackColorCell:identifier];
        cell.stateDelegate = self;
        cell.edgeInsets = UIEdgeInsetsMake(0.5, 0, 0.5, 0);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_sj_white.png"]] autorelease];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:13.f];
        cell.textLabel.textColor = kYellowTextColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *txtLbl = cell.textLabel;
    switch (indexPath.row) {
        case 0:
            txtLbl.text =  [NSString stringWithFormat:@"一级代理 (%d人)", _agentCount];
            break;
        case 1:
            txtLbl.text = [NSString stringWithFormat:@"下级玩家 (%d人)", _memberCount];
            break;
        case 2:
            txtLbl.text = @"最近搜索";
            break;
//        case 3:
//            cell.textLabel.text = @"余额排行";
//            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            CheckAgentListViewController *vc = [[CheckAgentListViewController  alloc] init];
            vc.userType = 1;
            vc.titleText = @"一级代理";
            vc.uid = self.uid;
            vc.high = _high;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
            break;
        case 1:
        {
            CheckAgentListViewController *vc = [[CheckAgentListViewController  alloc] init];
            vc.userType = 0;
            vc.titleText = @"下级玩家";
            vc.uid = self.uid;
            vc.high = _high;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
            break;
        case 2:
        {
//            CheckAgentListViewController *vc = [[CheckAgentListViewController  alloc] init];
            SearchUserViewController *vc = [[SearchUserViewController alloc] init];
            vc.title = @"最近搜索";
            [self.navigationController pushViewController:vc animated:YES];
            [vc showHistory];
            [vc release];
        }
            break;
//        case 3:
//        {
//            CheckAgentListViewController *vc = [[CheckAgentListViewController  alloc] init];
//            vc.titleText = @"余额排行";
//            [self.navigationController pushViewController:vc animated:YES];
//            [vc release];
//        }
//            break;
        default:
            break;
    }
}

#pragma mark - ColorCellDelegate

- (void)onCellSelected:(BOOL)selected animated:(BOOL)animated cell:(ColorCell *)cell{
}

- (void)onCellHighlighted:(BOOL)highlighted animated:(BOOL)animated cell:(ColorCell *)cell{
    UILabel *txtLbl = cell.textLabel;
    if (highlighted){
        cell.tintAlpha = 1.f;
        cell.tintColor = kYellowBackground;
        txtLbl.textColor = [UIColor blackColor];
    } else {
        cell.tintAlpha = .3f;
        cell.tintColor = [UIColor blackColor];
        txtLbl.textColor = kYellowTextColor;
    }
    [cell setNeedsDisplay];
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self searchUser:textField.text];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self beginSearch];
}

#pragma mark - RQDelegate
- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    if (rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
        
    } else {
        if ([rq isKindOfClass:[RQAgentMemberCount class]]){
            RQAgentMemberCount *request = (RQAgentMemberCount *)rq;
            _agentCount = request.agentCount;
            _memberCount = request.memberCount;
            [self.tableView reloadData];
        }
    }
}

- (void)onRQStart:(RQBase *)rq{
    
}

@end
