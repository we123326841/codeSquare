//
//  HomeViewController.m
//  Caipiao
//
//  Created by danal-rich on 7/17/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "HomeViewController.h"
#import "LotteryCustomController.h"
#import "HallViewController.h"
#import "BetLowViewController.h"
#import "BetHighViewController.h"
#import "JSKSViewController.h"
#import "OpenBallView.h"

#import "RQGetAdInfo.h"
#import "RQUserPoint.h"
#import "RQPublicHistory.h"
#import "TransferNoti.h"
#import "TransferAlert.h"
#import "SecurityPwdInputViewController.h"
#import "OldFundViewController.h"
#import "RQVersion.h"

@interface HomeViewController ()<HotLotViewDelegate>
@property (assign, nonatomic) IBOutlet UIScrollView *scroll;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_panelOpened){
        [self openPanel:nil];
    }
    [self getAdInfo];
    [RQVersion checkVersion];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self resizeTofitScreen];
    [self addFakeBar];
    _wrapView.clipsToBounds = YES;
    
    for (UILabel *lbl in _labels){
        lbl.textColor = Color(@"HomeTextColor");
    }
    for (UILabel *lbl in _lightLabels){
        lbl.textColor = Color(@"HomeLightTextColor");
    }
    [_customButton setTitleColor:Color(@"HomeLightTextColor") forState:UIControlStateNormal];
    
    _hotView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _hotView.layer.shadowOpacity = 0.1;
    _hotView.layer.shadowRadius = 1.;
    _hotView.layer.shadowOffset = CGSizeMake(0, -1);
    
    _openView.backgroundColor = RGBAi(241, 241, 241, 255);
    
    //GallaryView fix
    _scroll.contentSize = CGSizeMake(320.f, 500.f);
    if (IOS7){
        _scroll.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 49);
    } else {
        _scroll.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 49);
    }
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:_gallaryView.bounds];
    scroll.backgroundColor = [UIColor clearColor];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.delegate = _gallaryView;
    [_gallaryView addSubview:scroll];
    [scroll release];
    _gallaryView.scroll = scroll;
    [_gallaryView addSubview:_gallaryView.pageControl];

    _gallaryView.items = @[
                           [MSGallaryItem itemWithImage:ResImage(@"ad-placeholder.png") url:nil jumpLink:nil]
                           ];
    [_gallaryView update];
    [_gallaryView addTarget:self action:@selector(onGallaryViewClick:) forControlEvents:UIControlEventTouchUpInside];

    //Lastest Open
    __block __weak HomeViewController *self_ = self;
    [self_ updateLastOpen:[RQPublicHistory lastOpenIssue]];
    CDLottery *lastLot = [CDLottery findLotteryByName:[CDUserInfo user].lastLotteryName];
    RQPublicHistory *req = [[[RQPublicHistory alloc] init] autorelease];
    req.lotteryId = lastLot.lotteryId.integerValue;
    req.lowgame = lastLot.channelid.integerValue == kChannelLow;
    [req startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQPublicHistory *q = (id)rq_;
        IssueItem *item = [q.issueList firstObject];
        [self_ updateLastOpen:item];
        [RQPublicHistory saveLastOpenIssue:item];
    } sender:nil];
    
    
    //Hot Lotteries
    _hotLotView.hotLotterys = [CDHotLottery allSorted];
    _hotLotView.delegate = self;
    [_hotLotView update];
    
    //User points
    _msgButton.badge = [[CDUserInfo user].unread integerValue];
    _msgButton.badgeOffset = CGPointMake(-20, -5);
    _nameLbl.text = [CDUserInfo user].nickname;
    
    RQUserPoint *up = [[RQUserPoint alloc] init];
    [up startPostWithBlock:^(RQUserPoint *rq_, NSError *error_, id rqSender_) {
        if (rq_.userPointDict){
            CGFloat reward = [rq_.userPointDict floatForKey:@"win"];
            _rewardLbl.text = [SharedModel formatBalancef:reward];
            
//            CGFloat amount = [rq_.userPointDict floatForKey:UPBankAmount] + [rq_.userPointDict floatForKey:UPLowAmount] + [rq_.userPointDict floatForKey:UPHighAmount];
//            _balanceLbl.text = [SharedModel formatBalancef:amount];
        }
        [rq_ release];
    } sender:nil];
    
    MSNotificationCenterAddObserver(@selector(onHotLotterysUpdates:), kNotificationHotLotterysUpdates);
    MSNotificationCenterAddObserver(@selector(onUserInfoUpdates:), kNotificationUserInfoUpdated);
    MSNotificationCenterAddObserver(@selector(updateLotteryNewInfo:), kHomeViewControllerNewInfo);
    
    NSString *loginCount = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"loginCount%@",[CDUserInfo user].userid]];
    [[NSUserDefaults standardUserDefaults]setObject:@([loginCount integerValue]+1) forKey:[NSString stringWithFormat:@"loginCount%@",[CDUserInfo user].userid]];
    [[NSUserDefaults standardUserDefaults]synchronize];
//  隐藏  资金转移  2015-05-18
//    [self addNotiView];
    
    [self addBtnDot];
    
}
-(void)getAdInfo
{
    if ([RQGetAdInfo needRequestAdinfoAgain])
    {
        //ADs
        RQGetAdInfo *ad = [[RQGetAdInfo alloc] init];
        [ad startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            RQGetAdInfo *q = (id)rq_;
            if ([q.dataList count] > 0){
                NSMutableArray *items = [[NSMutableArray alloc] init];
                for (AdInfoModel *one in q.dataList){
                    MSGallaryItem *item = [[MSGallaryItem alloc] init];
                    item.image = ResImage(@"ad-placeholder.png");
                    item.imageUrl = one.imageUrl;
                    item.jumpLink = one.jumpUrl;
                    [items addObject:item];
                    [item release];
                }
                _gallaryView.items = items;
                [_gallaryView update];
                [items release];
            }
            
            [ad release];
        } sender:nil];
        [RQGetAdInfo saveCurrentRequestTime];
    }
}
-(void)addNotiView
{
    if ([[[CDUserInfo user] source] floatValue]==3.0) {
    NSString *loginCount = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"loginCount%@",[CDUserInfo user].userid]];
    if ([loginCount integerValue]==1)
    {
        UIImageView *bg = [[UIImageView alloc]initWithFrame:self.view.bounds];
        bg.image = [UIImage imageNamed:@"Resources.bundle/blacktransparent.png"];
        bg.userInteractionEnabled=YES;
        [self.view addSubview:bg];
        [bg release];
        
        TransferNoti *tranview = [TransferNoti loadFromNib];
        CGRect frame = tranview.frame;
        frame.origin.x = 10;
        frame.origin.y = (self.view.frame.size.height-tranview.frame.size.height)/2.0;
        tranview.frame = frame;
        __block HomeViewController *blockself = self;
        [tranview setClickedBlock:^(NSInteger index) {
            if (index==0) {

                [tranview removeFromSuperview];
                [bg removeFromSuperview];
                SecurityPwdInputViewController *vc = [[SecurityPwdInputViewController alloc] init];
                vc.isOldB=YES;
                [vc setViewDidLoadBlock:^(SecurityPwdInputViewController *c) {
                    c.title = @"查看资金";
                    c.pwdField.placeholder = @"输入旧版安全密码";
                }];
                [vc setCompleteBlock:^(SecurityPwdInputViewController *c, bool success) {
                    OldFundViewController *fund = [[OldFundViewController alloc] init];
                    fund.fundpwd=c.pwdField.text;
                    [c.navigationController pushViewController:fund animated:YES];
                    [fund release];
                }];
                UINavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
                 [[AppDelegate shared].nav pushNavigationController:nav animated:YES];
                [vc release];
                [nav  release];
            }else
            {
                [tranview removeFromSuperview];
                TransferAlert *tranview = [TransferAlert loadFromNib];
                CGRect frame = tranview.frame;
                frame.origin.x = 10;
                frame.origin.y = (blockself.view.frame.size.height-tranview.frame.size.height)/2.0;
                tranview.frame = frame;
                [tranview setClickedBlock:^() {
                        [tranview removeFromSuperview];
                    [bg removeFromSuperview];
                }];
                [bg addSubview:tranview];
            }
        }];
        [bg addSubview:tranview];
    }
  
  }
}
- (void)viewDidUnload{
    [super viewDidUnload];
    MSNotificationCenterRemoveObserver();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)customLottery:(id)sender{
    [self removeBtnDot];
    BaseViewController *vc = [NSClassFromString(@"LotteryCustomController") new];
    vc.modal = YES;
    UINavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:NULL];
    [vc release];
    [nav release];
}

- (void)updateLastOpen:(IssueItem *)item{
    if (item == nil) return;

    [[_openBallView viewWithTag:100] removeFromSuperview];
    _openIssueLbl.text = [NSString stringWithFormat:@"%@ 第%@期",item.lotteryName,item.issueNumber];
    _openBallView.lotteryName = item.lotteryName;
    if ([_openBallView.lotteryName rangeOfString:@"双色球"].location != NSNotFound) {
        _openBallView.isShuangSeQiu=YES;
    }else
        _openBallView.isShuangSeQiu=NO;
    
    [_openBallView updateCodes:item.number];
}

- (IBAction)gotoBet:(id)sender{
    IssueItem *item = [RQPublicHistory lastOpenIssue];
    CDLottery *lot = [CDLottery findLotteryById:item.lotteryId andChannelId:item.channelid];
    if (lot){
        [HallViewController checkLotteryStateIn:self lottery:lot];
        FLEvent(kFLEventGotoBet);
    }
}

- (IBAction)onGallaryViewClick:(MSGallaryView *)sender{
    Echo(@"%ld",(long)sender.clickedItemIndex);
    MSGallaryItem *item = sender.items[sender.clickedItemIndex];
    if (item && [item.jumpLink length] != 0) {
        MSWebViewController *web = [[MSWebViewController alloc] init];
        web.title = @"活动";
        web.url = item.jumpLink;
        UINavigationController *nav = [NavigationController new:web];
        [[AppDelegate shared].nav pushNavigationController:nav animated:YES];
        [nav release];
        [web release];
        FLEvent(kFLEventADClick);
    }
}

- (IBAction)openPanel:(UIButton *)sender{
    if (!_userPanel.superview){
        [_wrapView insertSubview:_userPanel belowSubview:sender];
    }
    if (_panelOpened){
        UIView *mask = [_wrapView viewWithTag:0x1000];
        [UIView animateWithDuration:.2f animations:^{
            _userPanel.frame = CGRectMake(0, -_userPanel.bounds.size.height-10, _userPanel.bounds.size.width, _userPanel.bounds.size.height);
            mask.alpha = 0.f;
        } completion:^(BOOL finished) {
            [mask removeFromSuperview];
        }];
        
    } else {
        FLEvent(kFLEventShortcuts);
        _nameLbl.textColor =
        _rewardLbl.textColor =
        _balanceLbl.textColor = Color(@"HomeTextColor");
        _userPanel.backgroundColor = Color(@"ViewBGColor");
        
        _balanceLbl.text = [SharedModel formatBalance:[SharedModel shared].balance];
        
        UIControl *mask = [[UIControl alloc] initWithFrame:_wrapView.bounds];
        mask.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7f];
        mask.userInteractionEnabled = YES;
        mask.alpha = 0.f;
        mask.tag = 0x1000;
        [mask addTarget:self action:@selector(onMaskClick) forControlEvents:UIControlEventTouchUpInside];
        [_wrapView insertSubview:mask belowSubview:_userPanel];
        [mask release];
        _userPanel.frame = CGRectMake(0, -_userPanel.bounds.size.height-10, _userPanel.bounds.size.width, _userPanel.bounds.size.height);
        [UIView animateWithDuration:.2f animations:^{
            _userPanel.frame = CGRectMake(0, 0, _userPanel.bounds.size.width, _userPanel.bounds.size.height);
            mask.alpha = 1.f;
        } completion:^(BOOL finished) {
        }];
    }
    _panelOpened = !_panelOpened;
    [_menuButton setImage:_panelOpened ? ResImage(@"home-nav-close") : ResImage(@"home-nav") forState:UIControlStateNormal];
    
    CDUserInfo *u = [CDUserInfo user];
    if ([u.isvip intValue]==1) _vipIcon.hidden=NO;
    else _vipIcon.hidden=YES;

}

- (void)onMaskClick{
    [self openPanel:nil];
}

-(void)addBtnDot
{
    NSString *str = [NSString stringWithFormat:@"CustomButtonDot%@",[CDUserInfo user].userid];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:str])
    {
        UIView *dot = [[ UIView alloc]initWithFrame:CGRectMake(50,2,8,8)];
        dot.layer.borderColor=[UIColor whiteColor].CGColor;
        dot.layer.borderWidth=2;
        dot.layer.cornerRadius=4;
        dot.backgroundColor = RGBAi(244,90,74, 255);
        dot.tag = 0x9999;
        [_customButton addSubview:dot];
        [dot release];
    }
}
-(void)removeBtnDot
{
    NSString *str = [NSString stringWithFormat:@"CustomButtonDot%@",[CDUserInfo user].userid];
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:str];
    UIView *v = [_customButton viewWithTag:0x9999];
    [v removeFromSuperview];
}

#pragma mark - 快捷菜单
- (IBAction)panelButtonClick:(UIButton *)sender{
    [self openPanel:nil];
    switch (sender.tag) {
        case 0: //充值
        {
            UIViewController *vc = [[NSClassFromString(@"RechargeViewController") alloc] initWithNibName:@"RechargeViewController" bundle:nil];
            [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
            [vc release];
        }
            break;
        case 1: //提现
        {
            UIViewController *vc = [[NSClassFromString(@"WithdrawCashVC") alloc] initWithNibName:@"WithdrawCashVC" bundle:nil];
            [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
            [vc release];
        }
            break;
        case 2: //记录
        {
            MSTabBarController *tab = (id)self.tabBarController;
            [tab setTabSelectedIndex:3];
        }
            break;
        case 3: //消息
        {
            UIViewController *vc = [[NSClassFromString(@"InfoCenterViewController") alloc] init];
            UINavigationController *nav = [NavigationController new:vc];
            [self.navi pushNavigationController:nav animated:YES];
            [nav release];
            [vc release];
        }
            break;
        default:
            break;
    }
}

- (void)onUserInfoUpdates:(NSNotification *)noti{
    _msgButton.badge = [[CDUserInfo user].unread integerValue];
    _nameLbl.text = [CDUserInfo user].nickname;
    _balanceLbl.text = [SharedModel formattedBalance];
    
}
- (void)updateLotteryNewInfo:(NSNotification *)noti{
    //Lastest Open
    __block __weak HomeViewController *self_ = self;
    [self_ updateLastOpen:[RQPublicHistory lastOpenIssue]];
    CDLottery *lastLot = [CDLottery findLotteryByName:[CDUserInfo user].lastLotteryName];
    RQPublicHistory *req = [[[RQPublicHistory alloc] init] autorelease];
    req.lotteryId = lastLot.lotteryId.integerValue;
    req.lowgame = lastLot.channelid.integerValue == kChannelLow;
    [req startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQPublicHistory *q = (id)rq_;
        IssueItem *item = [q.issueList firstObject];
        [self_ updateLastOpen:item];
        [RQPublicHistory saveLastOpenIssue:item];
    } sender:nil];
    }

#pragma mark - 热门彩种
- (void)onHotLotterysUpdates:(NSNotification *)noti{
    _hotLotView.hotLotterys = [CDHotLottery allSorted];
    [_hotLotView update];
}

- (void)onHotLotViewGridClick:(HotLotView *)view atIndex:(NSInteger)index{
    if (index == [view plusGridIndex]){
        [self customLottery:nil];
    } else {
        
        if ([CDUserInfo user].userType.integerValue==1) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"总代不能投注" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
        
        //goto bet
        CDHotLottery *hot = view.hotLotterys[index];
        CDLottery *lot = [CDLottery findLotteryById:hot.lotteryId.integerValue andChannelId:hot.channelid.integerValue];
        
        
        
        
        if ([lot.channelid integerValue] == 4 && [lot.lotteryId intValue] == 15) {
            MSWebViewController *web = [[MSWebViewController alloc] init];
            web.url = [NSString stringWithFormat:@"%@/slmmc/?%@", kAppUrl, [SharedModel shared].token];
            UINavigationController *nav = [NavigationController new:web];
            [[AppDelegate shared].nav pushNavigationController:nav animated:YES];
            web.navigationController.navigationBarHidden = YES;
            
            
            [nav release];
            [web release];
            
        }else{
        [HallViewController checkLotteryStateIn:self lottery:lot];
        }return;
        
        //For Debug
        UIViewController *vc = nil;
        if (lot.channelid.integerValue == kChannelHigh){
            if ([lot.name isEqualToString:JSK3]) {
                JSKSViewController *hvc = [JSKSViewController new];
                hvc.lotteryId = lot.lotteryId.integerValue;
                hvc.channelId = lot.channelid.integerValue;
                vc = hvc;
                
            }else{
                BetHighViewController *hvc = [BetHighViewController new];
                hvc.lotteryId = lot.lotteryId.integerValue;
                hvc.channelId = lot.channelid.integerValue;
                vc = hvc;
            }
        } else {
            BetLowViewController *hvc = [BetLowViewController new];
            hvc.lotteryId = lot.lotteryId.integerValue;
            hvc.channelId = lot.channelid.integerValue;
            vc = hvc;
        }
        UINavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
        [[AppDelegate shared].nav pushNavigationController:nav animated:YES];
        [nav release];
        [vc release];
    }
}

@end



@implementation HotLotView

- (void)dealloc{
    self.hotLotterys = nil;
    [_grids release];
    [super dealloc];
}

- (void)update{
    NSInteger i = 0;
    for (i = 0; i < _hotLotterys.count; i++) {
        CDHotLottery *lot = (CDHotLottery *)_hotLotterys[i];
        LotteryCircle *butt =(LotteryCircle*) [self gridButtonAtIndex:i];
        butt.tag = i;
        butt.isNewLottery=lot.isNewLottery.boolValue;
        [butt setImage:ResImage(lot.logoHot) forState:UIControlStateNormal];
    }
    for (NSInteger j = i; j < _grids.count; j++) {
        UIButton *butt = _grids[j];
        [butt removeFromSuperview];
    }
    [_grids removeObjectsInRange:NSMakeRange(i, _grids.count-i)];
    
    //Plus
    if (i < 6){
        UIButton *butt = [self gridButtonAtIndex:i];
        butt.tag = [self plusGridIndex];
        [butt setImage:ResImage(@"plus") forState:UIControlStateNormal];
    }
}

- (UIButton *)gridButtonAtIndex:(NSInteger)index{
    CGFloat w = self.bounds.size.width/3;
    CGFloat h = self.bounds.size.height/2;
    LotteryCircle *butt = nil;
    if (index < _grids.count){  //reuse a exist one
        butt = [_grids objectAtIndex:index];
    } else {                    //create a new one
        butt = [LotteryCircle buttonWithType:UIButtonTypeCustom];
        butt.style = kLotteryCircleStyleDefault;
        [butt addTarget:self action:@selector(gridClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:butt];
        
        if (!_grids) _grids = [[NSMutableArray alloc] init];
        [_grids addObject:butt];
    }
    butt.frame = CGRectMake(index%3*w, index/3*h, w, h);
    return butt;
}

- (void)gridClick:(UIButton *)sender{
    if (_delegate){
        [_delegate onHotLotViewGridClick:self atIndex:sender.tag];
    }
}

- (NSInteger)plusGridIndex{
    return -1;
}
@end