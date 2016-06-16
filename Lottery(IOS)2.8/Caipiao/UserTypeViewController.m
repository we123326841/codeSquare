//
//  UserTypeViewController.m
//  Caipiao
//
//  Created by cYrus on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UserTypeViewController.h"
#import "AddUserViewController.h"

@interface UserTypeViewController ()

@end

@implementation UserTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tipLabel.textColor=kYellowTextColor;
    [self.playerButton setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
    [self.agentButton setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)player:(id)sender
{
    AddUserViewController *vc=[[AddUserViewController alloc] initWithNibName:@"AddUserViewController" bundle:Nil];
    vc.userType=@"0";
    vc.title=@"增加用户";
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)agent:(id)sender
{
    AddUserViewController *vc=[[AddUserViewController alloc] initWithNibName:@"AddUserViewController" bundle:Nil];
    vc.userType=@"1";
    vc.title=@"增加用户";
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

@end
