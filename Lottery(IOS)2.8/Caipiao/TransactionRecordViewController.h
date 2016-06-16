//
//  TransactionRecordViewController.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "RQTransactionHistory.h"
#import "NavTitleMenu.h"

@interface TransactionRecordViewController : BaseViewController
<MSPullingRefreshTableViewDelegate,UIScrollViewDelegate,
UITableViewDataSource,UITableViewDelegate,RQBaseDelegate,NavTitileMenuDelegate>
{
    BOOL _isRefresh;
    
    int pageNo;
    int pageSize;
    int totalPage;
    NSString* requestUrl;
    MSHTTPRequest* request;
    UILabel *_amountLbl;
    NSString *_dateString;
    NavTitleControl *_titleLbl;
    UIView *_contentView;
    BOOL _isLowGame;
}

@property (strong, nonatomic) NSNumber *tradeType; //请求类型 "0：所有类型 1：转入频道 2：频道转出 3：加入游戏 4：销售返点 5：奖金派送 6：追号扣款 7：当期追号返款 9：撤单返款 10：撤单手续费 11：撤销返点 12：撤销派奖 13：频道小额转出 14：特殊金额整理 15：特殊金额清理 .未填则预设为0
@property (retain,nonatomic) NSMutableArray *tradeRecordsArray;
@property (retain,nonatomic) NSArray *titles;
@property (retain,nonatomic) MSPullingRefreshTableView *tableView;
@property (strong, nonatomic) NavTitleMenu *navTitleMenu;

@end
