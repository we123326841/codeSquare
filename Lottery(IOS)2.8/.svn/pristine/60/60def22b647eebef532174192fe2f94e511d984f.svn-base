//
//  RechargeViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-11-25.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RechargeViewController.h"
#import "SecurityPwdInputViewController.h"
#import "RechargeResultViewController.h"
#import "RQBankRecharge.h"
#import "CDUserInfo.h"
#import "BankCardCell.h"
#import "QuickRechargeResultViewController.h"
#import "QuickRechargeFAQViewController.h"
#import "WarningDialog.h"
@interface RechargeViewController ()<RQBaseDelegate>
@property (strong, nonatomic) NSArray *quickRechargeBankList;
@property (strong, nonatomic) WarningDialog *warningDialog;
@property (readwrite) int bankId;
@property (readwrite) float quickMax;
@property (readwrite) float quickMin;
@property (nonatomic,assign)BOOL isSHowWarning;


@end

@implementation RechargeViewController

@synthesize bankId = _bankId;
@synthesize quickMax = _quickMax;
@synthesize quickMin = _quickMin;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"快捷支付";
    
    UIButton *rightButton = [UIButton barButtonWithTitle:@"新增绑卡"];
    rightButton.frame = CGRectMake(0, 0, 76, rightButton.bounds.size.height);
    [rightButton addTarget:self action:@selector(bindNewCardAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:rightButton];
    rightButton.hidden=YES;
    
    [self showLoadingView];
    
    CDUserInfo *u = [CDUserInfo user];
    if ([u.needSetSecurityPass boolValue]){
        
    } else {
        
    }
    
    _noticeView = (id)[CardNotBindView loadFromNib];
    _noticeView.hidden = YES;
    [_noticeView.bindButton addTarget:self action:@selector(bindAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_noticeView];
    
    for (UIView *v in [_wrapView subviews]) {
        v.hidden = YES;
    }
    
    _amoutLbl.textColor = Color(@"RechargeAmountLabelColor");
    _tipLbl.textColor = Color(@"RechargeTipLabelColor");
    
    
    //quick recharge bank table
    _quickRechargeTable.frame = self.view.bounds;
    _quickRechargeTable.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    _quickRechargeTable.backgroundColor = self.view.backgroundColor;
    _quickRechargeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _quickRechargeTable.tableFooterView = _wrapView;
    
    self.lastIndexPath=[NSIndexPath indexPathForRow: MSIntForKey(@"lastIndexPathSelectTypeRecharge")  inSection:0];
    
    _amoutField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToNormalView)];
    [self.wrapView addGestureRecognizer:tap];
    
    //adding FAQ button
    UIButton *info = [UIButton buttonWithType:UIButtonTypeCustom];
    info.frame = CGRectMake(0, 0, 28, 28);
    [info setImage:ResImage(@"info-icon.png") forState:UIControlStateNormal];
    [info addTarget:self action:@selector(gotoInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:info];
}

-(void)showdialogWarning{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
   BOOL isNeedTip=[defaults doubleForKey:@"isNeedTip"];
    if (isNeedTip) return;
    
    WarningDialog *warningDialog =[WarningDialog warningWithNib];
    self.warningDialog =warningDialog;
    warningDialog.frame =[[UIScreen mainScreen]bounds];
   // warningDialog.center = self.view.center;
    [self.view.window addSubview:warningDialog];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [warningDialog.layer addAnimation:popAnimation forKey:nil];

    
    

}



//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
 //   [self.warningDialog removeFromSuperview];
//}



-(void)viewWillAppear:(BOOL)animated
{
    _amoutField.text = @"";
}

- (IBAction)gotoInfo:(id)sender{
    QuickRechargeFAQViewController *vc = [[QuickRechargeFAQViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

-(void)done
{
    if (_selected) {
        _selected(_lastIndexPath);
        MSSetIntForKey(_lastIndexPath.row, @"lastIndexPathSelectTypeRecharge");
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self backToNormalView];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = [_rechargeView convertRect:textField.frame fromView:_rechargeView];
    frame = [UIView convertViewFrame:textField toSuperview:_rechargeView];
    float boundsY = self.view.bounds.size.height - 340;
    if (frame.origin.y  + frame.size.height > boundsY){
        float diff = frame.origin.y + frame.size.height*2 - boundsY;
        frame = _rechargeView.frame;
        frame.origin.y = -diff;
        [UIView animateWithDuration:.2f animations:^{
            _rechargeView.frame = frame;
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)dismissKeyboard{
    [self.view endEditing:YES];
}

-(void) backToNormalView{
    [self dismissKeyboard];
    
    CGRect frame = _rechargeView.frame;
    frame.origin.y = 65.f;
    [UIView animateWithDuration:.2f animations:^{
        _rechargeView.frame = frame;
    }];
}

#pragma mark - Actions

- (void)requestData{
    RQQuickRechargeInit *rechargeInit = [[[RQQuickRechargeInit alloc] init] autorelease];
    self.rq = rechargeInit;
    [rechargeInit startPostWithDelegate:self];
}

//Bind right now
- (IBAction)bindAction:(id)sender
{
    SecurityPwdInputViewController *vc = [[SecurityPwdInputViewController alloc] init];
    vc.bindRightNow = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)bindNewCardAction:(id)sender
{
    SecurityPwdInputViewController *vc = [[SecurityPwdInputViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)confirm:(id)sender
{
    [self showLoadingView]; //update
    [self backToNormalView];
    
    if ([_amoutField.text floatValue] < _quickMin || [_amoutField.text floatValue] > _quickMax){
        NSString *msg = [NSString stringWithFormat:@"充值金额规定：最低%.02f元，最高%.02f元",_quickMin, _quickMax];
        HUDShowMessage(msg, nil);
        return;
    }
    
    RQQuickRechargeCommit *commit = [[[RQQuickRechargeCommit alloc] init] autorelease];
    commit.bankId = _bankId;
    commit.amount = _amoutField.text;
    
    [commit startPostWithBlock:^(id rq_, NSError *error_, id rqSender_) {
        RQQuickRechargeCommit *rq = (RQQuickRechargeCommit *)rq_;
        if (!rq.msgContent) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rq.quickUrl]];
            QuickRechargeResultViewController *vc = [[QuickRechargeResultViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }else {
            [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:commit.msgContent subtitle:nil];
        }
        
    } sender:nil];
    
}

#pragma mark - RequestDelegate

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    
    if (!_isSHowWarning) [self showdialogWarning];
    _isSHowWarning=YES;
    if ([rq isKindOfClass:[RQQuickRechargeInit class]]){
        
        [self hideLoadingView];
        RQQuickRechargeInit *quickRechargeInit = (id)rq;
        
        if (quickRechargeInit.msgContent){
            Echo(@"%@",quickRechargeInit.msgContent);
            //未绑卡
            if (quickRechargeInit.msgType == kMessageTypeCardNotBinded){
                _noticeView.hidden = NO;
                self.navigationItem.rightBarButtonItem = nil;
            }else if (quickRechargeInit.msgType == kMessageTypeError) {
                _noticeView.hidden = NO;
                _noticeView.image.hidden = YES;
                _noticeView.bindButton.hidden = YES;
                _noticeView.textLbl.text = quickRechargeInit.msgContent;
                self.navigationItem.rightBarButtonItem = nil;
            }else {
                HUDShowMessage(quickRechargeInit.msgContent, nil);
                self.noticeView.hidden = YES;
                [self backAction:nil];
            }
        } else {
            _quickRechargeBankList = quickRechargeInit.quickBankList;
            
            if ([_quickRechargeBankList count] > 0){
                
                for (UIView *v in [_wrapView subviews]) {
                    v.hidden = NO;
                }
                
                [_quickRechargeTable reloadData];
                
                [self setRechargeAmountTip];
                
            }
            else
            {
                HUDShowMessage(quickRechargeInit.msgContent, nil);
                _chooseBankLbl.hidden = YES;
                self.noticeView.hidden = YES;
            }
        }
    }
}


-(void)setRechargeAmountTip
{
    if(_bankId > 0)
    {
        _tipLbl.text = [NSString stringWithFormat:@"单次最低充值%.02f元，最高%.02f元，请在10分钟内完成充值操作", _quickMin, _quickMax];
    }
    else
    {
        _tipLbl.text=@"单次最低充值100元，最高45,000元，请在10分钟内完成充值操作";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSArray *coms = [textField.text componentsSeparatedByString:@"."];
    if (coms.count==2) {
        NSString *dec = coms[1];
        if (dec.length>=2) {
            return NO;
        }
    }
    return YES;
}
- (void)dealloc {
    //[_tableView release];
    [_quickRechargeTable release];
    [_chooseBankLbl release];
    [_rechargeView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setQuickRechargeTable:nil];
    [self setChooseBankLbl:nil];
    [self setRechargeView:nil];
    [super viewDidUnload];
}

//**********QUICK RECHARGE**********
#pragma mark - TableViewDelegate & dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.quickRechargeBankList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *kCustomCellID = @"Cell";
    BankCardCell *cell = [_quickRechargeTable dequeueReusableCellWithIdentifier:kCustomCellID];
    if (!cell) {
        cell = (BankCardCell *)[BankCardCell loadFromNib];
    }
    //cell.arrow.hidden=YES;
    BankModel *model = [_quickRechargeBankList objectAtIndex:indexPath.row];
    cell.bankIcon.image = ResImage(model.bank_name);
    cell.bankNameLbl.text = model.bank_name;
    cell.bankAccountLbl.text = model.hiddenAccount;
    
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [_lastIndexPath row];
    if (row == oldRow && _lastIndexPath != nil)
    {
        UIImageView *check = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)]autorelease];
        check.image = [UIImage imageNamed:Res(@"lottery_gou.png")];
        cell.accessoryView=check;
        _bankId = (int)[[_quickRechargeBankList objectAtIndex:indexPath.row] bank_id];
        _quickMax = (int)[[_quickRechargeBankList objectAtIndex:indexPath.row] loadmax];
        _quickMin = (int)[[_quickRechargeBankList objectAtIndex:indexPath.row] loadmin];
        [self setRechargeAmountTip];
        
    }else
    {
        cell.accessoryView=nil;
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 60.f;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger newRow = [indexPath row];
    NSInteger lastRow = (self.lastIndexPath != nil) ? [self.lastIndexPath row] : -1;
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
                                indexPath];
    
    UIImageView *check = [[[UIImageView alloc]initWithFrame:CGRectMake(0, -50,20, 20)]autorelease];
    check.image = [UIImage imageNamed:Res(@"lottery_gou.png")];
    newCell.accessoryView=check;
    
    if (newRow != lastRow )
    {
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:
                                     self.lastIndexPath];
        lastCell.accessoryView=nil;
        
        self.lastIndexPath = indexPath;
    }
    
    _bankId = (int)[[_quickRechargeBankList objectAtIndex:indexPath.row] bank_id];
    _quickMax = (int)[[_quickRechargeBankList objectAtIndex:indexPath.row] loadmax];
    _quickMin = (int)[[_quickRechargeBankList objectAtIndex:indexPath.row] loadmin];
    
    [self setRechargeAmountTip];
}

//Remove bottom lines
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)] autorelease];
    return view;
}


@end

@implementation RechargeAlertView

- (void)dealloc
{
    Block_release(_confirmBlock);
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

- (void)setAmount:(NSString *)amount
{
    [_amount release];
    _amount = [amount copy];
    _amountLbl.text = [NSString stringWithFormat:@"您将要充值%@元",_amount];;
}

- (IBAction)cancel:(id)sender
{
    [self removeFromSuperview];
}

- (IBAction)confirm:(id)sender
{
    if ([_pwdField.text length] > 0){
        
        [HUDView showLoading:self];
        self.confirmBlock(self);
    }
}


@end
