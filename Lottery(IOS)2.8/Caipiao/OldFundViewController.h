//
//  OldFundViewController.h
//  Caipiao
//
//  Created by danal-rich on 10/15/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface OldFundViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
}
@property (assign, nonatomic) IBOutlet UITableView *tableView;
@property (copy ,nonatomic)NSString *fundpwd;
@end
