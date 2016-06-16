//
//  MyAccountTableView.m
//  Caipiao
//
//  Created by CYRUS on 14-8-4.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "MyAccountTableView.h"
#import "RQGameHistory.h"
#import "RQZhuiHaoInfo.h"
#import "GameHistoryDetailVC.h"
#import "ZhuiHaoInfoVC.h"
#import "AccountCell.h"

@interface MyAccountTableView ()<AccountCellDelegate>

@property (retain, nonatomic) NSMutableArray *collectionDataList;

@end

@implementation MyAccountTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    _dataList = [[NSMutableArray alloc] init];
     _collectionDataList = [[NSMutableArray alloc]init];
    _tableView = [[MSPullingRefreshTableView alloc] initWithFrame:self.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.pullingDelegate = self;
    _tableView.headerOnly = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:_tableView];
}

- (void)startLoading
{
    if (self.rq) {
        [self.rq cancel];
        self.rq = nil;
    }
    if (_isRefresh) [_tableView tableViewDidFinishedLoading];
    [_dataList removeAllObjects];
    [self reloadData];
    [_tableView performSelector:@selector(launchRefreshing) withObject:nil afterDelay:.1f];
}

- (void)reloadData
{
    [self createCollectionDataList];
    [_tableView reloadData];
    if ([_collectionDataList count] == 0){
        [_tableView setTips:@"暂无投注记录哦，快去试试手气吧" andIcon:ResImage(@"note.png")];
    } else {
        [_tableView setTips:nil andIcon:nil];
    }
}

-(void)createCollectionDataList
{
    NSComparator cmptr = ^(id obj1, id obj2)
    {
        NSComparisonResult result;
        if ([obj1 isKindOfClass:[GameRecord class]]) {
            result = [[obj1 playTime] compare: [obj2 playTime]];
        }else
        {
          result = [[obj1 begainTime] compare: [obj2 begainTime]];
        }
        switch (result) {
            case NSOrderedAscending:
                return NSOrderedDescending;
                break;
            case NSOrderedDescending:
                return NSOrderedAscending;
            default:
                return NSOrderedSame;
                break;
        }

    };
    
   NSArray *objectList =  [_dataList sortedArrayUsingComparator:cmptr];
    
    [_collectionDataList removeAllObjects];
//    [_dataList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSLog(@"^^^%@",[self getDate:obj]);
//    }];
//    [objectList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSLog(@"^^^%@",[self getDate:obj]);
//    }];
    NSMutableArray *indexs = [NSMutableArray array];
    
    for (int i=0;i<objectList.count;i++)
    {
        id obj = objectList[i];
        
        if ([[self getDate:obj] isEqualToString:[self getDate:objectList[(i<objectList.count-1?i+1:i)]]])
        {
            if (i==objectList.count-1) {
                [indexs addObject:[NSNumber numberWithInt:i]];
            }
        }else
        {
            [indexs addObject:[NSNumber numberWithInt:i]];
        }
    }
   //  NSLog(@"&&%@",indexs);
    
    int j=0;
    for (int i=0; i<indexs.count; i++)
    {
        NSInteger index = [indexs[i] integerValue];
        NSMutableArray *sub = [NSMutableArray array];
        for (int k=j; k<=index; k++)
        {
            [sub addObject:objectList[k]];
        }
        j += sub.count;
        [_collectionDataList addObject:sub];
    }
   // NSLog(@"$$%@",_collectionDataList);
}
-(NSString *)getDate:(id)object
{
    if ([object isKindOfClass:[GameRecord class]])
    {
        GameRecord *obj = (GameRecord*)object;
        return [obj.playTime substringToIndex:10];
        
    }else
    {
        ZhuiHaoInfoItem *obj = (ZhuiHaoInfoItem*)object;
        return [obj.begainTime substringToIndex:10];
    }
}
- (void)loadData
{
    if (self.rq) {
        [self.rq cancel];
        self.rq = nil;
    }
    [_tableView setTips:nil andIcon:nil];

    if (_type == kDataTypeGameHistory) {
        RQGameHistory *rq = [[[RQGameHistory alloc] init] autorelease];
        [rq startPostWithDelegate:self];
        self.rq = rq;
    }else {
        RQZhuiHaoInfo *rq = [[[RQZhuiHaoInfo  alloc] init] autorelease];
        [rq startPostWithDelegate:self];
        self.rq = rq;
    }
    
}

#pragma mark - MSPullingRefreshTableViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
    
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_collectionDataList count];
}
-(NSUInteger)rowCount
{
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AccountCell";
    AccountCell *cell = nil;
    cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
          cell = [[[AccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]autorelease];
    }
    cell.delegate=self;
    cell.dataList = _collectionDataList[indexPath.row];

    cell.type = _type;
    
    [cell layoutSelfSubview];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = _collectionDataList[indexPath.row];
    return [arr count]*56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
}
- (void)cell:(AccountCell *)cell subCell:(MyAccountCell *)subCell indexpath:(NSIndexPath*)indexPath
{
 
    if (_type == kDataTypeGameHistory) {
//        GameRecord *model = [_dataList objectAtIndex:indexPath.row];
        GameRecord *model =(GameRecord*) subCell.object;

        GameHistoryDetailVC *vc = [[GameHistoryDetailVC alloc] initWithNibName:@"GameHistoryDetailVC" bundle:nil];
        vc.recordId = model.recordId;
        vc.chan_id = model.channelid;
        vc.model = model;
        vc.index = indexPath.row;
        
        __block NSMutableArray *blkArr = _dataList;
        __block MSPullingRefreshTableView *blkTab = _tableView;
        [vc setUpdateListBlock:^(GameRecord *gr, NSInteger index) {
            [blkArr replaceObjectAtIndex:index withObject:model];
            [blkTab reloadData];
        }];
        [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc]autorelease] animated:YES];
        [vc release];
    }else {
//        ZhuiHaoInfoItem *item = [_dataList objectAtIndex:indexPath.row];
        ZhuiHaoInfoItem *item = (ZhuiHaoInfoItem*)subCell.object;

        ZhuiHaoInfoVC *vc = [[ZhuiHaoInfoVC alloc] initWithNibName:@"ZhuiHaoInfoVC" bundle:nil];
        vc.title = @"注单详情";
        vc.model = item;
        vc.isLowGame = [item.channelId intValue] == 1 ? YES : NO;
        [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
        [vc release];
    }

    
}

#pragma mark - RQBaseDelegate

- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    
    if (error) {
        [self.tableView setTipsType:kPRTipsTypeNetworkError];
    }
    else if (rq.msgContent) {
        [HUDView showMessageToView:self msg:rq.msgContent subtitle:nil];

        if (rq.msgType == kMessageTypeSessionExpired) {
            [SharedModel signOut];
        }
    }else {
        [_dataList removeAllObjects];
        if (_type == kDataTypeGameHistory) {
            
            RQGameHistory *rq_ = (RQGameHistory *)rq;
            
//            假数据
//            for (int i=0; i<20; i++) {
//                GameRecord *r = [GameRecord new];
//                r.lotteryName=[NSString stringWithFormat:@"XXX%i",i];
//                r.methodName=@"yyyy";
//                r.recordId=[NSString stringWithFormat:@"%i",i];
//                r.win = i%4;
//                r.iscancel = i%2;
//                r.gameName = @"双色球";
//                r.methodId = i+19;
//                r.playType=@"dd";
//                r.playTime=[NSString stringWithFormat:@"2014-10-%i ",(i<4)?18:(i>28?30:i)];
//                r.amount=@"32";
//                r.issueNumber=@"99";
//                r.bonus=@"15666";
//                r.number=@"201407777";
//                r.channelid=55;
//                r.lotteryid=66;
//                
//                [rq_.recordList addObject:r];
//            }
            
            
            if ([rq_.recordList count] > 0) {
                if (_subType == 0) {
                    [_dataList addObjectsFromArray:rq_.recordList];
                }else if (_subType == 1) {
                    for (GameRecord *gr in rq_.recordList){
                        if (gr.win == 1)  [_dataList addObject:gr];
                    }
                }else if (_subType == 2) {
                    for (GameRecord *gr in rq_.recordList){
                        if (gr.win == 2) [_dataList addObject:gr];
                    }
                }else if (_subType == 3) {
                    for (GameRecord *gr in rq_.recordList){
                        if (gr.win == 3) [_dataList addObject:gr];
                    }
                }
//                [_tableView reloadData];
                [self.tableView setTipsType:kPRTipsTypeDefault];
            }
        }else {
            RQZhuiHaoInfo *rq_ = (RQZhuiHaoInfo *)rq;
//            假数据
//            for (int i=0; i<=30; i++) {
//                ZhuiHaoInfoItem *r = [ZhuiHaoInfoItem new];
//                r.lotteryName=[NSString stringWithFormat:@"YYY%i_%i",i,self.type];
//                r.methodId=2233;
//                r.multiple=i;
//                r.status = @(i%3);
//                r.taskId = @"5457";
//                r.username = @"双色球";
//                r.methodId = i+19;
//                r.taskPrice=@6678;
//                r.stopOnWin=@2013;
//                r.cancelCount=@32;
//                r.issueCount=@99;
//                r.bonus=@15666;
//                r.finishedCount=@201407777;
//                r.channelId=@55;
//                r.lotteryId=@66;
//                r.begainTime = [NSString stringWithFormat:@"2014-06-%i ",(i>5&&i<9)?44:i];
//                r.beginIssue= @"retr";
//                r.codes= @"retr";
//                r.methodname= [NSString stringWithFormat:@"YYY%i_%i",i,self.type];
//                r.cnname= [NSString stringWithFormat:@"YYY%i_%i",i,self.type];
//                [rq_.dataList addObject:r];
//            }

            if ([rq_.dataList count] > 0) {
                if (_subType == 0) {
                    [_dataList addObjectsFromArray:rq_.dataList];
                }else if (_subType == 1) {
                    for (ZhuiHaoInfoItem *model in rq_.dataList){
                        if ([model.status intValue] == 1)  [_dataList addObject:model];
                    }
                }else if (_subType == 2) {
                    for (ZhuiHaoInfoItem *model in rq_.dataList){
                        if ([model.status intValue] == 2) [_dataList addObject:model];
                    }
                }else if (_subType == 3) {
                    for (ZhuiHaoInfoItem *model in rq_.dataList){
                        if ([model.status intValue] == 3) [_dataList addObject:model];
                    }
                }
                //[_tableView reloadData];
                [self.tableView setTipsType:kPRTipsTypeDefault];
            }
        }
        
        if ([_dataList count] == 0){
            [_tableView setTips:@"暂无投注记录哦，快去试试手气吧" andIcon:ResImage(@"note.png")];
        } else {
            [_tableView setTips:nil andIcon:nil];
        }
    }
    
    [self.tableView tableViewDidFinishedLoading];
    
    MSNotificationCenterPost(kMyAccountRecordReqFinish);
}

#pragma mark -- UIScrollviewDelegate
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
  
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  [self.tableView tableViewDidScroll:scrollView];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableview:didScroll:)]) {
        [self.delegate tableview:self didScroll:scrollView];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableview:scrollViewWillBeginDragging:)]) {
        [self.delegate tableview:self scrollViewWillBeginDragging:scrollView];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tableview:scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate tableview:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

@end
