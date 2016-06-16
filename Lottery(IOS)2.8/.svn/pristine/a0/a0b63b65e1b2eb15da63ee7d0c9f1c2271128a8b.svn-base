//
//  PublicDetailViewController.h
//  Caipiao
//
//  Created by CYRUS on 14-8-1.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "PublicDetailSectionView.h"

@interface PublicDetailViewController : BaseViewController<MSPullingRefreshTableViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, RQBaseDelegate>
{
    BOOL _isRefresh;
}

@property (assign, nonatomic) NSInteger chan_id;
@property (assign, nonatomic) NSInteger lottery_id;
@property (assign, nonatomic) IBOutlet MSPullingRefreshTableView *tableView;
@property (assign, nonatomic) IBOutlet UIButton *betButton;
@property (strong, nonatomic) NSMutableArray *dataList;

@end
