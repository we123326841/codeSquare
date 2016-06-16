//
//  GameHistoryDetailVC.m
//  Caipiao
//
//  Created by CYRUS on 14-8-1.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "GameHistoryDetailVC.h"
#import "PublicBall.h"
#import "RQGameHistory.h"
#import "RQRevokeOrder.h"
#import "AutoHideAlertView.h"
#import "HallViewController.h"
#import "MyBetNumberCell.h"
#import "RecordInfoVC.h"
#define kBallTagStart 1
#define kBallTagEnd 7

@interface GameHistoryDetailVC ()

@property (strong, nonatomic) LoadingView *header;
@property (assign, nonatomic) IBOutlet UIScrollView *wrapView;
@property (assign, nonatomic) IBOutlet UIImageView *lotteryIcon;
@property (assign, nonatomic) IBOutlet UILabel *lotteryName;
@property (assign, nonatomic) IBOutlet UILabel *lotteryIssue;
@property (assign, nonatomic) IBOutlet UILabel *paidAmountLbl;
@property (assign, nonatomic) IBOutlet UILabel *paidAmountTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *prizeAmountLbl;
@property (assign, nonatomic) IBOutlet UILabel *prizeTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *publicTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *statusLbl;
@property (assign, nonatomic) IBOutlet UILabel *betStatusLbl;
@property (assign, nonatomic) IBOutlet UILabel *betInfoLbl;
@property (assign, nonatomic) IBOutlet UILabel *betModelLbl;
@property (assign, nonatomic) IBOutlet UILabel *betMultipleLbl;
@property (assign, nonatomic) IBOutlet UILabel *betTimeLbl;
@property (assign, nonatomic) IBOutlet UILabel *betIdLbl;
@property (assign, nonatomic) IBOutlet UILabel *betStatusTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *betInfoTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *betModelTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *betMultipleTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *betTimeTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *betIdTagLbl;
@property (assign, nonatomic) IBOutlet UILabel *publicNullLbl;
@property (assign, nonatomic) IBOutlet UIButton *betButton;
@property (assign, nonatomic) IBOutlet UIView *midView;

@property (assign, nonatomic) IBOutlet UIImageView *lotteryNumberLine;
@property (assign, nonatomic) IBOutlet UIView *mybetView;
@property (assign, nonatomic) IBOutlet UILabel *mybetTagL;
@property (assign, nonatomic) IBOutlet UIButton *goOnBetButton;
@property (assign, nonatomic) IBOutlet UIImageView *recordBg;
@end

@implementation GameHistoryDetailVC

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
    [_header release];
    [_model release];
    Block_release(_updateListBlock);
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注单详情";
    [super viewDidLoad];
    
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, -100.f, 320.f, 100.f) atTop:YES];
    [self.view addSubview:loadingView];
    self.header = loadingView;
    [loadingView release];
    
    UIButton *rightButton = [UIButton barButtonWithTitle:@"撤单"];
    rightButton.frame = CGRectMake(0, 0, 60, rightButton.bounds.size.height);
    [rightButton addTarget:self action:@selector(revokeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:rightButton];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    for (UIView *v in [_wrapView subviews]) {
        v.hidden = YES;
    }
    
    {
        _wrapView.backgroundColor = Color(@"GameHistoryBackground");
        _lotteryName.textColor = Color(@"GameHistoryNameColor");
        _lotteryIssue.textColor = Color(@"GameHistoryIssueColor");
        _paidAmountTagLbl.textColor = Color(@"GameHistoryNameColor");//Color(@"GameHistoryAmountTagColor");
        _paidAmountLbl.textColor = Color(@"GameHistoryAmountColor");
        _statusLbl.textColor = Color(@"GameHistoryStatusColor");
        _mybetTagL.textColor = Color(@"GameHistoryNameColor");;
        
        _betStatusTagLbl.textColor =
        _betInfoTagLbl.textColor =
        _betModelTagLbl.textColor =
        _betMultipleTagLbl.textColor =
        _betTimeTagLbl.textColor =
        _betIdTagLbl.textColor =
        _publicTagLbl.textColor = Color(@"GameHistoryBetTagColor");
        _betStatusLbl.textColor = Color(@"GameHistoryStatusColor");
        _betInfoLbl.textColor =
        _betModelLbl.textColor =
        _betMultipleLbl.textColor =
        _betTimeLbl.textColor =
        _betIdLbl.textColor = Color(@"GameHistoryBetInfoColor");
    }
    
    if (_rqZhuiHaoDetail) {
        [self projectDetail];
        [self layouts];
        return;
    }
    
    CGRect rect = self.header.frame;
    rect.origin.y = -40.f;
    [UIView animateWithDuration:.3f
                          delay:.1f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.header.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         self.header.state = kPRStateLoading;
                         [self performSelector:@selector(loadData) withObject:nil afterDelay:.3f];
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    RQGameDetail *rq  = [[[RQGameDetail alloc] init] autorelease];
    rq.recordId = self.recordId;
//    rq.chan_id = self.chan_id;
    [rq startPostWithDelegate:self];
    self.rq = rq;
}
-(void)projectDetail
{
    if (_rqZhuiHaoDetail) {
        self.title = @"方案详情";
    }
    GameRecord *gr = [[[GameRecord alloc] init]autorelease];
    gr.issueNumber = _zhuiHaoIssueModel.issue;//是否中奖 0:未开奖;1:未中奖;2:派奖中，3已派奖
    gr.lotteryName = [CDLottery findLotteryById:_zhuiHaoInfoItem.lotteryId.integerValue andChannelId:_zhuiHaoInfoItem.channelId.integerValue].name;
    gr.win = _zhuiHaoIssueModel.status;
    gr.lotteryid=_zhuiHaoInfoItem.lotteryId.integerValue;
    gr.channelid=_zhuiHaoInfoItem.channelId.integerValue;
    self.model=gr;
    
    
    RQGameDetail *rq  = [[[RQGameDetail alloc] init] autorelease];
    rq.enid = _zhuiHaoIssueModel.taskDetailNo;
    rq.gameNo = _zhuiHaoIssueModel.taskDetailNo;
    rq.time = _rqZhuiHaoDetail.begintime;
    rq.issue =_zhuiHaoIssueModel.issue;
    rq.total = _rqZhuiHaoDetail.finishedmoney;
    rq.bonus = _zhuiHaoIssueModel.bonus;
    rq.cancancel = _zhuiHaoIssueModel.cancancel;
    rq.openCode = _zhuiHaoIssueModel.opencode;
    rq.lotteryId = [NSString stringWithFormat:@"%@",_zhuiHaoInfoItem.lotteryId];
    for (int i=0 ;i<_rqZhuiHaoDetail.projectList.count;i++) {
        RecordInfo *r = (id)_rqZhuiHaoDetail.projectList[i];
        r.ifwin = [[[_zhuiHaoIssueModel.list objectAtIndex:i] objectForKey:@"ifwin"] integerValue];
        r.bonus = [[[_zhuiHaoIssueModel.list objectAtIndex:i] objectForKey:@"bonus"] floatValue];
        r.price = [[[_zhuiHaoIssueModel.list objectAtIndex:i] objectForKey:@"price"] floatValue];
    }
    rq.list = _rqZhuiHaoDetail.projectList;
    
    self.rq = rq;
}

- (void)layouts
{
    _wrapView.contentSize = CGSizeMake(self.view.bounds.size.width, 568);
    for (UIView *v in [_wrapView subviews]) {
        v.hidden = NO;
    }
    
    RQGameDetail *gd = (RQGameDetail *)self.rq;
    
    
    if (gd.cancancel == 1) {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
    }
    
    [self setCodes:gd.openCode];
    _lotteryName.text = _model.lotteryName;
    _lotteryIssue.text = [NSString stringWithFormat:@"第%@期", _model.issueNumber];
    _lotteryIcon.image = ResImage([CDLottery findLotteryByName:_model.lotteryName].logoHot);
    _betTimeLbl.text = gd.time;
    _betIdLbl.text = gd.gameNo;
    [_betButton setTitle:[NSString stringWithFormat:@"%@投注",_model.lotteryName] forState:UIControlStateNormal];
    
    _paidAmountLbl.text = [SharedModel formatBalancef:gd.total];
    //1:等待开奖 2:中奖 3:未中奖 4:撤销 5:存在异常 6:数据归档
    if (_model.win == 1) {
        _betStatusLbl.text = _statusLbl.text = @"等待开奖";
        _prizeTagLbl.text = @"";
        _prizeAmountLbl.text = @"";
        _publicNullLbl.text = @"--";
        for (int tag = kBallTagStart; tag <= kBallTagEnd ; tag++) {
            PublicBall *ball = (PublicBall *)[self.view viewWithTag:tag];
            ball.hidden = YES;
        }
        CGRect r = _lotteryNumberLine.frame;
        r.origin.y -= 45.f;
        _lotteryNumberLine.frame = r;
        
        CGRect r2 = _mybetView.frame;
        r2.origin.y -= 45.f;
        _mybetView.frame = r2;


    }else if (_model.win == 3) {
        _betStatusLbl.text = @"未中奖";
        _statusLbl.text = @"未中奖";
        _prizeTagLbl.text = @"";
        _prizeAmountLbl.text = @"";
    }else if (_model.win == 2) {
        _betStatusLbl.text = @"中奖";
        _statusLbl.text = @"";
        _prizeTagLbl.text = @"中奖金额";
        _prizeAmountLbl.text = [SharedModel formatBalancef:gd.bonus];
        
        _statusLbl.textColor = Color(@"GameHistoryStatusHighlighColor");
        _betStatusTagLbl.textColor = Color(@"GameHistoryStatusHighlighColor");
    }else  {
        _betStatusLbl.text = @"";
        _statusLbl.text = @"";
        _prizeTagLbl.text = @"";
        _prizeAmountLbl.text = @"";
    }
    
    if (gd.iscancel == 1) {
        _betStatusLbl.text = @"人工撤单";
        _statusLbl.text = @"人工撤单";
        _betStatusLbl.text = @"人工撤单";
        _prizeTagLbl.text = @"";
        _prizeAmountLbl.text = @"";
    }
    if (gd.iscancel == 2) {
        _betStatusLbl.text = @"已撤单";
        _statusLbl.text = @"已撤单";
        _betStatusLbl.text = @"已撤单";
        _prizeTagLbl.text = @"";
        _prizeAmountLbl.text = @"";
    }
    [self addRecordInfoView:gd.list];
}
-(void)addRecordInfoView:(NSArray*)list
{
    CGFloat x=13,y=33,w=294,h=60,height=0;
    for (int i=0;i<MIN(list.count, 3);i++) {
        MyBetNumberCell *cell = [[MyBetNumberCell alloc]initWithFrame:CGRectMake(x,y+i*h, w, h)];
        CGRect rect = cell.frame;
        rect.origin.x = x;
        rect.origin.y = y+i*h;
        rect.size.width = w;
        rect.size.height = h;
        cell.frame=rect;
        cell.backgroundColor=[UIColor clearColor];
        cell.record=list[i];
        [_mybetView addSubview:cell];
        [cell release];
        height += h;
    }
    if (list.count>3) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(x, y+height, w, 35);
        btn.backgroundColor = [UIColor clearColor];
        [_mybetView addSubview:btn];
        [btn addTarget:self action:@selector(recordInfoDetail:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 35)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        label.text=@"查看全部投注内容";
        [btn addSubview:label];
        [label release];
        
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(w-18, 17, 8, 12)];
        arrow.image = ResImage(@"arrow-right@2x.png");
        [btn addSubview:arrow];
        [arrow release];
        
        height +=35;
    }
    CGRect rect = _recordBg.frame;
    rect.size.height = height+10;
    _recordBg.frame = rect;
    _recordBg.backgroundColor=[UIColor clearColor];

    CGRect rect2 = _mybetView.frame;
    rect2.size.height = y+_recordBg.frame.size.height;
    _mybetView.frame = rect2;
    _mybetView.backgroundColor=[UIColor clearColor];
    
    CGRect rect3 = _midView.frame;
    rect3.size.height = _mybetView.frame.origin.y+_mybetView.frame.size.height;
    _midView.frame = rect3;
    
    CGRect rect4= _betButton.frame;
    rect4.origin.y = _midView.frame.origin.y+_midView.frame.size.height+10;
    _betButton.frame = rect4;
    
    _wrapView.contentSize = CGSizeMake(self.view.bounds.size.width, MAX(568, _betButton.frame.size.height+_betButton.frame.origin.y));
}
//查看全部投注内容
-(void)recordInfoDetail:(UIButton*)btn
{
     RQGameDetail *gd = (RQGameDetail *)self.rq;
    RecordInfoVC *vc = [[RecordInfoVC alloc]init];
    vc.list = gd.list;
    [self.navigationController  pushViewController:vc animated:YES];
    [vc release];
    
}
- (IBAction)gotoBet:(id)sender
{
    CDLottery *lot = [CDLottery findLotteryById:_model.lotteryid andChannelId:_model.channelid];
//    if (lot){
//        [HallViewController checkLotteryStateIn:self lottery:lot];
//    }
    
  //  CDLottery *lot = [CDLottery findLotteryById:hot.lotteryId.integerValue andChannelId:hot.channelid.integerValue];
    
    
    
    
    if ([lot.channelid integerValue] == 4 && [lot.lotteryId intValue] == 15) {
        MSWebViewController *web = [[MSWebViewController alloc] init];
        web.url = [NSString stringWithFormat:@"%@/slmmc/?%@", kAppUrl, [SharedModel shared].token];
        UINavigationController *nav = [NavigationController new:web];
        [[AppDelegate shared].nav pushNavigationController:nav animated:YES];
        web.navigationController.navigationBarHidden = YES;
        
        
        [nav release];
        [web release];
        
    }else{
        [HallViewController checkLotteryStateIn:self lottery:lot];
    }return;
    
    
}
- (IBAction)goOnBet:(id)sender
{
 
}
- (void)revokeOrder:(id)sender
{
    MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:nil message:@"您真的要撤单吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    [alert setClickBlock:^(MSBlockAlertView *a, NSInteger buttonIndex) {
        
        if (buttonIndex ==  1) {
            
            [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
            
            RQGameDetail *gd = (RQGameDetail *)self.rq;
            RQRevokeOrder *rq = [[[RQRevokeOrder alloc] init] autorelease];
            rq.chan_id = gd.chan_id;
            rq.recordId = gd.recordId;
            [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
                Echo(@"RQRevokeOrder : %ld,%@",(long)rq_.msgType,rq_.msgContent);
                [HUDView dismissCurrent];
                if ([rq.status isEqualToString:@"success"]) {
                    _betStatusLbl.text = @"人工撤单";
                    _statusLbl.text = @"人工撤单";
                    _prizeTagLbl.text = @"";
                    _prizeAmountLbl.text = @"";
                    [self.navigationItem.rightBarButtonItem setEnabled:NO];
                    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
                    _model.iscancel = 1;
                    self.updateListBlock(_model, _index);
                    
                    HUDShowMessage(@"注单已撤销", nil);
                }else {
                    HUDShowMessage(@"撤单失败", nil);
                }
                
            } sender:nil];
        }
        
    }];
    
    [alert show];
    [alert release];
}

- (void)setCodes:(NSString *)codes{
    [_codes release];
    _codes = [codes copy];
    
    BOOL isSSQ = NO;
    if ([codes rangeOfString:@"+"].length > 0) isSSQ = YES;
    codes = [codes stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSArray *nums = [codes publicSplit];
    
    int index = 0;
    for (int tag = kBallTagStart; tag <= kBallTagEnd ; tag++) {
        PublicBall *ball = (PublicBall *)[self.view viewWithTag:tag];
        ball.hidden = YES;
        if (index < [nums count]){
            ball.hidden = NO;
            ball.number = [nums objectAtIndex:index];
            index++;
            
            if (isSSQ) {
                if (index != kBallTagEnd) ball.image = ResImage(@"ball_bg_red.png");
                else ball.image = ResImage(@"ball_bg_blue.png");
            }
        }
    }

}

+ (NSString *)numFormatter:(NSString *)codes
{
    codes = [codes stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSArray *nums = [codes publicSplit];
    NSMutableString *result = [[NSMutableString alloc] init];
    for (NSString *n in nums) {
        [result appendFormat:@" %@",n];
    }
    return [result autorelease];
}

#pragma mark - RQBaseDelegate
- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQGameDetail *)rq error:(NSError *)error{
    Echo(@"RQGameDetail rq.msgContent:%@",rq.msgContent);
    CGRect rect = self.header.frame;
    rect.origin.y = -100.f;
    self.header.state = kPRStateNormal;
    [UIView animateWithDuration:.3f animations:^{
        self.header.frame = rect;
        
    } completion:^(BOOL finished) {
        [self layouts];
        
    }];
}

@end
