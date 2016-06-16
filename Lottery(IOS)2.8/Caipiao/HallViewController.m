//
//  HallViewController.m
//  Caipiao
//
//  Created by danal-rich on 7/22/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "HallViewController.h"
#import "BetLowViewController.h"
#import "BetHighViewController.h"
#import "CD.h"
#import "IssueItem.h"
#import "LotteryTimer.h"
#import "RQInitData.h"
#import "BaseCell.h"
#import "JSKSViewController.h"
#import "OABonusAlertView.h"

@interface HallViewController ()
@property (nonatomic, strong) NSDictionary *introduction;
@end

@implementation HallViewController

- (void)dealloc{
    self.lotList = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
    self.title = @"购彩大厅";
    self.lotList = [CDLottery allEnabled];
    self.introduction = [NSDictionary dictionaryWithContentsOfFile:
                         [[NSBundle mainBundle] pathForResource:@"Introduction.plist" ofType:nil]
                         ];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //ios7 fix
    if (_tableView.contentInset.top == -20){
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.contentOffset = CGPointZero;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _lotList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//        cell.indentationLevel = 1;
//        cell.indentationWidth = 100.f;
        cell.textLabel.textColor = Color(@"HallTextColor");
        cell.detailTextLabel.textColor = Color(@"HallLightTextColor");
        cell.detailTextLabel.numberOfLines=0;

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60.f, 60.f)];
        imageView.tag = 100;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imageView];
        [imageView release];
        
        UIImageView *corner = [[UIImageView alloc] initWithFrame:CGRectMake(260, 5, 60, 20)];
        corner.contentMode=UIViewContentModeScaleAspectFit;
        corner.tag = 200;
        corner.image = ResImage(@"自主彩种.png");
        [cell.contentView addSubview:corner];
        [corner release];
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectZero];
        bg.backgroundColor = Color(@"CellSelectedBGColor");
        cell.selectedBackgroundView = bg;
        [bg release];
    }
    CDLottery *lot = _lotList[indexPath.row];
    UIImageView *imgv = (UIImageView *)[cell.contentView viewWithTag:100];
    imgv.image = ResImage(lot.logo);
    cell.textLabel.text = lot.name;
//    cell.detailTextLabel.text = lot.introduction;
    cell.detailTextLabel.text = [self.introduction objectForKey:lot.name];
    
    UIImageView *corner = (UIImageView*)[cell.contentView viewWithTag:200];
    corner.hidden = lot.cornerTitle == nil;
    if ([lot.cornerTitle hasPrefix:@"自主"])
        corner.image = ResImage(@"自主彩种.png");
    else if ([lot.cornerTitle hasPrefix:@"新彩种"])
    corner.image = ResImage(@"new_lotteryLogo.png");
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CDLottery *lot = _lotList[indexPath.row];
//    [[self class] checkLotteryStateIn:self lottery:lot];
//    
//    //Flurry Event
//    switch ([lot.channelid integerValue]) {
//        case 1:
//           if([lot.lotteryId intValue] == 2) //P5
//           { FLEvent(kFLEventHallP5); }
//            break;
//        case 4:
//            if([lot.lotteryId intValue] == 14) //吉利分分彩
//            { FLEvent(kFLEventHallJLFFC); }
//            if([lot.lotteryId intValue] == 11) //乐利时时彩
//            { FLEvent(kFLEventHallLLSSC); }
//            if([lot.lotteryId intValue] == 1) //重庆时时彩
//            { FLEvent(kFLEventHallCQSSC); }
//            break;
//        default:
//            break;
//    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CDLottery *lot = _lotList[indexPath.row];
    
    //SLMMC changes
    if ([lot.channelid integerValue] == 4 && [lot.lotteryId intValue] == 15) {
        MSWebViewController *web = [[MSWebViewController alloc] init];
        web.url = [NSString stringWithFormat:@"%@/slmmc/?%@", kAppUrl, [SharedModel shared].token];
        UINavigationController *nav = [NavigationController new:web];
        [[AppDelegate shared].nav pushNavigationController:nav animated:YES];
        web.navigationController.navigationBarHidden = YES;
        
        
        [nav release];
        [web release];
        
    }
    else
    {
        //SLMMC changes
        
        [[self class] checkLotteryStateIn:self lottery:lot];
        
        //Flurry Event
        switch ([lot.channelid integerValue]) {
            case 1:
                if([lot.lotteryId intValue] == 2) //P5
                { FLEvent(kFLEventHallP5); }
                break;
            case 4:
                if([lot.lotteryId intValue] == 14) //吉利分分彩
                { FLEvent(kFLEventHallJLFFC); }
                if([lot.lotteryId intValue] == 11) //乐利时时彩
                { FLEvent(kFLEventHallLLSSC); }
                if([lot.lotteryId intValue] == 1) //重庆时时彩
                { FLEvent(kFLEventHallCQSSC); }
                break;
            default:
                break;
        }
        
        //SLMMC changes
    }
    //SLMMC changes
}

+ (void)checkLotteryStateIn:(UIViewController *)controller lottery:(CDLottery *)lot{
//    if (!lot.paused.boolValue){
        //Check the lottery's state
    
    if ([CDUserInfo user].userType.integerValue==1) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"总代不能投注" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
        RQSimpleInit *q = [[[RQSimpleInit alloc] init] autorelease];
        q.channelId = [lot.channelid intValue];
        q.lotteryId = [lot.lotteryId intValue];
        q.lotteryName = lot.name;
        [HUDView showLoadingToView:KEY_WINDOW msg:kStringLoading subtitle:nil];
        [HUDView setTouchHide:NO];
        [q startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            HUDHide();
            if (error_){
                [HUDView showMessageToView:KEY_WINDOW msg:rq_.msgContent subtitle:nil];
                return;
            }
            if (![SharedModel userIsSignedin]) return;
            
            RQSimpleInit *q_ = (RQSimpleInit *)rq_;
            if (q_.isPaused){
                [HUDView showMessageToView:controller.view msg:@"该彩种今日投注已截止，请稍后再试" subtitle:nil];
            } else {
                
                if (q_.bonusGroupStatus==0) {
                    [OABonusAlertView addNotiView:q_.awardGroups withlotteryid:q_.lotteryId channelid:q_.channelId];
                }
                
                //Set the current issue item
                [IssueItem current].channelid = [lot.channelid intValue];
                [IssueItem current].lotteryId = [lot.lotteryId intValue];
                [IssueItem current].curmid = [lot.curmid intValue];
                [IssueItem current].lotteryName = lot.name;
                [IssueItem current].issueNumber = lot.issueCode;
                [IssueItem current].issue = lot.issue;
                
                SimpleLotteryTimer *timer = [SimpleLotteryTimer shared];
                [timer setupWithLotteryId:q_.lotteryId andChannel:q_.channelId endTime:q_.endTime];
                
                UIViewController *vc = nil;
                if (lot.channelid.integerValue == kChannelHigh){
                    
                    if ([lot.name isEqualToString:JSK3]) {
                        JSKSViewController *hvc = [JSKSViewController new];
                        hvc.lotteryId = lot.lotteryId.integerValue;
                        hvc.channelId = lot.channelid.integerValue;
                        vc = hvc;

                    }else{
                        BetHighViewController *hvc = [BetHighViewController new];
                        hvc.lotteryId = lot.lotteryId.integerValue;
                        hvc.channelId = lot.channelid.integerValue;
                        vc = hvc;
                    }
                } else {
                    BetLowViewController *hvc = [BetLowViewController new];
                    hvc.lotteryId = lot.lotteryId.integerValue;
                    hvc.channelId = lot.channelid.integerValue;
                    vc = hvc;
                }
                UINavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
                [[AppDelegate shared].nav pushNavigationController:nav animated:YES];
                [nav release];
                [vc release];
            }
            
        } sender:nil];
        
//    } else {
//        [HUDView showMessageToView:controller.view msg:@"该彩种今日投注已截止，请稍后再试" subtitle:nil];
//    }

}

+ (void)generate1RandomIn:(UINavigationController *)controller lottery:(CDLottery *)lot{
    //SLMMC changes
    if ([lot.channelid integerValue] == 4 && [lot.lotteryId intValue] == 15) {
        MSWebViewController *web = [[MSWebViewController alloc] init];
        web.url = [NSString stringWithFormat:@"%@/slmmc/?%@", kAppUrl, [SharedModel shared].token];
        UINavigationController *nav = [NavigationController new:web];
        [[AppDelegate shared].nav pushNavigationController:nav animated:YES];
        web.navigationController.navigationBarHidden = YES;
        
        
        [nav release];
        [web release];
        return;
    }
    
    
    RQSimpleInit *q = [[[RQSimpleInit alloc] init] autorelease];
    q.channelId = [lot.channelid intValue];
    q.lotteryId = [lot.lotteryId intValue];
    q.lotteryName = lot.name;
    [HUDView showLoadingToView:KEY_WINDOW msg:kStringLoading subtitle:nil];
    [HUDView setTouchHide:NO];
    [q startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        HUDHide();
        if (error_) return;
        RQSimpleInit *q_ = (RQSimpleInit *)rq_;
        if (q_.isPaused){
            [HUDView showMessageToView:controller.view msg:@"该彩种今日投注已截止，请稍后再试" subtitle:nil];
        } else {
            
            //Set the current issue item
            [IssueItem current].channelid = [lot.channelid intValue];
            [IssueItem current].lotteryId = [lot.lotteryId intValue];
            [IssueItem current].curmid = [lot.curmid intValue];
            [IssueItem current].lotteryName = lot.name;
            [IssueItem current].issueNumber = lot.issueCode;
            [IssueItem current].issue = lot.issue;
            
            SimpleLotteryTimer *timer = [SimpleLotteryTimer shared];
            [timer setupWithLotteryId:q_.lotteryId andChannel:q_.channelId endTime:q_.endTime];

            BetHighViewController *vc = [[BetHighViewController alloc] init];
            vc.lotteryId = [lot.lotteryId integerValue];
            vc.channelId = [lot.channelid integerValue];
            [vc performSelector:@selector(randomBetting:) withObject:nil afterDelay:.2f];
            [controller setViewControllers:@[vc] animated:YES];
            [vc release];
        }
        
    } sender:nil];
    
}

@end
