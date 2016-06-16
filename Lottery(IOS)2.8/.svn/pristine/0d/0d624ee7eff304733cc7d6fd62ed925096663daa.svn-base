//
//  FundsSlideVC.h
//  Caipiao
//
//  Created by CYRUS on 14-8-5.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface FundsSlideVC : BaseViewController<MSPullingRefreshTableViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, RQBaseDelegate>
{
    BOOL _isRefresh;
}

@property (assign, nonatomic) BOOL isLowGame;
@property (assign, nonatomic) IBOutlet MSPullingRefreshTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (copy, nonatomic) NSString *type;//请求类型 "0：所有类型 1：转入频道 2：频道转出 3：加入游戏 4：销售返点 5：奖金派送 6：追号扣款 7：当期追号返款 9：撤单返款 10：撤单手续费 11：撤销返点 12：撤销派奖 13：频道小额转出 14：特殊金额整理 15：特殊金额清理 .未填则预设为0

- (void)startLoading;

@end
