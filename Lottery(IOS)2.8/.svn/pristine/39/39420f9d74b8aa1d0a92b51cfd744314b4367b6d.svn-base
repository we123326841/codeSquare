//
//  UserTransationViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-11-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UserTransationViewController.h"
#import "TradeRecordCell.h"

@interface UserTransationViewController ()

@end

@implementation UserTransationViewController

- (void)dealloc{
    [_dataList release];
    [super dealloc];
}

- (void)viewDidLoad
{
    self.title = @"银行账变列表";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view.
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
    [self.view addSubview:_amountLbl];
    
    CGRect tableRect = self.view.bounds;
    tableRect.origin.y = 23.f;
    tableRect.size.height -= (44+23);
    
    MSPullingRefreshTableView* tableView = [[[MSPullingRefreshTableView alloc] initWithFrame:tableRect pullingDelegate:self style:UITableViewStylePlain] autorelease];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.headerOnly = YES;
    tableView.backgroundView = [[[UIView alloc]init] autorelease];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor clearColor];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    _isRefresh = YES;
    
    self.dataList = [[[NSMutableArray alloc] init] autorelease];

    [self.tableView launchRefreshing];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData{
    RQUserTransactionHistory *rq = [[[RQUserTransactionHistory alloc] init] autorelease];
    rq.uid = self.uid;
    rq.username = self.username;
    [rq startPostWithDelegate:self];
    self.rq = rq;
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
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TradeRecordCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TradeRecordIdentifier];
    if (!cell) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"TradeRecordCell" owner:self options:nil];
        
        for (NSObject *o in objects) {
            if ([o isKindOfClass:[TradeRecordCell class]]) {
                cell = (TradeRecordCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.lblTradeType.font = [UIFont boldSystemFontOfSize:14.f];
                cell.lblAmount.font = [UIFont boldSystemFontOfSize:14.f];
                break;
            }
        }
    }
    
    TransactionRecord *tr = [self.dataList objectAtIndex:indexPath.row];
    
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
    cell.lblAccountBalance.text = [NSString stringWithFormat:@"高频余额：%@元", balance];
    
    cell.row = indexPath.row;
    return cell;
    
}

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(requestData) withObject:nil afterDelay:0.5f];
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(requestData) withObject:nil afterDelay:0.5f];
}


#pragma mark - RQBaseDelegate
- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQUserTransactionHistory *)rq error:(NSError *)error{
    if (error) {
        
    }
    else if(rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
        if (rq.msgType == kMessageTypeSessionExpired) {
            [SharedModel signOut];
        }
    }
    else if([rq.transactionList count] > 0){
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:rq.transactionList];
        [self.tableView reloadData];
    }
    [self.tableView tableViewDidFinishedLoading];
    //    [self.tableView setContentOffset:CGPointZero];
    
    float i = 0;
    for (TransactionRecord *tr in self.dataList) {
//        if (tr.time) {
//            NSString *date = [[tr.time componentsSeparatedByString:@" "] objectAtIndex:0];
//            if ([date isEqualToString:_dateString]) {
                i +=tr.change;
//            }else {
//                break;
//            }
//        }
    }
//    if ([self.tradeType intValue] == 0) {
        NSString *amount = [NSString stringWithFormat:@"%.4f",i];
        if ([amount hasPrefix:@"-"]) {
            _amountLbl.text = [NSString stringWithFormat:@"%@ 当前资金变动 -%@",_dateString, [SharedModel formatBalance:[amount substringFromIndex:1]]];
        }else {
            _amountLbl.text = [NSString stringWithFormat:@"%@ 当前资金变动 %@",_dateString, [SharedModel formatBalance:amount]];
        }
//    }
}

@end
