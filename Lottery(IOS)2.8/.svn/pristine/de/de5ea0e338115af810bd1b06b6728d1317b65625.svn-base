//
//  MyAccountViewController.m
//  Caipiao
//
//  Created by CYRUS on 14-7-23.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MyAccountCell.h"
#import "RQGameHistory.h"
#import "RQZhuiHaoInfo.h"
#import "ZhuiHaoInfoVC.h"
#import "RCLabel.h"
#import "MyAccountRecordVC.h"
#import "PwdCreateSecPwdVC.h"
#import "SecuritySettingResultVC.h"
#import "SecurityIssuesVC.h"
#import "Defines.h"
#import "Musou.h"
#import "OpenAccountVC.h"
#import "OAGrilView.h"
#import "HMTableViewController.h"
typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
} ScrollDirection;

#define kContentY 190

@interface MyAccountViewController ()
@property (strong, nonatomic) MyAccountRecordVC *vc1;
@property (strong, nonatomic) MyAccountRecordVC *vc2;
@property (strong, nonatomic) MyAccountRecordVC *vc3;
@property (strong, nonatomic) MyAccountRecordVC *vc4;

@property (assign, nonatomic) DataType recordtype;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (assign, nonatomic) ScrollDirection scrollDirection;


@end

@implementation MyAccountViewController

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
    MSNotificationCenterRemoveObserver();

    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addFakeBar];
    _wrapView.clipsToBounds = YES;
    if (IOS7){
        _wrapView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20.f-49.f);
        
    } else {
        _wrapView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-49.f);
    }
     _contentView.frame = CGRectMake(0, kContentY, _wrapView.bounds.size.width, _wrapView.frame.size.height-kContentY);
    
    _nameLbl.text = [SharedModel shared].username;
    _scrollDirection = ScrollDirectionNone;
    
    _dataList = [[NSMutableArray alloc] init];
   
     _recordtype = kDataTypeGameHistory;
    [_recordMenu enable:YES];

    
    [self  buildSlideView];
    
    CGRect pcRect = CGRectMake(_wrapView.bounds.size.width/2-60/2, _wrapView.bounds.size.height-40, 60, 20);
    _pageControl = [[PageControl alloc] initWithFrame:pcRect
                                          normalImage:ResImage(@"page_normal.png")
                                         currentImage:ResImage(@"page_current.png")];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = 4;
    [_wrapView addSubview:_pageControl];
    
    {
        CGRect r = _recordMenu.arrow.frame;
        r.origin.x += 10;
        _recordMenu.arrow.frame = r;
        
        _recordMenu.layer.borderWidth = 0;
        _recordMenu.backgroundColor = [UIColor whiteColor];
        _recordMenu.delegate = self;
        _recordMenu.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_recordMenu.dataList addObjectsFromArray:@[@"投注记录", @"追号记录"]];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _recordMenu.bounds.size.width, _recordMenu.mainView.bounds.size.height)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = @"投注记录";
        lbl.font = [UIFont systemFontOfSize:13.f];
        [_recordMenu.mainView addSubview:lbl];
        [lbl release];
    }
    
    
    {
        _nameLbl.textColor = Color(@"MyAccountNameColor");
        [_historyButton setTitleColor:Color(@"MyAccountMidTextColor") forState:UIControlStateNormal];
        [_zhuiHaoButton setTitleColor:Color(@"MyAccountMidTextColor") forState:UIControlStateNormal];
//        [_fundsButton setTitleColor:Color(@"FundsViewAmountTagColor") forState:UIControlStateNormal];
    }
    
    MSNotificationCenterAddObserver(@selector(reqFinish:),kMyAccountRecordReqFinish);
  MSNotificationCenterAddObserver(@selector(removeSettingBtnDot),@"kMyAccountRemoveSettingDot");
    MSNotificationCenterAddObserver(@selector(removeDelegate:),kSettingViewControllerLoginOutNotification);


    NSString *str = [NSString stringWithFormat:@"MyAccountSettingDot%@",[CDUserInfo user].userid];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:str]&&[[[CDUserInfo user]source]floatValue]==3.0) {
         [self addSettingBtnDot];
    }
    
    if ([CDUserInfo user].userType.integerValue==0) {
       _fundsButton.hidden = YES;
    }
    else
    {
        _fundsButton.hidden=NO;
        [self addOAInfoView];
        
    }
}
-(void)addSettingBtnDot
{
    UIView *dot = [[ UIView alloc]initWithFrame:CGRectMake(308,30,8,8)];
    dot.layer.borderColor=[UIColor whiteColor].CGColor;
    dot.layer.borderWidth=2;
    dot.layer.cornerRadius=4;
    dot.backgroundColor = RGBAi(244,90,74, 255);
    dot.tag = 0x9999;
    [self.view addSubview:dot];
    [dot release];
}
- (void)addOAInfoView{
    
    NSString *str = [NSString stringWithFormat:@"OAGrilView%@",[CDUserInfo user].userid];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:str]) {
        OAGrilView *leliV = [OAGrilView loadFromNib];
        [[AppDelegate shared].window addSubview:leliV];
    }
}
-(void)removeSettingBtnDot
{
    UIView *v = [self.view viewWithTag:0x9999];
    [v removeFromSuperview];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _amountLbl.text = [NSString stringWithFormat:@"￥%@", [SharedModel formattedBalance]];
    
    MyAccountRecordVC *vc = [_slideView.viewArray objectAtIndex:_slideView.selectedIndex];
    vc.tableView.type = _recordtype;
    vc.tableView.subType = _slideView.selectedIndex;
    [vc.tableView startLoading];
    
    CDUserInfo *u = [CDUserInfo user];
    if ([u.isvip intValue]==1) {
        _isvipView.hidden=NO;
    }else
    {
      _isvipView.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)gotoInfoCenter:(id)sender{
    UIViewController *vc = [[NSClassFromString(@"InfoCenterViewController") alloc] init];
    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
    [vc release];
    
    //Flurry Event
    FLEvent(kFLEventUserMail);
}

- (IBAction)gotoSetting:(id)sender{
    UIViewController *vc = [[NSClassFromString(@"SettingViewController") alloc] init];
    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
    [vc release];
    
    //Flurry Event
    FLEvent(kFLEventSetting);
}

- (IBAction)gotoWithdraw:(id)sender
{
//    static NSString *str1 = @"123df2fffff";
//    if (![[NSUserDefaults standardUserDefaults]objectForKey:str1]) {
//        [CDUserInfo user].needSetSecurityPass=@(YES);
//        [[CDUserInfo user]save];
//        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:str1];
//    }
//    
//    static NSString *str = @"123frrfffff";
//    if (![[NSUserDefaults standardUserDefaults]objectForKey:str]) {
//        [CDUserInfo user].needSetSafeQuest=@(YES);
//        [[CDUserInfo user]save];
//        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:str];
//    }
    
    [self checkNeedSetSecurityPass];
}
-(void)gotoWithdrawView
{
    UIViewController *vc = [[NSClassFromString(@"WithdrawCashVC") alloc] initWithNibName:@"WithdrawCashVC" bundle:nil];
    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
    [vc release];
    FLEvent(kFLEventWithdraw);
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
        UINavigationController *navi = [[NavigationController new:pwdvc] autorelease];
        [[AppDelegate shared].nav pushNavigationController:navi animated:YES];
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
                vc2.type=ComeTypeCash;
                [vc.navigationController pushViewController:vc2 animated:YES];
                [vc2 release];
            }else{
                MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil message:@"放弃设置安全问题意味着放弃本次提现，您确定放弃？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
                    if (index == 1){
                        [ [AppDelegate shared].nav popToRootViewControllerAnimated:YES];
                    }
                }];
                [alert show];
            }
        };
        UINavigationController *navi = [[NavigationController new:vc] autorelease];
        [self.navigationController pushNavigationController:navi animated:YES];
        [vc release];
        return;
    }else{
        [self gotoWithdrawView];
    }
}
- (IBAction)gotoRecharge:(id)sender
{
    UIViewController *vc = [[NSClassFromString(@"RechargeViewController") alloc] initWithNibName:@"RechargeViewController" bundle:nil];
    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
    [vc release];
    FLEvent(kFLEventRecharge);
}

- (IBAction)gotoTransfer:(id)sender
{
    UIViewController *vc = [[NSClassFromString(@"TransferViewController") alloc] initWithNibName:@"TransferViewController" bundle:nil];
    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
    [vc release];
}
- (IBAction)gotoOpenAccount:(id)sender
{
    OpenAccountVC *vc = [[OpenAccountVC alloc]init];
    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
    [vc release];

}
- (IBAction)gotoFundsDetail:(id)sender
{
    UIViewController *vc = [[NSClassFromString(@"FundsViewController") alloc] initWithNibName:@"FundsViewController" bundle:nil];
    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
//    [[AppDelegate shared].nav pushViewController:vc animated:YES];
    [vc release];
    FLEvent(kFLEventFundDetail);
}

- (IBAction)selectGameHistory:(id)sender
{
//    [_historyMenu enable:YES];
//    [_zhuiHaoMenu enable:NO];
//    [_historyButton setBackgroundImage:ResImage(@"myaccount_tab.png") forState:UIControlStateNormal];
//    [_zhuiHaoButton setBackgroundImage:nil forState:UIControlStateNormal];
//    
//    _tableView.type = kDataTypeGameHistory;
//    _tableView.subType = _historyMenu.selectedIndex;
//    [_tableView startLoading];
}

- (IBAction)selectZhuiHao:(id)sender
{
//    [_historyMenu enable:NO];
//    [_zhuiHaoMenu enable:YES];
//    [_historyButton setBackgroundImage:nil forState:UIControlStateNormal];
//    [_zhuiHaoButton setBackgroundImage:ResImage(@"myaccount_tab.png") forState:UIControlStateNormal];
//    
//    _tableView.type = kDataTypeZhuiHao;
//    _tableView.subType = _zhuiHaoMenu.selectedIndex;
//    [_tableView startLoading];
}

#pragma mark - DropDownMenuDelegate

- (UITableViewCell *)dropDownMenu:(DropDownMenu *)menu cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MYACCOUNTCELL";
    UITableViewCell *cell = [menu.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = [menu.dataList objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.f];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)dropDownMenu:(DropDownMenu *)menu selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (UIView *view in [menu.mainView subviews]) {
        [view removeFromSuperview];
    }
    if (indexPath.row==0){
        _recordtype = kDataTypeGameHistory;
        _pageControl.numberOfPages=4;
    }else{
         _recordtype = kDataTypeZhuiHao;
        _pageControl.numberOfPages=4;
        }
    
      [self setSlideView];
    
    [self selectSlideItemAtIndex:0];
    MyAccountRecordVC *vc = [_slideView.viewArray objectAtIndex:0];
    [_dataList removeAllObjects];
    [self setSlideTableviewType];
    vc.tableView.subType = 0;
    [vc.tableView startLoading];
    
    NSString *text = [NSString stringWithFormat:@"%@", [_recordMenu.dataList objectAtIndex:indexPath.row]];
    RCLabel *lbl = [[RCLabel alloc] initWithFrame:CGRectMake(0, 10, _recordMenu.bounds.size.width, _recordMenu.mainView.bounds.size.height)];
    lbl.font = [UIFont systemFontOfSize:13.f];
    lbl.backgroundColor = [UIColor clearColor];
    RTLabelComponentsStructure *component = [RCLabel extractTextStyle:text];
    [lbl setTextAlignment:RTTextAlignmentCenter];
    [lbl setComponentsAndPlainText:component];
    [_recordMenu.mainView addSubview:lbl];
    [lbl release];
    
    NSLog(@"%@",_contentView.subviews);

}
-(void)setSlideView
{
    if (_slideView)
    {
        for (id obj in _slideView.viewArray) {
//            NSLog(@"%@",obj);
            if ([obj isKindOfClass:[MyAccountRecordVC class]]) {
                MyAccountRecordVC *vc = (MyAccountRecordVC*)obj;
                vc.tableView.rq.delegate=nil;
                vc.tableView.delegate=nil;
                vc.delegate = nil;
            }
        }
        [_slideView removeFromSuperview];
    }
    SlideSwitchView *s = [[[SlideSwitchView alloc]initWithFrame:_contentView.bounds]autorelease];
    [_contentView insertSubview:s belowSubview:_recordMenu];
    _slideView = s;
    
    [self buildSlideView];
}
- (void)buildSlideView
{
//    NSArray *betItems = @[@"全部",@"等待开奖",@"中奖",@"未中奖" ,@"撤销",@"存在异常",@"数据归档"];
//    NSArray *zhuihaoItems = @[@"全部", @"未开始", @"进行中", @"已结束",@"已终止",@"暂停",@"存在异常",@"执行中"];
    NSArray *betItems = @[@"全部",@"未开奖",@"已中奖",@"未中奖" ];
    NSArray *zhuihaoItems = @[@"全部", @"进行中", @"已结束",@"已终止"];//
    self.vc1 = [[[MyAccountRecordVC alloc] initWithNibName:@"MyAccountRecordVC" bundle:nil] autorelease];
    _vc1.title = @"全部";
    _vc1.delegate=self;
    
    self.vc2 = [[[MyAccountRecordVC alloc] initWithNibName:@"MyAccountRecordVC" bundle:nil] autorelease];
    _vc2.title = _recordtype==kDataTypeGameHistory?betItems[1]:zhuihaoItems[1];
    _vc2.delegate=self;

    self.vc3 = [[[MyAccountRecordVC alloc] initWithNibName:@"MyAccountRecordVC" bundle:nil] autorelease];
    _vc3.title = _recordtype==kDataTypeGameHistory?betItems[2]:zhuihaoItems[2];
    _vc3.delegate=self;

    self.vc4 = [[[MyAccountRecordVC alloc] initWithNibName:@"MyAccountRecordVC" bundle:nil] autorelease];
    _vc4.title = _recordtype==kDataTypeGameHistory?betItems[3]:zhuihaoItems[3];
    _vc4.delegate=self;
    
    
    _slideView.frame = _contentView.bounds;
    _slideView.tabItemNormalColor = Color(@"FundsViewSlideTabColor");
    _slideView.tabItemSelectedColor = Color(@"FundsViewSlideTabSelectedColor");
    _slideView.indicatorImage = ResImage(@"myaccount_underline.png");
//    _slideView.tabBackgroundImage = ResImage(@"myaccount_mid_bg.png");
    _slideView.slideSwitchViewDelegate = self;
    [_slideView buildUI];
    
    CGRect topF = _slideView.topScrollView.frame;
//    if (![_slideView viewWithTag:0x9999]) {
//        UIView *v = [[UIView alloc]initWithFrame:topF];
//        v.tag=0x9999;
//        v.backgroundColor=RGBAi(239, 239, 239, 255);
//        [_slideView insertSubview:v belowSubview:_slideView.topScrollView];
//        [v release];
//    }
    _slideView.topScrollView.backgroundColor = RGBAi(239, 239, 239, 255);
      topF.origin.x += 82;
    topF.size.width -= 82;
    _slideView.topScrollView.frame = topF;
    
    
    
    for (UIButton *btn in _slideView.nameBtns) {
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
}

#pragma mark - SlideSwitchViewDelegate

- (NSUInteger)numberOfTab:(SlideSwitchView *)view
{
    return _recordtype==kDataTypeGameHistory?4:4;
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
    if (_recordtype == kDataTypeGameHistory) {
        
         MyAccountRecordVC *vc = [_slideView.viewArray objectAtIndex:_slideView.selectedIndex];
        [vc.tableView.dataList removeAllObjects];
        
        if (number == 0)
        {
            [vc.tableView.dataList addObjectsFromArray:_dataList];
            
        }else if (number == 1)
        {
            for (GameRecord *gr in _dataList){
                if (gr.win == 1)  [vc.tableView.dataList addObject:gr];
            }
        }else if (number == 2)
        {
            for (GameRecord *gr in _dataList){
                if (gr.win == 2) [vc.tableView.dataList addObject:gr];
            }
        }else if (number == 3)
        {
            for (GameRecord *gr in _dataList){
                if (gr.win == 3) [vc.tableView.dataList addObject:gr];
            }
        }

        
        [vc.tableView reloadData];

    }else {
        MyAccountRecordVC *vc = [_slideView.viewArray objectAtIndex:_slideView.selectedIndex];

        [vc.tableView.dataList removeAllObjects];
        if (number == 0) {
            [vc.tableView.dataList addObjectsFromArray:_dataList];
        }else if (number == 1) {
            for (ZhuiHaoInfoItem *model in _dataList){
                if ([model.status intValue] == 1)  [vc.tableView.dataList addObject:model];
            }
        }else if (number == 2) {
            for (ZhuiHaoInfoItem *model in _dataList){
                if ([model.status intValue] == 2) [vc.tableView.dataList addObject:model];
            }
        }else if (number == 3) {
            for (ZhuiHaoInfoItem *model in _dataList){
                if ([model.status intValue] == 3) [vc.tableView.dataList addObject:model];
            }}

        [vc.tableView reloadData];
    }
    
    _pageControl.currentIndex = number;
}

-(void)setSlideTableviewType
{
    [_slideView.viewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MyAccountRecordVC *vc = (MyAccountRecordVC*)obj;
        vc.tableView.type = _recordtype;
    }];
}
-(void)selectSlideItemAtIndex:(NSUInteger)index
{
    if (index>=_slideView.nameBtns.count) return;
    
    [_slideView selectNameButton:_slideView.nameBtns[index]];
}
-(void)reqFinish:(NSNotification*)noti
{
    MyAccountRecordVC *vc = [_slideView.viewArray objectAtIndex:0];
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray: vc.tableView.dataList];
    
    [self slideSwitchView:_slideView didSelectTab:_slideView.selectedIndex];
}
-(void)removeDelegate:(NSNotification*)noti
{
    for (id obj in _slideView.viewArray) {
        if ([obj isKindOfClass:[MyAccountRecordVC class]]) {
            MyAccountRecordVC *vc = (MyAccountRecordVC*)obj;
            vc.tableView.rq.delegate=nil;
            vc.tableView.delegate=nil;
            vc.delegate = nil;
        }
    }
}
#pragma mark -- MyAccountTableviewDelegate
-(void)tableview:(MyAccountTableView*)table didScroll:(UIScrollView*)scroll
{

    CGFloat offsety = scroll.contentOffset.y;
    CGPoint t = [scroll.panGestureRecognizer translationInView:scroll];

    if (t.y < 0 && offsety > 5.f){  //drag up
        if (_scrollDirection != ScrollDirectionUp){
            _scrollDirection  = ScrollDirectionUp;
            [self adjustPosition:scroll];
        }
    } else if (t.y > 0 && offsety < 0.f){   //drag down
        if (_scrollDirection != ScrollDirectionDown){
             _scrollDirection  =ScrollDirectionDown;
            [self adjustPosition:scroll];
        }
    }
    
}
-(void)tableview:(MyAccountTableView *)table scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
/*    
 CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    NSLog(@"***%f",point.y);
    if (point.y >= 0)
    {
        _scrollDirection  =  ScrollDirectionDown;
       
    } else if(point.y<-2)
    {
        _scrollDirection  =ScrollDirectionUp;
          [self adjustPosition:scrollView];
    }
 */
}
-(void)tableview:(MyAccountTableView *)table scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
 /*
    NSLog(@"停止");
    _scrollDirection = ScrollDirectionNone;
  */
}

-(void)adjustPosition:(UIScrollView*)scroll
{
    switch (_scrollDirection)
    {
        case ScrollDirectionDown:
        {
          NSLog(@"向下");
            [UIView animateWithDuration:0.3 animations:^{
                _contentView.frame = CGRectMake(0, kContentY, _wrapView.bounds.size.width, _wrapView.frame.size.height-kContentY);
            } completion:^(BOOL finished) {
                _slideView.frame = _contentView.bounds;
            }];
        }
            break;
        case ScrollDirectionUp:
        {
          NSLog(@"向上");
            [UIView animateWithDuration:0.3 animations:^{
               _contentView.frame = CGRectMake(0,40, _wrapView.bounds.size.width, _wrapView.frame.size.height-40);
            } completion:^(BOOL finished) {
               _slideView.frame = _contentView.bounds;
            }];
        }
        default:
            break;
    }
}
- (IBAction)resetPosition:(id)sender {
    //Stop scrolling
    MyAccountRecordVC *vc = [_slideView.viewArray objectAtIndex:_slideView.selectedIndex];
    [vc.tableView.tableView setContentOffset:vc.tableView.tableView.contentOffset animated:NO];

    _scrollDirection = ScrollDirectionDown;
    [self adjustPosition:nil];
/*
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.frame = CGRectMake(0, kContentY, _wrapView.bounds.size.width, _wrapView.frame.size.height-kContentY);
    } completion:^(BOOL finished) {
        _slideView.frame = _contentView.bounds;
    }];
*/
}
- (void)viewDidUnload {
//    [self setSettingBtn:nil];
    [super viewDidUnload];
}



- (IBAction)gaoJiZhuiHao:(UIButton *)sender {
    HMTableViewController *vc=[UIStoryboard storyboardWithName:@"HMTableViewController" bundle:nil].instantiateInitialViewController;
    
    //[self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
