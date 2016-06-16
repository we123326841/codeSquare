//
//  UserTypeViewController.h
//  Caipiao
//
//  Created by cYrus on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface UserTypeViewController : BaseViewController

@property (assign, nonatomic) IBOutlet UILabel *tipLabel;
@property (assign, nonatomic) IBOutlet UIButton *playerButton;
@property (assign, nonatomic) IBOutlet UIButton *agentButton;


- (IBAction)player:(id)sender;
- (IBAction)agent:(id)sender;

@end
