//
//  BetHighViewController.m
//  Caipiao
//
//  Created by danal-rich on 7/23/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "CD.h"
#import "BetHighViewController.h"
#import "LotteryTimer.h"

#import "Ball.h"
#import "BetCell.h"
#import "MethodMenuItem.h"
#import "MethodView.h"
#import "NumberPad.h"
#import "LeLiGrilView.h"
#import "KxMovieViewController.h"
#import "VideoAlert.h"
#import "Reachability.h"
#import <AudioToolbox/AudioToolbox.h>

@interface BetHighViewController () <MethodMenuItemDelegate,MethodItemClickDelegate>
@property (nonatomic, strong) MethodMenuItem *methodMenuItem;
@property (nonatomic, assign) BetMode   mode;
//当前选中的注数和金额
@property (nonatomic, assign) NSInteger currentBetCount;
@property (nonatomic, assign) CGFloat   currentAmount;
@property (nonatomic, strong) NSMutableArray *recentMethods;
@property (nonatomic, assign) UIGestureRecognizer *gesture;
@end

@implementation BetHighViewController

- (void)dealloc{
    MSNotificationCenterRemoveObserver();
    [[SimpleLotteryTimer shared] stop];
    [self removeKeyboardObserver];
    NSString *file = [NSBundle pathInDocuments:[NSString stringWithFormat:@"Recent%ld_%ld",(long)self.channelId,(long)self.lotteryId]];
    [self.recentMethods writeToFile:file atomically:YES];
    self.methodMenuItem = nil;
    self.recentMethods = nil;
    [_currentIssuleL release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    self.navigationItem.title = lot.name;
    
    UIButton *info = [UIButton buttonWithType:UIButtonTypeCustom];
    info.frame = CGRectMake(0, 0, 28, 28);
    [info setImage:ResImage(@"info-icon.png") forState:UIControlStateNormal];
    [info addTarget:self action:@selector(gotoInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:info];
    
    
    //Reset values
    [CDBetList deleteAll];
    [SharedModel shared].totalAmountInSelect = 0.f;
    
    //Config views
    NSString *file = [NSBundle pathInDocuments:[NSString stringWithFormat:@"Recent%ld_%ld",(long)self.channelId,(long)self.lotteryId]];
    _recentMethods = [[NSMutableArray alloc] initWithContentsOfFile:file];
    if (!_recentMethods){
        _recentMethods = [[NSMutableArray alloc] init];
    }
    _methodView.delegate = self;
    _methodView.recentItemNames = _recentMethods;
    _methodView.methodItems = [MethodMenuItem getAll:self.lotteryId channelId:self.channelId];
    
    //Add bet views
    self.mode = [BetManager mode];
    self.methodId = [self lastMethodId];
    self.methodMenuItem = [MethodMenuItem itemFromMethodId:self.methodId lottery:self.lotteryId channelId:self.channelId];
    self.methodMenuItem.delegate = self;
    [self reloadBetView];
    
    _methodView.selectedMethodName = self.methodMenuItem.methodName;
    [_methodView updateDisplay];
    Echo(@"%@",_methodMenuItem.methodName);
    
    //Show first method if first enter
    if ([_recentMethods count] == 0){
        [_recentMethods addObject:_methodMenuItem.methodName];
        _methodView.recentItemNames = _recentMethods;
        [_methodView updateDisplay];
    }
    
    _touLbl.textColor = _beiLbl.textColor = Color(@"BetMethodTextColor");
    [_randomButton setTitleColor:Color(@"BetRandomTextColor") forState:UIControlStateNormal];
    _betView.backgroundColor = Color(@"BetViewBGColor");
    _footerView.backgroundColor = Color(@"BetFooterColor");
    _countLabel.textColor = Color(@"BetFooterCountColor");
    _balanceLabel.textColor = Color(@"BetFooterBalanceColor");
    _tipsLabel.textColor = Color(@"BetFooterBalanceColor");
    _multipleField.inputView = [NumberPad instance];
    _timerLabel.textColor = Color(@"BetMethodMaskColor");
    _basketButton.badge = 0;
    _basketButton.badgeOffset = CGPointMake(-15.f, 0.f);
//    //Launch timer
//    [self fireTimer:nil];
    MSNotificationCenterAddObserver(@selector(requestSimpleInitData), UIApplicationDidBecomeActiveNotification);
    //视频播放
    [self addVideoPlayButton];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addKeyboardObserver];
    [self updateBalance];
    
    _basketButton.badge = [[CDBetList count] integerValue];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.navigationController.navigationBar addGestureRecognizer:swipe];
    self.gesture = swipe;
    [swipe release];
    
    //Launch timer
    [self fireTimer:nil];
    [self showVideoPlayButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeKeyboardObserver];
    [self.navigationController.navigationBar removeGestureRecognizer:self.gesture];
    [self hiddenVideoPlayButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction:(id)sender{
    if ([[CDBetList count] integerValue] == 0){
        [super backAction:nil]; return;
    }
    NSString *msg = @"返回上层将清空已选号码,您确定返回吗?";
    MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil
                                                              message:msg
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"确定", nil];
    [alert show];
    [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
        if (index == 1){
            [super backAction:sender];
        }
    }];
}

- (void)prepareToBack{
    [CDBetList deleteAll];
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
        
        //[BetManager firstMenuItemModelForLottery:self.lotteryId channelId:_channelId];
        mid = [m.methodid integerValue];
        m = nil;
    }
    return mid;
}

- (NSInteger)currentMultiple{
    return MAX(1, [_multipleField.text integerValue]);
}

- (NSInteger)limitTimes{
    CGFloat limitTimes = 1;
    limitTimes = MAX(limitTimes, (self.methodMenuItem.limitBonus*1.f/self.methodMenuItem.methodPrice));
    if (self.methodMenuItem.methodPrice == 0.f){
        return 1;
    }
    if ([BetManager mode] == kModeJiao) {
        limitTimes *= 10;
    }
    Echo(@"LIMIT TIMES:%d limitBonus=%f methodPrice=%f",(int)limitTimes,self.methodMenuItem.limitBonus,self.methodMenuItem.methodPrice);
    return (NSInteger)limitTimes;
}


- (void)updateMethodId:(NSInteger)mid{
    Echo(@"new methodId %ld",(long)mid);
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    lot.lastMethodId = [NSNumber numberWithInteger:mid];
    [lot save];
    lot = nil;
}

- (void)updateBasketBadge{
    _basketButton.badge = [[CDBetList count] integerValue];
}

/* Update betting count and amount... */
- (void)updateCount{
    NSInteger betCount = [self.methodMenuItem betItemsUpdated];
    NSInteger multiple = [self currentMultiple];
    CGFloat amount = [BetManager amountWithBetCount:betCount multile:multiple mode:_mode];
    _countLabel.text = [NSString stringWithFormat:@"已选%ld注，%.02f元",(long)betCount,amount];
    _balanceLabel.text = [NSString stringWithFormat:@"可用余额 %@元",[SharedModel formattedBalance]];
    NSString *number = [self.methodMenuItem jointedNumbers];
    if ([self.methodMenuItem selectedNumberCount] > 0){
        //Show numbers and Add button
        _tipsLabel.text = [CDBetList numbersForShow:number lotteryId:_lotteryId channelId:_channelId];
        CGRect rect = _addButton.frame;
        rect.origin.x = 10.f;
        _addButton.frame = rect;
        rect = _countLabel.frame;
        rect.origin.x = 40.f; //_addButton.frame.origin.x + _addButton.frame.size.width;
        _countLabel.frame = rect;
        rect = _tipsLabel.frame;
        rect.origin.x = 40.f;   //_addButton.frame.origin.x + _addButton.frame.size.width;
        _tipsLabel.frame = rect;
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.adjustsFontSizeToFitWidth = NO;
        _footerBG.image = ResImage(@"basket-bg-gray.png");
        
    } else {
        _tipsLabel.text = self.methodMenuItem.tips;
        CGRect rect = _addButton.frame;
        rect.origin.x = -rect.size.width;
        _addButton.frame = rect;
        rect = _countLabel.frame;
        rect.origin.x = 10.f;
        _countLabel.frame = rect;
        rect = _tipsLabel.frame;
        rect.origin.x = 10.f;
        _tipsLabel.frame = rect;
        _tipsLabel.adjustsFontSizeToFitWidth = YES;
        _tipsLabel.textColor = Color(@"BetFooterBalanceColor");
        _footerBG.image = ResImage(@"basket-bg-black.png");
    }
}

- (void)reloadBetView{
    [self resetMultileValue];
    [_betView clear];
    CGFloat h = 0.f, w = _betView.bounds.size.width;
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
}

- (BOOL)addNumbersToBasket:(BOOL)checkTips{
    
    //检查球的数量
    if (![self.methodMenuItem isValidBet]) {
        if (checkTips)
            [HUDView showMessageToView:self.view msg:self.methodMenuItem.tips subtitle:nil];
        return NO;
    }
    
    //计算注数
    NSInteger betCount = [self.methodMenuItem betCount];
    //格式化选择的号码
    NSString *number = [self.methodMenuItem jointedNumbers];
//    number = [number stringByReplacingOccurrencesOfString:@"|" withString:@","];
    Echo(@"%@",number);
    
    //倍数和金额
    NSInteger mul = [self currentMultiple];
    CGFloat amount = [BetManager amountWithBetCount:betCount multile:mul mode:_mode];
    
    //余额判断
    if ([SharedModel shared].totalAmountInSelect + amount > [[SharedModel shared].balance floatValue]) {
        if (checkTips) {
            NSString *msg = @"您的余额不足";
            [HUDView showMessageToView:self.view msg:msg subtitle:nil];
            
        }
        return NO;
    }
    [SharedModel shared].totalAmountInSelect += amount;
    Echo(@"_totalAmountInSelect:%f",[SharedModel shared].totalAmountInSelect);
    
    //Add
    CDBetList *bet = [CDBetList new];
    bet.origNumberStr = number;
    //    bet.type = MSIntToStr([RQInitData lotteryId]);                  //彩种：default 1
    bet.lotteryId = [NSNumber numberWithInteger:self.lotteryId];
    bet.channelId = [NSNumber numberWithInteger:self.channelId];
    bet.methodId = [NSNumber numberWithInteger:self.methodMenuItem.methodId];          //玩法
    bet.betType = self.methodMenuItem.betType;          //投注类型
    bet.name = self.methodMenuItem.methodName;
    bet.userAccount = [SharedModel shared].username;        //user account
    bet.userId = [NSNumber numberWithInt:0];                    //user id
    bet.bid = [NSNumber numberWithInt:0];
    bet.number = number;                                                    //号码
    bet.count = [NSNumber numberWithInteger:betCount];      //注数，后台可以按公式计算出
    bet.amount = [NSNumber numberWithFloat:amount];    //[NSNumber numberWithInt:2*betCount];    //金额，后台可以计算出
    bet.multiple = MSIntegerToNumber(mul);
    bet.mode = MSIntToNumber(_mode);
    bet.desc = [NSString stringWithFormat:@"[%@]%@", self.methodMenuItem.methodName,[CDBetList numbersToDesc:number]];
    
    bet.limitbet = [NSNumber numberWithInteger:[self limitTimes]];
    
    Echo(@"name:%@,mid:%ld:%@",self.methodMenuItem.methodName, (long)self.methodMenuItem.methodId, [bet toDict]);
    [bet save];
    [bet release];
    
    //reset
    [self.methodMenuItem resetBet];
    [self reloadBetView];
    
    _currentBetCount = 0;
    _currentAmount = 0;

    [self updateCount];
    
    return YES;
    
}
//视频播放按钮
- (void)addVideoPlayButton{
    if([self.methodMenuItem.lotteryName isEqualToString:LLSSC]
       || [self.methodMenuItem.lotteryName isEqualToString:LL11X5]){
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(videoPlayAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor=[UIColor clearColor];
        button.tag=0x1234;
        CGRect rect = CGRectMake(240,0, 40, 40);
        [button setImage:ResImage(@"videoIcon.png") forState:UIControlStateNormal];
        button.imageEdgeInsets=UIEdgeInsetsMake(9, 13, 9, 5);
        button.frame = rect;
        [self.navigationController.navigationBar addSubview:button];
        
        NSString *str = [NSString stringWithFormat:@"LeLiGrilView%@",[CDUserInfo user].userid];
        if (![[NSUserDefaults standardUserDefaults]objectForKey:str]) {
            LeLiGrilView *leliV = [LeLiGrilView loadFromNib];
            [[AppDelegate shared].window addSubview:leliV];
        }
    }
}
-(void)showVideoPlayButton
{
    [self.navigationController.navigationBar viewWithTag:0x1234].hidden=NO;
}
-(void)hiddenVideoPlayButton
{
    [self.navigationController.navigationBar viewWithTag:0x1234].hidden=YES;
}
#pragma mark - Actions
//视频播放
- (IBAction)videoPlayAction:(id)sender
{
    if (![[Reachability reachabilityForInternetConnection] isReachableViaWiFi]) {
        VideoAlert *alrt = [VideoAlert loadFromNib];
        alrt.clickedBlock = ^(NSInteger index){
            [self playVideo];
        };
        [self.view addSubview:alrt];
    }else {
        [self playVideo];
    }
    
    //Flurry Event
    if([self.methodMenuItem.lotteryName isEqualToString:LL11X5])
    {FLEvent(kFLEventLL11x5Video);}
    
}
-(void)playVideo
{
    CDLottery *lot = [CDLottery findLotteryById:_lotteryId andChannelId:_channelId];
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:lot.rtmpUrl parameters:nil];
    //    NSString *rtmpStr = @"rtmp://192.168.1.102/live/huoying";
    //    NSString *rtmpStr = @"rtmp://aragontvlivefs.fplive.net/aragontvlive-live/stream_normal_abt";
    //    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:@"rtsp://184.72.239.149/vod/mp4:BigBuckBunny_115k.mov"  parameters:nil];
    
    [self presentViewController:vc animated:YES completion:nil];
    FLEvent(kFLEventLollyVideo);
}
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
    
    /*
    if (!_historyView){
        _historyView = [HistoryView loadFromNib];
        _historyView.frame = CGRectMake(0, -_historyView.frame.size.height,
                                        _historyView.frame.size.width, _historyView.frame.size.height);
        [self.view addSubview:_historyView];
    }
    NSArray *items = [RQPublicHistory pastIssueList:self.channelId lotteryId:self.lotteryId];
    if (items){
        _historyView.issueItems = items;
        [self openHistory];
        
    } else {
        HUDShowLoading(kStringLoading, nil);
        RQPublicHistory *req = [[RQPublicHistory alloc] init];
        req.lotteryId = self.lotteryId;
        req.lowgame = self.channelId == kChannelLow;
        [req startPostWithBlock:^(id rq_, NSError *error_, id rqSender_) {
            HUDHide();
            _historyView.issueItems = items;
            [self openHistory];
            [rq_ release];
        } sender:nil];
    }
    */
}

- (IBAction)addToBasket:(id)sender{
    if([self addNumbersToBasket:YES]){
        [self resetMultileValue];
        [self updateBasketBadge];
        [self updateCount];
    }
}

- (IBAction)gotoBasket:(id)sender{
    NSInteger ballCount = 0;
    for (BetItem *item in self.methodMenuItem.betItems){
        ballCount += item.selectedBallCount;
    }
    //有选号时要判断添加
    if (ballCount > 0){
        if (![self addNumbersToBasket:YES]) return;
    }
    
    if ([[CDBetList count] integerValue] > 0){
        CDBetList *bet = [[CDBetList all] lastObject];
        BasketViewController *vc = [[NSClassFromString(@"BasketViewController") alloc] init];
        vc.lotteryId = self.lotteryId;
        vc.channelId = self.channelId;
        vc.currentMethodName = self.methodMenuItem.methodName;
        vc.inputedMultiple = [bet.multiple integerValue];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
}

- (IBAction)randomBetting:(id)sender{
    [self.methodMenuItem random1];
}

- (IBAction)switchMethodPanel:(id)sender{
    _methodView.selectedMethodName = self.methodMenuItem.methodName;
    [_methodView togglePanel];
}

- (void)onMethodItemClick:(NSString *)methodName view:(MethodView *)methodView{
    Echo(@"%@",methodName);
    MethodMenuItem *curItem = [MethodMenuItem itemFromMethodName:methodName lottery:self.lotteryId channelId:self.channelId];
    if ([self lastMethodId] != curItem.methodId){
        [methodView commit];
        
        //Reload for new play method
        self.methodMenuItem = curItem;
        self.methodMenuItem.delegate = self;
        
        [self updateMethodId:self.methodMenuItem.methodId];
        [self reloadBetView];
        
        //Update recents
        if (methodView != _methodView){
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

#pragma mark - Keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    //非数字
    NSRange range = [textField.text rangeOfString:@"[^\\d]" options:NSRegularExpressionSearch];
    if (range.length > 0) {
        textField.text = [textField.text substringToIndex:range.location];
    }
    
    //限制倍数
    NSInteger limitTimes = [self limitTimes];
    NSInteger multiple = [self currentMultiple];
    if (multiple > limitTimes) {
        [HUDView showMessageToView:self.view msg:@"超出奖金限额" subtitle:nil];
        textField.text = [NSString stringWithFormat:@"%ld",(long)limitTimes];
    } else {
        textField.text = [@(multiple) stringValue];
    }

    [self updateCount];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%@",NSStringFromRange(range));
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if ([textField.text isEqualToString:@"1"]) {
//        textField.text = nil;
//    }
    [textField selectAll:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text length] == 0) {
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
    [self randomBetting:nil];
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Vibrate~");
#else
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
#endif
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
