//
//  TransactionRecordViewController.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "TransactionRecordViewController.h"
#import "MSHTTPRequest.h"
#import "TradeRecordCell.h"
#import "TouchLabel.h"
#import "LoadingAlertView.h"
#import "HallViewController.h"


@interface TransactionRecordViewController ()
@end

@implementation TransactionRecordViewController

@synthesize tradeRecordsArray;

- (void)dealloc{
    Echo(@"%s",__func__);
    [_tableView release];
    _tableView = nil;
    [tradeRecordsArray release];tradeRecordsArray = nil;
    [_amountLbl release];
    [_titles release];
    [request release];
    [_tradeType release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _isLowGame = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsTransRecordChannelIsLowGame];
    if (_isLowGame) {
        self.title = @"低频账变列表";
    }else {
        self.title = @"高频账变列表";
    }
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    _dateString= [[formatter stringFromDate:date] retain];
    [formatter release];
    
    _amountLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 23)];
    _amountLbl.backgroundColor = [UIColor blackColor];
    _amountLbl.textColor = [UIColor rgbColorWithR:255 G:196 B:16 alpha:1];
    _amountLbl.textAlignment = NSTextAlignmentCenter;
    _amountLbl.font = [UIFont boldSystemFontOfSize:13];
    _amountLbl.text = [NSString stringWithFormat:@"%@ 当前资金变动 ",_dateString];
    [_contentView addSubview:_amountLbl];
    
    self.titles = @[@"所有类型", @"加入游戏",  @"转入频道", @"频道转出", @"奖金派送"];
    
    CGRect tableRect = self.view.bounds;
    tableRect.origin.y = 23.f;
    tableRect.size.height -=67.f;
    
    _tableView = [[[MSPullingRefreshTableView alloc] initWithFrame:tableRect pullingDelegate:self style:UITableViewStylePlain] autorelease];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.headerOnly = YES;
    _tableView.backgroundView = [[[UIView alloc]init] autorelease];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    
    self.tradeType = [NSNumber numberWithInt:0];
    _isRefresh = YES;
    [_contentView addSubview:_tableView];
    
    _titleLbl = [[NavTitleControl alloc] initWithFrame:CGRectMake(0, 0, 200.f, 44.f)];
    _titleLbl.textColor = kNavTitleColor;
    _titleLbl.textAlignment = UITextAlignmentCenter;
    _titleLbl.backgroundColor = [UIColor clearColor];
    _titleLbl.shadowColor = kNavTitleShadowColor;
    _titleLbl.shadowOffset = CGSizeMake(0, 1);
    _titleLbl.font = [UIFont boldSystemFontOfSize:20.f];
    _titleLbl.text = self.title;
    [_titleLbl addTarget:self selector:@selector(titleMenuAction:)];
    self.navigationItem.titleView = _titleLbl;
    
//    UIButton *button = [UIButton barButtonWithTitle:@"查看低频"];
//    button.titleLabel.font = [UIFont boldSystemFontOfSize:10.f];
    UIImage *im = [UIImage imageNamed: _isLowGame ? @"button_highgame.png" : @"button_lowgame.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, im.size.width, im.size.height);
    [button setBackgroundImage:im forState:UIControlStateNormal];
    [button addTarget:self action:@selector(switchChannel:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:button];
    
    self.tradeRecordsArray = [[[NSMutableArray alloc] init] autorelease];
    
    NSArray *list = [RQTransactionHistory cachedTransactionList];
    if (list) {
        [self.tradeRecordsArray addObjectsFromArray:list];
    } else {
//        [self loadData];
        [self.tableView launchRefreshing];
    }
}

- (void)switchChannel:(id)sender
{
    _isLowGame = !_isLowGame;
    
    //保存最后一次使用的频道
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:_isLowGame forKey:kUserDefaultsTransRecordChannelIsLowGame];
    [ud synchronize];
    
    [self.tradeRecordsArray removeAllObjects];
    [_tableView reloadData];
    
    [self.navTitleMenu dismiss];
    CGRect rect = _contentView.frame;
    rect.origin.y = 0;
    _contentView.layer.shadowRadius = YES;
    [UIView animateWithDuration:.2f animations:^{
        _contentView.frame = rect;
    } completion:^(BOOL finished){
        _contentView.layer.shadowRadius = NO;
    }];
    NavTitleControl *ntc =  (NavTitleControl *)self.navigationItem.titleView;
    ntc.opened = NO;
    
    UIButton *button = (UIButton *)self.navigationItem.rightBarButtonItem.customView;

    if (_isLowGame) {
        self.title = @"低频账变列表";
        [button setBackgroundImage:[UIImage imageNamed:@"button_highgame.png"] forState:UIControlStateNormal];
    }else {
        self.title = @"高频账变列表";
        [button setBackgroundImage:[UIImage imageNamed:@"button_lowgame.png"] forState:UIControlStateNormal];
    }
    
    [self.navTitleMenu removeFromSuperview];
    NavTitleMenu *menu = [[NavTitleMenu alloc] initWithFrame:CGRectMake(0, 0, 320.f, 100.f) titles:_titles];
    [menu selectItemForTitle:self.title];//[self.title substringFromIndex:2]];
    [menu addTarget:self selector:@selector(titleMenuSelectAction:)];
    menu.delegate = self;
    self.navTitleMenu = menu;
    self.navTitleMenu.selectedIndex = 0;
    [menu release];
    
    if (self.rq) {
        [self.rq cancel];
    }
    [self.tableView tableViewDidEndDragging:self.tableView];
    [self.tableView launchRefreshing];
}

- (void)betButonAction:(id)sender
{
//    BetViewController* vc = [[BetViewController alloc] init];
//    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
//    [dele.menuController swithToMenuIndex:kMenuIndexHall andActiveViewController:vc];
//    [vc release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)requestUrl
{
    return [NSString stringWithFormat:@"%@/ios/ssc/traderecords.php?pageNo=%i&pageSize=%i&self.tradeType=%i",baseUrl,pageNo,pageSize,[self.tradeType intValue]];
}

- (void)loadData
{
    if (self.rq) {
        [self.rq cancel];
    }
    
    RQTransactionHistory *rq = [[[RQTransactionHistory alloc] init] autorelease];
    rq.ordertype = [NSString stringWithFormat:@"%@",self.tradeType];
    rq.isLowGame = _isLowGame;
    [rq startPostWithDelegate:self];
    self.rq = rq;

}

- (void)filterRecords{
    
    [self.tradeRecordsArray removeAllObjects];
    [self.tableView reloadData];
    [self loadData];
    [self.tableView launchRefreshing];
}

#pragma mark - NavTitleMenu

- (void)titleMenuAction:(id)sender
{
    //Intialize navTitleMenu
    if (self.navTitleMenu == nil) {
        
        NavTitleMenu *menu = [[NavTitleMenu alloc] initWithFrame:CGRectMake(0, 0, 320.f, 100.f) titles:_titles];
        [menu selectItemForTitle:self.title];
        [menu addTarget:self selector:@selector(titleMenuSelectAction:)];
        menu.delegate = self;
        self.navTitleMenu = menu;
        self.navTitleMenu.selectedIndex = 0;
        [menu release];
    }
    //toggle
    if ([self.navTitleMenu opened]) {
        [self.navTitleMenu dismiss];
        
        CGRect rect = _contentView.frame;
        rect.origin.y = 0;
        _contentView.layer.shadowRadius = YES;
        [UIView animateWithDuration:.2f animations:^{
            _contentView.frame = rect;
        } completion:^(BOOL finished){
            _contentView.layer.shadowRadius = NO;
        }];
    } else {
//        FLEvent(kFLEventChangePlayType);
        [self.navTitleMenu showInView:self.view];
        
        CGRect rect = _contentView.frame;
        rect.origin.y += self.navTitleMenu.bounds.size.height;
        _contentView.layer.shadowRadius = YES;
        [UIView animateWithDuration:.2f animations:^{
            _contentView.frame = rect;
        } completion:^(BOOL finished){
            _contentView.layer.shadowRadius = NO;
        }];
    }
}

- (void)titleMenuSelectAction:(NavTitleMenu *)sender
{
    [sender dismiss];
    CGRect rect = _contentView.frame;
    rect.origin.y = 0;
    _contentView.layer.shadowRadius = YES;
    [UIView animateWithDuration:.2f animations:^{
        _contentView.frame = rect;
    } completion:^(BOOL finished){
        _contentView.layer.shadowRadius = NO;
    }];
    
    NavTitleControl *ntc =  (NavTitleControl *)self.navigationItem.titleView;
    ntc.opened = !ntc.opened;
    ntc.text = [NSString stringWithFormat:@"%@%@",
                _isLowGame?@"低频":@"高频",
                [sender.titles objectAtIndex:sender.selectedIndex]];
    //如果选项没有变化
    if (sender.lastIndex == sender.selectedIndex) {
        return;
    }
    
    switch (sender.selectedIndex) {
        case 0:
            self.tradeType = [NSNumber numberWithInt:0];
            break;
        case 1:
            self.tradeType = [NSNumber numberWithInt:3];
            break;
        case 2:
            self.tradeType = [NSNumber numberWithInt:1];
            break;
        case 3:
            self.tradeType = [NSNumber numberWithInt:2];
            break;
        case 4:
            self.tradeType = [NSNumber numberWithInt:5];
            break;
        default:
            break;
    }
    [sender commit];
    [self filterRecords];
}

#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark - TableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tradeRecordsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TradeRecordCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TradeRecordIdentifier];
    if (!cell) {
        cell = (TradeRecordCell *)[TradeRecordCell loadFromNib];
        cell.identifier = TradeRecordIdentifier;
        cell.lblTradeType.font = [UIFont boldSystemFontOfSize:14.f];
        cell.lblAmount.font = [UIFont boldSystemFontOfSize:14.f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    TransactionRecord *tr = [self.tradeRecordsArray objectAtIndex:indexPath.row];
    
    NSString* flag = tr.change > 0.f ? @"+" : @"-";
    NSString *change = [NSString stringWithFormat:@"%.4f", fabsf(tr.change)];
    change = [SharedModel formatBalance:change];
    cell.lblAmount.text = [NSString stringWithFormat:@"%@ %@元",flag, change];
    cell.lblAmount.textColor = tr.change < 0.f ?  [UIColor greenColor] : [UIColor redColor];
    cell.lblTradeType.text = tr.type;
    NSArray *arrTime = [tr.time componentsSeparatedByString:@":"];
    cell.lblDate.text = [NSString stringWithFormat:@"%@:%@",[arrTime objectAtIndex:0],[arrTime objectAtIndex:1]];
    
    NSString *balance = [NSString stringWithFormat:@"%@",tr.balance];
    balance = [SharedModel formatBalance:balance];
    NSString *prefix = _isLowGame ? @"低频余额" : @"高频余额";
    cell.lblAccountBalance.text = [NSString stringWithFormat:@"%@：%@元",prefix, balance];
    
    cell.row = indexPath.row;
    return cell;
    
}

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5f];
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5f];
}

#pragma mark - HttpRequest

- (void)buttonAction:(id)sender
{
    HallViewController* vc = [[HallViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark - RQBaseDelegate
- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQTransactionHistory *)rq error:(NSError *)error{
    if (error) {
        [self.tableView setTipsType:kPRTipsTypeNetworkError];
    }
    else if(rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
        if (rq.msgType == kMessageTypeSessionExpired) {
            [SharedModel signOut];
        }
    }
    else if([rq.transactionList count] > 0){
        [self.tableView setTipsType:kPRTipsTypeDefault];
        [self.tradeRecordsArray removeAllObjects];
        [self.tradeRecordsArray addObjectsFromArray:rq.transactionList];
        [self.tableView reloadData];
    }
    else if ([rq.transactionList count] == 0){
        [self.tableView setTipsType:kPRTipsTypeNoData];
    }
    [self.tableView tableViewDidFinishedLoading];
//    [self.tableView reloadData];
//    [self.tableView setContentOffset:CGPointZero];
    
    float i = 0;
    for (TransactionRecord *tr in self.tradeRecordsArray) {
        if (tr.time) {
            NSString *date = [[tr.time componentsSeparatedByString:@" "] objectAtIndex:0];
            if ([date isEqualToString:_dateString]) {
                i +=tr.change;
            }else {
                break;
            }
        }
    }
    if ([self.tradeType intValue] == 0) {
        NSString *amount = [NSString stringWithFormat:@"%.4f",i];
        if ([amount hasPrefix:@"-"]) {
            _amountLbl.text = [NSString stringWithFormat:@"%@ 当前资金变动 -%@",_dateString, [SharedModel formatBalance:[amount substringFromIndex:1]]];
        }else {
            _amountLbl.text = [NSString stringWithFormat:@"%@ 当前资金变动 %@",_dateString, [SharedModel formatBalance:amount]];
        }
    }
}

@end

