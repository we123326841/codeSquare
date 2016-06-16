//
//  OpenLinkViewController.m
//  Caipiao
//
//  Created by danal-rich on 4/1/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "OpenLinkViewController.h"
#import "LinkDetailViewController.h"

#import "RQLink.h"
#import "LinkTabBar.h"
#import "ShareManager.h"

@interface OpenLinkViewController ()<RQBaseDelegate>
@property (strong, nonatomic) NSArray *linkItems;
@property (strong, nonatomic) ShareManager *shareMgr;
@end

@implementation OpenLinkViewController

- (void)dealloc{
    self.shareMgr = nil;
    self.linkItems = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    self.title = @"代理链接管理";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_bar addTarget:self action:@selector(onTabBarChanges:) forControlEvents:UIControlEventValueChanged];
    
    _textView.backgroundColor =
    _checkButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
    _textView.layer.cornerRadius =
    _checkButton.layer.cornerRadius = 4.f;
    
    _textView.text = @"十年，业内最安全平台，充提便捷，到帐迅速，祝您购彩愉快。";
    
    _textView.textColor = kYellowTextColor;
    _textView.delegate = self;
    [_checkButton setTitleColor:kYellowTextColor forState:UIControlStateNormal];
    [_forwardButton setTitleColor:kGreenBGColor forState:UIControlStateNormal];
    _checkButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _checkButton.imageEdgeInsets = UIEdgeInsetsMake(0, _checkButton.bounds.size.width - 40, 0, 0);
    
    for (UIView *v in self.view.subviews){
        v.hidden = YES;
    }
    [self showLoadingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (IBAction)checkLinkAction:(id)sender{
    LinkItem *item = [self.linkItems objectAtIndex:_bar.selectedIndex];
    LinkDetailViewController *vc = [[LinkDetailViewController alloc] init];
    vc.linkItem = item;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)forwardActionl:(id)sender{
    //Share to Weixin,email,sms,copy
    LinkItem *item = [self.linkItems objectAtIndex:_bar.selectedIndex];
    ShareManager *share = [[ShareManager alloc] initWithText:_textView.text link:item.urlString];
    [share openShareList];
    self.shareMgr = share;
    [share release];
}

- (void)onTabBarChanges:(LinkTabBar *)bar{
    Echo(@"%d",bar.selectedIndex);
    LinkItem *item = [self.linkItems objectAtIndex:bar.selectedIndex];
//    if ([item.remark length] > 0){
//        _textView.text = [item.remark stringByAppendingString:item.urlString];
//    }
    _textView.text = item.remark;
}

- (void)requestData{
    RQLinkList *request = [[RQLinkList alloc] init];
    [request startPostWithDelegate:self];
    self.rq = request;
    [request release];
}

- (void)onRQComplete:(RQLinkList *)rq error:(NSError *)error{
    [self hideLoadingView];
    
    if (rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
    }
    else {
//        _bar.titleItems = @[@"会员",@"会员",@"会员",@"会员",@"会员",@"会员",@"会员",@"会员"];
        if ([rq.linkList count] > 0){
            self.linkItems = rq.linkList;
            NSMutableArray *titles = [[NSMutableArray alloc] init];
            for (LinkItem *item in self.linkItems){
                [titles addObject:item.type == 0 ? @"会员" : @"代理"];
            }
            _bar.titleItems = titles;
            [titles release];
            
            //Fill with the 1st item
            LinkItem *item = [self.linkItems objectAtIndex:0];
            _textView.text = item.remark;
            
            //Show these views
            for (UIView *v in self.view.subviews){
                v.hidden = NO;
            }
        }
        //No link
        else {
            UILabel *lbl = [[UILabel alloc] initWithFrame:self.view.bounds];
            lbl.textColor = kYellowTextColor;
            lbl.backgroundColor = [UIColor clearColor];
            lbl.textAlignment = UITextAlignmentCenter;
            lbl.font = [UIFont boldSystemFontOfSize:16.f];
            lbl.numberOfLines = 0;
            lbl.text = @"您还没有任何开启链接\n请登录平台设置";
            [self.view addSubview:lbl];
            [lbl release];
        }
            
    }
}


#pragma mark - TextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}

@end
