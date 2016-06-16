//
//  LinkDetailViewController.m
//  Caipiao
//
//  Created by danal-rich on 4/1/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "LinkDetailViewController.h"
#import "RQLink.h"
#import "BaseCell.h"
#import "LinkDetailCellView.h"


@interface LinkDetailViewController ()<RQBaseDelegate>

@end

@implementation LinkDetailViewController



- (void)viewDidLoad
{
    self.title = @"代理链接管理";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    CGRect rect = self.view.bounds;
//    self.tableView = [[[MSPullingRefreshTableView alloc] initWithFrame:CGRectInset(rect, 10, 10)] autorelease];
//    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = kGreenBGColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self configTableView];
    [self launchRefreshing];
    
    _accountTypeLbl.font =
    _expireLbl.font =
    _pointSettingLbl.font = [UIFont systemFontOfSize:13.f];
    _introLbl.font = [UIFont systemFontOfSize:10.f];
    
    _accountTypeLbl.text = [_accountTypeLbl.text stringByAppendingString:self.linkItem.type == 0 ? @"会员" : @"代理"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request
- (void)requestData{
    RQLinkDetail *request = [[RQLinkDetail alloc] init];
    request.linkId = self.linkItem.linkId;
    [request startPostWithDelegate:self];
    self.rq = request;
    [request release];
}

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{

    RQLinkDetail *request = (RQLinkDetail *)rq;
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:request.dataList];
    
    _expireLbl.text = [@"链接有效期：" stringByAppendingFormat:@"%@ 至 %@",request.startTime,request.endTime];
    [self finishLoading:nil];
}

#pragma mark - Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : [self.dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 28.f;
    
    //section 1
    id obj = [self.dataList objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[LinkDetailItem class]]){
        return 28.f;
    } else {
        return 44.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier0 = @"cell0";
    static NSString *identifier = @"cell";
    if (indexPath.section == 0){
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier0];
        if (!cell){
            cell = [[[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            LinkDetailCellView *view = (id)[LinkDetailCellView loadFromNib];
            view.backgroundColor = kGreenBGColor;
            view.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height);
            view.tag = 100;
            view.typeLbl.text = @"彩种类型";
            view.point1Lbl.text = @"返点";
            view.point2Lbl.hidden = YES;
            view.point1Lbl.frame = CGRectMake(view.point1Lbl.frame.origin.x, 0, view.point1Lbl.bounds.size.width*2, view.bounds.size.height);
            [cell.contentView addSubview:view];
        }
        LinkDetailCellView *view = (id)[cell.contentView viewWithTag:100];
        view.pos = [self.dataList count] == 0 ? kCellPositionSingle : kCellPositionDefault;
        return cell;
    }
    
    //section 1
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        LinkDetailCellView *view = (id)[LinkDetailCellView loadFromNib];
        view.backgroundColor = kGreenBGColor;
        view.frame = CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height);
        view.tag = 100;
        [cell.contentView addSubview:view];
    }

    LinkDetailCellView *view = (id)[cell.contentView viewWithTag:100];
    id obj = [self.dataList objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[LinkDetailItem class]]){
        LinkDetailItem *item = (LinkDetailItem *)obj;
        view.typeLbl.text = item.cnname;
        view.point1Lbl.text = [item.userPoint stringByAppendingString:@"%"];
        view.point2Lbl.text = [item.indefinitePoint stringByAppendingString:@"%"];
        view.point2Lbl.hidden = !item.hasSecondPoint;
    } else {    //Header
        
        LinkDetailHeaderItem *item = (LinkDetailHeaderItem *)obj;
        view.typeLbl.text = item.lotteryType;
        view.point1Lbl.text = item.point1;
        view.point2Lbl.text = item.point2;
        view.point2Lbl.hidden = !item.hasSecondPoint;
    }

    if ([self.dataList count] == 1) view.pos = kCellPositionSingle;
    else if (indexPath.row + 1 == [self.dataList count]) view.pos = kCellPositionBottom;
    else view.pos = kCellPositionDefault;
    return cell;
}

@end
