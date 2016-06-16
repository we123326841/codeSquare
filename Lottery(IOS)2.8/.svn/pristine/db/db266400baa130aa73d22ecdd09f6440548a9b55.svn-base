//
//  LeftViewController.m
//  SideMenuController
//
//  Created by danal on 13-1-3.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "LeftViewController.h"
#import "MenuCell.h"
#import "AppDelegate.h"
#import "SignViewController.h"
#import "TableDataObject.h"
#import "UserAmountListView.h"
#import "CDUserInfo.h"

#ifdef __LV__
@interface LeftViewController ()
@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UserAmountListView *amountListView;

@end

@implementation LeftViewController
@synthesize dataList = _dataList;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize tableView = _tableView;

- (void)dealloc{
    MSNotificationCenterRemoveObserver();
    [_dataList release];    _dataList = nil;
    [_selectedIndexPath release];   _selectedIndexPath = nil;
    [_tableView release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        //Initialize the user type if logined
        CDUserInfo *u = [CDUserInfo findFirst];
        if (u){
            _userType = [u.userType intValue];
        }
        _lastMenuIndex = -0xff;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.dataList = [NSMutableArray array];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    CGRect rect = self.view.bounds;
#ifdef __IPHONE_7_0
    if (IOS7) {
        rect.origin.y = 20;
        rect.size.height -= 20;
    }
#endif
    
    rect.origin.y += [UserHeaderView height];
    rect.size.height -= [UserHeaderView height];
    
    UserAmountListView *amountView=[[UserAmountListView alloc] initWithFrame:rect];
    amountView.alpha=0;
    __block LeftViewController *vc = self;
    [amountView setExitBlock:^(UIView *amountListView) {
        
        vc.userHeaderView.balanceLbl.text = @"高频余额：";
        vc.userHeaderView.opened = NO;
        [vc.userHeaderView.userAmountButton setImage:[UIImage imageNamed:@"arrow_down_yellow.png"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            amountListView.alpha=0;
        }];
        
        [[AppDelegate leftMenuController] swithToMenuIndex:kMenuIndexSign];
        //[[(AppDelegate *)[UIApplication sharedApplication].delegate menuController] swithToMenuIndex:kMenuIndexSign];
        [SharedModel shared].username = nil;
        [SharedModel shared].balance = 0;
        [SharedModel shared].token = nil;
        MSNotificationCenterPost(kNotificationUserInfoUpdated);
//        RQLogout *rqLogout = [[[RQLogout alloc] init] autorelease];
//        [rqLogout startPostWithBlock:nil sender:nil];
    }];
    [self.view addSubview:amountView];
    self.amountListView=amountView;
    [amountView release];
    
    UserHeaderView *tmpheadView = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320.f, [UserHeaderView height])];
    tmpheadView.accountLbl.textColor = kMenuTextColor;
    tmpheadView.balanceLbl.textColor = kMenuTextColor;
    tmpheadView.backgroundColor = [UIColor clearColor];
    __block UIView *blkAmtView = self.amountListView;
    [tmpheadView setOpenUserAmountListViewBlock:^{
        [UIView animateWithDuration:0.3 animations:^{
            blkAmtView.alpha=1;
        }];
    } closeUserAmountListViewBlock:^{
        [UIView animateWithDuration:0.3 animations:^{
            blkAmtView.alpha=0;
        }];
    }];
    [self.view addSubview:tmpheadView];
    self.userHeaderView = tmpheadView;
    [tmpheadView release];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tag = 0xafaf;
    [self.view insertSubview:tableView belowSubview:self.amountListView];
    [tableView release];
    self.tableView = tableView;
    
//    UIImage *bgImage = [UIImage imageNamed:@"home_bg.png"];
//    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(2.f, 2.f, 100.f, 10.f)];
//    UIImageView *bg = [[UIImageView alloc] initWithImage:bgImage];
    rect = self.view.bounds;
    rect.origin.x = -15.f;
    rect.size.width += 15.f;
    UIImageView *bg = [[UIImageView alloc] initWithFrame:rect];
    bg.backgroundColor = [UIColor rgbColorWithR:29 G:29 B:29 alpha:1.f];
    bg.frame = rect;
    [self.view insertSubview:bg atIndex:0];
    [bg release];
//    if (rect.size.height > 480) {
//        UIImage *image = [UIImage imageNamed:@"chongzhi.png"];
//        UIImageView *textImageView = [[UIImageView alloc] initWithImage:image];
//        textImageView.frame = CGRectMake(55, rect.size.height - image.size.height - 10, image.size.width, image.size.height);
//        [bg addSubview:textImageView];
//        [textImageView release];
//    }
    
    [self loadData];
    MSNotificationCenterAddObserver(@selector(userLoginAction:), kNotificationUserInfoUpdated);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reload:(UserType)userType{
    _userType = userType;
    [self loadData];
}

- (void)loadData{
    [self.dataList removeAllObjects];
    
    int sectionIndex = 0;
    /*
    //Header 0: User information area
    TableDataObject *userInfo = [TableDataObject objectWithIcon:nil subject:@"UserInfo" controller:nil];
    userInfo.section = sectionIndex++;
    TableDataObject *header = [TableDataObject objectWithIcon:nil subject:nil controller:nil];
    [userInfo addChild:header];
    [self.dataList addObject:userInfo];
     */
    
    //Menu sections
    Echo(@"--Load menu for user of type:%d", _userType);
    NSArray *sections = [TableDataObject tableDataObjectsForUserType:_userType];
    for (TableDataObject *one in sections){
        [self.dataList addObject:one];
        one.section = sectionIndex++;
    }
    
    /*
     //Initialize the data list with placeholders
     for (int i = 0; i < kMenuIndexMax; i++) {
     [self.dataList addObject:@"placeholder"];
     }
     
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"gcdt.png",@"Icon",
     @"UserInfo",@"Text",
     @"UserInfo",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexHeader withObject:d];
     }
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"gcdt.png",@"Icon",
     @"购彩大厅",@"Text",
     @"HallViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexHall withObject:d];
     }
     
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"kjxx.png",@"Icon",
     @"开奖信息",@"Text",
     @"LotteryPublicViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexPublic withObject:d];
     }
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"yxjl.png",@"Icon",
     @"游戏记录",@"Text",
     @"GameRecordViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexGame withObject:d];
     }
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"jyjl.png",@"Icon",
     @"账变列表",@"Text",
     @"TransactionRecordViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexTransacation withObject:d];
     }
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"pdzz.png",@"Icon",
     @"频道转账",@"Text",
     @"TransferViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexTransfer withObject:d];
     }
     //    {
     //        NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     //                           @"scj.png",@"Icon",
     //                           @"收藏夾",@"Text",
     //                           @"FavoriteViewController",@"Class", nil];
     //        [self.dataList addObject:d];
     //    }
     
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"ckzh.png",@"Icon",
     @"查看追号",@"Text",
     @"ZhuiHaoListViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexZhuiHao withObject:d];
     }
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"zxzx.png",@"Icon",
     @"公告列表",@"Text",
     @"InfoCenterViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexInfo withObject:d];
     }
     {
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"sz.png",@"Icon",
     @"设置",@"Text",
     @"SettingViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexSetting withObject:d];
     }
     {
     NSString *text = [SharedModel userIsSignedin] ? @"退出" : @"登录";
     NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
     @"zx.png",@"Icon",
     text,@"Text",
     @"SignViewController",@"Class", nil];
     [self.dataList replaceObjectAtIndex:kMenuIndexSign withObject:d];
     }
     */
    
    UITableView *tableView = (UITableView *)[self.view viewWithTag:0xafaf];
    [tableView reloadData];
}

- (void)userLoginAction:(NSNotification *)noti{
    Echo(@"%s",__func__);
    [self.dataList removeAllObjects];
    CDUserInfo *u = [CDUserInfo findFirst];
    [self reload:[u.userType intValue]];
}

- (void)activeMenuAtRow:(int)row inSection:(int)section{
    self.selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.tableView reloadData];
}

- (void)activeMenuIndex:(MenuIndex)index{
    int section = 0, row = 0;
    for (TableDataObject *sectionObj in self.dataList){
        NSArray *children = [sectionObj children];
        for (TableDataObject *child in children){
            if (child.mark == index){
                section = sectionObj.section;
                row = child.row;
                break;
            }
        }
    }
    
    [self activeControllerAtRow:row inSection:section];
}

- (void)activeControllerAtRow:(int)row inSection:(int)section{
    TableDataObject *sectionObj = [self.dataList objectAtIndex:section];
    TableDataObject *rowObj = [sectionObj childAtIndex:row];
    NSString *cls = rowObj.controllerClass;
    NSString *title = rowObj.subjectText;
    if (cls == nil){
        cls = NSStringFromClass([BaseViewController class]);
    }
    
    UIViewController *vc = [[NSClassFromString(cls) alloc] init];
    vc.title = title;
    
    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [dele.smc activeViewController:nav];
    [vc release];
    [nav release];
    
    [self activeMenuAtRow:row inSection:section];
}

#pragma mark - 用这个方法来实现页面跳转
- (void)swithToMenuIndex:(MenuIndex)index{
    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
    
    //如果没有登录，跳转到登录界面
    if ( ![SharedModel userIsSignedin]) {
        _lastMenuIndex = kMenuIndexSign;
        SignViewController *vc = [[SignViewController alloc] init];
        vc.title = @"登录";
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
        [dele.smc activeViewController:nav];
        [vc release];
        [nav release];
        return;
    }

    if (_lastMenuIndex == index){
            [dele.smc slideToDirection:NO];
            return;
    }
    
    _lastMenuIndex = index;
    //登录，充值，提现这几个比较特殊
    if (index == kMenuIndexSign){
        SignViewController *vc = [[SignViewController alloc] init];
        AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
        [dele.smc activeViewController:nav];
        [vc release];
        [nav release];
        return;
        
    } else if(index == kMenuIndexChongzhi){
        UIViewController *vc = [[NSClassFromString(@"RechargeViewController") alloc] init];
        vc.title = @"充值申请";
        
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
        [dele.smc activeViewController:nav];
        [vc release];
        [nav release];
        [self activeMenuAtRow:kMenuIndexChongzhi inSection:0];
        return;
        
    } else if(index == kMenuIndexTixian){
        UIViewController *vc = [[NSClassFromString(@"WithdrawCashVC") alloc] init];
        vc.title = @"提现申请";
        
        AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
        [dele.smc activeViewController:nav];
        [vc release];
        [nav release];
        [self activeMenuAtRow:kMenuIndexTixian inSection:0];
        return;
        
    }
    
    NSString *cls = nil;
    NSString *title = nil;
    int section = 0, row = 0;
    for (TableDataObject *sectionObj in self.dataList){
        NSArray *children = [sectionObj children];
        for (TableDataObject *child in children){
            if (child.mark == index){                   //按mark来找到对应的menuIndex
                cls = child.controllerClass;
                title = child.subjectText;
                section = sectionObj.section;
                row = child.row;
                break;
            }
        }
    }
    if (cls == nil){
        cls = NSStringFromClass([BaseViewController class]);
    }
    
    UIViewController *vc = [[NSClassFromString(cls) alloc] init];
    vc.title = title;
    
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [dele.smc activeViewController:nav];
    [vc release];
    [nav release];
    
    [self activeMenuAtRow:row inSection:section];       //激活选中状态
}

- (void)swithToMenuIndex:(MenuIndex)index andActiveViewController:(UIViewController *)controller{
    
    NSString *cls = nil;
    NSString *title = nil;
    int section = 0, row = 0;
    for (TableDataObject *sectionObj in self.dataList){
        NSArray *children = [sectionObj children];
        for (TableDataObject *child in children){
            if (child.mark == index){
                cls = child.controllerClass;
                title = child.subjectText;
                section = sectionObj.section;
                row = child.row;
                break;
            }
        }
    }
    if (cls == nil){
        cls = NSStringFromClass([BaseViewController class]);
    }
    
    UIViewController *vc = [[NSClassFromString(cls) alloc] init];
    vc.title = title;
    
    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [nav pushViewController:controller animated:NO];
    [dele.smc activeViewController:nav];
    [vc release];
    [nav release];
    
    [self activeMenuAtRow:row inSection:section];
}

- (void)traceEventWithTitle:(NSString *)title{
    NSString *evt = nil;
    if ([title isEqualToString:LotteryHall]){
            evt = kFLEventHall;
    } else if([title isEqualToString:GameInfo]){
            evt = kFLEventGameHistory;
    }  else if([title isEqualToString:NoticeCenter]){
            evt = kFLEventInformationList;
    }  else if([title isEqualToString:LotteryPublic]){
            evt = kFLEventPublickHistory;
    }  else if([title isEqualToString:AppSetting]){
            evt = kFLEventSetting;
//    }  else if([title isEqualToString:]){
//            evt = kFLEventLogout;
    }  else if([title isEqualToString:TransactionList]){
            evt = kFLEventTransactionHistory;
    }  else if([title isEqualToString:ChannelTransfer]){
            evt = kFLEventChannelTransfer;
    }  else if([title isEqualToString:TraceInfo]){
            evt = kFLEventZhuiHaoHistory;
    }
//    if (evt != nil) FLEvent(evt);
}

#pragma mark - TableView*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return [self.dataList count];
    TableDataObject *sectionObj = [self.dataList objectAtIndex:section];
    return [[sectionObj children] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return indexPath.section == 0 && indexPath.row == 0  ? [UserHeaderView height] : 44.f;
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    /*
    static NSString *identifier0 = @"cell0";
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
        if (cell == nil) {
            cell = [[[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0] autorelease];
            [(MenuCell *)cell setShowIndicator:NO];
            [(MenuCell *)cell indicatorView].hidden = YES;
            UserHeaderView *view = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320.f, [UserHeaderView height])];
            view.accountLbl.textColor = kMenuTextColor;
            view.balanceLbl.textColor = kMenuTextColor;
            view.backgroundColor = [UIColor clearColor];
            __block UIView *amountView=self.amountListView;
            [view setOpenUserAmountListViewBlock:^{
                [UIView animateWithDuration:0.3 animations:^{
                    amountView.alpha=1;
                }];
            } closeUserAmountListViewBlock:^{
                [UIView animateWithDuration:0.3 animations:^{
                    amountView.alpha=0;
                }];
            }];
            [cell.contentView addSubview:view];
            self.userHeaderView=view;
            [view release];
        }
        return cell;
    }
     */
    
    TableDataObject *sectionObj = [self.dataList objectAtIndex:indexPath.section];
    TableDataObject *rowObj = [sectionObj childAtIndex:indexPath.row];
    
    MenuCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    /*
     NSDictionary *d = [self.dataList objectAtIndex:indexPath.row];
     cell.iconLblView.iconView.image = [UIImage imageNamed:[d objectForKey:@"Icon"]];
     cell.iconLblView.textLbl.text = [d objectForKey:@"Text"];
     cell.showIndicator = self.selectedIndexPath.row == indexPath.row;
     */
    
    //UIImage *dot =  [UIImage imageNamed:@"dot_yellow"]; //[UIImage imageNamed:rowObj.iconName];
    cell.iconLblView.iconView.contentMode = UIViewContentModeCenter;
    //cell.iconLblView.iconView.image = dot;
    cell.iconLblView.textLbl.text = rowObj.subjectText;
    cell.showIndicator = self.selectedIndexPath.section == indexPath.section && self.selectedIndexPath.row == indexPath.row;
    cell.iconLblView.iconView.layer.cornerRadius = 3.f;
    cell.iconLblView.iconView.layer.masksToBounds = YES;
    cell.badgeNumber = 0;
    if (rowObj.mark == kMenuIndexInfo){
        cell.badgeNumber = [[[CDUserInfo findFirst] unread] integerValue];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //if (indexPath.section == 0 && indexPath.row == kMenuIndexHeader) return;
    
    TableDataObject *sectionObj = [self.dataList objectAtIndex:indexPath.section];
    TableDataObject *rowObj = [sectionObj childAtIndex:indexPath.row];
    _lastMenuIndex = rowObj.mark;
    
    //Trace
    [self traceEventWithTitle:rowObj.subjectText];
    /*
    NSString *evt = nil;
    switch (indexPath.row) {
        case kMenuIndexHall:
            evt = kFLEventHall;
            break;
        case kMenuIndexGame:
            evt = kFLEventGameHistory;
            break;
        case kMenuIndexInfo:
            evt = kFLEventInformationList;
            break;
        case kMenuIndexPublic:
            evt = kFLEventPublickHistory;
            break;
        case kMenuIndexSetting:
            evt = kFLEventSetting;
            break;
        case kMenuIndexSign:
            evt = kFLEventLogout;
            break;
        case kMenuIndexTransacation:
            evt = kFLEventTransactionHistory;
            break;
        case kMenuIndexTransfer:
            evt = kFLEventChannelTransfer;
            break;
        case kMenuIndexZhuiHao:
            evt = kFLEventZhuiHaoHistory;
            break;
        default:
            break;
    }
    if (evt != nil) FLEvent(evt);
    */
    
    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
    
    if (indexPath.row == kMenuIndexInfo) {
        
    }
    //如果没有登录，跳转到登录界面
    else if ( ![SharedModel userIsSignedin]) {
//#ifndef DEBUG
        SignViewController *vc = [[SignViewController alloc] init];
        vc.title = @"登录";
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
        [dele.smc activeViewController:nav];
        [vc release];
        [nav release];
        return;
//#endif
    }
    
    if ([SharedModel userIsSignedin] && indexPath.row == [self.dataList count] - 1) {
  
        AlertView *alert = [[AlertView alloc] initWithTitle:@"温馨提示" msg:@"您确认要退出登录吗？" okButton:@"确认" cancelButton:@"取消"];
        [alert show];
        [alert setCompleteBlock:^(AlertView *alertView, bool okay) {
            if (okay){
                [self alertView:nil didDismissWithButtonIndex:1];
            }
        }];
        [alert release];

        return;
    }
    
    //点中的行和上一次相同
    if (self.selectedIndexPath.section == indexPath.section && self.selectedIndexPath.row == indexPath.row) {
        [dele.smc slideToDirection:NO];
        return;
    }
    
    if (self.selectedIndexPath != nil) {
        MenuCell *oldCell = (id)[tableView cellForRowAtIndexPath:self.selectedIndexPath];
        oldCell.showIndicator = NO;
    }
    MenuCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    cell.showIndicator = YES;
    self.selectedIndexPath = indexPath;
    
    /*   NSDictionary *d = [self.dataList objectAtIndex:indexPath.row];    */
    //    if ([self needLogon:[d objectForKey:@"Class"]])
    //    {
    //        [self showSheet];
    //        return;
    //    }
    
    UIViewController *vc = [[NSClassFromString(rowObj.controllerClass) alloc] init];
    vc.title = rowObj.subjectText;
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [dele.smc activeViewController:nav];
    [vc release];
    [nav release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
    //return section < 1 ?  0 : 20;
    //    return [UserHeaderView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TableDataObject *sectionObj = [self.dataList objectAtIndex:section];
    float h = [self tableView:tableView heightForHeaderInSection:section];
    
    /*    UserHeaderView *view = [[UserHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320.f, h)];
     view.accountLbl.textColor = [UIColor yellowColor];
     view.balanceLbl.textColor = [UIColor yellowColor];
     view.backgroundColor = [UIColor clearColor];
     return [view autorelease];
     */
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, h)] autorelease];
    view.backgroundColor = [UIColor rgbColorWithHex:@"#171717"];
    UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(10, 3, 320, h-6)] autorelease];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = kYellowTextColor;
    lbl.font = [UIFont boldSystemFontOfSize:11];
    lbl.text = sectionObj.subjectText;
    [view addSubview:lbl];
    return view;
}

- (BOOL)needLogon:(NSString*)str
{
    if ([SharedModel userIsSignedin])
    {
        return NO;
    }
    
    NSArray* array = [NSArray arrayWithObjects:@"GameRecordViewController",@"TransactionRecordViewController",@"FavoriteViewController",@"SettingViewController", nil];
    
    for(NSString* temp in array){
        if ([temp isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
    
}

- (void)showSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"請先登錄"
                                                             delegate:self
                                                    cancelButtonTitle:@"返回"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"登錄",nil] ;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == kTagSheet1) {
        if (buttonIndex == 0) {
            //sign out
            [HUDView showLoading:self.view];
            RQLogout  *rq = [[RQLogout alloc] init];
            [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
                [HUDView dismissCurrent];
                if (error_) {
                    
                } else if(rq_.msgType ){    //有返回消息就认为是注销成功
                    HUDShowMessage(rq_.msgContent, nil);
                    [SharedModel signOut];
                    LeftViewController *this_ = rqSender_;
                    [this_ loadData];
                    
                } else {    //success
                    
                    [SharedModel signOut];
                    LeftViewController *this_ = rqSender_;
                    [this_ loadData];
                }
                [rq_ release];
            } sender:self];
            
        }
        return;
    }
    
    if(buttonIndex == 0) {
        SignViewController* vc = [[SignViewController alloc] init];
        vc.title = @"登錄";
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
        AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
        [dele.smc activeViewController:nav];
        [vc release];
        [nav release];
    } else if (buttonIndex == 1) {
        
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //sign out
        
        RQLogout  *rq = [[RQLogout alloc] init];
        [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            /*
             if(rq_.msgType ){    //有返回消息就认为是注销成功
             
             [AlertHUD showMessage:rq_.msgContent];
             [SharedModel signOut];
             LeftViewController *this_ = rqSender_;
             [this_ loadData];
             
             } else {    //success
             
             [SharedModel signOut];
             LeftViewController *this_ = rqSender_;
             [this_ loadData];
             }
             */
            if (error_) {
                
            } else {
                if(rq_.msgContent) {
                    [AlertHUD showMessage:rq_.msgContent];
                }
                [SharedModel signOut];
                LeftViewController *this_ = rqSender_;
                [this_ loadData];
                
                [[AppDelegate leftMenuController] swithToMenuIndex:kMenuIndexSign];
            }
            [rq_ release];
        } sender:self];
    }
}

@end

#else

@implementation LeftViewController

- (void)swithToMenuIndex:(MenuIndex)index{
}

@end

#endif