//
//  SignViewController.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "SignViewController.h"
#import "AppDelegate.h"
#import "LoadingAlertView.h"
#import "LotteryTimer.h"
#import "CheckBox.h"
#import "DropDownSelector.h"
#import "MSNSData+Additions.h"
#import "RQPush.h"
#import "RQGuoQing.h"
//#import "RQVersion.h"
#import "Base64.h"

@interface SignViewController ()
@property (retain, nonatomic) IBOutlet UIButton *mRegister;
@property (nonatomic, strong) NSArray *historyAccounts;
@end

@implementation SignViewController

- (void)dealloc{
    Echo(@"%s", __func__);
    self.historyAccounts = nil;
    [_mRegister release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    //[self setRegisterButton];
    //[self setRegisterImageView];
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
    
    for (UILabel *lbl in _labels){
        lbl.textColor = Color(@"LoginTipsTextColor");
    }
    UIView *wrapView = self.view.subviews[0];
    wrapView.backgroundColor = self.view.backgroundColor;
    _accountField.textColor =
    _passwdField.textColor = Color(@"LoginInputTextColor");
    [_loginButton setTitleColor:Color(@"LoginButtonTextColor") forState:UIControlStateNormal];
    _accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableArray *hisAccs = [CDUserInfo all];
    if (hisAccs.count>4) {
        self.historyAccounts = [hisAccs objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(hisAccs.count-4,4)]];
    }else self.historyAccounts = hisAccs;
    
    NSString *ha = [[self class] remeberedAccount];
    if (ha){
        _accountField.text = ha;
        self->_checkBox.checked = YES;
/*        for (CDUserInfo *u in self.historyAccounts){
            if ([u.account isEqualToString:ha]){
                if (u.passwd){
                    NSString *passwd = [[self class] decryptStr:u.passwd];
                    self.passwdField.text = passwd;
                }
                break;
            }
        }
*/
    }
     [self autoLogin];
    
//    [RQVersion checkVersion];

}

//-(void)setRegisterButton{
//    
//    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"我要注册"];
//    NSRange strRange = {0,[str length]};
//    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
//    [_mRegister setAttributedTitle:str forState:UIControlStateNormal];
//    
//    [_mRegister addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [str release];
//
//}



//-(void)setRegisterImageView{
//   UIImageView *imageView= [[UIImageView alloc]init];
//   // imageView.image=ResImage(@"ad-placeholder.png");
//    imageView.backgroundColor=[UIColor redColor];
//    imageView.y =CGRectGetMaxY(_mRegister.frame);
//        imageView.size=CGSizeMake(self.view.width, 80);
//    [self.view addSubview:imageView];
//    imageView.userInteractionEnabled=YES;
//    
//    
//    
//    
//    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)];
//    [imageView addGestureRecognizer:singleTap1];
//    [singleTap1 release];
//   
//    [imageView release];
//    
//}


-(void)imageViewClick{
    NSLog(@"图片被点击");
}


-(void)registerClick{
    NSLog(@"registerClick");


}

-(void)autoLogin
{
    if (self.historyAccounts.count)
    {
        if (_isAutoLogin) {
            CDUserInfo *CDUserInfo = self.historyAccounts[self.historyAccounts.count-1];
            self.accountField.text = CDUserInfo.account;
            self.passwdField.text = [[self class] decryptStr:CDUserInfo.passwd];
            [self loginAction:nil];
            NSLog(@"%@ ** %@",self.accountField.text,self.passwdField.text);

        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareToBack{
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    self.view.frame = rect;
}

- (IBAction)openAccountPanel:(UIButton *)sender{

    [self.view endEditing:YES];
    _panelOpened = !_panelOpened;
    if (_panelOpened){
        CGRect rect = _accoutView.frame;
        rect.origin.y += rect.size.height;
        rect.size.height = 160.f;
        NSMutableArray *titles = [NSMutableArray array];
        for (CDUserInfo *u in _historyAccounts){
            [titles addObject:u.account];
        }
        __block __weak SignViewController *self_ = self;
        DropDownSelector *dds = [[DropDownSelector alloc] initWithFrame:rect];
        dds.rowTitles = titles;
        [dds setSelectBlock:^(DropDownSelector *s, NSInteger row) {
            if (row == -1) {
                sender.layer.transform = CATransform3DMakeRotation(0,0,0,1);
            } else {
                self_->_accountField.text = s.rowTitles[row];
                CDUserInfo *u = self_.historyAccounts[row];
                if (u&&u.passwd&&![u.passwd isKindOfClass:[NSNull class]]){
                    NSString *passwd = [[self class] decryptStr:u.passwd];
                    self_.passwdField.text = passwd;
                    self_->_checkBox.checked = YES;
                }
            }
            _panelOpened = NO;
            sender.layer.transform = CATransform3DMakeRotation(0,0,0,1);
        }];
        [dds attachToView:self.view];
        [dds release];
    }
    sender.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
}

- (IBAction)switchPasswdEntry:(id)sender{
    UITextField *field = [[UITextField alloc] initWithFrame:_passwdField.frame];
    field.secureTextEntry = !_passwdField.secureTextEntry;
    field.font = _passwdField.font;
    field.textColor = _passwdField.textColor;
    field.borderStyle = _passwdField.borderStyle;
    field.placeholder = _passwdField.placeholder;
    field.keyboardType = _passwdField.keyboardType;
    field.text = _passwdField.text;
    [_passwdField.superview addSubview:field];
    if (_passwdField.isFirstResponder){
        [field becomeFirstResponder];
    }
    
    [_passwdField removeFromSuperview];
    _passwdField = field;
    [field release];
}
- (IBAction)registerForGuoQing:(id)sender {
    RQGuoQing *rq = [[[RQGuoQing alloc] init] autorelease];
   
    [rq startPostWithDelegate:self];
    self.rq = rq;

    
}

- (IBAction)loginAction:(id)sender{
    
    
    if ([_accountField.text length] * [_passwdField.text length] == 0) {
        HUDShowMessage(@"请输入账号和密码", nil);
        return;
    }
    
    [[self class] setRememberedAccount:_checkBox.checked ? _accountField.text : nil];   //Remeber the account
    [[self class] setRememberedPasswd:_checkBox.checked ? _passwdField.text : nil];   //Remeber the pwd
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    CGRect rect = self.view.frame;
    rect.origin.y = IOS7 ? 64.f : 0;
    [UIView beginAnimations:nil context:nil];
    self.view.frame = rect;
    [UIView commitAnimations];
    
    RQLogin *rq = [[[RQLogin alloc] init] autorelease];
    rq.loginPass = _passwdField.text;
    rq.username = _accountField.text;
    [rq startPostWithDelegate:self];
    self.rq = rq;
    
}

//- (void)retrieveVersion{
//    RQVersion *rq = [[RQVersion alloc] init];
//    rq.appType = kAPPVersionType;
//    [rq startPostWithBlock:^(RQVersion *rq_, NSError *error_, id rqSender_) {
//        NSString *currentVersion = [NSBundle appVersion];
//        if ([rq.version compare:currentVersion] == NSOrderedDescending) {
////            NSString *msg = [NSString stringWithFormat:@"发现新版本(%@)，立即更新？",rq.version];
//            NSString *msg = [NSString stringWithFormat:@"发现新版本！\n便于您更好体验服务，请进行更新"];
//            MSBlockAlertView *alert = [[MSBlockAlertView alloc] initWithTitle:@"新版更新"
//                                                                      message:msg
//                                                                     delegate:nil
//                                                            cancelButtonTitle:@"取消"
//                                                            otherButtonTitles:@"更新", nil];
//            [alert show];
//            [alert setClickBlock:^(MSBlockAlertView *a, NSInteger index) {
//                if (index == 1){
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rq_.downloadUrl]];
//                }
//            }];
//        }
//        [rq_ release];
//    } sender:nil];
//}

#pragma mark - RQBaseDelegate

- (void)onRQStart:(RQBase *)rq{
    [HUDView showLoadingToView:self.view msg:@"正在登录，请稍候..." subtitle:nil];
}

- (void)onRQComplete:(RQLogin *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    
    if (error) {
//        HUDShowMessage(NSLocalizedString(@"Network error", nil), nil);
    } else if(rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
    } else {    //success

        if ([rq isKindOfClass:[RQLogin class]]) {
            
            MSNotificationCenterPost(kNotificationUserPointUpdated);
            if (_checkBox.checked){
                CDUserInfo *u = [CDUserInfo user];
                u.passwd = [[self class] encryptStr:self.passwdField.text];
                [u save];
            }
            [[self class] setRememberedAccount:self.accountField.text];
            
            //Register push
            RQPush *push = [[[RQPush alloc] init] autorelease];
            push.deviceToken = [AppDelegate shared].deviceToken;
            push.userId = [[SharedModel shared] userid];
            [push startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            } sender:nil];
            [[AppDelegate shared] pushInTab];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[AppDelegate shared] requestBalance];
            });
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    CGRect rect = self.view.frame;
    rect.origin.y = IOS7 ? 64.f : 0.f;
    [UIView beginAnimations:nil context:nil];
    self.view.frame = rect;
    [UIView commitAnimations];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    CGRect rect = self.view.frame;
//    rect.origin.y = -100.f;
//    [UIView beginAnimations:nil context:nil];
//    self.view.frame = rect;
//    [UIView commitAnimations];

}

#pragma mark - Motion
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    SideMenuController *smc = [AppDelegate sideMenuController];
    [smc enablePanGesture:NO];
#ifdef DEBUG
    _accountField.text = kTestUser;
    _passwdField.text = kTestPasswd;
#endif
}


#pragma mark - Class Methods

static NSString *_AESKey = @"LotKey";
static NSString *_AESIV = @"LotIV";
+ (void)setRememberedAccount:(NSString *)account{
    NSData *data = [[account dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:_AESKey AndIV:_AESIV];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"ACCOUNT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)remeberedAccount{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACCOUNT"];
    data = [data AES128DecryptWithKey:_AESKey AndIV:_AESIV];
    const char *bytes = [data bytes];
    NSMutableData *md = [NSMutableData data];
    for (int i = 0; i < [data length]; i++) {
        if (bytes[i] != 0){
            [md appendBytes:&bytes[i] length:1];
        }
    }
    NSString *account = [[[NSString alloc] initWithData:md encoding:NSUTF8StringEncoding] autorelease];
    return account;
}

+ (void)setRememberedPasswd:(NSString *)passwd{
    NSData *data = [[passwd dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:_AESKey AndIV:_AESIV];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"PWD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)remeberedPasswd{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"PWD"];
    data = [data AES128DecryptWithKey:_AESKey AndIV:_AESIV];
    const char *bytes = [data bytes];
    NSMutableData *md = [NSMutableData data];
    for (int i = 0; i < [data length]; i++) {
        if (bytes[i] != 0){
            [md appendBytes:&bytes[i] length:1];
        }
    }
    NSString *passwd = [[[NSString alloc] initWithData:md encoding:NSUTF8StringEncoding] autorelease];
    return passwd;
}

+ (NSString *)encryptStr:(NSString *)str{
    NSData *data = [[str dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:_AESKey AndIV:_AESIV];
    NSString *s = [data base64EncodedString];
    return s;
}

+ (NSString *)decryptStr:(NSString *)str{
    @try {
        NSData *data = [NSData dataWithBase64EncodedString:str];
        data = [data AES128DecryptWithKey:_AESKey AndIV:_AESIV];
        const char *bytes = [data bytes];
        NSMutableData *md = [NSMutableData data];
        for (int i = 0; i < [data length]; i++) {
            if (bytes[i] != 0){
                [md appendBytes:&bytes[i] length:1];
            }
        }
        return [[[NSString alloc] initWithData:md encoding:NSUTF8StringEncoding] autorelease];
    }
    @catch (NSException *exception) {
        MSShowMessage(exception.description);
        return nil;
    }
}

@end
