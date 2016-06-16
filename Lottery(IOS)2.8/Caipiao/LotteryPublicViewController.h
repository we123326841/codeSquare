//
//  LotteryPublicViewController.h
//  Caipiao 开奖信息
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "RQPublicHistory.h"

@interface LotteryPublicViewController  : BaseViewController
<MSPullingRefreshTableViewDelegate,
RQBaseDelegate,
UIScrollViewDelegate,
UITableViewDataSource,
UITableViewDelegate>
{
    BOOL _isRefresh;
    
    UIView *_wrapView;
    
    int pageNo;
    int pageSize;
    int totalPage;
    
    NSString* requestUrl;
    MSHTTPRequest* request;
    NSMutableDictionary* balls;
    NSMutableDictionary* selectedBalls;
}

@property (retain,nonatomic) NSMutableArray *tradeRecordsArray;
@property (retain,nonatomic) MSPullingRefreshTableView *tableView;
@property (nonatomic) BOOL hideBetButton;

@end
