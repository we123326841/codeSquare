//
//  ZhuiHaoInfoVC.m
//  Caipiao
//
//  Created by Cyrus on 13-6-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "ZhuiHaoInfoVC.h"
#import "ZhuiHaoDetailVC.h"
#import "CDBetList.h"
#import "HallViewController.h"
#import "CDMenuItem.h"
#import "CDLottery.h"
#import "ZhuiHaoInfoCell.h"
#import "TableArrayDataSource.h"
#import "GameHistoryDetailVC.h"
#import "RecordInfoVC.h"
@interface ZhuiHaoInfoVC ()<RQBaseDelegate>

@end

@implementation ZhuiHaoInfoVC

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
    [_model release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _isLowGame ? @"低频追号信息" : @"高频追号信息";
    [self layouts];
    
    UIButton *rightButton = [UIButton barButtonWithTitle:@"撤单"];
    rightButton.frame = CGRectMake(0, 0, 60, rightButton.bounds.size.height);
    [rightButton addTarget:self action:@selector(revokeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:rightButton];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    
    [self loadData];
}
- (void)loadData{
    RQZhuiHaoDetail *rq = [[[RQZhuiHaoDetail alloc] init] autorelease];
    rq.rqId = _model.taskId;
    [rq startPostWithDelegate:self];
    self.rq = rq;
}
#pragma mark - RQDelegate

- (void)onRQComplete:(RQZhuiHaoDetail *)rq error:(NSError *)error{
  
    [self layouts];
    [self.tableview reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layouts
{
    CGFloat topBottom = _topView.frame.origin.y+_topView.frame.size.height;
    _tableview.frame = CGRectMake(0,topBottom , self.view.bounds.size.width, self.view.bounds.size.height-topBottom-5);
    _tableview.backgroundColor = [UIColor clearColor];
     UIEdgeInsets edgeInset = self.tableview.separatorInset;
    self.tableview.separatorInset = UIEdgeInsetsMake(edgeInset.top, 0, edgeInset.bottom, edgeInset.right);//修改分隔线长度    
    
    for (ZhuiHaoIssueModel *task in ((RQZhuiHaoDetail*)self.rq).tasks)
    {
        if (task.cancancel==1) {
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
            self.navigationItem.rightBarButtonItem.customView.hidden = NO;
        }
    }
    
    CDLottery *lot = [CDLottery findLotteryById:_model.lotteryId.intValue andChannelId:_model.channelId.intValue];
    _lotteryNameLbl.text = lot.name;
//    _totalIssueLbl.text = [NSString stringWithFormat:@"追号共%d期",[_model.issueCount intValue]];
    _finishIssueLbl.text = [NSString stringWithFormat:@"已追%d期 总%d期",[_model.finishedCount intValue],[_model.issueCount intValue]];
    _numberLbl.text = ((RQZhuiHaoDetail*)self.rq).taskNo;
    _dateLbl.text = _model.begainTime;
    _amountLbl.text = [SharedModel formatBalancef:[_model.taskPrice floatValue]];
    _lotteryIcon.image = ResImage([CDLottery findLotteryByName:_model.lotteryName].logoHot);
    //0:未开始 1:进行中 2 已结束 3 已终止 4 暂停 5 存在异常 6 执行中
    if ([_model.status intValue] == 0) {
        _statusLbl.text = @"未开始";
        _amountStatusLbl.text = @"";
    }else if ([_model.status intValue] == 1) {
        _statusLbl.text = @"进行中";
        _amountStatusLbl.text = @"";
    }else if ([_model.status intValue] == 2) {
        _statusLbl.text = @"已结束";
        _amountStatusLbl.text = @"";
    }else if ([_model.status intValue] == 3) {
        _statusLbl.text = @"已终止";
        _amountStatusLbl.text = @"";
    }else if ([_model.status intValue] == 4) {
        _statusLbl.text = @"暂停";
        _amountStatusLbl.text = @"";
    }else if ([_model.status intValue] == 5) {
        _statusLbl.text = @"存在异常";
        _amountStatusLbl.text = @"";
    }else if ([_model.status intValue] == 6) {
        _statusLbl.text = @"执行中";
        _amountStatusLbl.text = @"";
    }
    NSString *trace = @"";//0:不停只1:按累计盈利停止2:中奖即停
    if (((RQZhuiHaoDetail*)self.rq).traceStop==0) {
        trace = @"不停止";
    }else  if (((RQZhuiHaoDetail*)self.rq).traceStop==1) {
        trace = @"按累计盈利停止";
    }else if (((RQZhuiHaoDetail*)self.rq).traceStop==2) {
        trace = @"中奖即停";
    }
    _stopAfterWinL.text = trace;

    
}

- (void)betAgainAction:(id)sender
{
    return;
    
    //取得玩法
    NSString *tmpMethodName = nil;
    NSMutableString *betNumber = [NSMutableString string];
    PlayType playType = [BetManager playTypeForMethodId:_model.methodId methodName:&tmpMethodName];
    _model.methodname = tmpMethodName;
    //因为接口写的不统一，这里只能在客户端针对各种玩法先格式化号码再进行解析
    switch (playType) {
        case kPlayTypeHEZX:
        case kPlayTypeHSZX:
        case kPlayTypeQEZX:
        case kPlayTypeQSZX:
        case kPlayTypeSXZX:
        case kPlayTypeWXZX:
            //当前格式:123|345|5|6|7; 需要在各个号码间插入&
        {
            NSArray *segments = [_model.codes componentsSeparatedByString:@"|"];
            for (NSString *seg in segments){
                for (int i = 0; i < [seg length]; i++) {
                    NSString *num  = [seg substringWithRange:NSMakeRange(i, 1)];
                    [betNumber appendFormat:@"%@&",num];
                }
                [betNumber replaceCharactersInRange:NSMakeRange([betNumber length] - 1, 1) withString:@"|"];    //把最后一个&替换成|
            }
            [betNumber deleteCharactersInRange:NSMakeRange([betNumber length] - 1, 1)]; //移除最后一个|
        }
            break;
//        case kPlayTypeDWD:
//            //格式:123|345|5|6|7; 需要在各个号码间插入&
//        {
//            NSArray *segments = [_model.codes componentsSeparatedByString:@"|"];
//            for (NSString *seg in segments){
//                if (seg.length > 0) {
//                    for (int i = 0; i < [seg length]; i++) {
//                        NSString *num  = [seg substringWithRange:NSMakeRange(i, 1)];
//                        [betNumber appendFormat:@"%@&",num];
//                    }
//                } else {
//                    [betNumber appendString:@"|"];
//                }
//                if (betNumber.length > 0) {
//                    [betNumber replaceCharactersInRange:NSMakeRange([betNumber length] - 1, 1) withString:@"|"];    //把最后一个&替换成|
//                }
//            }
//            [betNumber deleteCharactersInRange:NSMakeRange([betNumber length] - 1, 1)]; //移除最后一个|
//        }
//            break;
        case kPlayTypeHEZuXuan:
        case kPlayTypeHSZuLiu:
        case kPlayTypeHSZuSan:
        case kPlayTypeQEZuXuan:
        case kPlayTypeQSZuLiu:
        case kPlayTypeQSZuSan:
        case kPlayTypeHSYMBDW:
        case kPlayTypeQSYMBDW:
            //只需要将|转换成&
        {
            [betNumber appendString:_model.codes];
            [betNumber replaceOccurrencesOfString:@"|" withString:@"&" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [betNumber length])];
        }
            break;
        case kPlayTypeDWD:
            //格式相同 ||9||，不需要转换
            [betNumber appendString:_model.codes];
            break;
        default:
            Echo(@"Error:Method not found!");
            break;
    }
    
    //    [CDBetList deleteAll];
/*
    HallViewController *hall = [[[HallViewController alloc] init] autorelease];
    BetViewController *bet = [[[BetViewController alloc] init] autorelease];
    BetListViewController *blvc = [[[BetListViewController alloc] init] autorelease];
    blvc.currentPlayType = playType;
    blvc.inputedMultiple = _model.multiple;
    blvc.comeFromZhuiHaoInfo = YES;
    
    [CDBetList betListFromBetNumbers:betNumber forPlayType:playType];
    CDBetList *obj = [[CDBetList all] lastObject];
    obj.multiple = [NSNumber numberWithInt:_model.multiple];
    if ([obj.mode intValue] == 1) {
        obj.amount = [NSNumber numberWithFloat: 2 * [obj.multiple floatValue]*[obj.count intValue]];
    }else {
        obj.amount = [NSNumber numberWithFloat: 0.2 * [obj.multiple floatValue]*[obj.count intValue]];
    }
    [obj save];

    NSMutableArray *controllers = [NSMutableArray array];
    [controllers addObject:hall];
    [controllers addObject:bet];
    [controllers addObject:blvc];
    UINavigationController *nav = (UINavigationController *)[AppDelegate sideMenuController].rightController;
    [nav dismissModalViewControllerAnimated:NO];
    [nav setViewControllers:controllers animated:YES];
    [[AppDelegate leftMenuController] activeMenuIndex:kMenuIndexHall];
    
    Echo(@"play type:%@|betNumber:%@",_model.methodname,betNumber);
 */
}

- (void)gotoDetailVC:(id)sender
{
  
    
}

- (IBAction)gotoBet:(id)sender
{
    CDLottery *lot = [CDLottery findLotteryById:[_model.lotteryId intValue] andChannelId:[_model.channelId intValue]];
    if (lot){
        [HallViewController checkLotteryStateIn:self lottery:lot];
    }
}
- (IBAction)gotoBetPlan:(id)sender
{
    RecordInfoVC *vc = [[RecordInfoVC alloc]init];
    vc.list = ((RQZhuiHaoDetail*)self.rq).projectList;
    vc.isZhuiHaoProject=YES;
    [self.navigationController  pushViewController:vc animated:YES];
    [vc release];
}
- (void)revokeOrder:(id)sender
{
//    MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil message:@"您真的要撤单吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
//    [alert setClickBlock:^(MSBlockAlertView *a, NSInteger buttonIndex) {
//        
//        if (buttonIndex ==  1) {
//            
//            [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
//        }
//        
//    }];
//    
//    [alert show];
//    [alert release];
    
    ZhuiHaoDetailVC *vc = [[ZhuiHaoDetailVC alloc] initWithNibName:@"ZhuiHaoDetailVC" bundle:nil];
    vc.title = @"追号详情";
    vc.taskId = _model.taskId;
    vc.isLowGame = _isLowGame;
    NSMutableArray *list = [NSMutableArray array];
    for (ZhuiHaoIssueModel *task in ((RQZhuiHaoDetail*)self.rq).tasks) {
        ZhuiHaoDetailModel *item = [[[ZhuiHaoDetailModel alloc] init]autorelease];
        item.taskDetailId = task.taskdetailid;
        item.issue = task.issue;
        item.multiple = @(task.multiple);
        item.status =  @(task.status);
        item.canCancel =  @(task.cancancel)
        ;
        item.issueCode=task.issueCode;
        item.isSelected = NO;
        item.taskDetailNo=task.taskDetailNo;
        [list addObject:item];
    }
    vc.dataList=list;
    vc.rq=self.rq;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}
#pragma mark -- uitableview delegate datasource
#pragma mark - TableViewDelegate & dataSource
- (void)setupTableView
{
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(RQZhuiHaoDetail*)self.rq tasks].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    ZhuiHaoInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZhuiHaoInfoCell" owner:self options:nil] lastObject];
    }
    
    {
        cell.statusL.textColor = Color(@"ZhuihaoDetailCellStatusColor");
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.issueL.textColor = Color(@"ZhuihaoDetailCellIssueColor");
        cell.priceL.textColor = Color(@"ZhuihaoDetailCellAmountColor");
    }
    ZhuiHaoIssueModel *m = (ZhuiHaoIssueModel*)([(RQZhuiHaoDetail*)self.rq tasks][indexPath.row]);
    
    cell.issueL.text = [NSString stringWithFormat:@"第%@期",m.issue];
    cell.priceL.text = [NSString stringWithFormat:@"%.2f元",m.money];
    //"如果taskDetailNo不为null则status表示
    //    1:等待开奖 2:中奖 3:未中奖 4:撤销 5:存在异常(显示处理中) 6:数据归档
    //    若为null则表示
    //    0:未生成;1:生成追号单;2:追号单取消"
    BOOL taskDetail =([m.taskDetailNo isKindOfClass:[NSNull class]])||(m.taskDetailNo==nil);
    switch (m.status) {
        case 0:
            cell.statusL.text = @"未生成";
            break;
        case 1:
            if(taskDetail)
            {
                cell.statusL.text = @"生成追号单";
            }else
            {
                cell.statusL.text = [NSString stringWithFormat:@"等待开奖"];
            }
            break;
        case 2:
            if(taskDetail)
            {
                cell.statusL.text = @"追号单取消";
            }else
            {
                cell.statusL.text = [NSString stringWithFormat:@"中奖 %.2f",m.bonus];
                if(![m.opencode isKindOfClass:[NSNull class]]&&m.opencode.length>0)
                    cell.codesL.text = [NSString stringWithFormat:@"开奖号%@",m.opencode];
            }
            break;
        case 3:
              cell.statusL.text = [NSString stringWithFormat:@"未中奖"];
            if(![m.opencode isKindOfClass:[NSNull class]]&&m.opencode.length>0)
                cell.codesL.text = [NSString stringWithFormat:@"开奖号%@",m.opencode];
            break;
        case 4:
            cell.statusL.text = [NSString stringWithFormat:@"撤销"];
            if(![m.opencode isKindOfClass:[NSNull class]]&&m.opencode.length>0)
                cell.codesL.text = [NSString stringWithFormat:@"开奖号%@",m.opencode];
            break;
        case 5:
            cell.statusL.text = [NSString stringWithFormat:@"处理中"];
            if(![m.opencode isKindOfClass:[NSNull class]]&&m.opencode.length>0)
                cell.codesL.text = [NSString stringWithFormat:@"开奖号%@",m.opencode];
            break;
        case 6:
            cell.statusL.text = [NSString stringWithFormat:@"数据归档"];
            if(![m.opencode isKindOfClass:[NSNull class]]&&m.opencode.length>0)
                cell.codesL.text = [NSString stringWithFormat:@"开奖号%@",m.opencode];
            break;
        default:
            break;
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   ZhuiHaoIssueModel *model = (ZhuiHaoIssueModel*)([(RQZhuiHaoDetail*)self.rq tasks][indexPath.row]);
    if (![model.taskDetailNo isKindOfClass:[NSNull class]]&&model.taskDetailNo!=nil) {
        GameHistoryDetailVC *vc = [[GameHistoryDetailVC alloc] initWithNibName:@"GameHistoryDetailVC" bundle:nil];
        vc.zhuiHaoInfoItem=_model;
        vc.zhuiHaoIssueModel=model;
        vc.rqZhuiHaoDetail=(RQZhuiHaoDetail*)self.rq;
        
        [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
        [vc release];
    }
}

@end
