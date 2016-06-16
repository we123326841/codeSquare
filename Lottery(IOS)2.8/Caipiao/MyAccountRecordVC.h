//
//  MyAccountRecordVCViewController.h
//  Caipiao
//
//  Created by GroupRich on 14-10-13.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAccountTableView.h"

@interface MyAccountRecordVC : BaseViewController
@property (assign, nonatomic) id delegate;
@property (assign, nonatomic) IBOutlet MyAccountTableView *tableView;
@end
