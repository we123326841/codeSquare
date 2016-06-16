//
//  TransferViewController.m
//  Caipiao
//
//  Created by danal on 13-5-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "TransferViewController.h"
#import "TransferResultViewController.h"
#import "TransferResultView.h"
#import "View+Factory.h"

@interface TransferViewController ()
@property (strong, nonatomic) LoadingView *header;

@end

@implementation TransferViewController

- (void)dealloc{
    [self removeKeyboardObserver];
    [super dealloc];
}

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
	// Do any additional setup after loading the view.
    self.title = @"转账";
    for (UIView *view in [self.view subviews]) {
        view.alpha = 0;
    }

    _menu.delegate = self;
    _menu.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_menu.dataList addObjectsFromArray:@[@"银行余额转入高频",@"银行余额转入低频",@"高频转入银行余额",@"低频转入银行余额"]];

    _nameLbl.text = [NSString stringWithFormat:@"用户名  %@", [SharedModel shared].username];
    _amountInputField.keyboardType = UIKeyboardTypeDecimalPad;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldChangeNotificationMethod:) name:UITextFieldTextDidChangeNotification object:nil];
    _toChannelIndex = 0;
    [_confirmButton setEnabled:NO];
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, -100.f, 320.f, 100.f) atTop:YES];
    [self.view addSubview:loadingView];
    self.header = loadingView;
    [loadingView release];
    
    CGRect rect = self.header.frame;
    rect.origin.y = -40.f;
    [UIView animateWithDuration:.3f
                          delay:.1f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.header.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         self.header.state = kPRStateLoading;
                         //                         [self loadData];
                         [self performSelector:@selector(loadData) withObject:nil afterDelay:.3f];
                     }];
    
    {
        for (UILabel *l in _tagLbls) {
            l.textColor = Color(@"TransferTagColor");
        }
        _bankBalanceLbl.textColor=_highBalanceLbl.textColor=_lowBalanceLbl.textColor=_accountLbl.textColor = Color(@"TransferAmountColor");
        _amountTagLbl.textColor = Color(@"TransferAmountTagColor");
        [_confirmButton setTitleColor:Color(@"TransferMenuColor") forState:UIControlStateNormal];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_menu close];
}

- (void)loadData
{
    RQGetBalance *rq = [[[RQGetBalance alloc] init] autorelease];
    [rq startPostWithDelegate:self];
    self.rq = rq;
}

- (void)layouts
{
    for (UIView *view in [self.view subviews]) {
        view.alpha = 1;
    }
    
    [self addKeyboardObserver];
    _amountInputField.returnKeyType = UIReturnKeyDone;
    _amountInputField.delegate = self;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, _menu.mainView.bounds.size.height)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = [_menu.dataList objectAtIndex:0];
    lbl.textColor = Color(@"TransferMenuColor");
    [_menu.mainView addSubview:lbl];
    [lbl release];
    
    _bankBalanceLbl.text = [SharedModel formatBalance:_bankBalance];
    _highBalanceLbl.text = [SharedModel formatBalance:_highBalance];
    _lowBalanceLbl.text = [SharedModel formatBalance:_lowBalance];
    _accountLbl.text = [SharedModel formatBalancef:([_bankBalance floatValue]+[_highBalance floatValue]+[_lowBalance floatValue])];
    _availableAmountLbl.text = [NSString stringWithFormat:@"可转账%@元",[SharedModel formatBalance:_bankBalance]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)animatedChangeViewFrame:(CGRect)frame view:(UIView *)view{
    
}

- (IBAction)confirmAction:(id)sender
{
    [_amountInputField resignFirstResponder];
    [HUDView showLoadingToView:self.view msg:@"正在提交数据，请等待..." subtitle:nil];
    
    RQTransfer *tr = [[RQTransfer alloc] init];
    tr.fmoney = _amountInputField.text;
    switch (_toChannelIndex) {
        case 0:
            tr.direction = kTransferBankToHigh;
            break;
        case 1:
            tr.direction = kTransferBankToLow;
            break;
        case 2:
            tr.direction = kTransferHighToBank;
            break;
        case 3:
            tr.direction = kTransferLowToBank;
            break;
        default:
            break;
    }
    [tr startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        NSLog(@"rq_.msgContent| %ld |%@",(long)rq_.msgType,rq_.msgContent);
        [HUDView dismissCurrent];
        
        if (!rq_.msgContent) {
            
            [SharedModel shared].balance = [tr.balanceArray objectAtIndex:1];
            _bankBalance = [[tr.balanceArray objectAtIndex:0] retain];
            _highBalance = [[tr.balanceArray objectAtIndex:1] retain];
            _lowBalance = [[tr.balanceArray objectAtIndex:2] retain];

            _accountLbl.text = [SharedModel formatBalancef:([_bankBalance floatValue]+[_highBalance floatValue]+[_lowBalance floatValue])];

            MSNotificationCenterPost(kNotificationUserInfoUpdated);
            
            TransferResultViewController *vc = [[TransferResultViewController alloc] initWithNibName:@"TransferResultViewController" bundle:nil];
            vc.amount = _amountInputField.text;
            vc.descr = [_menu.dataList objectAtIndex:_menu.selectedIndex];
            
            NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [controllers removeLastObject];
            [controllers addObject:vc];
            [self.navigationController setViewControllers:controllers animated:YES];
            [vc release];
            
        }else if (rq_.msgType == 2) {
            
            TransferResultView *result = [[[NSBundle mainBundle] loadNibNamed:@"TransferResultView" owner:self options:nil] lastObject];
            result.balanceArray = @[[tr.balanceArray objectAtIndex:0], [tr.balanceArray objectAtIndex:1], [tr.balanceArray objectAtIndex:2]];
            result.direction = tr.direction;
            result.amountLbl.alpha = 0;
            //result.tag = 999;
            [result.retryButton addTarget:self action:@selector(retryCommit:) forControlEvents:UIControlEventTouchUpInside];
            WhiteAlertView *alert = [[WhiteAlertView alloc] initWithTitle:@"转账失败" titleIcon:[UIImage imageNamed:@"alert_failed.gif"] contentView:result cancelButtonTitle:@"继续转账"];
            alert.tag = 999;
            alert.errorLbl.text = rq_.msgContent;
            [alert show];
            [alert release];
        }
        
        [rq_ release];
    } sender:nil];
    
}

- (void)retryCommit:(UIButton *)sender
{
    WhiteAlertView *alert = (WhiteAlertView *)[[UIApplication sharedApplication].keyWindow viewWithTag:999];
    [alert removeFromSuperview];
    
    [self confirmAction:nil];
}

#pragma mark - DropDownMenuDelegate

- (UITableViewCell *)dropDownMenu:(DropDownMenu *)menu cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [menu.tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = [_menu.dataList objectAtIndex:indexPath.row];
    cell.textLabel.textColor = Color(@"TransferMenuColor");
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)dropDownMenu:(DropDownMenu *)menu selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            _toChannelIndex = 0;
            _availableAmountLbl.text = [SharedModel formatBalance:_bankBalance];
        }
            break;
        case 1:
        {
            _toChannelIndex = 1;
            _availableAmountLbl.text = [SharedModel formatBalance:_bankBalance];
        }
            break;
        case 2:
        {
            _toChannelIndex = 2;
            _availableAmountLbl.text = [SharedModel formatBalance:_highBalance];
        }
            break;
        case 3:
        {
            _toChannelIndex = 3;
            _availableAmountLbl.text = [SharedModel formatBalance:_lowBalance];
        }
            break;
        default:
            break;
    }
    
    for (UIView *view in [_menu.mainView subviews]) {
        [view removeFromSuperview];
    }
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, _menu.mainView.bounds.size.height)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = [_menu.dataList objectAtIndex:indexPath.row];
    lbl.textColor = Color(@"TransferMenuColor");
    [_menu.mainView addSubview:lbl];
    [lbl release];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_amountInputField resignFirstResponder];
    return NO;
}

- (void)textfieldChangeNotificationMethod:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    if ([textField.text floatValue] == 0.0) {
        [_confirmButton setEnabled:NO];
    }else if ([[textField.text componentsSeparatedByString:@"."] count] >1 && [[[textField.text componentsSeparatedByString:@"."] lastObject] length] > 4) {
        textField.text = [textField.text substringToIndex:[textField.text length]-1];
    }else if ([[textField.text componentsSeparatedByString:@"."] count] >1 && [[[textField.text componentsSeparatedByString:@"."] objectAtIndex:0] length] == 0) {
        [_confirmButton setEnabled:NO];
    }else {
        [_confirmButton setEnabled:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = IOS7 ? 64.f : 0.f;
        self.view.frame = frame;
    }];
}

#pragma mark - Keyboard

- (void)keyboardDidShowComplete:(CGRect)keyboardFrame
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        if (IPHONE5) {
            frame.origin.y = -100;
        }else {
            frame.origin.y = -190;
        }
        self.view.frame = frame;
    }];
}

- (void)keyboardDidHideComplete:(CGRect)keyboardFrame
{
//    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
//    [[tempWindow viewWithTag:0xf1f1] removeFromSuperview];
}

#pragma mark - RQBaseDelegate
- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQGetBalance *)rq error:(NSError *)error{
    Echo(@"RQGetBalance rq.msgContent:%@",rq.msgContent);
    CGRect rect = self.header.frame;
    rect.origin.y = -100.f;
    self.header.state = kPRStateNormal;
    [UIView animateWithDuration:.3f animations:^{
        self.header.frame = rect;
        
    } completion:^(BOOL finished) {
        
        _bankBalance = rq.bankBalance;
        _highBalance = rq.highBalance;
        _lowBalance = rq.lowBalance;
        
        [self layouts];
        
    }];
}

@end
