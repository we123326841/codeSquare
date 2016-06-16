//
//  HallViewController.h
//  Caipiao
//
//  Created by danal-rich on 7/22/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface HallViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
}
@property (strong, nonatomic) NSArray *lotList;

/**
 * 检查彩种状态
 */
+ (void)checkLotteryStateIn:(UIViewController *)controller lottery:(CDLottery *)lot;

/**
 * 机选1注
 */
+ (void)generate1RandomIn:(UINavigationController *)controller lottery:(CDLottery *)lot;

@end
