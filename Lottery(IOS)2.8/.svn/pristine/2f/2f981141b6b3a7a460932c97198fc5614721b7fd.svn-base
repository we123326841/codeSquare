//
//  InfoCenterViewController.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "InfoCenterViewController.h"
#import "MSHTTPRequest.h"
#import "TradeRecordCell.h"
#import "LoadingAlertView.h"
#import "InfoCenterCell.h"
#import "SiteNoticeCell.h"
#import "HallViewController.h"
#import "InfoCenterDetail.h"
#import "SiteNoticeDetailViewController.h"


@interface InfoCenterViewController ()<SiteNoticeCellDelegate>
@end

@implementation InfoCenterViewController

@synthesize tableView;

- (void)dealloc{
    MSNotificationCenterRemoveObserver();
    [self.rq cancel];
    self.rq = nil;
    self.controllers = nil;
    self.dataList = nil;
    self.tableView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _segBar.superview.backgroundColor =
    _segBar.backgroundColor = self.view.backgroundColor;
    _segBar.selectedIndex = 0;
    _segBar.indicatorInset = 10.f;
    _segBar.indicator.backgroundColor = Color(@"InfoSegBarColor");
    _segBar.normalColor = Color(@"NoticeLightTextColor");
    _segBar.highlightColor = Color(@"NoticeTextColor ");
    [_segBar addTarget:self action:@selector(onSegBarClick:) forControlEvents:UIControlEventValueChanged];
    _titleView.clipsToBounds = NO;
    _titleView.layer.cornerRadius = 3.f;
    _titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = _titleView;
    [self noticeButtonClick:nil];
    _noticeButton.backgroundColor = _msgButton.backgroundColor = [UIColor clearColor];
    _msgButton.badge = [[CDUserInfo user].unread integerValue];
    _msgButton.badgeOffset = CGPointMake(-10, -5);
//    CGRect tableRect = self.view.bounds;
//    tableRect.origin.y = 0;
//    tableRect.size.height -= (45);
    
    self.dataList = [NSMutableArray array];
//    self.tableView.frame = tableRect;
    tableView.pullingDelegate = self;
    tableView.headerOnly = YES;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    
    if ([tableView respondsToSelector:@selector(separatorInset)]){
        tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    [_actionView removeFromSuperview];
    [self.view addSubview:_actionView];
    _actionView.frame = CGRectMake(0, self.view.bounds.size.height,
                                   _actionView.bounds.size.width, _actionView.bounds.size.height);

    //Notice views
    self.controllers = [NSMutableArray array];
//    NoticeType types[3] = {kNoticeTypeBank,kNoticeTypeHigh,kNoticeTypeLow};
    NoticeType types[1] = {kNoticeTypeBank};

    for (NSInteger i = 0; i < 1; i++) {
        NoticeViewController *vc = [NoticeViewController new];
        vc.noticeType = types[i];
        [self.controllers addObject:vc];
        vc.navi = self.navigationController;
        [vc release];
        if (i == 0){
            [vc performSelector:@selector(launchLoading) withObject:nil afterDelay:.2f];
        }
    }
    
    MSNotificationCenterAddObserver(@selector(onUserInfoUpdates:), kNotificationUserInfoUpdated);
}

- (void)onUserInfoUpdates:(NSNotification *)noti{
    _msgButton.badge = [[CDUserInfo user].unread integerValue];
    
}

- (NSInteger)segmentViewNumberOfPages{
    return self.controllers.count;
}

- (UIView *)segmentView:(MSSegmentView *)segView contentViewAtPage:(NSInteger)page{
    UIViewController *vc = self.controllers[page];
    return vc.view;
}

- (void)segmentViewDidScrollToPage:(MSSegmentView *)view page:(NSInteger)page{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)betButonAction:(id)sender
{
//    BetViewController* vc = [[BetViewController alloc] init];
//    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
//    [dele.menuController swithToMenuIndex:kMenuIndexHall andActiveViewController:vc];
//    [vc release];
}

- (void)loadData{
    [self.rq cancel];
    self.rq = nil;
    RQNotice *req = [[RQNotice alloc] initWithType:kNoticeTypeSite];
    [req startPostWithDelegate:self];
    self.rq = req;
    [req release];
}

- (void)editAction:(UIButton *)sender{

    _isEditing = !_isEditing;
    if (sender){
        [sender setTitle:_isEditing ? @"取消" : @"编辑" forState:UIControlStateNormal];
    }
    
    if (_isEditing){
        for (NoticeItem *item in self.dataList){
            item.checked = NO;
        }
    }
    
    NSArray *cells = [self.tableView visibleCells];
    [UIView beginAnimations:nil context:nil];
    for (SiteNoticeCell *cell in cells){
        cell.checkbox.checked = NO;
        [cell setEditingCell:_isEditing animated:YES];
    }
    CGRect frame = _actionView.frame;
    frame.origin.y = _isEditing ? self.view.bounds.size.height - frame.size.height : self.view.bounds.size.height;
    _actionView.frame = frame;

    [UIView commitAnimations];
    
    frame = self.tableView.frame;
    frame.size.height = _isEditing ? frame.size.height - _actionView.frame.size.height : self.view.bounds.size.height;
    NSLog(@"****%@",NSStringFromCGRect(frame));
    self.tableView.frame = frame;
    
}

- (IBAction)selectAllAction:(id)sender{
    for (NoticeItem *item in self.dataList){
        item.checked = YES;
    }
    [self.tableView reloadData];
}

- (IBAction)deleteAction:(id)sender{
    NSMutableArray *ids = [NSMutableArray array];
    NSMutableArray *temps = [NSMutableArray array];
    for (NoticeItem *item in self.dataList){
        if (item.checked){
            [ids addObject:[NSNumber numberWithInteger:item.nid]];
            [temps addObject:item];
        }
    }
    
    if ([ids count] > 0){
        RQNoticeDelete *rq = [[[RQNoticeDelete alloc] init] autorelease];
        rq.noticeIds = ids;
        HUDShowLoading(kStringLoading, nil);
        __block __weak InfoCenterViewController *self_ = self;
        [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            HUDHide();
            if ([rq_.msgContent length] > 0){
                HUDShowMessage(@"删除失败!", nil);
            } else {
                HUDShowMessage(@"删除成功!", nil);
                //Delete local
                for (NoticeItem *item in temps){
                    [self_.dataList removeObject:item];
                }
                [temps removeAllObjects];
                [self_.tableView reloadData];
            }
            
        } sender:nil];
        self.rq = rq;
    }
    
}
//公告
- (void)noticeButtonClick:(id)sender{
    [_noticeButton setBackgroundImage:ResImage(@"seg-left-selected.png") forState:UIControlStateNormal];
    [_msgButton setBackgroundImage:ResImage(@"seg-right.png") forState:UIControlStateNormal];
    [_noticeButton setTitleColor:Color(@"InfoSegBarColor") forState:UIControlStateNormal];
    [_msgButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
   
    _segBar.superview.hidden = NO;
    _segView.hidden = NO;
    self.tableView.hidden = YES;
    _isEditing = YES;
    [self editAction:nil];
   
    [self enableEditting:NO];
    
    NoticeViewController *vc = self.controllers[_segBar.selectedIndex];
    if ([vc.dataList count] == 0){
        [vc launchLoading];
    }
}
//站内信
- (void)msgButtonClick:(id)sender{
    [_noticeButton setBackgroundImage:ResImage(@"seg-left.png") forState:UIControlStateNormal];
    [_msgButton setBackgroundImage:ResImage(@"seg-right-selected.png") forState:UIControlStateNormal];
    [_noticeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_msgButton setTitleColor:Color(@"InfoSegBarColor") forState:UIControlStateNormal];
    
    _segBar.superview.hidden = YES;
    _segView.hidden = YES;
    self.tableView.hidden = NO;

    [self enableEditting:YES];
    
    if ([self.dataList count] == 0){
        [self.tableView launchRefreshing];
    }
}

- (void)enableEditting:(BOOL)enable{
    if (enable){
        UIButton *button = [UIButton barButtonWithTitle:@"编辑"];
        [button addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        [self setRightBarButton:button];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)onSegBarClick:(MSSegmentBar *)sender{
    NoticeViewController *vc = self.controllers[_segBar.selectedIndex];
    if ([vc.dataList count] == 0){
        [vc launchLoading];
    }
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#define kTagCellLine 1000000
#pragma mark - TableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //站内信
    static NSString *identifier = @"cell_site";
    SiteNoticeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = (id)[SiteNoticeCell loadFromNib];
        cell.identifier = identifier;
        cell.delegate = self;
        cell.titleLbl.font = [UIFont systemFontOfSize:15];
        cell.titleLbl.textColor = Color(@"NoticeTextColor ");
        cell.titleLbl.backgroundColor = [UIColor whiteColor];
        
        cell.datetimeLbl.font = [UIFont systemFontOfSize:13];
        cell.datetimeLbl.textColor = Color(@"NoticeLightTextColor");
        cell.datetimeLbl.backgroundColor = [UIColor whiteColor];
        
        cell.typeLbl.textColor = [UIColor lightGrayColor];
        cell.typeLbl.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
        
    }

    cell.row = indexPath.row;
    [cell setEditingCell:_isEditing animated:NO];
    NoticeItem *item = [self.dataList objectAtIndex:indexPath.row];
    cell.typeLbl.text = item.noticeType;
    cell.titleLbl.text = item.subject;
    cell.datetimeLbl.text = item.time;
    cell.iconNew.hidden = item.isRead;
    cell.checkbox.checked = item.checked;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 68.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    NoticeItem *item = self.dataList[indexPath.row];
    if (_isEditing) {
        //编辑时点中本行
        SiteNoticeCell *cell = (id)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.checkbox.checked = !cell.checkbox.checked;
        return;
    }
    
    InfoCenterDetail *vc = [[SiteNoticeDetailViewController alloc] init];
    [(SiteNoticeDetailViewController *)vc setShouldKeep:item.isKeep];
    [(SiteNoticeDetailViewController *)vc setOnSiteNoticeViewed:^(NSInteger noticeId, BOOL deleted) {
        for (NoticeItem *item in self.dataList){
            if (item.nid == noticeId){
                if (deleted){   //delete it
                    [self.dataList removeObject:item];
                } else {        //remove mark
                    item.isRead = YES;
                }
                [self.tableView reloadData];
                break;
            }
        }
    }];

    vc.type = kNoticeTypeSite;
    vc.curItem = item;
    vc.noticeItems = self.dataList;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];

}

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
    
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
}

//Remove bottom lines
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)] autorelease];
    return view;
}

#pragma mark - SiteNoticeCellDelegate
- (void)onSiteNoticeCellCheckBoxValueChanged:(SiteNoticeCell *)cell{
    NoticeItem *item = [self.dataList objectAtIndex:cell.row];
    item.checked = cell.checkbox.checked;
}

#pragma mark - RQBaseDelegate

- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQNotice *)rq error:(NSError *)error{
    [self.tableView tableViewDidFinishedLoading];



    if (error){
        [self.tableView setTipsType:kPRTipsTypeNetworkError];
        if (rq.type == kNoticeTypeSite){
            [self enableEditting:NO];
        }
    }
    else if ([rq.noticeItems count] > 0){
        [self.tableView setTipsType:kPRTipsTypeDefault];
        if (_isRefresh) [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:rq.noticeItems];
        [self enableEditting:YES];
        [self.tableView setTips:nil andIcon:nil];
    }
    else if ([rq.noticeItems count] == 0){
        [self.tableView setTipsType:kPRTipsTypeNoData];
        [self enableEditting:NO];
        [self.tableView setTips:@"暂时没有记录哦" andIcon:ResImage(@"note.png")];
    }
    
//    //Test codes
//    if (!self.dataList) {
//        _dataList = [[NSMutableArray alloc] init];
//    }
//    
//    [_dataList removeAllObjects];
//    for (int i = 0; i < 20; i ++){
//        NoticeItem *item = [[[NoticeItem alloc] init] autorelease];
//        item.nid = 1;
//        item.isKeep = YES;
//        item.isRead = NO;
//        item.subject = @"公告信";
//        item.content = @"公告信";
//        [_dataList addObject:item];
//        [self enableEditting:YES];
//    }
    
    [self.tableView reloadData];
}

@end


@implementation NoticeViewController

- (void)dealloc{
    [self.rq cancel];
    self.rq = nil;
    self.tableView = nil;
    self.dataList = nil;
    [super dealloc];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataList = [NSMutableArray array];
    
    MSPullingRefreshTableView *tv = [[MSPullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-65) pullingDelegate:self];
    tv.headerOnly = YES;
    tv.dataSource = self;
    tv.delegate = self;
    tv.backgroundColor = [UIColor whiteColor];
    tv.autoresizesSubviews = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tv];
    self.tableView = tv;
    
    if ([self.tableView respondsToSelector:@selector(separatorInset)]){
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }

}

- (void)loadData{
    [self.rq cancel];
    RQNotice *req = [[RQNotice alloc] initWithType:self.noticeType];
    [req startPostWithDelegate:self];
    self.rq = req;
    [req release];
}

- (void)launchLoading{
    [self.tableView launchRefreshing];
}

#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#define kTagCellLine 1000000
#pragma mark - TableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //公告
    InfoCenterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:InfoCenerIdentifier];
    if (!cell) {
        cell = (InfoCenterCell *)[InfoCenterCell loadFromNib];
        cell.identifier = InfoCenerIdentifier;
        cell.lblType.textColor = kGreenBGColor;
        cell.lblType.layer.cornerRadius = 4.f;
        cell.lblType.bgColor = kYellowTextColor;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.row = indexPath.row;
    NoticeItem *item = self.dataList[indexPath.row];
    NSString * title = item.subject;
    NSString * dateTime = item.time;
    
    cell.noticeType = self.noticeType;
    cell.lblTitle.font = [UIFont systemFontOfSize:15];
    cell.lblTitle.textColor = [UIColor darkGrayColor];
    cell.lblTitle.backgroundColor = [UIColor whiteColor];
    cell.lblTitle.text = title;
    
    cell.lblDateTime.font = [UIFont systemFontOfSize:13];
    cell.lblDateTime.textColor = [UIColor lightGrayColor];
    cell.lblDateTime.backgroundColor = [UIColor whiteColor];
    cell.lblDateTime.text = dateTime;
    cell.iconNew.hidden = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 68.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NoticeItem *item = self.dataList[indexPath.row];
    InfoCenterDetail *vc = [[InfoCenterDetail alloc] init];
    vc.type = self.noticeType;
    vc.curItem = item;
    vc.noticeItems = self.dataList;
    [self.navi pushViewController:vc animated:YES];
    [vc release];
}

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
    
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
}
//Remove bottom lines
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)] autorelease];
    return view;
}

#pragma mark - RQBaseDelegate

- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQNotice *)rq error:(NSError *)error{
    [self.tableView tableViewDidFinishedLoading];
    
    
    if (error){
        [self.tableView setTipsType:kPRTipsTypeNetworkError];
    }
    else if ([rq.noticeItems count] > 0){
        [self.tableView setTipsType:kPRTipsTypeDefault];
        if (_isRefresh) [self.dataList removeAllObjects];
        [self.dataList  addObjectsFromArray:rq.noticeItems];
        [self.tableView setTips:nil andIcon:nil];
    }
    else if ([rq.noticeItems count] == 0){
        [self.tableView setTipsType:kPRTipsTypeNoData];
        [self.tableView setTips:@"暂时没有记录哦" andIcon:ResImage(@"note.png")];
    }
//    
//    //Test codes
//    if (!self.dataList) {
//        _dataList = [[NSMutableArray alloc] init];
//    }
//    for (int i = 0; i < 20; i ++){
//        NoticeItem *item = [[[NoticeItem alloc] init] autorelease];
//        item.nid = 1;
//        item.isKeep = YES;
//        item.isRead = NO;
//        item.subject = @"通知";
//        item.content = @"通知";
//        [_dataList addObject:item];
//    }

    
    [self.tableView reloadData];
}

@end