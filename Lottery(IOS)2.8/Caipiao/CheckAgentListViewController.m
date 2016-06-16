//
//  CheckAgentListViewController.m
//  Caipiao
//
//  Created by danal on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CheckAgentListViewController.h"
#import "AgentDetailViewController.h"
#import "ColorCell.h"
#import "RQAgentMember.h"

@interface CheckAgentListViewController ()<RQBaseDelegate>
@end

@implementation CheckAgentListViewController

- (void)dealloc{
    [_titleText release];
    [super dealloc];
}

- (void)viewDidLoad
{
    self.title = @"查看下级";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLbl.text = self.titleText;
    self.titleLbl.textColor = kYellowTextColor;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self configTableView];
    
    [self launchRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRequest:(BOOL)high page:(NSInteger)page{
    RQAgentMemberList *rq = [[[RQAgentMemberList alloc] init] autorelease];
    rq.high = high;
    rq.page = page;
    rq.type = self.userType;
    rq.uid = self.uid;
    [rq startPostWithDelegate:self];
    self.rq = rq;
}

- (void)requestData{
    Echo(@"refresh=%d", self.refresh);
    [self startRequest:_high page:self.page];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count] > 0 ? [self.dataList count] + 1 : 0;
}

- (CGFloat)rowHeightAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CELL";
    ColorCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [ColorCell blackColorCell:identifier];
        cell.edgeInsets = UIEdgeInsetsMake(0.5, 0, 0.5, 0);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_sj_white.png"]] autorelease];
        
        UILabel *leftLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 24/2, 100, 20)];
        leftLbl.tag = 101;
        leftLbl.backgroundColor = [UIColor clearColor];
        leftLbl.textColor = [UIColor whiteColor];
        leftLbl.font = [UIFont boldSystemFontOfSize:13.f];
        [cell.contentView addSubview:leftLbl];
        [leftLbl release];
        
        UILabel *rightLbl = [[UILabel alloc] initWithFrame:CGRectMake(320-110, 24/2, 80, 20)];
        rightLbl.tag = 102;
        rightLbl.textAlignment = UITextAlignmentRight;
        rightLbl.backgroundColor = [UIColor clearColor];
        rightLbl.textColor = [UIColor whiteColor];
        rightLbl.font = [UIFont boldSystemFontOfSize:13.f];
        [cell.contentView addSubview:rightLbl];
        [rightLbl release];
    }
    AgentMember *am = [self.dataList objectAtIndex:indexPath.row];
    UILabel *leftLbl = (UILabel *)[cell.contentView viewWithTag:101];
    UILabel *rightLbl = (UILabel *)[cell.contentView viewWithTag:102];
    leftLbl.text = [NSString stringWithFormat:@"%ld %@", (long)indexPath.row + 1, am.name];
    rightLbl.text  = [SharedModel formatBalance:am.balance];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AgentMember *am = [self.dataList objectAtIndex:indexPath.row];
    AgentDetailViewController *vc = [[AgentDetailViewController alloc] init];
    vc.member = am;
    vc.high = self.high;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark - RQDelegate
- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    RQAgentMemberList *request = (RQAgentMemberList *)rq;
    if (error){
        [self.tableView setTipsType:kPRTipsTypeNetworkError];
    }
    else if (request.msgContent){
        HUDShowMessage(request.msgContent, nil);
        
    } else if ([request.list count] > 0){
        [self.tableView setTipsType:kPRTipsTypeDefault];
        if (self.refresh) [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:request.list];
    } else if ([request.list count] == 0){
        [self.tableView setTipsType:kPRTipsTypeNoData];
    }
    
    //Reload after lowgame request finished
//    if (!request.high) {
        [self.tableView reloadData];
        [self finishLoading:nil];
//    }
    
}

- (void)onRQStart:(RQBase *)rq{
    
}

@end
