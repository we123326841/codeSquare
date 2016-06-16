//
//  PublicDetailViewController.m
//  Caipiao
//
//  Created by CYRUS on 14-8-1.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "PublicDetailViewController.h"
#import "RQPublicHistory.h"
#import "PublicDetailCell.h"
#import "HallViewController.h"

@interface PublicDetailViewController ()

@end

@implementation PublicDetailViewController

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
    // Do any additional setup after loading the view from its nib.    
    _dataList = [[NSMutableArray alloc] init];

    _tableView.pullingDelegate = self;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.headerOnly = YES;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView performSelector:@selector(launchRefreshing) withObject:nil afterDelay:.1f];
    
    [_betButton setTitleColor:Color(@"PublicBetButtonTextColor") forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    if (self.rq) {
        [self.rq cancel];
        self.rq = nil;
    }
    
    RQPublicDetail *rq = [[[RQPublicDetail alloc] init] autorelease];
    rq.chan_id = _chan_id;
    rq.lottery_id = _lottery_id;
    self.rq = rq;
    [self.rq startPostWithDelegate:self];
}

- (IBAction)betNow:(id)sender
{
    CDLottery *lot = [CDLottery findLotteryById:_lottery_id andChannelId:_chan_id];
    if (lot){
        [HallViewController checkLotteryStateIn:self lottery:lot];
        
        //Flurry Event
        if([lot.channelid intValue] == 1 && [lot.lotteryId intValue] ==  2) //P5
        { FLEvent(kFLEventPublicHistoryDetailsP5BetNow); }
    }
}

#pragma mark - MSPullingRefreshTableViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}
/* 按日期分组改成不分组
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.f;
}
 */
- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5f];
    
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5f];
}
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataList count];
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
    /*
    PublicDetailItem *item = [_dataList objectAtIndex:section];
    if (item.opened) return [item.list count];
    else return 0;
     */
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PublicDetailItem *item = [_dataList objectAtIndex:section];
    IssueItem *obj = [item.list objectAtIndex:0];
    
    PublicDetailSectionView *view = (PublicDetailSectionView *)[PublicDetailSectionView loadFromNib];
    view.delegate = self;
    view.section = section;
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy-MM-dd";
    NSString *nowTime = [f stringFromDate:[NSDate date]];
    [f release];
    if ([nowTime isEqualToString:obj.openTime]) view.titleLabel.text = @"今日";
    else if ([[[nowTime componentsSeparatedByString:@"-"] lastObject] intValue]-[[[obj.openTime componentsSeparatedByString:@"-"] lastObject] intValue] == 1) view.titleLabel.text = @"昨日";
    else view.titleLabel.text = obj.openTime;
    
    view.backgroundImageView.image = item.opened ? ResImage(@"cell_section_open.png") : ResImage(@"cell_section_close.png");
    if (view.opened) view.arrow.transform = CGAffineTransformRotate(view.arrow.transform, DEGREES_TO_RADIANS(180));
    return view;
}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PublicDetailCell";
    PublicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = (PublicDetailCell *)[PublicDetailCell loadFromNib];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //PublicDetailItem *item = [_dataList objectAtIndex:indexPath.section];
    IssueItem *obj = [_dataList objectAtIndex:indexPath.row];
    cell.lotteryName=obj.lotteryName;
    cell.issueLbl.text = [NSString stringWithFormat:@"第%@期", obj.issueNumber];
    if ([obj.lotteryName isEqualToString:JSK3]) {
        cell.codes = obj.number;
        cell.preCodes = @"";
        cell.sumL.text = [NSString stringWithFormat:@"和值:%ld",(long)cell.sum];
    }else{
        if (indexPath.row == 0) {
            cell.codes = obj.number;
            cell.preCodes = @"";
        }else {
            cell.codes = 0;
            cell.preCodes = obj.number;
        }
    }
    /*
    if ([item.list count] == 1) cell.pos = kCellPositionBottom;
    else if (indexPath.row == [item.list count]-1) cell.pos = kCellPositionBottom;
    else cell.pos = kCellPositionDefault;
    
    [cell setNeedsDisplay];
     */
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - PublicDetailSectionViewDelegate

- (void)sectionHeaderView:(PublicDetailSectionView *)sectionHeaderView sectionOpened:(NSInteger)section
{
	PublicDetailItem *item = [_dataList objectAtIndex:section];
    item.opened = !item.opened;

    [_tableView reloadData];
//	if(item.indexPaths){
//		[self.tableView insertRowsAtIndexPaths:item.indexPaths withRowAnimation:UITableViewRowAnimationFade];
//	}
//	item.indexPaths = nil;
}

- (void)sectionHeaderView:(PublicDetailSectionView *)sectionHeaderView sectionClosed:(NSInteger)section
{	
	PublicDetailItem *item = [_dataList objectAtIndex:section];
    item.opened = !item.opened;

    [_tableView reloadData];
//	NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:section];
//    if (countOfRowsToDelete > 0) {
//        item.indexPaths = [[NSMutableArray alloc] init];
//        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
//            [item.indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
//        }
//        [self.tableView deleteRowsAtIndexPaths:item.indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    }
}
 */

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
