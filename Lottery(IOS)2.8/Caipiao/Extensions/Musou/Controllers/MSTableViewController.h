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
#import "MSPullingRefreshTableView.h"
#import "MSLoadingCell.h"

@interface MSTableViewController : UIViewController <
UITableViewDataSource,
UITableViewDelegate,
MSPullingRefreshTableViewDelegate,
MSLoadingCellDelegate
>

@property (retain,nonatomic) MSPullingRefreshTableView *tableView;
@property (retain,nonatomic) NSMutableArray *dataList;
@property (nonatomic) CGPoint offset;
@property (nonatomic) BOOL isAutoLoadingCell;

- (void)configCell:(UITableViewCell **)cell 
       atIndexPath:(NSIndexPath *)indexPath
    reuseIdentifier:(NSString *)identifier;

@end
