//
//  MSTableViewController.h
//  Musou
//  A TableView controller that contains ability of pulling down to refresh
//  and tapping loading cell to load more
//
//  Created by luo danal on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSBaseViewController.h"
#import "MSPullingRefreshTableView.h"
#import "MSLoadingCell.h"

@interface MSLoadingTableViewController : MSTableViewController
<MSPullingRefreshTableViewDelegate,MSLoadingCellDelegate>
@property (assign,nonatomic) IBOutlet MSPullingRefreshTableView *tableView;
@property (assign, nonatomic) NSInteger page;
@property (readonly, nonatomic) BOOL refresh;
@property (nonatomic) BOOL autoLoading;

@end


@interface MSPullToLoadTableViewController : MSTableViewController
<MSPullingRefreshTableViewDelegate>
@property (assign,nonatomic) IBOutlet MSPullingRefreshTableView *tableView;
@property (assign, nonatomic) NSInteger page;
@property (readonly, nonatomic) BOOL refresh;

@end