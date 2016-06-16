//
//  BetLowViewController.m
//  Caipiao
//
//  Created by danal-rich on 7/23/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "CD.h"
#import "BetLowViewController.h"
#import "ResultViewController.h"
#import "LotteryTimer.h"
#import "Ball.h"
#import "BetCell.h"
#import "MethodMenuItem.h"
#import "IssueItem.h"
#import "MethodView.h"
#import "NumberPad.h"
#import "RQBet.h"
#import "RQAllTraceIssues.h"
#import "TraceFloatView.h"
#import "MSBlockAlertView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface BetLowViewController () <MethodMenuItemDelegate,MethodItemClickDelegate,RQBaseDelegate>
@property (nonatomic, strong) MethodMenuItem *methodMenuItem;
@property (nonatomic, assign) BetMode   mode;
@property (nonatomic, assign) TraceFloatView *floatView;
@property (nonatomic, assign) UIGestureRecognizer *gesture;
//当前选中的注数和金额
@property (nonatomic, assign) NSInteger currentBetCount;
@property (nonatomic, assign) CGFloat   currentAmount;
@property (nonatomic, assign) CGFloat   totalAmount;
@property (nonatomic) BOOL isSSQ;       //是否双色球
@property (nonatomic, copy) NSString *bettingMessage;
@property (nonatomic, copy) NSString *bettingDetail;
@property (nonatomic, strong) NSMutableArray *recentMethods;
@property (nonatomic, strong) NSArray *traceIssueList;
@property (nonatomic, assign) NSInteger traceStartIdx;
@property (nonatomic, assign) IBOutlet UIButton *methodButton;
@end

@implementation BetLowViewController

- (void)dealloc{
    MSNotificationCenterRemoveObserver();
    [[SimpleLotteryTimer shared] stop];
    [self removeKeyboardObserver];
    NSString *file = [NSBundle pathInDocuments:[NSString stringWithFormat:@"Recent%ld_%ld",(long)self.channelId,(long)self.lotteryId]];
    [self.recentMethods writeToFile:file atomically:YES];
    self.recentMethods = nil;
    self.methodMenuItem = nil;
    self.bettingMessage = nil;
    self.bettingDetail = nil;
    self.traceIssueList = nil;
    [_currentIssuleL release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    self.title = lot.name;
    self.isSSQ = [lot.name isEqualToString:LOW_SSQ];
    
    UIButton *info = [UIButton buttonWithType:UIButtonTypeCustom];
    info.frame = CGRectMake(0, 0, 28, 28);
    [info setImage:ResImage(@"info-icon.png") forState:UIControlStateNormal];
    [info addTarget:self action:@selector(gotoInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:info];
    
    //Reset values
    [CDBetList deleteAll];
    [SharedModel shared].totalAmountInSelect = 0.f;
    
    //Config views
    _betView.backgroundColor = [UIColor rgbColorWithHex:@"EEEEEE"];
    _methodView.delegate = self;
    if (_isSSQ){
        _methodButton.hidden = YES;
        _recentMethods = [[NSMutableArray alloc] initWithArray:@[@"复式",@"胆拖"]];
    } else {
        NSString *file = [NSBundle pathInDocuments:[NSString stringWithFormat:@"Recent%ld_%ld",(long)self.channelId,(long)self.lotteryId]];
        _recentMethods = [[NSMutableArray alloc] initWithContentsOfFile:file];
        if (!_recentMethods){
            _recentMethods = [[NSMutableArray alloc] init];
        }
    }
    _methodView.recentItemNames = _recentMethods;
    _methodView.methodItems = [MethodMenuItem getAll:self.lotteryId channelId:self.channelId];
 
    [_issueField addTarget:self action:@selector(onIssueCountChanged:) forControlEvents:UIControlEventEditingChanged];
    TraceFloatView *floatView = [TraceFloatView loadFromNib];
    floatView.center = CGPointMake(self.view.bounds.size.width/2 + 48.f, 0);
    floatView.checkbox.checked = YES;
    floatView.hidden = YES;
    [self.view addSubview:floatView];
    [floatView followTarget:_multipleView];
    self.floatView = floatView;
    
    //Add bet views
    self.mode = [BetManager mode];
    self.methodId = [self lastMethodId];
    self.methodMenuItem = [MethodMenuItem itemFromMethodId:self.methodId lottery:self.lotteryId channelId:self.channelId];
    self.methodMenuItem.delegate = self;
    [self reloadBetView];
    
    _methodView.selectedMethodName = self.methodMenuItem.methodName;
    [_methodView updateDisplay];
    
    //Show first method if first enter
    if ([_recentMethods count] == 0){
        [_recentMethods addObject:_methodMenuItem.methodName];
        _methodView.recentItemNames = _recentMethods;
        [_methodView updateDisplay];
    }
    
    if (_isSSQ) {
        UIView *btn1 = [_methodView.scroll viewWithTag:100];
        CGRect frame1 = btn1.frame;
        frame1.origin.x=100;
        btn1.frame=frame1;
        
        UIView *btn2 = [_methodView.scroll viewWithTag:101];
        CGRect frame2 = btn2.frame;
        frame2.origin.x=170;
        btn2.frame=frame2;
    }
    
    _touLbl.textColor = _beiLbl.textColor =
    _zhuiLbl.textColor = _qiLbl.textColor = Color(@"BetMethodTextColor");
    [_randomButton setTitleColor:Color(@"BetRandomTextColor") forState:UIControlStateNormal];
    _betView.backgroundColor = Color(@"BetViewBGColor");
    _footerView.backgroundColor = Color(@"BetFooterColor");
    _countLabel.textColor = Color(@"BetFooterCountColor");
    _balanceLabel.textColor = Color(@"BetFooterBalanceColor");
    _multipleField.inputView = [NumberPad instance];
    _issueField.inputView = [NumberPad instance];
    _timerLabel.textColor = Color(@"BetMethodMaskColor");
    _issueField.text = @"1";
    
//    //Launch timer
//    [self fireTimer:nil];
   
    [self retrieveTraceIssues];
    
     MSNotificationCenterAddObserver(@selector(requestSimpleInitData), UIApplicationDidBecomeActiveNotification);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addKeyboardObserver];
    [self updateBalance];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.navigationController.navigationBar addGestureRecognizer:swipe];
    self.gesture = swipe;
    [swipe release];
    
    //Launch timer
    [self fireTimer:nil];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeKeyboardObserver];
    
    [self.navigationController.navigationBar removeGestureRecognizer:self.gesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateBalance{
    RQGetBalance *q = [[RQGetBalance alloc] init];
    [q startPostWithBlock:^(id rq_, NSError *error_, id rqSender_) {
        [self updateCount];
    } sender:nil];
}

- (NSInteger)lastMethodId{
    
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    NSInteger mid = [lot.lastMethodId integerValue];
    if (mid == 0){
        MethodMenuItemCategory *cat = [_methodView.methodItems firstObject];
        MethodMenuItem *item = [cat.methodMenuItems firstObject];
        MenuItemModel *m = [BetManager menuItemModelForMethodName:item.methodName lottery:_lotteryId channelId:_channelId];
        
//        MenuItemModel *m = [BetManager firstMenuItemModelForLottery:self.lotteryId channelId:_channelId];
        mid = [m.methodid integerValue];
        m = nil;
    }
    return mid;
}

- (void)updateMethodId:(NSInteger)mid{
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    lot.lastMethodId = [NSNumber numberWithInteger:mid];
    [lot save];
    lot = nil;
}

- (NSInteger)currentMultiple{
    return MAX(1, [_multipleField.text integerValue]);
}

//追号期数
- (NSInteger)currentTraceCount{
    return MAX(1, [_issueField.text integerValue]);
}

- (NSInteger)limitTimes{
    if (_isSSQ) return NSIntegerMax;
    
    CGFloat limitTimes = 1;
    limitTimes = MAX(limitTimes, (self.methodMenuItem.limitBonus*1.f/self.methodMenuItem.methodPrice));
    if (self.methodMenuItem.methodPrice == 0.f){
        return 1;
    }
    return (NSInteger)limitTimes;
}

/* Update betting count and amount... */
- (void)updateCount{
    NSInteger betCount = [self.methodMenuItem betItemsUpdated];
    NSInteger multiple = [self currentMultiple];
    _currentBetCount = betCount;
    
    //SSQ remains the same even the 角mode is triggered
    if(_isSSQ)
    {
        _currentAmount = betCount * multiple * 2.f;
    }
    else
    {
        CGFloat amount = [BetManager amountWithBetCount:betCount multile:multiple mode:_mode];
        _currentAmount = amount;
    }
    _totalAmount = _currentAmount;
    
    NSInteger traceCount = [self currentTraceCount];
    if (traceCount > 1){
        //追号时的总金额计算是  注数 * 期数 * 倍数(最后一单的投注倍数)
//        _totalAmount = betCount * traceCount * multiple * (_mode==kModeYuan?2.0f:0.2f);
        _totalAmount = _currentAmount*traceCount;
    }

    _countLabel.text = [NSString stringWithFormat:@"%ld注x%ld倍x%ld期=%.02f元",(long)betCount,(long)multiple,(long)traceCount,_totalAmount];
    if (betCount > 0){
        _balanceLabel.text = [NSString stringWithFormat:@"可用余额 %@元",[SharedModel formattedBalance]];
    } else {
        _balanceLabel.text = self.methodMenuItem.tips;
    }
}

- (void)reloadBetView{
    [self resetMultileValue];
    [_betView clear];
    CGFloat h = 0.f, w = _betView.bounds.size.width;
    Echo(@"%@",self.methodMenuItem.lotteryName);
    
    if (_isSSQ){
        for (BetItem *item in self.methodMenuItem.betItems){
            h = [SSQBetView heightForBetItem:item];
            BetView *bv = nil;
            bv = [[SSQBetView alloc] initWithFrame:CGRectMake(0, 0, w, h) item:item];
            bv.betItem = item;
            [_betView addBetView:bv];
            [bv release];
        }

    } else {
        for (BetItem *item in self.methodMenuItem.betItems){
            h = [BetView heightForBetItem:item];
            BetView *bv = nil;
            if (item.type == kBetItemTypeWords){
                bv = [[WordsBetView alloc] initWithFrame:CGRectMake(0, 0, w, h) item:item];
            } else {
                bv = [[BetView alloc] initWithFrame:CGRectMake(0, 0, w, h) item:item];
            }
            bv.betItem = item;
            [_betView addBetView:bv];
            [bv release];
        }
    }
    [self updateCount];
}

- (void)timerLoop:(SimpleLotteryTimer *)timer{
    _timerLabel.text = [[SimpleLotteryTimer shared] remainningTimeStr];
    _currentIssuleL.text = [NSString stringWithFormat:@"当前期:%@",[IssueItem current].issue];
}

- (void)fireTimer:(NSNotification *)noti{
    [[SimpleLotteryTimer shared] setTimerLoopCallback:@selector(timerLoop:) target:self];
    [[SimpleLotteryTimer shared] launch];
}
-(void)requestSimpleInitData{
    [[SimpleLotteryTimer shared] launch];
    [[SimpleLotteryTimer shared]simpleInit];
}
- (void)resetMultileValue{
    _multipleField.text = @"1";
    _issueField.text = @"1";
}

- (void)onIssueCountChanged:(UITextField *)sender{
    _floatView.hidden = [sender.text integerValue] == 0;
}

#pragma mark - Actions


//Open history
- (void)swipeDown:(UISwipeGestureRecognizer *)g{
    Echo(@"%s",__func__);
    if (!_historyView){
        _historyView = [HistoryView loadFromNib];
        _historyView.frame = CGRectMake(0, -_historyView.frame.size.height,
                                        _historyView.frame.size.width, _historyView.frame.size.height);
        _historyView.tableView.scrollEnabled = NO;
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openHistory)];
        swipe.direction=UISwipeGestureRecognizerDirectionUp;
        [_historyView addGestureRecognizer:swipe];
        [swipe release];
        
        [self.view addSubview:_historyView];
    }
    NSArray *items = [RQPublicHistory pastIssueList:self.channelId lotteryId:self.lotteryId];
    if ([items count] > 0){
        _historyView.issueItems = [items subarrayWithRange:NSMakeRange(0, MIN(10, items.count))];
        [self openHistory];
        
    } else {
        HUDShowLoading(kStringLoading, nil);
        RQPublicHistory *req = [[RQPublicHistory alloc] init];
        req.lotteryId = self.lotteryId;
        req.lowgame = self.channelId == kChannelLow;
        [req startPostWithBlock:^(RQPublicHistory *rq_, NSError *error_, id rqSender_) {
            if ([rq_.issueList count] > 0){
                _historyView.issueItems = [rq_.issueList subarrayWithRange:NSMakeRange(0, MIN(10, rq_.issueList.count))];
            }
            [self openHistory];
            [rq_ release];
            HUDHide();
        } sender:nil];
    }
    
}

- (void)openHistory{
    BOOL toShow = _historyView.tag == 0;
    CGRect rect = CGRectMake(0, toShow ? 0.f : -_historyView.frame.size.height,
                             _historyView.frame.size.width, _historyView.frame.size.height);
    [UIView animateWithDuration:.28f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        _historyView.frame = rect;
        _wrapView.frame = CGRectMake(0, rect.origin.y + rect.size.height,
                                     _wrapView.frame.size.width, _wrapView.frame.size.height);
    } completion:^(BOOL finished) {
        _historyView.tag = toShow;
    }];
    
}

- (IBAction)gotoInfo:(id)sender{
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    NSString *url = [kUrlGameTips stringByAppendingString:lot.abbreviation];
    MSWebViewController *vc = [[MSWebViewController alloc] init];
    vc.title = @"玩法说明";
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)randomBetting:(id)sender{
    [self.methodMenuItem random1];
}

- (IBAction)switchMethodPanel:(id)sender{
    [_methodView togglePanel];
}

- (void)onMethodItemClick:(NSString *)methodName view:(MethodView *)methodView{
    MethodMenuItem *curItem = [MethodMenuItem itemFromMethodName:methodName lottery:self.lotteryId channelId:self.channelId];
    Echo(@"%@ %@ %ld",curItem, curItem.methodName,(long)curItem.methodId);
    if ([self lastMethodId] != curItem.methodId){
        [methodView commit];
        
        //Reload for new play method
        self.methodId = curItem.methodId;
        [self updateMethodId:curItem.methodId];
        
        self.methodMenuItem = curItem;
        self.methodMenuItem.delegate = self;
        
        [self reloadBetView];
        
        //Update recents
        if (methodView != _methodView && !_isSSQ){
            BOOL found = NO;
            for (NSString *s in _recentMethods){
                if ([s isEqualToString:curItem.methodName]){
                    found = YES;
                    break;
                }
            }
            if (!found){
                [_recentMethods insertObject:curItem.methodName atIndex:0];
                if ([_recentMethods count] > 5){
                    [_recentMethods removeObjectsInRange:NSMakeRange(5, _recentMethods.count-5)];
                }
            }
            _methodView.selectedMethodName = curItem.methodName;
            [_methodView updateDisplay];
        }

    }
    
}

- (void)onMethodMenuItemChanges:(MethodMenuItem *)methodMenuItem{
    [_betView reload];
    [self updateCount];
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
    NSInteger issueCount = [self currentTraceCount];
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
    
    if (_currentAmount == 0.f) return;
    if (![self checkTraceIssues]) return;
    
    {
        NSString *numbers = [self.methodMenuItem jointedNumbers];
        Echo(@"%@",numbers);
    }
    //余额检查
    NSString *balance = [SharedModel shared].balance;
    if ( _totalAmount >[balance floatValue] ) {
        MSBlockAlertView *alert = [[MSBlockAlertView alloc]initWithTitle:@"余额不足" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    //For success alert
    NSString *detail = [NSString stringWithFormat:@"期号：%@\n详情：%ld期 %ld注 %ld倍",
                        [IssueItem current].issue,
                        (long)[self currentTraceCount],
                        (long)_currentBetCount,
                        (long)[self currentMultiple]
                        ];
    self.bettingMessage = [NSString stringWithFormat:@"%@ 注单金额%.2f元",self.methodMenuItem.lotteryName,_totalAmount];
    self.bettingDetail = detail;
    
    //Fee
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    CGFloat fee = 0.f;
    if (_totalAmount > lot.backOutStartFee.floatValue){
        fee = lot.backOutRadio.floatValue * _totalAmount;
    }
    Echo(@"%@ - fee:%f/%f backOutStartFee=%@",lot.name, fee,_totalAmount,lot.backOutStartFee);
    
    //Flurry Event
    if([lot.channelid intValue] == 1 && [lot.lotteryId intValue] == 2) //P5
    { FLEvent(kFLEventP5Bet); }
    
    //号码
    NSString *numbers = [self.methodMenuItem jointedNumbers];
    
    //追号期数
    NSInteger traceCount = [self currentTraceCount];
    long long startIssue = [[IssueItem current].issue longLongValue];
    long long endIssue = startIssue + MAX(traceCount-1, 0);
    
    
    NSString *details = [NSString stringWithFormat:@"[%@]%@",self.methodMenuItem.methodName,numbers];
    BettingAlert *alert = [BettingAlert alertWithTitle:@"注单确认"
                                               lottery:self.methodMenuItem.lotteryName
                                                amount:_totalAmount
                                           minusAmount:0
                                                 issue:[IssueItem current].issue
                                               toIssue:traceCount > 1 ? @(endIssue).stringValue : nil
                                            issueCount:MAX(0, traceCount)
                                                detail:details
                                                 limit:nil
                                                   fee:fee
                                               buttons:@"取消",@"确认投注",nil];
    

    [alert setCompleteBlock:^(WhiteAlert *a, NSInteger buttonIndex) {
        if (buttonIndex == 1){
            RQBetLow *rq = [[[RQBetLow alloc] init] autorelease];
            self.rq = rq;
            rq.channelId = self.channelId;
            rq.lotteryId = self.methodMenuItem.lotteryId;
            rq.methodId = self.methodId;   //self.methodMenuItem.methodId;
            rq.multiple = [self currentMultiple];
            rq.totalNumbers = _currentBetCount;
            rq.totalMoney = _totalAmount;   //_currentAmount;
            rq.issueNumber = [IssueItem current].issueNumber;
            
            //SSQ remains the same even the 角mode is triggered
            if(_isSSQ)
            {
                rq.mode = @"1"; //元
            }
            else
            {
                rq.mode = @([BetManager mode]).stringValue;
            }
            
            rq.numbers = numbers;
            
            //追号
            if (traceCount > 1){
                BOOL stopOnWin = _floatView.checkbox.checked;
                NSMutableArray *traceIssueItems = [NSMutableArray array];
                @try {
                    for (NSUInteger i = 0; i < traceCount; i++) {
                        TraceIssueObject *tio = _traceIssueList[_traceStartIdx+i];
                        TraceIssueItem *item = [[TraceIssueItem alloc] init];
                        item.issue = tio.issueCode; //@(startIssue+i).stringValue; //[self.traceIssueList objectAtIndex:i];
                        item.money = 2.0f;
                        [traceIssueItems addObject:item];
                        [item release];
                    }
                }
                @catch (NSException *exception) {
                    [HUDView showMessageToView:self.view msg:@"追号奖期错误" subtitle:nil];
                    return;
                }
                
                rq.traceIf = [traceIssueItems count] > 1;
                rq.traceStop = stopOnWin;
                rq.traceIssueItems = traceIssueItems;
            }
            [rq startPostWithDelegate:self];

        }
    }];
    [alert show];
    
}

- (void)onRQStart:(RQBase *)rq{
   [HUDView showLoadingToView:[UIApplication sharedApplication].keyWindow msg:@"正在投注，请稍候..." subtitle:nil touchToHide:NO];
}

- (void)onRQComplete:(RQBetLow *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    
    if (error || rq.msgContent) {    //Net errors
        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"投注失败"
                                                   message:rq.msgContent
                                                    detail:nil
                                                   buttons:@"确定",nil];
        [alert show];
    }
    else if (rq.orderId > 0){    //Success

        NSInteger betCount = _currentBetCount;
        NSInteger multiple = [self currentMultiple];
        NSInteger traceCount = [self currentTraceCount];
        CGFloat amount = _totalAmount;
        
        NSString *ln = [IssueItem current].lotteryName;
        [RQPublicHistory saveLastOpenIssue:[IssueItem current]];
        [CDUserInfo user].lastLottery = ln;
        [[CDUserInfo user] save];
         MSNotificationCenterPost(kHomeViewControllerNewInfo);
        [self updateBalance]; //更新余额
        
        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"投注成功"
                                                   message:_bettingMessage
                                                    detail:_bettingDetail
                                                   buttons:@"再次投注",@"查看结果",nil];
        [alert setCompleteBlock:^(WhiteAlert *a, NSInteger buttonIndex) {
            if(buttonIndex == 1){
                ResultViewController *vc = [[ResultViewController alloc] init];
                vc.channelId = self.channelId;
                [vc setOnViewDidLoad:^(ResultViewController *c) {
                    c.lotteryNameLbl.text = self.title;
                    c.issueLbl.text = [NSString stringWithFormat:@"第%@期[追%ld期]",[IssueItem current].issue,(long)traceCount];
                    c.amountLbl.text = [NSString stringWithFormat:@"%ld注x%ld倍x%ld期=%.2f元",
                                        (long)betCount,
                                        (long)multiple,
                                        (long)traceCount,
                                        amount];
                    c.detailLbl.text = self.bettingMessage;
                }];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
            }else                 [self updateBalance];
        }];
        [alert show];
        
        //Clear
        _multipleField.text = @"1";
        _issueField.text = @"1";
        [self.methodMenuItem resetBet];
        [CDBetList deleteAll];
    }
    else if (rq.overMutipleDTO != nil){
        OverMultipleAlert *alert = [OverMultipleAlert alertWithTitle:@"提示" msg:@"您的注单内容超出倍数限制" details:rq.overMutipleDTO button:@"我知道了"];
        [alert show];
    }
    else if (rq.lists == nil||rq.lists.count==0){
        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"提示" message:@"您投注的号码方案受到限制，请重新选择" detail:nil buttons:@"我知道了",nil];
        [alert show];
    }
    else if (rq.isSlip || rq.isLock){
        //号码
        NSString *numbers = [self.methodMenuItem jointedNumbers];
        numbers = [numbers stringByReplacingOccurrencesOfString:@" " withString:@","];
        //追号期数
        NSInteger traceCount = [self currentTraceCount];
        long long startIssue = [[IssueItem current].issueNumber longLongValue];
        long long endIssue = startIssue + traceCount;
        //Fee
        CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
        CGFloat fee = 0.f;
        if (_totalAmount > lot.backOutStartFee.floatValue){
            fee = lot.backOutRadio.floatValue * _totalAmount;
        }
        //封锁变价
        NSMutableString *limits = [NSMutableString string];
        if (rq.isLock){
            [limits appendString:@"投注受限，已帮您调整"];
        }
        if (rq.isSlip){
            if (rq.isLock) [limits appendString:@"\n"];
            [limits appendString:@"存在资金变动风险"];
        }
        __block CGFloat afterAmount = rq.afterAmount;
        __block NSArray *betList = [rq.lists copy];
        
        NSString *details = [NSString stringWithFormat:@"[%@]%@",self.methodMenuItem.methodName,numbers];
        BettingAlert *alert = [BettingAlert alertWithTitle:@"注单确认"
                                                   lottery:self.methodMenuItem.lotteryName
                                                    amount:rq.afterAmount
                                               minusAmount:rq.reduceAmount
                                                     issue:[IssueItem current].issueNumber
                                                   toIssue:traceCount > 0 ? @(endIssue).stringValue : nil
                                                issueCount:MAX(0, traceCount)
                                                    detail:details
                                                     limit:limits
                                                       fee:fee
                                                   buttons:@"取消",@"确认投注",nil];
        [alert show];
        [alert setCompleteBlock:^(WhiteAlert *a, NSInteger buttonIndex) {
            if (buttonIndex == 1){
                RQBetLow *rq1 = [[[RQBetLow alloc] init] autorelease];
                self.rq = rq1;
                rq1.slipResonseDTOList = rq.slipResonseDTOList;
                rq1.isFirstSubmit = @"1";
                rq1.channelId = self.channelId;
                rq1.lotteryId = self.methodMenuItem.lotteryId;
                rq1.methodId = self.methodId;
                rq1.multiple = [self currentMultiple];
                rq1.totalNumbers = _currentBetCount;
                rq1.totalMoney = afterAmount;
                rq1.issueNumber = [IssueItem current].issueNumber;
                //rq.numbers = numbers;
                rq1.betList = betList;
                [betList release];
                //追号
                if (traceCount > 0){
                    BOOL stopOnWin = _floatView.checkbox.checked;
                    NSMutableArray *traceIssueItems = [NSMutableArray array];
                    @try {
                        for (NSUInteger i = 0; i < traceCount; i++) {
                            TraceIssueObject *tio = _traceIssueList[_traceStartIdx+i];
                            TraceIssueItem *item = [[TraceIssueItem alloc] init];
                            item.issue = tio.issueCode;//@(startIssue+i).stringValue;    // [self.traceIssueList objectAtIndex:i];
                            item.money = 2.0f;
                            [traceIssueItems addObject:item];
                            [item release];
                        }
                    }
                    @catch (NSException *exception) {
                        [HUDView showMessageToView:self.view msg:@"追号奖期错误" subtitle:nil];
                        return;
                    }
                    
                    rq1.traceIf = [traceIssueItems count] > 1;
                    rq1.traceStop = stopOnWin;
                    rq1.traceIssueItems = traceIssueItems;
                }
                [rq1 startPostWithDelegate:self];
                
            }

        }];
        
    }
//    else if (rq.lists == nil){
//        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"提示" message:@"您投注的号码方案受到限制，请重新选择" detail:nil buttons:@"我知道了"];
//        [alert show];
//    }
}

#pragma mark - Keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    //非数字
    NSRange range = [textField.text rangeOfString:@"[^\\d]" options:NSRegularExpressionSearch];
    if (range.length > 0) {
        textField.text = [textField.text substringToIndex:range.location];
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
    
    [self updateCount];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (textField == _multipleField && [textField.text isEqualToString:@"1"]) {
//        textField.text = nil;
//    }
    [textField selectAll:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _multipleField && [textField.text length] == 0) {
        textField.text = @"1";
    }
    if (textField == _issueField && [textField.text length] == 0) {
        textField.text = @"1";
    }
}

- (UIView *)keyboardAccessoryView{
    return _multipleView;
}

- (CGRect)keyboardAccessoryViewOrigFrame{
    return CGRectMake(0, self.view.bounds.size.height - _footerView.frame.size.height - _multipleView.frame.size.height,
                      _multipleView.frame.size.width, _multipleView.frame.size.height);
}

#pragma mark - Shake
- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self.methodMenuItem random1];
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Vibrate~");
#else
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
#endif
}


@end
