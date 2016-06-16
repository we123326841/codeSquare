//
//  ZhuiHaoDetailVC.m
//  Caipiao
//
//  Created by Cyrus on 13-6-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "ZhuiHaoDetailVC.h"
#import "ZhuiHaoDetailCell.h"
#import "RQRevokeZhuiHaoOrder.h"
#import "AutoHideAlertView.h"
#import "LoadingAlertView.h"

@interface ZhuiHaoDetailVC ()

@end

@implementation ZhuiHaoDetailVC
@synthesize tableView = _tableView;
@synthesize dataList = _dataList;
@synthesize taskId = _taskId;
@synthesize countLbl = _countLbl;
@synthesize selectionView = _selectionView;
@synthesize selectedLbl = _selectedLbl;
@synthesize stopZhuiHaoButton = _stopZhuiHaoButton;

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
    [_dataList release];
    [_selectAllBtn release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rect;
    if (IPHONE5) {
        rect = CGRectMake(0, 23, 320, self.view.frame.size.height-23);
    }else {
        rect = CGRectMake(0, 23, 320, self.view.frame.size.height-23-88);
    }
    _tableView.pullingDelegate = self;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.headerOnly = YES;
    _tableView.backgroundColor = Color(@"ZhuihaoDetailTableViewBackground");
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _rightBarButton = [UIButton barButtonWithTitle:@"编辑"];
    [_rightBarButton addTarget:self action:@selector(editZhuiHao:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];
    self.navigationItem.rightBarButtonItem = barButton;
    [barButton release];
    
    _selectedLbl.textColor = Color(@"ZhuihaoDetailSelectedLabelColor");
    _selectedTagLbl.textColor = Color(@"ZhuihaoDetailSelectedTagLabelColor");
    [_stopZhuiHaoButton setTitleColor:Color(@"ZhuihaoDetailSelectedButtonColor") forState:UIControlStateNormal];
    [_stopZhuiHaoButton setEnabled:NO];
    [_stopZhuiHaoButton addTarget:self action:@selector(stopZhuiHao:) forControlEvents:UIControlEventTouchUpInside];
    [_selectAllBtn setTitleColor:Color(@"ZhuihaoDetailSelectedButtonColor") forState:UIControlStateNormal];

    
    _selectedCount = 0;
    if (!_dataList) {
          _dataList = [[NSMutableArray alloc] init];
    }
    _editArray = [[NSMutableArray alloc] init];
    _isEditing = NO;
//    [self.tableView performSelector:@selector(launchRefreshing) withObject:nil afterDelay:.1f];
    
   
    _selectedCount = 0;
    _selectedLbl.text = [NSString stringWithFormat:@"%ld",(long)_selectedCount];
    _countLbl.text = [NSString stringWithFormat:@"共%lu期",(unsigned long)[self.dataList count]];
     [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    RQZhuiHaoDetail *rq = [[[RQZhuiHaoDetail alloc] init] autorelease];
    rq.rqId = _taskId;
    rq.isLowGame = _isLowGame;
    [rq startPostWithDelegate:self];
    
    self.rq = rq;
}

- (void)editZhuiHao:(id)sender
{
    _isEditing = !_isEditing;
    if (_isEditing) {
        
        [_rightBarButton setTitle:@"取消" forState:UIControlStateNormal];
        CGRect rect = _tableView.frame;
        rect.size.height -=60;
        _tableView.frame = rect;

        [UIView animateWithDuration:0.3 animations:^{
            _selectionView.frame = CGRectMake(0, self.view.frame.size.height-60, _selectionView.frame.size.width, _selectionView.frame.size.height);
        }];
    }else {
        
        [_rightBarButton setTitle:@"编辑" forState:UIControlStateNormal];
        CGRect rect = IPHONE5 ? CGRectMake(0, 23, 320, self.view.frame.size.height-23) : CGRectMake(0, 23, 320, self.view.frame.size.height-23-88);
        _tableView.frame = rect;

        [UIView animateWithDuration:0.3 animations:^{
            _selectionView.frame = CGRectMake(0, self.view.frame.size.height, _selectionView.frame.size.width, _selectionView.frame.size.height);
        }];
    }
    [_tableView reloadData];
}

- (void)stopZhuiHao:(id)sender
{
    [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
    
    NSString *taskString = @"";
    for (int i = 0; i < [_dataList count]; ++i) {
        ZhuiHaoDetailModel *model = [_dataList objectAtIndex:i];
        if (model.isSelected) {
            taskString = [taskString stringByAppendingFormat:@"%@,",model.taskDetailId];
        }
    }
    if (taskString.length>0)
    taskString = [taskString substringToIndex:[taskString length]-1];
    
    NSString *issueStr = @"";
     RQZhuiHaoDetail *rq = (RQZhuiHaoDetail*)self.rq;
//    for (int i = 0; i < [rq.tasks count]; ++i) {
//        ZhuiHaoIssueModel *model = [rq.tasks  objectAtIndex:i];
//        issueStr = [issueStr stringByAppendingFormat:@"%@,",model.issueCode];
//    }
    for (int i = 0; i < [_dataList count]; ++i) {
        ZhuiHaoDetailModel *model = [_dataList objectAtIndex:i];
        if (model.isSelected) {
            issueStr = [issueStr stringByAppendingFormat:@"%@,",model.issueCode];
        }
    }
    if (issueStr.length>0)
    issueStr = [issueStr substringToIndex:[issueStr length]-1];

    
    RQRevokeZhuiHaoOrder *rqrz = [[RQRevokeZhuiHaoOrder alloc] init];
    rqrz.recordId = _taskId;
    rqrz.taskId = taskString;
    rqrz.lotteryId = rq.lotteryId;
    rqrz.issueCode = issueStr;
    rqrz.isLowGame = self.isLowGame;
    
    [rqrz startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        Echo(@"RQRevokeZhuiHaoOrder | %ld,%@",(long)rq_.msgType,rq_.msgContent);
        [HUDView dismissCurrent];
        if (rq_.msgContent) {
            [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:rq_.msgContent subtitle:nil];
        }else {
            if ([rqrz.messageType intValue] == 0) {
                [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:@"终止追号成功！" subtitle:nil];

                for (int i = 0; i < [_dataList count]; ++i) {
                    ZhuiHaoDetailModel *model = [_dataList objectAtIndex:i];
                    if (model.isSelected) {
                        model.isSelected = NO;//设置完之后返回没有选择的状态
                        model.canCancel = 0;
                        model.status = [NSNumber numberWithInt:2];
                    }
                    [_dataList replaceObjectAtIndex:i withObject:model];
                }
                [self editZhuiHao:nil];
                [self.tableView reloadData];
                
                [_stopZhuiHaoButton setEnabled:NO];
                _selectedCount = 0;
            }else {
                [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:@"已过撤单时间！" subtitle:nil];
            }
        }
        _selectedLbl.text = [NSString stringWithFormat:@"%ld",(long)_selectedCount];
        [rq_ release];
    } sender:nil];
    
}
- (IBAction)selectAllAction:(id)sender {
    [_dataList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ZhuiHaoDetailModel *item = (ZhuiHaoDetailModel *)obj;
        if ([item.canCancel intValue] ==1) {
            item.isSelected = YES;
        }else {
            item.isSelected = NO;
        }
    }];
    _selectedCount = _dataList.count;
    _selectedLbl.text = [NSString stringWithFormat:@"%ld",(long)_selectedCount];
    _stopZhuiHaoButton.enabled=YES;
    [_tableView reloadData];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ZhuiHaoDetailCell";
    ZhuiHaoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhuiHaoDetailCell" owner:self options:nil] lastObject];
    }
    
    ZhuiHaoDetailModel *item = [self.dataList objectAtIndex:indexPath.row];
    
    //"如果taskDetailNo不为null则status表示
    //1:等待开奖 2:中奖 3:未中奖 4:撤销 5:存在异常(显示处理中) 6:数据归档
    //若为null则表示
    //0:未生成;1:生成追号单;2:追号单取消"
    if (item.taskDetailNo) {
        if ([item.status intValue] == 1)
        {
            cell.statusLbl.text = @"等待开奖";
        }else if ([item.status intValue] == 2) {
            cell.statusLbl.text = @"已中奖";
        }else if ([item.status intValue] == 3){
            cell.statusLbl.text = @"未中奖";
        }else {
          cell.statusLbl.text = @"";
        }

    }else
    {//未生成
        if ([item.status intValue] == 0) {
            cell.statusLbl.text = @"未生成";
        }else if ([item.status intValue] == 1) {
            cell.statusLbl.text = @"生成追号单";
        }else {
            cell.statusLbl.text = @"追号单取消";
        }
    }
    
    {
        cell.statusLbl.textColor = Color(@"ZhuihaoDetailCellStatusColor");
        cell.backgroundColor = Color(@"ZhuihaoDetailCellBackground");
        cell.contentView.backgroundColor = Color(@"ZhuihaoDetailCellBackground");
        cell.numberLbl.textColor = Color(@"ZhuihaoDetailCellIssueColor");
        cell.multipleLbl.textColor = Color(@"ZhuihaoDetailCellAmountColor");
    }
    
    cell.numberLbl.text = [NSString stringWithFormat:@"第%@期",item.issue];
    cell.multipleLbl.text = [NSString stringWithFormat:@"追号倍数：%@", [item.multiple stringValue]];

//    if ([item.status intValue] ==1) {
//        [cell.selectionButton setEnabled:NO];
//    }else {
//        if ([item.canCancel intValue] == 0) {
//            [cell.selectionButton setEnabled:NO];
//        }else {
//            [cell.selectionButton setEnabled:YES];
//        }
//    }
    
    
    if ([item.canCancel intValue] ==1) {
        [cell.selectionButton setEnabled:YES];
    }else {
         [cell.selectionButton setEnabled:NO];
    }
    
    if (item.isSelected) {
        cell.isSelected = YES;
        [cell.selectionButton setImage:ResImage(@"badge_selected.png") forState:UIControlStateNormal];
    }else {
        cell.isSelected = NO;
        [cell.selectionButton setImage:ResImage(@"badge_unselected.png") forState:UIControlStateNormal];
    }
    
    [cell.selectionButton addTarget:self action:@selector(selectionZhuiHao:) forControlEvents:UIControlEventTouchUpInside];
    
    float offset = 30.f;
    if (_isEditing) {
//        [UIView animateWithDuration:0.3 animations:^{            
//            for (UIView *view in [cell.contentView subviews]) {
//                view.frame = CGRectMake(view.frame.origin.x + offset, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
//            }
//        }];
        for (UIView *view in [cell.contentView subviews]) {
            if (!([view isKindOfClass:[UILabel class]]&&view.tag==9999)) {
                view.frame = CGRectMake(view.frame.origin.x + offset, view.frame.origin.y, view.frame.size.width, view.frame.size.height);

            }
        }
    }
//    else {
//        for (UIView *view in [cell.contentView subviews]) {
//            view.frame = CGRectMake(view.frame.origin.x + offset, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
//        }
//        [UIView animateWithDuration:0.3 animations:^{
//            for (UIView *view in [cell.contentView subviews]) {
//                view.frame = CGRectMake(view.frame.origin.x - offset, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
//            }
//        }];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isEditing) {
        ZhuiHaoDetailCell *cell = (ZhuiHaoDetailCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [self cellForSelectStatus:cell];
    }
    
}

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.3f];
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.3f];
}

- (void)selectionZhuiHao:(id)sender
{
    UIButton *button = (UIButton *)sender;
    ZhuiHaoDetailCell *cell = nil;
    id superview = [button superview];
    while (![superview isKindOfClass:[ZhuiHaoDetailCell class]]) {
        superview = [superview superview];
    };
//    if (IOS7) cell = (ZhuiHaoDetailCell *)button.superview.superview.superview;
//    else cell = (ZhuiHaoDetailCell *)button.superview.superview;
    cell = (ZhuiHaoDetailCell *)superview;
    [self cellForSelectStatus:cell];
}

- (void)cellForSelectStatus:(ZhuiHaoDetailCell *)cell
{
    if (cell.selectionButton.enabled) {
        ZhuiHaoDetailModel *model = [_dataList objectAtIndex:[_tableView indexPathForCell:cell].row];
        cell.isSelected = !cell.isSelected;
        if (cell.isSelected) {
            [cell.selectionButton setImage:ResImage(@"badge_selected.png") forState:UIControlStateNormal];
            model.isSelected = YES;
            ++_selectedCount;
        }else {
            [cell.selectionButton setImage:ResImage(@"badge_unselected.png") forState:UIControlStateNormal];
            model.isSelected = NO;
            --_selectedCount;
        }
        
        if (_selectedCount > 0) {
            [_stopZhuiHaoButton setEnabled:YES];
        }else {
            [_stopZhuiHaoButton setEnabled:NO];
        }
        Echo(@"row :%ld | select = %@",(long)[_tableView indexPathForCell:cell].row,model.isSelected ? @"YES":@"NO");
        _selectedLbl.text = [NSString stringWithFormat:@"%ld",(long)_selectedCount];
        [_dataList replaceObjectAtIndex:[_tableView indexPathForCell:cell].row withObject:model];
    }
}

#pragma mark - RQDelegate

- (void)onRQComplete:(RQZhuiHaoDetail *)rq error:(NSError *)error{
    if (!rq.msgContent) {
        
        if (_isRefresh) {
            [self.dataList removeAllObjects];
        }
        [self.dataList addObjectsFromArray:rq.issueList];
        [self.tableView reloadData];
    }
    
    _selectedCount = 0;
    _selectedLbl.text = [NSString stringWithFormat:@"%ld",(long)_selectedCount];
    _countLbl.text = [NSString stringWithFormat:@"共%lu期",(unsigned long)[self.dataList count]];
    [self.tableView tableViewDidFinishedLoading];
}

- (void)viewDidUnload {
    [self setSelectAllBtn:nil];
    [super viewDidUnload];
}
@end
