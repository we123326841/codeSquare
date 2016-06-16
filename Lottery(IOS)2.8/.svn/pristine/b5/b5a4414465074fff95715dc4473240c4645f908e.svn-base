//
//  NotSetSecurityPwdVC.m
//  Caipiao
//
//  Created by GroupRich on 14-11-17.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "NotSetSecurityPwdVC.h"

@interface NotSetSecurityPwdVC ()

@end

@implementation NotSetSecurityPwdVC

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
    
    self.title=@"设定绑卡";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingPwd:(id)sender {
    __block NotSetSecurityPwdVC *vc = self;
    _clickedBlock(vc);
}
-(void)dealloc
{
    [_clickedBlock release];
    [super dealloc];
}
@end
