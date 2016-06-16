//
//  PwdChangeResultVC.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "PwdChangeResultVC.h"
#import "CDUserInfo.h"
#import "View+Factory.h"

@interface PwdChangeResultVC ()

@property (assign, nonatomic) IBOutlet YellowLabel *noticeContentLbl;
@property (assign, nonatomic) IBOutlet YellowButton *noticeBtn;

- (IBAction)confirm:(id)sender;

@end

@implementation PwdChangeResultVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    Echo(@"%s",__func__);
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _count = 11;
    if (_passwordType == kPasswordTypeLogin) {
        _noticeContentLbl.text = @"登录密码修改成功，请重新登录";
    }else if (_passwordType == kPasswordTypeSecCreate) {
        _noticeContentLbl.text = @"安全密码设置成功，请牢记您的新密码";
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_timer) {
        [_timer invalidate];
        [_timer release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPasswordType:(PasswordType)passwordType
{
    _passwordType = passwordType;
    
    _timer = [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES] retain];
    [_noticeBtn setTitle:[NSString stringWithFormat:@"确 定（%d）",_count] forState:UIControlStateNormal];
    
//    //设置了安全密码之后保存状态
//    if (_passwordType == kPasswordTypeSecCreate) {
//        CDUserInfo *u = [CDUserInfo findFirst];
//        u.needSetSecurityPass = [NSNumber numberWithBool:NO];
//        [u save];
//    }
}

- (void)backAction:(id)sender
{
    [self confirm:nil];
}

- (void)updateTime
{
    --_count;
    [_noticeBtn setTitle:[NSString stringWithFormat:@"确 定（%d）",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self confirm:nil];
    }
}

- (void)confirm:(id)sender
{
//    LeftViewController *vc = [AppDelegate leftMenuController];
//    vc.userHeaderView.balanceLbl.text = @"高频余额：0.0000元";
//    [[AppDelegate leftMenuController] swithToMenuIndex:kMenuIndexSign];
    
    [SharedModel shared].username = nil;
    [SharedModel shared].balance = 0;
    [SharedModel shared].token = nil;
    MSNotificationCenterPost(kNotificationUserInfoUpdated);
    RQLogout *rqLogout = [[[RQLogout alloc] init] autorelease];
    [rqLogout startPostWithBlock:nil sender:nil];
}

@end
