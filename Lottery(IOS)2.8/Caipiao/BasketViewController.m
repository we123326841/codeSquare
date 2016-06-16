//
//  BasketViewController.m
//  Caipiao
//
//  Created by danal-rich on 8/4/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BasketViewController.h"
#import "ResultViewController.h"
#import "LotteryTimer.h"
#import "BetManager.h"
#import "CDMenuItem.h"
#import "CDBetList.h"
#import "CDOrderInfo.h"
#import "CDLottery.h"
#import "IssueItem.h"

#import "RQBet.h"
#import "RQAllTraceIssues.h"

#import "FolderButton.h"
#import "BasketCellView.h"
#import "View+Factory.h"
#import "TraceFloatView.h"
#import "HMTableViewController.h"


//#import "KeyboardManager.h"
@interface BasketViewController ()<RQBaseDelegate>

@property (copy, nonatomic) void (^alertConfirmBlock)(BasketViewController *sender);
@property (assign, nonatomic) NSInteger issueStartIndex;
@property (nonatomic, copy) NSString *bettingMessage;
@property (nonatomic, copy) NSString *bettingDetail;
@property (nonatomic ,strong) CDLottery *lottery;
@property (nonatomic, assign) TraceFloatView *floatView;
@property (nonatomic, strong) NSArray *traceIssueList;
@property (nonatomic, assign) NSInteger traceStartIdx;
@property (nonatomic,assign)BOOL wasKeyboardManagerEnabled;
@property (nonatomic,assign)BOOL enableHigherChase;

@end

@implementation BasketViewController

BasketViewController *__basketInstance = nil;
+ (instancetype)currentInstace{
    return __basketInstance;
}

- (void)dealloc{
    __basketInstance = nil;
    self.dataList = nil;
    self.lottery = nil;
    self.bettingMessage = nil;
    self.bettingDetail = nil;
    self.traceIssueList = nil;
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    MSNotificationCenterAddObserver(@selector(onIssueNumberUpdated:), kNotificationIssueNumberUpdated);
    [self addKeyboardObserver];
    [[IssueItem current] addObserver:self];
    //_wasKeyboardManagerEnabled = [[IQKeyboardManager //sharedManager] isEnabled];
    //[[IQKeyboardManager sharedManager] setEnable:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IssueItem current] removeLastObserver];
    [self removeKeyboardObserver];
    //[[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
    MSNotificationCenterRemoveObserver();
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    // [[IQKeyboardManager sharedManager] setEnable:NO];
    
    
    __basketInstance = self;
    self.title = @"号码篮";
    self.view.backgroundColor = [UIColor rgbColorWithHex:@"EEEEEE"];
    self.tableView.backgroundColor = self.view.backgroundColor;
    UIButton *edit = [UIButton barButtonWithTitle:@"编辑"];
    edit.frame = CGRectMake(0, 0, 40, 30);
    [edit addTarget:self action:@selector(editList:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:edit];
    
    //Config views
    _touLbl.textColor = _beiLbl.textColor = Color(@"BetMethodTextColor");
    _footerView.backgroundColor = Color(@"BetFooterColor");
    _countLabel.textColor = Color(@"BetFooterCountColor");
    _balanceLabel.textColor = Color(@"BetFooterBalanceColor");
    _issueField.textColor = Color(@"BasketMethodColor");
    _issueField.inputView = [NumberPad instance];
    _multipleField.inputView = [NumberPad instance];
    [_issueField addTarget:self action:@selector(onIssueCountChanged:) forControlEvents:UIControlEventEditingChanged];
    
    TraceFloatView *floatView = [TraceFloatView loadFromNib];
    floatView.center = CGPointMake(self.view.bounds.size.width/2+48, 0);
    floatView.checkbox.checked = YES;
    floatView.hidden = YES;
    [self.view addSubview:floatView];
    [floatView followTarget:_issueView];
    self.floatView = floatView;
    
    
    self.dataList = [NSMutableArray array];
    [self.dataList addObject:@"1"];
    [self.dataList addObject:@"2"];
    [self.dataList addObject:@"3"];
    
    //Data
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    self.maxTraceCount = [lot.maxTrace intValue];
    _restIssueCount = self.maxTraceCount;
    _canSubmit = YES;
    self.lottery = lot;
    
    self.dataList = [CDBetList betListForAccount:[SharedModel shared].username];
    [self updateBetCount];
    
    _multipleField.text = @"1";
    _issueField.text = @"1";
    _issueCount = 1;
    
    [self retrieveTraceIssues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//最后一注的倍数
- (NSInteger)lastMultiple{
    
    
    
    if ([self.dataList count] > 0) {
        CDBetList *bet = [self.dataList lastObject];
        return [bet.multiple intValue];
    }
    return 1;
}

//追号期数
- (NSInteger)issueCount{
    return MAX(1, [_issueField.text integerValue]);
}

//计算注数，总金额，同时返回总金额
- (CGFloat)updateBetCount{
    _totalCount = _totalAmount = 0;
    //    _inputedMultiple = [self lastMultiple];
    _inputedMultiple = [self currentMultiple];
    
    //追期金额的计算分元角模式,追号时的总金额计算是  注数 * 期数 * 倍数(最后一单的投注倍数)
    NSInteger issueCount = [self issueCount];
    float unit = 2.f;
    for (CDBetList *bet in self.dataList){
        _totalCount += [bet.count intValue];
        if (_isTrace){
            unit = [bet.mode intValue] == kModeYuan ? 2.f : 0.2f;
            _totalAmount +=  [bet.amount floatValue]/[bet.multiple intValue]*_inputedMultiple*issueCount;   //#新的计算方式#
            
        } else {
            _totalAmount += [bet.amount floatValue]*_inputedMultiple;                //#amount是包含了倍数的金额#
        }
    }
    
    //追号判断
    if (_isTrace) {
        _countLabel.text =  [NSString stringWithFormat:@"%ld注x%ld期x%ld倍=%.2f元",
                             (long)_totalCount,  (long)issueCount, (long)_inputedMultiple, _totalAmount];
    } else {
        _countLabel.text =  [NSString stringWithFormat:@"%ld注x%ld=%.2f元",
                             (long)_totalCount, (long)MAX(issueCount,1), _totalAmount];
    }
    
    //金额判断
    if (_totalAmount > [[SharedModel shared].balance floatValue]) {
        HUDShowMessage(@"超出余额", nil);
        _canSubmit = NO;
    } else {
        _canSubmit = YES;
    }
    
    //临时金额
    [SharedModel shared].totalAmountInSelect = _totalAmount;
    _balanceLabel.text = [NSString stringWithFormat:@"可用余额 %@元",[SharedModel formattedBalance]];
    return _totalAmount;
}

- (void)onIssueNumberUpdated:(NSNotification *)noti{
    
}

- (void)onIssueCountChanged:(UITextField *)sender{
    _floatView.hidden = [sender.text integerValue] == 0;
}

- (NSInteger)limitTimes{
    
    __block NSInteger limitTimes = NSIntegerMax;
    [self.dataList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CDBetList *bet = (CDBetList*)obj;
        limitTimes = MIN(limitTimes, [bet.limitbet integerValue]);
        *stop=YES;
    }];
    
    limitTimes = MAX(limitTimes, 1);
    
    return (NSInteger)limitTimes;
}

- (NSInteger)currentMultiple{
    return MAX(1, [_multipleField.text integerValue]);
}

#pragma mark - Actions
- (void)reload{
    self.dataList = [CDBetList betListForAccount:[SharedModel shared].username];
    [self.tableView reloadData];
    [self updateBetCount];
}

//清空
- (IBAction)clearList:(id)sender{
    MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil message:@"确定要清空吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
        if (index == 1){
            [CDBetList deleteAll];
            [self reload];
            [self backAction:nil];
        }
    }];
    [alert show];
}

- (IBAction)deleteBet:(UIButton *)sender{
    CDBetList *bet = self.dataList[sender.tag];
    [bet destroy];
    [self.dataList removeObjectAtIndex:sender.tag];
    [self reload];
}

- (IBAction)editList:(UIButton *)sender{
    _editing = !_editing;
    [self reload];
    [sender setTitle:_editing ? @"完成" : @"编辑" forState:UIControlStateNormal];
}

- (IBAction)random1:(id)sender{
    [self traceAlert:^(BasketViewController *sender) {
        [CDBetList randomListN:1 forMethodName:self.currentMethodName lottery:self.lotteryId channelId:_channelId];
        [sender reload];
    }];
}

- (IBAction)random5:(id)sender{
    [self traceAlert:^(BasketViewController *sender) {
        [CDBetList randomListN:5 forMethodName:self.currentMethodName lottery:self.lotteryId channelId:_channelId];
        [sender reload];
    }];
    
}

- (IBAction)goonBetting:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resetTrace{
    _isTrace = NO;
    _issueCount = 0;
    _issueField.text = @"";
    [self updateBetCount];
    
}

- (void)traceAlert:(void (^)(BasketViewController *sender))confirmBlock{
    self.alertConfirmBlock = confirmBlock;
    if (_isTrace){
        
        AlertView *alert = [[AlertView alloc] initWithTitle:@"温馨提示" msg:@"您的操作将会取消当前追号方案" okButton:@"我知道了" cancelButton:@"取消"];
        [alert show];
        [alert setCompleteBlock:^(AlertView *alertView, bool okay) {
            if (okay){
                [self resetTrace];
                [self performSelector:@selector(alertConfirm) withObject:nil afterDelay:.2f];
            }
        }];
        [alert release];
        
    } else {
        
        self.alertConfirmBlock(self);
    }
}

/** 取回奖期 */
- (void)retrieveTraceIssues{
    HUDShowLoading(@"加载奖期...", nil);
    RQAllTraceIssues *r = [[[RQAllTraceIssues alloc] init] autorelease];
    r.channelId = _channelId;
    r.lotteryId = _lotteryId;
    [r startPostWithBlock:^(RQAllTraceIssues* rq_, NSError *error_, id rqSender_) {
        self.traceIssueList = [RQAllTraceIssues allIssues:rq_.lotteryId channelId:rq_.channelId];
        HUDHide();
        
    } sender:nil];
}
/** 检验期数是否有效 */
- (BOOL)checkTraceIssues{
    if ([_issueField.text integerValue] == 0) return YES;
    if (_traceIssueList.count == 0){
        HUDShowMessage(@"未能取回追号奖期", nil); return NO;
    }
    NSInteger issueCount = [self issueCount];
    for (NSInteger i = 0; i < _traceIssueList.count; i++) {
        TraceIssueObject *issue = _traceIssueList[i];
        //Find the head and the tail
        if ([issue.issueCode isEqualToString:[IssueItem current].issueNumber]){
            _traceStartIdx = i;
            if (i+issueCount > _traceIssueList.count){
                NSString *msg = [NSString stringWithFormat:@"最多只能追%@期",@(_traceIssueList.count-i)];
                HUDShowMessage(msg, nil);
                return NO;
            }
        }
    }
    return YES;
}

- (IBAction)confirm:(id)sender{
    if ([self.dataList count] == 0) return;
    
    if (![self checkTraceIssues]) return;
    
    NSMutableArray *betList = [CDBetList betListForAccount:[SharedModel shared].username];
    
    CGFloat totalAmount = 0.f;
    NSInteger totalBetCount = 0;
    for (CDBetList *bet in betList){
        totalAmount += [bet.amount floatValue];
        totalBetCount += [bet.count intValue];
    }
    //Fee
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    CGFloat fee = 0.f;
    if (_totalAmount > lot.backOutStartFee.floatValue){
        fee = lot.backOutRadio.floatValue * _totalAmount;
    }
    
    NSString *balance = [SharedModel shared].balance;//
    if ( _totalAmount >[balance floatValue]  ) {
        MSBlockAlertView *alert = [[MSBlockAlertView alloc]initWithTitle:@"余额不足" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
        return;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%@ 投注金额%.2f",self.lottery.name,_totalAmount];
    NSString *detail = [NSString stringWithFormat:@"起始期：%@\n追   号：%ld期 %ld 注 %ld倍",
                        [IssueItem current].issue,
                        (long)_issueCount,
                        (long)totalBetCount,
                        (long)self.inputedMultiple
                        ];
    self.bettingMessage = [NSString stringWithFormat:@"%@ 注单金额%.2f元",self.lottery.name,_totalAmount];
    self.bettingDetail = detail;
    WhiteAlert *alert = [WhiteAlert alertWithTitle:@"投注确认"
                                           message:msg
                                            detail:detail
                                           buttons:@"取消",@"确认投注",nil];
    [alert show];
    [alert setCompleteBlock:^(WhiteAlert *a, NSInteger buttonIndex) {
        if (buttonIndex == 1){
            
            RQBet *rq = [[[RQBet alloc] init] autorelease];
            self.rq = rq;
            rq.channelId = [IssueItem current].channelid;
            rq.lotteryId = [IssueItem current].lotteryId;
            rq.curmid = [IssueItem current].curmid;
            rq.mode = @([BetManager mode]).stringValue;
            rq.select4 = @"1倍";
            rq.multiple = self.inputedMultiple;
            rq.totalNumbers = totalBetCount;
            rq.totalMoney = _totalAmount;   //totalAmount;
            rq.issueNumber = [IssueItem current].issueNumber;
            rq.betList = betList;
            
            //追号
            if (_issueCount > 1) {
                //            long long startIssue = [[IssueItem current].issueNumber longLongValue];
                //            if (startIssue > 0) {
                
                BOOL stopOnWin = _floatView.checkbox.checked;
                
                NSMutableArray *traceIssueItems = [NSMutableArray array];
                @try {
                    for (NSUInteger i = 0; i < _issueCount; i++) {
                        TraceIssueObject *tio = _traceIssueList[_traceStartIdx+i];
                        TraceIssueItem *item = [[TraceIssueItem alloc] init];
                        item.issue = tio.issueCode; //@(startIssue+i).stringValue; //[self.traceIssueList objectAtIndex:i];
                        item.money =[BetManager mode]==kModeYuan ? 2.0f:0.2f;
                        [traceIssueItems addObject:item];
                        [item release];
                    }
                }
                @catch (NSException *exception) {
                    [HUDView showMessageToView:self.view msg:@"追号奖期错误" subtitle:nil];
                    return;
                }
                
                rq.traceIf = [traceIssueItems count] > 0;
                rq.traceStop = stopOnWin;
                rq.traceIssueItems = traceIssueItems;
            }
            [rq startPostWithDelegate:self];
        }
        
    }];
    
}

- (void)onRQStart:(RQBet *)rq{
    [HUDView showLoadingToView:[UIApplication sharedApplication].keyWindow msg:@"正在投注，请稍候..." subtitle:nil touchToHide:NO];
}

- (void)onRQComplete:(RQBet *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    [SharedModel shared].traceStartIssue = nil;
    
    if (error || rq.msgContent || rq.fullFail) {
        
        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"投注失败"
                                               message:rq.msgContent
                                                detail:nil
                                               buttons:@"确定",nil];
        [alert show];
    } else if (rq.orderId > 0){    //Success
        
        NSInteger   totalCount = _totalCount,
        multiple = _inputedMultiple,
        issueCount = _issueCount;
        CGFloat     amount = _totalAmount;
        
        NSString *ln = [IssueItem current].lotteryName;
        [RQPublicHistory saveLastOpenIssue:[IssueItem current]];
        [CDUserInfo user].lastLottery = ln;
        [[CDUserInfo user] save];
        MSNotificationCenterPost(kHomeViewControllerNewInfo);
        //        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"投注成功"
        //                                                   message:_bettingMessage
        //                                                    detail:_bettingDetail
        //                                                   buttons:@"再次投注",@"查看结果",nil];
        //        [alert setCompleteBlock:^(WhiteAlert *a, NSInteger buttonIndex) {
        //            if (buttonIndex == 1){
        //                ResultViewController *vc = [[ResultViewController alloc] init];
        //                [vc setOnViewDidLoad:^(ResultViewController *c) {
        //                    c.lotteryNameLbl.text = self.lottery.name;
        //                    c.issueLbl.text = [NSString stringWithFormat:@"第%@期[追%ld期]",rq.issueNumber,(long)issueCount];
        //                    c.amountLbl.text = [NSString stringWithFormat:@"%ld注x%ld倍x%ld期=%.2f元",
        //                                        (long)totalCount,
        //                                        (long)multiple,
        //                                        (long)issueCount,
        //                                        amount];
        //                    c.detailLbl.text = self.bettingMessage;
        //                }];
        //                [self.navigationController pushViewController:vc animated:YES];
        //                [vc release];
        //            } else {
        //                [self.navigationController popViewControllerAnimated:YES];
        //            }
        //        }];
        //        [alert show];
        {
            ResultViewController *vc = [[ResultViewController alloc] init];
            [vc setOnViewDidLoad:^(ResultViewController *c) {
                c.lotteryNameLbl.text = self.lottery.name;
                c.issueLbl.text = [NSString stringWithFormat:@"第%@期[追%ld期]",[IssueItem current].issue,(long)issueCount];
                c.amountLbl.text = [NSString stringWithFormat:@"%ld注x%ld倍x%ld期=%.2f元",
                                    (long)totalCount,
                                    (long)multiple,
                                    (long)issueCount,
                                    amount];
                c.detailLbl.text = self.bettingMessage;
            }];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        [self resetTrace];
        [CDBetList deleteAll];
        [self reload];
    }
    else if (rq.overMutipleDTO != nil){
        OverMultipleAlert *alert = [OverMultipleAlert alertWithTitle:@"提示" msg:@"您的注单内容超出倍数限制" details:rq.overMutipleDTO button:@"我知道了"];
        [alert show];
    }
    else if (rq.lists == nil){
        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"提示" message:@"您投注的号码方案受到限制，请重新选择" detail:nil buttons:@"我知道了"];
        [alert show];
    }
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? [self.dataList count] : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 60.f : 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            UIImageView *bg = [[UIImageView alloc] initWithFrame:cell.bounds];
            bg.image = ResImage(@"paper-cell.png");
            cell.backgroundView = bg;
            [bg release];
            
            BasketCellView *view = [BasketCellView loadFromNib];
            [view.deleteButton addTarget:self action:@selector(deleteBet:) forControlEvents:UIControlEventTouchUpInside];
            view.frame = cell.bounds;
            view.backgroundColor = [UIColor clearColor];
            view.tag = 100;
            view.textLabel.textColor = Color(@"BasketCodeColor");
            view.methodLabel.textColor = Color(@"BasketMethodColor");
            view.detailLabel.textColor = Color(@"BasketMethodDetailColor");
            [cell.contentView addSubview:view];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height - 1.f, cell.bounds.size.width, 1.f)];
            line.tag = 101;
            line.image = ResImage(@"paper-dash.png");
            line.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [cell addSubview:line];
            [line release];
        }
        CDBetList *bet = self.dataList[indexPath.row];
        BasketCellView *view = (id)[cell.contentView viewWithTag:100];
        view.deleteButton.hidden = !_editing;
        view.deleteButton.tag = indexPath.row;
        view.textLabel.text = bet.numbersForShow;
        view.methodLabel.text = bet.name;
        view.detailLabel.text = [NSString stringWithFormat:@"%@注x%.1f元=%.2f元",
                                 bet.count, [bet.mode integerValue] == kModeJiao ? 0.2f : 2.f,
                                 [BetManager amountWithBetCount:bet.count.integerValue multile:bet.multiple.integerValue]];
        ;
        [view update];
        return cell;
        
    } else {
        static NSString *identifier = @"cell_del";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            UIImageView *bg = [[UIImageView alloc] initWithFrame:cell.bounds];
            bg.image = ResImage(@"paper-tail.png");
            cell.backgroundView = bg;
            [bg release];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 7, 280.f, 30);
            [button addTarget:self action:@selector(clearList:) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:ResImage(@"basket-clear.png") forState:UIControlStateNormal];
            [cell.contentView addSubview:button];
        }
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Keyboard helper

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField selectAll:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _multipleField && [textField.text length] == 0) {
        textField.text = @"1";
    }
    if (textField == _issueField && [textField.text length] == 0) {
        textField.text = @"1";
    }
    
    if (textField==_issueField) {
        _isTrace = [textField.text integerValue] > 0;
    }
    
    if (textField == _multipleField){
        //限制倍数
        NSInteger limitTimes = [self limitTimes];
        NSInteger multiple = [self currentMultiple];
        if (multiple > limitTimes) {
            [HUDView showMessageToView:self.view msg:@"超出奖金限额" subtitle:nil];
            textField.text = [NSString stringWithFormat:@"%ld",(long)limitTimes];
        } else {
            textField.text = [@(multiple) stringValue];
        }
    }
    
    [self updateBetCount];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (textField==_issueField) {
        _isTrace = [textField.text integerValue] > 0;
    }
    
    if (textField == _multipleField){
        //限制倍数
        NSInteger limitTimes = [self limitTimes];
        NSInteger multiple = [self currentMultiple];
        if (multiple > limitTimes) {
            [HUDView showMessageToView:self.view msg:@"超出奖金限额" subtitle:nil];
            textField.text = [NSString stringWithFormat:@"%ld",(long)limitTimes];
        } else {
            textField.text = [@(multiple) stringValue];
        }
    }
    
    [self updateBetCount];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    Echo(@"%s %@ |%@ |Range:%@", __func__, textField.text, string , NSStringFromRange(range));
    NSString *text  = textField.text;
    NSInteger prior = [text integerValue];
    
    if (range.length > 0) {     //Backspace
        text = [text stringByReplacingCharactersInRange:range withString:string];
    } else {        //Append
        text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    
    //非数字
    NSRange rang = [text rangeOfString:@"[^\\d]" options:NSRegularExpressionSearch];
    if (rang.length > 0) {
        return NO;
    }
    
    if (textField == _issueField) {
        _issueCount = [text integerValue];
        if (_issueCount > _restIssueCount) {
            _issueCount = _restIssueCount;
            textField.text = [NSString stringWithFormat:@"%ld",(long)prior];
            NSString *msg = [NSString stringWithFormat:@"最多可追%ld期",(long)_restIssueCount];
            HUDHide();
            HUDShowMessage(msg, nil);
            [self updateBetCount];
            return NO;
        }
    }
    
    return YES;
}

- (UIView *)keyboardAccessoryView{
    return _issueView;
}

- (CGRect)keyboardAccessoryViewOrigFrame{
    return CGRectMake(0, self.view.bounds.size.height - _footerView.bounds.size.height - _issueView.bounds.size.height,
                      self.view.bounds.size.width, _issueView.bounds.size.height);
}

#pragma mark - AlertDelegate
- (void)alertConfirm{
    if (self.alertConfirmBlock) {
        self.alertConfirmBlock(self);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self resetTrace];
        [self performSelector:@selector(alertConfirm) withObject:nil afterDelay:.2f];
        
    }
}
- (IBAction)gaoJiZhuiHao:(UIButton *)sender {
    [self checkHighChase];
      if (_enableHigherChase) {
        
        
        HMTableViewController *vc=[UIStoryboard storyboardWithName:@"HMTableViewController" bundle:nil].instantiateInitialViewController;
        
        //[self presentViewController:vc animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(NSMutableArray*)getNoHigherChaseLotteryIds{
    NSMutableArray *lotteryIds =[NSMutableArray array];
    
    
    
    [lotteryIds addObject:@"1"];
    [lotteryIds addObject:@"3"];
    [lotteryIds addObject:@"6"];
    [lotteryIds addObject:@"12"];
    
    return lotteryIds;
}

-(NSMutableArray*)getNoHigherChaseMethodidsForType:(int) type{
    NSMutableArray *methodids =[NSMutableArray array];
    if(type ==1){
        [methodids addObject:@"11"];
        [methodids addObject:@"453"];
        [methodids addObject:@"16"];
        [methodids addObject:@"463"];
        
    }else if (type==2) {
        
        
        
        [methodids addObject:@"562"];
        [methodids addObject:@"563"];
        [methodids addObject:@"568"];
        [methodids addObject:@"569"];
        
    }else if (type==3) {
        
        
        [methodids addObject:@"847"];
        [methodids addObject:@"848"];
        [methodids addObject:@"853"];
        [methodids addObject:@"854"];
        
    }
    
    return methodids;
    
}

-(void)checkHighChase{
    _enableHigherChase=YES;
    NSString* lastName =nil;
    NSMutableArray* ssclotteryIds =[self getNoHigherChaseLotteryIds];
    
    NSMutableArray *sscMethodids=[self getNoHigherChaseMethodidsForType:1];
    NSMutableArray *llcMethodids =[self getNoHigherChaseMethodidsForType:2];
    NSMutableArray *jlffcMethodids =[self getNoHigherChaseMethodidsForType:3];
    if(self.dataList.count==0){
        
        HUDShowMessage(@"请添加注单", nil);
        _enableHigherChase=NO;
        return;
    }
    for(CDBetList *bet in self.dataList){
        
        
        
        NSString*  name =bet.name;
        int channelId=[bet.channelId intValue];
        int lotteryId=[_lottery.lotteryId intValue];;
        int methodId=[bet.methodId intValue];
        NSLog(@"channelid=%d ,lotteryId=%d ,methoId=%d",channelId,lotteryId,methodId);
        if((channelId==4&&lotteryId==14&&[jlffcMethodids containsObject:[NSString stringWithFormat:@"%d",methodId]])||(channelId==4&&lotteryId==11&&[llcMethodids containsObject:[NSString stringWithFormat:@"%d",methodId]])||(channelId==4&&[ssclotteryIds containsObject:[NSString stringWithFormat:@"%d",lotteryId]]&&[sscMethodids containsObject:[NSString stringWithFormat:@"%d",methodId]])||(channelId==4&&lotteryId==16&&methodId==1)){
            
            HUDShowMessage(@"组选和值为多奖金玩法不支持高级追号", nil);
            _enableHigherChase=NO;
            return;
        }
        //
        if(lastName!=nil&&![lastName isEqualToString:name]){
            
            HUDShowMessage(@"请保持注单玩法统一", nil);
            _enableHigherChase=NO;
            return;
        }
        
        lastName=name;
        
    }
    
    
    
    
}

@end
