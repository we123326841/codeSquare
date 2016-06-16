//
//  FundsViewController.m
//  Caipiao
//
//  Created by CYRUS on 14-7-29.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "FundsViewController.h"
#import "FundsSlideVC.h"
#import "RQUserPoint.h"
#import "RQWithdrawCash.h"

@interface FundsViewController ()

@property (strong, nonatomic) FundsSlideVC *vc1;
@property (strong, nonatomic) FundsSlideVC *vc2;
@property (strong, nonatomic) FundsSlideVC *vc3;
@property (strong, nonatomic) FundsSlideVC *vc4;

@end

@implementation FundsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_userPointDict release];
    [_pageControl release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"账户明细";
    // Do any additional setup after loading the view from its nib.
    _wrapView.clipsToBounds = YES;
    _userPointDict = [[NSMutableDictionary alloc] init];
    _isLowGame = NO;
    
    if (IOS7){
        _wrapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 0);
    } else {
        _wrapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    for (int i = 1; i <= 3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
        [btn addTarget:self action:@selector(onSegBarClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self buildSlideView];
    
    CGRect pcRect = CGRectMake(_wrapView.bounds.size.width/2-60/2, _wrapView.bounds.size.height-40, 60, 20);
    _pageControl = [[PageControl alloc] initWithFrame:pcRect
                                          normalImage:ResImage(@"page_normal.png")
                                         currentImage:ResImage(@"page_current.png")];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = 4;
    [_wrapView addSubview:_pageControl];
    
    {
        self.view.backgroundColor = [UIColor blackColor];
//        [_highButton setTitleColor:Color(@"FundsViewHeaderColor") forState:UIControlStateNormal];
//        [_highButton setTitleColor:Color(@"FundsViewHeaderSelectedColor") forState:UIControlStateSelected];
//        [_lowButton setTitleColor:Color(@"FundsViewHeaderColor") forState:UIControlStateNormal];
//        [_lowButton setTitleColor:Color(@"FundsViewHeaderSelectedColor") forState:UIControlStateSelected];
//        _yesterdayBetTagLbl.textColor = Color(@"FundsViewAmountTagColor");
//        _yesterdayWinTagLbl.textColor = Color(@"FundsViewAmountTagColor");
//        _balanceTagLbl.textColor = Color(@"FundsViewAmountTagColor");
//        _yesterdayBetLbl.textColor = Color(@"FundsViewAmountColor");
//        _yesterdayWinLbl.textColor = Color(@"FundsViewAmountColor");
//        _balanceLbl.textColor = Color(@"FundsViewAmountColor");
//        
//        _availBalanceL.textColor = Color(@"FundsViewAmountColor");
//        _availCashBalanceL.textColor = Color(@"FundsViewAmountColor");
//        _availBalanceTagL.textColor = RGBAi(207,207,207,255);
//        _availCashBalanceTagL.textColor = RGBAi(207,207,207,255);
    }
    
    [self loadData];
    
    if(_isFromRecharge)
    {
        [_slideView selectNameButton:_slideView.nameBtns[2]];
    }

}

- (IBAction)backAction:(id)sender{
    [[AppDelegate shared].nav popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildSlideView
{    
    _vc1 = [[FundsSlideVC alloc] initWithNibName:@"FundsSlideVC" bundle:nil];
    _vc1.title = @"所有类型";
    _vc1.type = @"";
    _vc2 = [[FundsSlideVC alloc] initWithNibName:@"FundsSlideVC" bundle:nil];
//    _vc2.title = @"加入游戏";
    _vc2.title = @"奖金派送";
    _vc2.type = @"PDXX";
    _vc3 = [[FundsSlideVC alloc] initWithNibName:@"FundsSlideVC" bundle:nil];
//    _vc3.title = @"频道转入";
    _vc3.title = @"充值";
    _vc3.type = @"ADAL";
    _vc4 = [[FundsSlideVC alloc] initWithNibName:@"FundsSlideVC" bundle:nil];
//    _vc4.title = @"奖金派送";
    _vc4.title = @"提现";
    _vc4.type = @"CWCS";
    
    _slideView.tabItemNormalColor = Color(@"FundsViewSlideTabColor");
    _slideView.tabItemSelectedColor = Color(@"FundsViewSlideTabSelectedColor");
    _slideView.indicatorImage = ResImage(@"myaccount_underline.png");
    _slideView.tabBackgroundImage = ResImage(@"myaccount_mid_bg.png");
    _slideView.slideSwitchViewDelegate = self;
    [_slideView buildUI];
    
//    CGRect frame =  [_slideView.topScrollView viewWithTag:102].frame;
//    CGFloat width = [_slideView.topScrollView viewWithTag:100].frame.size.width;
//    frame.size.width = width;
//    [_slideView.topScrollView viewWithTag:102].frame = frame;
//    
//    CGRect frame2 =  [_slideView.topScrollView viewWithTag:103].frame;
//    frame2.size.width = width;
//     frame2.origin.x = CGRectGetMaxX([_slideView.topScrollView viewWithTag:102].frame)+16;
//    [_slideView.topScrollView viewWithTag:103].frame = frame2;
    
    for (UIButton *btn in _slideView.nameBtns) {
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    
}

- (void)loadData
{
    RQGetBalance *rqBalance = [[[RQGetBalance alloc] init] autorelease];
    [rqBalance startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQGetBalance *rq = (RQGetBalance *)rq_;
        if (!rq_.msgContent && !error_) {

            [self.userPointDict setObject:[SharedModel formatBalance:rq.bankBalance]
                                   forKey:UPBankAmount];
//            [self.userPointDict setObject:[SharedModel formatBalance:rq.highBalance]
//                                   forKey:UPHighAmount];
//            [self.userPointDict setObject:[SharedModel formatBalance:rq.lowBalance]
//                                   forKey:UPLowAmount];
            
//            [SharedModel shared].lowBalance = rq.lowBalance;
        }
        
//        RQUserPoint *rqUserPoint = [[[RQUserPoint alloc] init] autorelease];
//        [rqUserPoint startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
//            
//            RQUserPoint *rq = (RQUserPoint *)rq_;
//            if (!rq_.msgContent && !error_) {
//                
//                for (NSString *key in rq.userPointDict) {
//                    [self.userPointDict setObject:[rq.userPointDict objectForKey:key] forKey:key];
//                }
        
//                if (!_isLowGame) {
//                    _yesterdayBetLbl.text = [_userPointDict objectForKey:UPHighYesterdayBetting];
//                    _yesterdayBetTagLbl.text = @"高频昨日投注";
//                    _yesterdayWinLbl.text = [_userPointDict objectForKey:UPHighYesterdayReward];
//                    _yesterdayWinTagLbl.text = @"高频昨日中奖";
//                    _balanceLbl.text = [_userPointDict objectForKey:UPHighAmount];
//                    _availBalanceL.text = [_userPointDict objectForKey:UPBankAmount];
//                    if ([[FundsViewController valueForFormatBalance:_availBalanceL.text] floatValue] >= 20000) {
//                        _availCashBalanceL.text = [SharedModel formatBalance:@"20000"];
//                    }else _availCashBalanceL.text = _availBalanceL.text;
//                    _balanceTagLbl.text = @"高频余额";
//                }else {
//                    _yesterdayBetLbl.text = [_userPointDict objectForKey:UPLowYesterdayBetting];
//                    _yesterdayBetTagLbl.text = @"低频昨日投注";
//                    _yesterdayWinLbl.text = [_userPointDict objectForKey:UPLowYesterdayReward];
//                    _yesterdayWinTagLbl.text = @"低频昨日中奖";
//                    _balanceLbl.text = [_userPointDict objectForKey:UPLowAmount];
//                    _balanceTagLbl.text = @"低频余额";
//                }
//            }
//            
//        } sender:nil];
//        
    } sender:nil];
    
    
//    RQWithdrawCashInit *rqcashInit = [[RQWithdrawCashInit alloc] init];
//    [rqcashInit startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
//        
//        RQWithdrawCashInit *withdrawInit = (RQWithdrawCashInit *)rq_;
//        _availBalanceL.text = [NSString stringWithFormat:@"%.2f",withdrawInit.availableBalance];
//        if (rq_.msgContent &&withdrawInit.availableBalance==0) {
//            _availBalanceL.text = [SharedModel formatBalance:[[CDUserInfo user] balance]];
//        }
//        _availCashBalanceL.text = [NSString stringWithFormat:@"%.2f",withdrawInit.maxWithdrawMoney
//                               ];
//    } sender:nil];
}
+(NSString*)valueForFormatBalance:(NSString*)balance
{
    NSArray *units = [balance componentsSeparatedByString:@","];
    NSString *balStr = @"";
    for (NSString *unit in units) {
            balStr = [balStr stringByAppendingString:(NSString *)unit];
    }
    return balStr;
}
- (IBAction)backActionCustom:(id)sender
{
    [self backAction:nil];
}

////高低频切换
//- (void)onSegBarClick:(UIButton *)sender
//{
//    [UIView animateWithDuration:0.15f animations:^{
//        _indicator.center = CGPointMake(sender.center.x, _indicator.center.y);
//    }];
//    switch (sender.tag) {
//        case 1: //高频
//        {
//            _isLowGame = NO;
//            _yesterdayBetLbl.text = [_userPointDict objectForKey:UPHighYesterdayBetting];
//            _yesterdayBetTagLbl.text = @"高频昨日投注";
//            _yesterdayWinLbl.text = [_userPointDict objectForKey:UPHighYesterdayReward];
//            _yesterdayWinTagLbl.text = @"高频昨日中奖";
//            _balanceLbl.text = [_userPointDict objectForKey:UPHighAmount];
//            _balanceTagLbl.text = @"高频余额";
//            _highButton.selected = YES;
//            _lowButton.selected = NO;
//        }
//            break;
//        case 2: //低频
//        {
//            _isLowGame = YES;
//            _yesterdayBetLbl.text = [_userPointDict objectForKey:UPLowYesterdayBetting];
//            _yesterdayBetTagLbl.text = @"低频昨日投注";
//            _yesterdayWinLbl.text = [_userPointDict objectForKey:UPLowYesterdayReward];
//            _yesterdayWinTagLbl.text = @"低频昨日中奖";
//            _balanceLbl.text = [_userPointDict objectForKey:UPLowAmount];
//            _balanceTagLbl.text = @"低频余额";
//            _highButton.selected = NO;
//            _lowButton.selected = YES;
//        }
//            break;
//        default:
//            break;
//    }
//    FundsSlideVC *vc = [_slideView.viewArray objectAtIndex:_slideView.selectedIndex];
//    vc.isLowGame = _isLowGame;
//    [vc startLoading];
//}

#pragma mark - SlideSwitchViewDelegate

- (NSUInteger)numberOfTab:(SlideSwitchView *)view
{
    return 4;
}

- (UIViewController *)slideSwitchView:(SlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0)  return _vc1;
    else if (number == 1) return _vc2;
    else if (number == 2) return _vc3;
    else if (number == 3) return _vc4;
    else return nil;
}

- (void)slideSwitchView:(SlideSwitchView *)view didSelectTab:(NSUInteger)number
{
    if (number == 0) {
        _vc1.isLowGame = _isLowGame;
        [_vc1 startLoading];
    }
    else if (number == 1) {
        _vc2.isLowGame = _isLowGame;
        [_vc2 startLoading];
    }
    else if (number == 2) {
        _vc3.isLowGame = _isLowGame;
        [_vc3 startLoading];
    }
    else if (number == 3) {
        _vc4.isLowGame = _isLowGame;
        [_vc4 startLoading];
    }
    _pageControl.currentIndex = number;
}

@end
