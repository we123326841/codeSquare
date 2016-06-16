//
//  FundsSlideVC.m
//  Caipiao
//
//  Created by CYRUS on 14-8-5.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "FundsSlideVC.h"
#import "RQTransactionHistory.h"
#import "FundsCell.h"
#import "RechargeDetailViewController.h"

@interface FundsSlideVC ()

@end

@implementation FundsSlideVC

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
    _isLowGame = NO;
    
    _dataList = [[NSMutableArray alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.pullingDelegate = self;
    _tableView.headerOnly = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView=[[[UIView alloc]init]autorelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startLoading
{
    if (self.rq) {
        [self.rq cancel];
        self.rq = nil;
    }
    if (_isRefresh) [_tableView tableViewDidFinishedLoading];
    [_dataList removeAllObjects];
    [_tableView reloadData];
    [_tableView performSelector:@selector(launchRefreshing) withObject:nil afterDelay:.1f];
}

- (void)loadData
{
    if (self.rq) {
        [self.rq cancel];
    }
    
    if([_type isEqualToString:@"ADAL"]) //充值
    {
        RQRechargeRecord *rq = [[[RQRechargeRecord alloc] init] autorelease];
        rq.chargeType = @"0";
        [rq startPostWithDelegate:self];
        self.rq = rq;
    }
    else
    {
        RQTransactionHistory *rq = [[[RQTransactionHistory alloc] init] autorelease];
        rq.ordertype = _type;
        //    rq.chan_id = _isLowGame ? 1 : 4;

        rq.chan_id =  4;
        [rq startPostWithDelegate:self];
        self.rq = rq;
    
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

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5f];
    
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5f];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_type isEqualToString:@"ADAL"]) //充值
    {
        static NSString *identifier = @"FundsCell";
        FundsCell *cell = nil;
        cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FundsCell" owner:self options:nil] lastObject];
        }
    
        RechargeRecordModel *model = [_dataList objectAtIndex:indexPath.row];
        
        cell.typeLabel.text = model.type;
        cell.timeLabel.text = model.time;
        
        switch (model.status) {
            case 1:
                cell.statusLabel.text = @"支付中";
                break;
            case 2:
                cell.statusLabel.text = @"支付成功";
                break;
            case 3:
                cell.statusLabel.text = @"订单关闭";
                break;
            case 4:
                cell.statusLabel.text = @"用户关闭";
                break;
            case 5:
                cell.statusLabel.text = @"管理员关闭";
                break;
            default:
                break;
        }
        
        NSString *changeStr = [SharedModel formatBalancef:model.applyMoney];
        if (model.applyMoney>0) {
            changeStr = [NSString stringWithFormat:@"+%@",changeStr];
        }
        cell.moneyLabel.text = changeStr;
  
        cell.typeLabel.textColor = Color(@"FundsViewCellNameColor");
        cell.timeLabel.textColor = Color(@"FundsViewCellTimeColor");
        cell.statusLabel.textColor = Color(@"FundsViewCellNameColor");
        if (model.applyMoney > 0) {
            cell.moneyLabel.textColor = Color(@"FundsViewCellAmountPlusColor");
        }else {
            cell.moneyLabel.textColor = Color(@"FundsViewCellAmountReduceColor");
        }
        return cell;
    }
    else
    {
        static NSString *identifier = @"FundsCell";
        FundsCell *cell = nil;
        cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FundsCell" owner:self options:nil] lastObject];
        }
        
        TransactionRecord *model = [_dataList objectAtIndex:indexPath.row];
        cell.typeLabel.text = model.type;
        cell.timeLabel.text = model.time;
        NSString *changeStr = [SharedModel formatBalancef:model.change];
        if (model.change>0) {
            changeStr = [NSString stringWithFormat:@"+%@",changeStr];
        }
        cell.statusLabel.text = changeStr;
        
        cell.typeLabel.textColor = Color(@"FundsViewCellNameColor");
        cell.timeLabel.textColor = Color(@"FundsViewCellTimeColor");
        if (model.change > 0) {
            cell.statusLabel.textColor = Color(@"FundsViewCellAmountPlusColor");
        }else {
            cell.statusLabel.textColor = Color(@"FundsViewCellAmountReduceColor");
        }
        if ([model.type isEqualToString:@"充值"]) {
            cell.statusLabel.textColor = Color(@"FundsViewCellRechargeColor");
        }
        if ([model.type isEqualToString:@"提现"]) {
            cell.statusLabel.textColor = Color(@"FundsViewCellCashColor");
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([_type isEqualToString:@"ADAL"]) //充值
    {
        NSArray *childVC =  [[AppDelegate shared].nav.viewControllers.lastObject childViewControllers];
        UINavigationController *navi = [childVC firstObject];
        
        RechargeRecordModel *item = [self.dataList objectAtIndex:indexPath.row];
        
        RechargeDetailViewController *vc = [[RechargeDetailViewController alloc] init];
        vc.model = item;
        [navi pushViewController:vc animated:YES];
        [vc release];
    }
}

#pragma mark - RQBaseDelegate

- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    
//    TransactionRecord *model1 = [[TransactionRecord alloc]init];
//    model1.type = @"充值";
//    model1.change = 104500;
//    model1.time  =@"20110708";
//    model1.balance= @"200708";
//    
//    TransactionRecord *model2 = [[TransactionRecord alloc]init];
//    model2.type = @"提现";
//    model2.change = 104500;
//    model2.time  =@"20110708";
//    model2.balance= @"200708";
//    
//    TransactionRecord *model3 = [[TransactionRecord alloc]init];
//    model3.type = @"1";
//    model3.change = 104500;
//    model3.time  =@"20110708";
//    model3.balance= @"200708";
//    
//    TransactionRecord *model4 = [[TransactionRecord alloc]init];
//    model4.type = @"2";
//    model4.change = 104500;
//    model4.time  =@"20110708";
//    model4.balance= @"200708";
//    
//    [rq.transactionList addObject:model1];
//    [rq.transactionList addObject:model2];
//
//    [rq.transactionList addObject:model3];
//
//    [rq.transactionList addObject:model4];

    if (error) {
        [self.tableView setTipsType:kPRTipsTypeNetworkError];
    }
    else if(rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
        if (rq.msgType == kMessageTypeSessionExpired) {
            [SharedModel signOut];
        }
    }
    else if ([_type isEqualToString:@"ADAL"]) //充值
    {
         RQRechargeRecord *rechargeRecordRQ = (id)rq;
        
        if ([rechargeRecordRQ.rechargeRecordList count] > 0) {
            
            [_dataList removeAllObjects];
            [_dataList addObjectsFromArray:rechargeRecordRQ.rechargeRecordList];
            [_tableView reloadData];
            
            [_tableView setTips:nil andIcon:nil];
        }
        else if([rechargeRecordRQ.rechargeRecordList count] == 0){
            [_tableView setTips:@"暂时没有记录哦" andIcon:ResImage(@"note.png")];
        }
    }
    else if ([rq isKindOfClass:[RQTransactionHistory class]])
    {
        RQTransactionHistory *transactionHistoryRQ = (id)rq;
        
        if ([transactionHistoryRQ.transactionList count] > 0) {
            
            [_dataList removeAllObjects];
            [_dataList addObjectsFromArray:transactionHistoryRQ.transactionList];
            [_tableView reloadData];
            
            [_tableView setTips:nil andIcon:nil];
        }
        else if([transactionHistoryRQ.transactionList count] == 0){
            [_tableView setTips:@"暂时没有记录哦" andIcon:ResImage(@"note.png")];
        }
    }
    
    [self.tableView tableViewDidFinishedLoading];
}

@end
