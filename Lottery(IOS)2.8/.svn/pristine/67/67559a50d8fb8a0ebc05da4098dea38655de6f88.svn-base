//
//  AddUserResultVC.m
//  Caipiao
//
//  Created by cYrus on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "AddUserResultVC.h"
#import "AddUserViewController.h"

@interface AddUserResultVC ()

@property (assign, nonatomic) IBOutlet UILabel *typeLabel;
@property (assign, nonatomic) IBOutlet UILabel *accountLabel;
@property (assign, nonatomic) IBOutlet UILabel *pwdLabel;
@property (assign, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (assign, nonatomic) IBOutlet UIButton *cpyBtn;
@property (assign, nonatomic) IBOutlet UIButton *forwardBtn;
@property (assign, nonatomic) IBOutlet UIButton *addUserBtn;
@property (assign, nonatomic) IBOutlet UIButton *userListBtn;

//@property (assign, nonatomic) IBOutlet UIButton *button;

@end

@implementation AddUserResultVC

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
    for (id obj in [self.view subviews]) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *lbl=(UILabel *)obj;
            lbl.textColor=kYellowTextColor;
        }
    }
    
    [self.cpyBtn setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
    [self.forwardBtn setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
    [self.addUserBtn setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
    [self.userListBtn setTitleColor:kDarkGreenColor forState:UIControlStateNormal];

    self.accountLabel.text=[self.accountLabel.text stringByAppendingString:self.userAccount];
    self.pwdLabel.text=[self.pwdLabel.text stringByAppendingString:self.userPwd];
    self.typeLabel.text=[self.typeLabel.text stringByAppendingString:self.userType];
    self.nicknameLabel.text=[self.nicknameLabel.text stringByAppendingString:self.userNickname];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction:(id)sender
{
    [self addNewUser:nil];
}

- (IBAction)copyInfo:(id)sender
{
    NSString *msgContent = [NSString stringWithFormat:@"用户组：%@ \n登录账号：%@ \n用户昵称：%@ \n登录密码：%@",self.userType, self.userAccount, self.userNickname, self.userPwd];
    [[UIPasteboard generalPasteboard] setString:msgContent];
    
    HUDShowMessage(@"复制成功", nil);
}

- (IBAction)forward:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"短信", @"邮件", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];
    [sheet release];
}

- (IBAction)gotoUserList:(id)sender
{
    [[AppDelegate leftMenuController] swithToMenuIndex:kMenuIndexUserList];
}

- (IBAction)addNewUser:(id)sender
{
    AddUserViewController *vc = [[AddUserViewController alloc] initWithNibName:@"AddUserViewController" bundle:nil];
    vc.title = @"增加用户";
    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [dele.smc activeViewController:nav];
    [vc release];
    [nav release];
}

- (void)sendSMSWithContent:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];

    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}

- (void)sendMailWithSubject:(NSString *)subject content:(NSString *)content
{
    MFMailComposeViewController *controller = [[[MFMailComposeViewController alloc] init] autorelease];
    
    if([MFMailComposeViewController canSendMail])
    {
        [controller setSubject:subject];
        [controller setMessageBody:content isHTML:NO];
        controller.mailComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *msgContent = [NSString stringWithFormat:@"用户组：%@ \n登录账号：%@ \n用户昵称：%@ \n登录密码：%@",self.userType, self.userAccount, self.userNickname, self.userPwd];
    
    switch (buttonIndex) {
        case 0:
            [self sendSMSWithContent:msgContent recipientList:nil];
            break;
        case 1:
            [self sendMailWithSubject:@"用户信息" content:msgContent];
            break;
        case 2:
            break;
        default:
            break;
    }
}

#pragma mark - MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled) {
        Echo(@"Message cancelled");
    }else if (result == MessageComposeResultSent) {
        Echo(@"Message sent");
    }else {
        Echo(@"Message failed");
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled) {
        Echo(@"Message cancelled");
    }else if (result == MessageComposeResultSent) {
        Echo(@"Message sent");
    }else {
        Echo(@"Message failed");
    }
}

@end
