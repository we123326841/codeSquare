//
//  AddCardViewController.m
//  Caipiao
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "AddCardViewController.h"
#import "CardBindSucessViewController.h"
//#import "CardBindConfirmViewController.h"

#import "DropDownBox.h"
#import "CardCellView.h"
#import "View+Factory.h"
#import "AddCardTextField.h"
#import "RQCardBinding.h"

@interface AddCardViewController ()<RQBaseDelegate,DropDownBoxDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
  
    IBOutlet AddCardTextField *secPwdField;
}
@property (strong, nonatomic) RQCityList *cityRequest;
@property (strong, nonatomic) NSMutableArray *bankList;
@property (strong, nonatomic) NSMutableArray *provinceList;
@property (strong, nonatomic) NSMutableArray *cityList;
@property (strong, nonatomic) BankModel *selectedBank;
@property (strong, nonatomic) ProvinceModel *selectedProvince;
@property (strong, nonatomic) CityModel *selectedCity;
@end

@implementation AddCardViewController

- (void)dealloc{
    _cityRequest.delegate = nil;
    [_cityRequest cancel];
    [_cityRequest release];
    [_bankList release];
    [_provinceList release];
    [_cityList release];
    [_selectedBank release];
    [_selectedProvince release];
    [_selectedCity release];
    [secPwdField release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"卡号绑定";

    _gridView.image = ResImage(@"add-card-bg.png");
    
    _branchField.textColor =
    _nameField.textColor = Color(@"AddCardTextColor");
    _bankAccountField.textColor = Color(@"AddCardNumberColor");
    
    for (UILabel *l in _lbl6s){
        l.textColor = Color(@"AddCardTextColor");
    }
    
    for (UILabel *l in _lbl9s){
        l.textColor = Color(@"AddCardTipsColor");
    }
    
    [_cityField setTitleColor:Color(@"AddCardCityColor") forState:UIControlStateNormal];
    
    _branchField.delegate =
    _nameField.delegate =
    _bankAccountField.delegate = self;
    _bankList = [[NSMutableArray alloc] init];
    _provinceList = [[NSMutableArray alloc] init];
    _cityList = [[NSMutableArray alloc] init];
    
//    [self.view addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    
    __block AddCardViewController *self_ = self;
    [self_ showLoadingView];
    RQCardBindingInit *bindingInit = [[[RQCardBindingInit alloc] init] autorelease];
    [bindingInit startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        RQCardBindingInit *q = (id)rq_;
        for (BankModel *bank in q.bankList){
            [self_.bankList addObject:bank.bank_name];
        }
        for (ProvinceModel *province in q.provinceList){
            [self_.provinceList addObject:province.name];
        }
        [self_ hideLoadingView];
    } sender:nil];
    
    self.rq = bindingInit;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onBankAction:(UIButton *)sender{
    [self.view endEditing:YES];
     __block AddCardViewController *self_ = self;
   
    SheetPicker *sp = (id)[SheetPicker loadFromNib];
    sp.titles = _bankList;
    [sp setConfirmBlock:^(SheetPicker *p, NSInteger row) {
        if(p.titles.count<=0)return;
        [sender setTitle:p.titles[row] forState:UIControlStateNormal];
        self_.selectedBank = [(RQCardBindingInit *)self_.rq bankList][row];
    }];
    [sp showInView:self.view];
}

- (IBAction)onProvinceAction:(UIButton *)sender{
    [self.view endEditing:YES];
    __block AddCardViewController *self_ = self;
    SheetPicker *sp = (id)[SheetPicker loadFromNib];
    sp.titles = _provinceList;
    [sp setConfirmBlock:^(SheetPicker *p, NSInteger row) {
         if(p.titles.count<=0)return;
        [sender setTitle:p.titles[row] forState:UIControlStateNormal];
        self_.selectedProvince = [(RQCardBindingInit *)self_.rq provinceList][row];
    }];
    [sp showInView:self.view];
}

- (IBAction)onCityAction:(UIButton *)sender{
    [self.view endEditing:YES];
    if (!_selectedProvince){ HUDShowMessage(@"请选择省份", nil); return;   }
    
    [HUDView showLoading:self.view];
    __block AddCardViewController *self_ = self;
    
    RQCityList *cityRequest = [[[RQCityList alloc] init] autorelease];
    cityRequest.provinceId = self.selectedProvince.provinceId;
    [cityRequest startPostWithBlock:^(RQCityList *rq_, NSError *error_, id rqSender_) {

        [self_.cityList removeAllObjects];
        for (CityModel *city in rq_.cityList){
            [self_.cityList addObject:city.name];
        }
        
        SheetPicker *sp = (id)[SheetPicker loadFromNib];
        sp.titles = self_.cityList;
        [sp setConfirmBlock:^(SheetPicker *p, NSInteger row) {
             if(p.titles.count<=0)return;
            [sender setTitle:p.titles[row] forState:UIControlStateNormal];
            self_.selectedCity = rq_.cityList[row];
        }];
        [sp showInView:self.view];
        [HUDView dismissCurrent];
        
    } sender:nil];
    
}

- (IBAction)submitAction:(id)sender{
    if (!(_bankAccountField.text.length==16||_bankAccountField.text.length==18||_bankAccountField.text.length==19)) {
        HUDShowMessage(@"银行卡由16、18或19位数字组成", nil); return;
    }
    if(![self luhmCheck:_bankAccountField.text]){
        HUDShowMessage(@"请输入有效的银行卡号", nil); return;}

    if (!_selectedBank) {   HUDShowMessage(@"请选择银行", nil); return;   }
    if (!_selectedProvince){ HUDShowMessage(@"请选择省份", nil); return;   }
    if (!_selectedCity){    HUDShowMessage(@"请选择城市", nil); return;    }
    if (_branchField.text.length == 0) {   HUDShowMessage(@"请输入支行名称",nil); return;  }
    if (_nameField.text.length == 0) { HUDShowMessage(@"请输入开户人姓名",nil); return; }
    if (_bankAccountField.text.length == 0) {  HUDShowMessage(@"请输入银行账号",nil); return; }
    
    BankModel *bank = [[[BankModel alloc] init] autorelease];
    bank.bank_id = _selectedBank.bank_id;
    bank.bank_name = _selectedBank.bank_name;
    bank.provinceId = _selectedProvince.provinceId;
    bank.province = _selectedProvince.name;
    bank.cityId = _selectedCity.cityId;
    bank.city = _selectedCity.name;
    bank.branch = _branchField.text;
    bank.account = _bankAccountField.text;
    bank.account_name = _nameField.text;
  
    
    //直接提交
    [HUDView showLoading:self.view];
    RQCardCommit *commit = [[[RQCardCommit alloc] init] autorelease];
    commit.bankId = bank.bank_id;
    commit.bankName = bank.bank_name;
    commit.provinceId = bank.provinceId;
    commit.provinceName = bank.province;
    commit.cityId = bank.cityId;
    commit.cityName = bank.city;
    commit.branch = bank.branch;
    commit.account = bank.account;
    commit.accountName = bank.account_name;
//    commit.secPass = [SharedModel shared].securityPasswd;
    commit.secPass = secPwdField.text;
    [commit startPostWithBlock:^(RQCardCommit *rq_, NSError *error_, id rqSender_) {
        [HUDView dismissCurrent];
        if (rq_.msgContent){
            HUDShowMessage(rq_.msgContent,nil);
        } else {
            //提交成功            
            CardBindSucessViewController *vc = [[CardBindSucessViewController alloc] init];
            vc.detail = [NSString stringWithFormat:@"您绑定了尾号%@的%@储蓄卡",
                         [CardCellView secrectCard:rq_.account],
                         NSLocalizedStringFromTable(rq_.bankName, @"Bank", nil)
                         ];
            NSMutableArray *controllers = [self.navigationController.viewControllers mutableCopy];
            [controllers removeLastObject];
            [controllers addObject:vc];
            [self.navigationController setViewControllers:controllers animated:YES];
            [controllers release];
            [vc release];
        }
    } sender:nil];
    
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dismissKeyboard];
    CGRect frame = _warpView.frame;
    frame.origin.y = 0.f;
    [UIView animateWithDuration:.2f animations:^{
        _warpView.frame = frame;
    }];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = [_warpView convertRect:textField.frame fromView:_warpView];
    frame = [UIView convertViewFrame:textField toSuperview:_warpView];
    float boundsY = self.view.bounds.size.height - 216;
    if (frame.origin.y  + frame.size.height > boundsY){
        float diff = frame.origin.y + frame.size.height*2 - boundsY;
        frame = _warpView.frame;
        frame.origin.y = -diff;
        [UIView animateWithDuration:.2f animations:^{
            _warpView.frame = frame;
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self dismissKeyboard];
}

- (void)dismissKeyboard{
    [self.view endEditing:YES];
}

- (void)onTouchDown:(UITapGestureRecognizer *)g{
    [self dismissKeyboard];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyboard];
    CGRect frame = _warpView.frame;
    frame.origin.y = 0.f;
    [UIView animateWithDuration:.2f animations:^{
        _warpView.frame = frame;
    }];
}
#pragma mark - Request

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    if ([rq isKindOfClass:[RQCityList class]]){
    
    } else if ([rq isKindOfClass:[RQCardConfirm class]]){
        [HUDView dismissCurrent];
        RQCardConfirm *cardConfirm = (id)rq;
        if (cardConfirm.msgContent){
            HUDShowMessage(cardConfirm.msgContent,nil);
        } else {
            /*
            BankModel *bank = [[BankModel alloc] init];
            bank.bank_id = _selectedBank.bank_id;
            bank.bank_name = _selectedBank.bank_name;
            bank.provinceId = _selectedProvince.provinceId;
            bank.province = _selectedProvince.name;
            bank.cityId = _selectedCity.cityId;
            bank.city = _selectedCity.name;
            bank.branch = _branchField.text;
            bank.account = _bankAccountField.text;
            bank.account_name = _nameField.text;
            CardBindConfirmViewController *vc = [[CardBindConfirmViewController alloc] init];
            vc.bank = bank;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            [bank release];
             */
        }
    }
}

- (void)viewDidUnload {
    [secPwdField release];
    secPwdField = nil;
    [super viewDidUnload];
}

- (BOOL)luhmCheck:(NSString*)bankCode
{
    NSString * lastNum = [[bankCode substringFromIndex:(bankCode.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[bankCode substringToIndex:(bankCode.length -1)] copy];//前15或18位
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i=0; i<forwardNum.length; i++) {
        
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i =(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    for (int i=0; i< forwardDescArr.count; i++)
    {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2)
        {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else
        {//奇数位
            if (num * 2 < 9)
            {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else
            {
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    return (luhmTotal%10 ==0)?YES:NO;
}
@end
