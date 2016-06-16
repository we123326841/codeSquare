//
//  SettingViewController.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "Switch.h"

@interface SettingViewController : BaseViewController<
UITableViewDataSource,UITableViewDelegate>
{
}

@property (assign,nonatomic) IBOutlet UITableView *tableSetting;
@property (assign,nonatomic) IBOutlet Switch * pushSwitch;
@property (assign,nonatomic) IBOutlet UIView * footerView;
@property (assign,nonatomic) IBOutlet UIButton * logoutButton;
@end

#import "RQPush.h"
#import "RQVersion.h"
