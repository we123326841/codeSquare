//
//  UserTransationViewController.h
//  Caipiao
//
//  Created by danal-rich on 13-11-6.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RQTransactionHistory.h"

@interface UserTransationViewController : BaseViewController
<MSPullingRefreshTableViewDelegate,UIScrollViewDelegate,
UITableViewDataSource,UITableViewDelegate,RQBaseDelegate>
{
    BOOL _isRefresh;
    UILabel *_amountLbl;
    NSString *_dateString;
}

@property (retain,nonatomic) NSMutableArray *dataList;
@property (retain,nonatomic) MSPullingRefreshTableView *tableView;

@property (assign, nonatomic) int uid;
@property (copy, nonatomic) NSString *username;
@end
