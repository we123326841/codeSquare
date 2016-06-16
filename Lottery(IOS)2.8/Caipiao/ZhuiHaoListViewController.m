//
//  ZhuiHaoListViewController.m
//  Caipiao
//
//  Created by danal on 13-5-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "ZhuiHaoListViewController.h"
#import "ZhuiHaoCell.h"
#import "ZhuiHaoInfoVC.h"

#import "SharedModel.h"
#import "HallViewController.h"
#import "CDLottery.h"

@interface ZhuiHaoListViewController ()

@end

@implementation ZhuiHaoListViewController
@synthesize tableView = _tableView, dataList = _dataList;
@synthesize selectBlock = _selectBlock;

- (void)dealloc{
    self.selectBlock = NULL;
    self.dataList = nil;
    self.allArray = nil;
    self.typeArray = nil;
    [_titleLbl release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _isLowGame = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsZhuiHaoChannelIsLowGame];
    if (_isLowGame) {
        self.title = @"低频追号信息";
    }else {
        self.title = @"高频追号信息";
    }
    
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    
    GreenBar *bar = [[GreenBar alloc] initWithFrame:CGRectMake(0, 23, 320, 45)];
    bar.numberOfButton = 4;
    bar.delegate = self;
    [bar greenBarLabelWithTitle:@"全部" isSelected:YES byIndex:0];
    [bar greenBarLabelWithTitle:@"已完成" isSelected:NO byIndex:1];
    [bar greenBarLabelWithTitle:@"进行中" isSelected:NO byIndex:2];
    [bar greenBarLabelWithTitle:@"中奖" isSelected:NO byIndex:3];
    [_contentView addSubview:bar];
    [bar release];
    
    CGRect rect;
    if (IPHONE5) {
        rect = CGRectMake(0, 68, 320, self.view.frame.size.height - 68);
    }else {
        rect = CGRectMake(0, 68, 320, self.view.frame.size.height - 68 - 88);
    }
    MSPullingRefreshTableView *tableView =[[MSPullingRefreshTableView alloc] initWithFrame:rect pullingDelegate:self];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.headerOnly = YES;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentView addSubview:tableView];
    self.tableView = tableView;
    
    _dataList = [[NSMutableArray alloc] init];
    _typeArray = [[NSMutableArray alloc] init];
    _allArray = [[NSMutableArray alloc] init];
    _isRefresh = YES;
    [self.tableView performSelector:@selector(launchRefreshing) withObject:nil afterDelay:.1f];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    if (self.rq) {
        [self.rq cancel];
    }
    
    RQZhuiHaoInfo *rq = [[[RQZhuiHaoInfo  alloc] init] autorelease];
    //rq.isLowGame = _isLowGame;
    [rq startPostWithDelegate:self];
    self.rq = rq;
}

- (void)switchChannel:(id)sender
{
    _isLowGame = !_isLowGame;
    
    //保存最后一次使用的频道
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:_isLowGame forKey:kUserDefaultsZhuiHaoChannelIsLowGame];
    [ud synchronize];
    
    _selectedType = @"";
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
    
    [self.dataList removeAllObjects];
    [_tableView reloadData];
    
    UIButton *button = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    [titles addObject:@"全部彩种"];
    NSArray *arr = [CDLottery all];
    for (CDLottery *obj in arr) {
        int channelId = _isLowGame ? 1 : 4;
        if ([obj.channelid intValue] == channelId) {
            [titles addObject:obj.name];
        }
    }
    if (_isLowGame) {
        [button setBackgroundImage:[UIImage imageNamed:@"button_highgame.png"] forState:UIControlStateNormal];
        ntc.text = @"低频追号信息";
        
    }else {
        [button setBackgroundImage:[UIImage imageNamed:@"button_lowgame.png"] forState:UIControlStateNormal];
        ntc.text = @"高频追号信息";
    }
    [self.navTitleMenu removeFromSuperview];
    NavTitleMenu *menu = [[NavTitleMenu alloc] initWithFrame:CGRectMake(0, 0, 320.f, 100.f) titles:titles];
    [menu selectItemForTitle:self.title];
    [menu addTarget:self selector:@selector(titleMenuSelectAction:)];
    menu.delegate = self;
    self.navTitleMenu = menu;
    self.navTitleMenu.selectedIndex = 0;
    [menu release];
    [titles release];
    
    [self.tableView tableViewDidEndDragging:self.tableView];
    [self.tableView launchRefreshing];
}

#pragma mark - NavTitleMenu

- (void)titleMenuAction:(id)sender
{
    //Intialize navTitleMenu
    if (self.navTitleMenu == nil) {
        
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        [titles addObject:@"全部彩种"];
        NSArray *arr = [CDLottery all];
        for (CDLottery *obj in arr) {
            int channelId = _isLowGame ? 1 : 4;
            if ([obj.channelid intValue] == channelId) {
                [titles addObject:obj.name];
            }
        }
        
        NavTitleMenu *menu = [[NavTitleMenu alloc] initWithFrame:CGRectMake(0, 0, 320.f, 100.f) titles:titles];
        [menu selectItemForTitle:self.title];
        [menu addTarget:self selector:@selector(titleMenuSelectAction:)];
        menu.delegate = self;
        self.navTitleMenu = menu;
        [menu release];
        [titles release];
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
    if (sender.selectedIndex == 0) {
        if (_isLowGame) {
            ntc.text = @"低频全部彩种";
        }else {
            ntc.text = @"高频全部彩种";
        }
    }else {
        ntc.text = [sender.titles objectAtIndex:sender.selectedIndex];
    }

    //如果选项没有变化
    if (sender.lastIndex == sender.selectedIndex) {
        return;
    }
    
    if (sender.selectedIndex == 0) {
        _selectedType = @"";
        [self.typeArray removeAllObjects];
        [self.typeArray addObjectsFromArray:self.allArray];
    }else {
        _selectedType = [sender.titles objectAtIndex:sender.selectedIndex];
        [self filterType];
    }
    [sender commit];
    [self filterRecords];
}

- (void)filterType
{
    if (_selectedType != nil && ![_selectedType isEqualToString:@""]) {
        [self.typeArray removeAllObjects];
        for (ZhuiHaoInfoItem *item in self.allArray) {
            if ([item.lotteryName isEqualToString:_selectedType]) {
                [self.typeArray addObject:item];
            }
        }
    }
}

#pragma mark - GreenBarDelegate

- (void)greenBar:(id)bar didSelectedAtIndex:(NSInteger)index
{
    _selectedIndex = index;
    
    GreenBar *greenBar = (GreenBar *)bar;
    for (UIView *view in [greenBar.scroll subviews]) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lbl = (UILabel *)view;
            if (lbl.tag == 10+index) {
                lbl.textColor = COLOR_HIGHLIGHTED;
            }else {
                lbl.textColor = COLOR_NORMAL;
            }
        }
    }
    [self filterRecords];
}

- (void)filterRecords
{
    [self.dataList removeAllObjects];
    switch (_selectedIndex) {
        case 0:
        {
            [self.dataList addObjectsFromArray:self.typeArray];
        }
            break;
        case 1:
        {
            for (ZhuiHaoInfoItem *item in self.typeArray) {
                if ([item.status intValue] == 2) {
                    [self.dataList addObject:item];
                }
            }
        }
            break;
        case 2:
        {
            for (ZhuiHaoInfoItem *item in self.typeArray) {
                if ([item.status intValue] == 0) {
                    [self.dataList addObject:item];
                }
            }
        }
            break;
        case 3:
        {
            for (ZhuiHaoInfoItem *item in self.typeArray) {
                if ([item.bonus floatValue] > 0) {
                    [self.dataList addObject:item];
                }
            }
        }
            break;
        default:
            break;
    }
    [_tableView reloadData];
    if ([self.dataList count] == 0){
        [self.tableView setTipsType:kPRTipsTypeNoData];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ZhuiHaoCell";
    ZhuiHaoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhuiHaoCell" owner:self options:nil] lastObject];
        cell.identifier = identifier;
    }
    ZhuiHaoInfoItem *item = [self.dataList objectAtIndex:indexPath.row];
    
    cell.typeLbl.text = item.lotteryName;   // item.cnname;
    cell.multipleLbl.text = item.methodname;
    cell.numberLbl.text = [NSString stringWithFormat:@"%@期",item.beginIssue];
    cell.dateLbl.text = [[item.begainTime componentsSeparatedByString:@" "] objectAtIndex:0];
    cell.amountLbl.text = [NSString stringWithFormat:@"中奖：%.4f元", [item.bonus floatValue]];
    cell.amountLbl.textColor = [UIColor rgbColorWithHex:@"FF2400"];
    if ([item.bonus intValue] == 0) {
        cell.amountLbl.alpha = 0;
    }else {
        cell.amountLbl.alpha = 1;
    }
    cell.statusLbl.text = [item.status intValue] == 0 ? @"进行中" : ([item.status intValue] == 1 ? @"取消" : @"已完成");
    cell.zhuiHaoLbl.text = [NSString stringWithFormat:@"追号 %@/%@",item.finishedCount,item.issueCount];
    cell.row = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZhuiHaoInfoItem *item = [self.dataList objectAtIndex:indexPath.row];
    
    if (_selectBlock) {
        _selectBlock(item);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    ZhuiHaoInfoVC *vc = [[ZhuiHaoInfoVC alloc] initWithNibName:@"ZhuiHaoInfoVC" bundle:nil];
    vc.model = item;
    vc.isLowGame = _isLowGame;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    _isRefresh = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.3f];
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    _isRefresh = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.3f];    
}

#pragma mark - RQDelegate

- (void)onRQComplete:(RQZhuiHaoInfo *)rq error:(NSError *)error{
    if (error){
         [self.tableView setTipsType:kPRTipsTypeNetworkError];
    }
    else if(rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
        if (rq.msgType == kMessageTypeSessionExpired) {
            [SharedModel signOut];
        }
    }
    else if (!rq.msgContent) {
        
        if (_isRefresh) {
            [self.dataList removeAllObjects];
            [self.typeArray removeAllObjects];
            [self.allArray removeAllObjects];
        }
        [self.dataList addObjectsFromArray:rq.dataList];
        [self.allArray addObjectsFromArray:rq.dataList];
        [self.typeArray addObjectsFromArray:rq.dataList];
        [self filterType];
        [self filterRecords];
        
        if ([self.dataList count] == 0)
             [self.tableView setTipsType:kPRTipsTypeNoData];
        else
            [self.tableView setTipsType:kPRTipsTypeDefault];
    }
    
    _countLbl.text = [NSString stringWithFormat:@"共有%lu单追号",(unsigned long)[self.allArray count]];
    [self.tableView tableViewDidFinishedLoading];
}

@end
