//
//  LotteryPublicViewController.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "LotteryPublicViewController.h"
#import "MSHTTPRequest.h"
#import "TradeRecordCell.h"
#import "LoadingAlertView.h"
#import "LotteryPublicCell.h"

#import "PublicCellView.h"
#import "CDSSC.h"
#import "PublicDetailViewController.h"
#import "HallViewController.h"

@interface LotteryPublicViewController ()

@property (strong, nonatomic) NSMutableArray *dataList;

@end

@implementation LotteryPublicViewController

- (void)dealloc{
    Echo(@"%s",__func__);
    [_tableView release];
    _tableView = nil;
    [_dataList release];
    _dataList = nil;
    [request release];
    [balls release];
    [selectedBalls release];
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
    // Do any additional setup after loading the view.
    self.title = @"开奖号码";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
    self.view.backgroundColor = [UIColor blackColor];
    _wrapView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                         0,
                                                         self.view.frame.size.width,
                                                         self.view.frame.size.height-44.f-49.f+(IOS7?20.f:0.f))];
    _wrapView.clipsToBounds = YES;
    _wrapView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_wrapView];
    
    CGRect tableRect = _wrapView.bounds;
    tableRect.size.height -= 44.f;
    
    _tableView = [[[MSPullingRefreshTableView alloc] initWithFrame:tableRect pullingDelegate:self style:UITableViewStylePlain] autorelease];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.headerOnly = YES;
    _tableView.backgroundView = [[[UIView alloc]init] autorelease];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.separatorColor = [UIColor yellowColor];
    
    _isRefresh = YES;
    [_wrapView addSubview:_tableView];

    self.dataList = [NSMutableArray array];
    
    NSArray *issuelist = nil;   //[RQPublicHistory cachedIssueList];
    if (issuelist) {
        [self.dataList addObjectsFromArray:issuelist];
    }
    else {
        [self.tableView launchRefreshing];
    }
    
    balls = [[NSMutableDictionary alloc] initWithCapacity:9];
    selectedBalls= [[NSMutableDictionary alloc] initWithCapacity:9];
    for(int i = 0; i < 10; i++)
    {
        NSString* key = [NSString stringWithFormat:@"%d", i ];
        NSString* selectedBall = [NSString stringWithFormat:@"ball_%d_selected.png", i ];
        NSString* noSelectedBall = [NSString stringWithFormat:@"whiteball_%d.png", i ];
        [balls setObject:noSelectedBall forKey:key];
        [selectedBalls setObject:selectedBall forKey:key];
        
    }

}

- (void)loadData{
    
    RQSubPublicHistory *rq = [[[RQSubPublicHistory alloc] init] autorelease];
    self.rq = rq;
    [self.rq startPostWithDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoBet:(UIButton *)sender
{
    NSMutableArray *items = [_dataList objectAtIndex:sender.tag-9999];
    IssueItem *model = [items objectAtIndex:0];
    CDLottery *lot = [CDLottery findLotteryById:model.lotteryId andChannelId:model.channelid];
    if (lot){
        [HallViewController checkLotteryStateIn:self lottery:lot];
        
        //Flurry Event
        if([lot.channelid intValue] == 1 && [lot.lotteryId intValue] ==  2) //P5
        { FLEvent(kFLEventPublicHistoryP5BetNow); }
    }
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
    return [self.dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 143.f;
    /*
    IssueItem *item = [self.dataList objectAtIndex:indexPath.row];
    switch (item.lotteryType) {
        case kLotteryKuaile8:
            return 90.f;
            break;
        
        default:
            return 68.f;
            break;
    }
    return 68.f;
     */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = nil;
    cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        PublicCellView *view = (id)[PublicCellView loadFromNib];
        view.tag = 100;
        [cell.contentView addSubview:view];
        
        UIView *sbg = [[UIView alloc] initWithFrame:cell.bounds];
        sbg.backgroundColor = Color(@"MyAccountCellSelectedBackground");
        cell.selectedBackgroundView = sbg;
        [sbg release];
    }
    
    NSMutableArray *items = [_dataList objectAtIndex:indexPath.row];
    IssueItem *item1 = [items objectAtIndex:0];
    IssueItem *item2 = nil;
    if (items.count>1) {
      item2  = [items objectAtIndex:1];
    }
    IssueItem *item3 = nil;
    if (items.count>2) {
        item3  = [items objectAtIndex:2];
    }
    
    PublicCellView *view = (id)[cell.contentView viewWithTag:100];
    view.nameLbl.text = item1.lotteryName;
    view.issueLbl.text = [NSString stringWithFormat:@"第%@期",item1.issueNumber];
    view.codes  = item1.number;
    
    
    view.pre1IssueLbl.text = item2.issueNumber?[NSString stringWithFormat:@"第%@期",item2.issueNumber]:@"";
    view.pre2IssueLbl.text = item3.issueNumber?[NSString stringWithFormat:@"第%@期",item3.issueNumber]:@"";
    view.pre1Codes = item2.number;
    view.pre2Codes = item3.number;
    
    [view.nameLbl sizeToFit];
    CGRect r = view.issueLbl.frame;
    r.origin.x = view.nameLbl.frame.origin.x+view.nameLbl.frame.size.width+10;
    view.issueLbl.frame = r;
    
    view.betButton.tag = indexPath.row+9999;
    [view.betButton addTarget:self action:@selector(gotoBet:) forControlEvents:UIControlEventTouchUpInside];
    
#ifdef __IPHONE_7_0
    cell.contentView.backgroundColor = [UIColor whiteColor];   // [UIColor clearColor];
    cell.backgroundColor = [UIColor whiteColor];   //[UIColor clearColor];
#endif
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *items = [self.dataList objectAtIndex:indexPath.row];
    IssueItem *item = [items objectAtIndex:0];
    PublicDetailViewController *vc = [[PublicDetailViewController alloc] initWithNibName:@"PublicDetailViewController" bundle:nil];
    vc.chan_id = item.channelid;
    vc.lottery_id = item.lotteryId;
    vc.title = item.lotteryName;
    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
    [vc release];
}

#pragma mark - RQBaseDelegate

- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQSubPublicHistory *)rq error:(NSError *)error{
    if (error) {
        [self.tableView setTipsType:kPRTipsTypeNetworkError];
    }
    else if (rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
        if (rq.msgType == kMessageTypeSessionExpired) {
            [SharedModel signOut];
        }
        
    }
    else if([rq.issueList count] > 0){
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:rq.issueList];
        self.tableView.reachedTheEnd = YES;
        [self.tableView setTipsType:kPRTipsTypeDefault];
    }
    else if ([rq.issueList count] == 0){
        [self.tableView setTipsType:kPRTipsTypeNoData];
    }
    
    [self.tableView tableViewDidFinishedLoading];
    [self.tableView reloadData];
}


@end
