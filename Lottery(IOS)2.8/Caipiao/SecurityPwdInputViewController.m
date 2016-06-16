//
//  SecurityPwdInputViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "SecurityPwdInputViewController.h"
#import "CardListViewController.h"
#import "AddCardViewController.h"
#import "PwdCreateSecPwdVC.h"

#import "CDUserInfo.h"
#import "RQCardBinding.h"

@interface SecurityPwdInputViewController ()<UITextFieldDelegate,RQBaseDelegate>

@end

@implementation SecurityPwdInputViewController
- (void)dealloc{
    self.completeBlock = nil;
    self.viewDidLoadBlock = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"卡号绑定";
    self.view.backgroundColor = kLightGrayBGColor;
//    [_button setTitleColor:kDarkGrayTextColor forState:UIControlStateNormal];
    
    _pwdField.secureTextEntry = YES;
    _pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdField.delegate = self;
    [_pwdField becomeFirstResponder];
    
    if (_viewDidLoadBlock) _viewDidLoadBlock(self);
    
    if (_isOldB) return;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self securityCheck];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)securityCheck{
    CDUserInfo *u = [CDUserInfo user];
    //if未设置安全密码
    UINavigationController *nav = self.navigationController;
    if ([u.needSetSecurityPass boolValue]){
        PwdCreateSecPwdVC *vc = [[PwdCreateSecPwdVC alloc] init];
        NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [controllers removeLastObject];
        [controllers addObject:vc];
        [nav setViewControllers:controllers animated:YES];
        [vc release];
    }
}

- (IBAction)submitAction:(id)sender
{
    if ([_pwdField.text length] > 0)
    {
        if (_isOldB)
        {
            __block SecurityPwdInputViewController *blockSelf = self;
            RQCheckSecPwdB *rq = [[RQCheckSecPwdB alloc]init];
            rq.fundpassword = _pwdField.text;
            [rq startPostWithBlock:^(id rq_, NSError *error_, id rqSender_) {
                RQCheckSecPwdB *rqb =(RQCheckSecPwdB *) rq_;
                if ([rqb.status isEqualToString:@"success"]) {
                    [SharedModel shared].oldBalance = rqb.msg;
                     _completeBlock(blockSelf,YES);   return;
                }else{
                    [HUDView showMessageToView:KEY_WINDOW msg:rqb.msg subtitle:nil];
                }
            } sender:nil];
            [rq release];
            return;
        }
        
        [SharedModel shared].securityPasswd = _pwdField.text;   //save
        RQCheckSecPwd *check = [[[RQCheckSecPwd alloc] init] autorelease];
        check.pwd = _pwdField.text;
        [check startPostWithDelegate:self];
        self.rq = check;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)onRQStart:(RQBase *)rq{
    [HUDView showLoading:self.view];
}

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    RQCheckSecPwd *check = (id)rq;
    
    if (!error && check.msgContent){
        HUDShowMessage(check.msgContent, nil);
        
        SecurityAlertView *alert = (SecurityAlertView *)[SecurityAlertView loadFromNib];
        __block SecurityPwdInputViewController *blkVc = self;
        [alert setCancelBlock:^(SecurityAlertView *view) {
            [blkVc backAction:nil];
            [view removeFromSuperview];
        }];
        __block UITextField *blkTf = _pwdField;
        [alert setConfirmBlock:^(SecurityAlertView *view) {
            [blkTf becomeFirstResponder];
            [view removeFromSuperview];
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:alert];
        
    } else if (check.statusOK){
        if (_completeBlock) {
            __block SecurityPwdInputViewController *blockSelf = self;
            _completeBlock(blockSelf,YES);   return;
        }
        if (_bindRightNow){     //立即绑定
            AddCardViewController *vc = [[AddCardViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        else {      //绑卡列表
            CardListViewController *vc = [[CardListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
    }

}

@end


@implementation SecurityAlertView

- (void)dealloc
{
    Block_release(_confirmBlock);
    Block_release(_cancelBlock);
    [super dealloc];
}

- (void)awakeFromNib
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    
    //Animated show
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 1.f)],
                  nil];
    kfa.duration = .1f;
    kfa.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_mainView.layer addAnimation:kfa forKey:nil];
}

- (IBAction)cancel:(id)sender
{
    self.cancelBlock(self);
}

- (IBAction)confirm:(id)sender
{
    self.confirmBlock(self);
}

@end


