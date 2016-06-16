//
//  UserAmountListView.m
//  Caipiao
//
//  Created by cYrus on 13-10-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UserAmountListView.h"
#import "UserAmountListCell.h"
#import "RQUserPoint.h"

@implementation UserAmountListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor rgbColorWithR:29 G:29 B:29 alpha:1.f];
        
        _currBalanceArray = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", nil];
        _userPointArray = [[NSMutableArray alloc] init];
        
        UITableView *tableView=[[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        [self addSubview:tableView];
        self.tableView = tableView;
        [tableView release];
        
        if ([SharedModel userIsSignedin]){
            [self loadData];
        }
        
        MSNotificationCenterAddObserver(@selector(loadData), kNotificationUserPointUpdated);
    }
    return self;
}

- (void)dealloc
{
    MSNotificationCenterRemoveObserver();
    Block_release(_exitBlock);
    [_tableView release];
    [_userPointDict release];
    [_currBalanceArray release];
    [_titleArray release];
    _titleArray=nil;
    _tableView=nil;
    [super dealloc];
}

- (void)loadData
{
    self.titleArray = nil;
    if ([SharedModel userType] == kUserTypePlayer) {
        
        self.titleArray = @[
                            UPBankAmount, UPHighAmount, UPLowAmount,
                            UPHighYesterdayBetting,UPLowYesterdayBetting,
                            UPHighYesterdayReward,UPLowYesterdayReward
                            ];
        
    }else if ([SharedModel userType] == kUserTypeTopAgent) {
        
        self.titleArray = @[
                            UPBankAmount, UPHighAmount, UPLowAmount,
                            UPHighYesterdayBetting,UPLowYesterdayBetting,
                            UPHighReturnPoint,UPLowReturnPoint
                            ];
        
    }else {
        
        self.titleArray = @[
                            UPBankAmount, UPHighAmount, UPLowAmount,
                            UPHighYesterdayBetting,UPLowYesterdayBetting,
                            UPHighReturnPoint,UPLowReturnPoint,
                            UPHighYesterdayReward,UPLowYesterdayReward
                            ];
    }
    
    if (!self.userPointDict)
        self.userPointDict = [NSMutableDictionary dictionary];
    else
        [self.userPointDict removeAllObjects];
    
    RQGetBalance *rqBalance = [[[RQGetBalance alloc] init] autorelease];
//    __block NSMutableArray *blockCBArr = self.currBalanceArray;
//    __block NSMutableArray *blockUserPointArr = self.userPointArray;
    [rqBalance startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        Echo(@"RQGetBalance rq_.msgContent  %@",rq_.msgContent);
        RQGetBalance *rq = (RQGetBalance *)rq_;
        if (!rq_.msgContent && !error_) {
            
//            [blockCBArr removeAllObjects];
//            [blockCBArr addObject:[SharedModel formatBalance:rq.bankBalance]];
//            [blockCBArr addObject:[SharedModel formatBalance:rq.highBalance]];
//            [blockCBArr addObject:[SharedModel formatBalance:rq.lowBalance]];
            
            [self.userPointDict setObject:[SharedModel formatBalance:rq.bankBalance]
                                   forKey:UPBankAmount];
            [self.userPointDict setObject:[SharedModel formatBalance:rq.highBalance]
                                   forKey:UPHighAmount];
            [self.userPointDict setObject:[SharedModel formatBalance:rq.lowBalance]
                                   forKey:UPLowAmount];
            
            [SharedModel shared].lowBalance = rq.lowBalance;
            Echo(@"------------------------%@,%@",[SharedModel shared].lowBalance,rq.lowBalance);
            [_tableView reloadData];
        }
        
        RQUserPoint *rqUserPoint = [[[RQUserPoint alloc] init] autorelease];
        [rqUserPoint startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            
            RQUserPoint *rq = (RQUserPoint *)rq_;
            if (!rq_.msgContent && !error_) {
                
//                [blockUserPointArr removeAllObjects];
//                [blockUserPointArr addObjectsFromArray:rq.userPointArray];
                NSLog(@"%@",rq.userPointDict);
                for (NSString *key in rq.userPointDict) {
                    [self.userPointDict setObject:[rq.userPointDict objectForKey:key] forKey:key];
                }

                [_tableView reloadData];
                
                //保存当前时间，每日更新一次UserPoint
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMdd";
                NSString *strDate = [formatter stringFromDate:[NSDate date]];
                [formatter release];
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:strDate forKey:kUserDefaultsLastUpdateUserPointDate];
                [ud synchronize];
            }
            
        } sender:nil];
        
    } sender:nil];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count]+3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 20;
    }else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    static NSString *exitCellIdentifier = @"exitCell";
    
    if (indexPath.row != [self.titleArray count]+2) {
        
        UserAmountListCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell=[[[UserAmountListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
        
        cell.textLabel.textColor=kYellowTextColor;
        if (indexPath.row == 0) {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:11];
            cell.textLabel.text = @"以下是本账户当天交易明细总额";
        }
        else if (indexPath.row < [self.titleArray count]+1) {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            NSString *tagText = [self.titleArray objectAtIndex:indexPath.row-1];
            
            NSString *value = [self.userPointDict stringForKey:tagText];
            if ([value length] == 0)    value = @" ";
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",tagText, value];

/*
            if (indexPath.row >= 1 && indexPath.row <= 3) {
                cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",tagText, [self.currBalanceArray objectAtIndex:indexPath.row - 1]];
            }else {
                @try {
                    NSString *value = [self.userPointDict stringForKey:tagText];
                    if ([value length] == 0)    value = @" ";
                    cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",tagText, value];
//                                         [self.userPointArray objectAtIndex:indexPath.row - 4]];
                }
                @catch (NSException *exception) {}
            }
 */
        } else {
            cell.textLabel.text = @"";
        }
        
        return cell;
        
    }else {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:exitCellIdentifier];
        if (!cell) {
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exitCellIdentifier] autorelease];
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(0, 0, self.bounds.size.width-40, 45);
            button.titleLabel.font=[UIFont boldSystemFontOfSize:14];
            [button setTitle:@"退出登录" forState:UIControlStateNormal];
            [button setTitleColor:kYellowTextColor forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"button_leftmenu_gray.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            
            UIImageView *bottomSept=[[UIImageView alloc] initWithFrame:CGRectMake(0, cell.contentView.bounds.size.height-2, cell.contentView.bounds.size.width, 2)];
            bottomSept.image=[UIImage imageNamed:@"home_list_item_line.png"];
            [cell.contentView addSubview:bottomSept];
            [bottomSept release];
        }
        
        return cell;
    }
    
}

- (void)exitAction:(id)sender
{
    self.exitBlock(self);
}

@end
