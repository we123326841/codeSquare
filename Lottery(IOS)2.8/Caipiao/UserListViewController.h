//
//  UserListViewController.h
//  Caipiao-用户列表
//
//  Created by danal on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface UserListViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (assign, nonatomic) IBOutlet UIImageView *northBackground;
@property (assign, nonatomic) IBOutlet UILabel *nameLbl;
@property (assign, nonatomic) IBOutlet UILabel *balance1Lbl;
@property (assign, nonatomic) IBOutlet UILabel *balance2Lbl;
@property (assign, nonatomic) IBOutlet UITextField *textField;
@property (assign, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MSPullingRefreshTableView *searchTableView;

@property (assign, nonatomic) int uid;  //所查看的用户id,缺省为当前登录用户

@end
