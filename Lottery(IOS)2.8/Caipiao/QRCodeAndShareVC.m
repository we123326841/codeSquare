//
//  QRCodeAndShareVC.m
//  Caipiao
//
//  Created by 王浩 on 15/7/30.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "QRCodeAndShareVC.h"
#import "QRCodeGenerator.h"
#import "OADetailVC.h"
#import "GRShareManager.h"
#import "CoverView.h"
#import "ContentCenterView.h"
#import "TabBarView.h"
#import "TextFiledDialog.h"
#import "TabBarView.h"
#import "DeleteLinkDialog.h"
#import "CopyContentView.h"
#import "MBProgressHUD.h"
#import "RQLinkUsers.h"
#import "UserListController.h"
#import "RebateDialog.h"
#import "RQDeleteLink.h"
#import "RQModifyRemark.h"
#import "RQManualSetting.h"
@interface QRCodeAndShareVC ()<ContentCenterViewDelegate,TabBarViewDelegate,CopyContentViewDelegate,RQBaseDelegate,DeleteLinkDialogDelegate,TextFiledDialogDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *qrview;
@property (retain, nonatomic) IBOutlet UIImageView *success_copy_view;
@property (retain, nonatomic) IBOutlet UIButton *copyLinekBtn;

@end

@implementation QRCodeAndShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"链接详情";
    TabBarView *tabBarView=[[TabBarView alloc]init];
    
    if ([self.state isEqualToString:@"未使用"]||[self.state isEqualToString:@"已过期"]||[self.state isEqualToString:@"已注册(0)"]) {
        tabBarView.register1.enabled=NO;
        
        tabBarView.register1.backgroundColor =[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    }
    [tabBarView.register1 setTitle:self.state forState:UIControlStateNormal];
    
    tabBarView.delegate =self;
    CGFloat x =0;
    CGFloat height =40;
    CGFloat y =[[UIScreen mainScreen]bounds].size.height-height-64;
    CGFloat width =self.view.width;
    tabBarView.frame =CGRectMake(x, y, width, height);
    [self.view addSubview:tabBarView];
    [tabBarView release];
    
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setBackgroundImage:ResImage(@"qr_menu.png") forState:UIControlStateNormal];
    rightbutton.frame = CGRectMake(0, 0, 21, 20);
    [rightbutton addTarget:self action:@selector(gotodetail:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem=item;
    [item release];
    
    // sample
    _qrview.image = [QRCodeGenerator qrImageForString:_object.urlstring imageSize:_qrview.bounds.size.width];
    
    // button
    [_copyLinekBtn setTitle:_object.urlstring forState:UIControlStateNormal];
    
    
    _qrview.userInteractionEnabled = YES;
    UITapGestureRecognizer *singtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimg)];
    [_qrview addGestureRecognizer:singtap];
    
    
    
}

-(void)clickimg{
    
    CoverView *cover=[[CoverView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:cover];
    [cover release];
    ContentCenterView *contentView=[[[NSBundle mainBundle]loadNibNamed:@"ViewItem" owner:nil options:nil]lastObject];
    contentView.delegate =self;
    contentView.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    //contentView.userInteractionEnabled=NO;
    contentView.center=cover.center;
    contentView.layer.cornerRadius = 50/4;/////////////////////////自己试着改变这个值，看看各个不同的效果。现在的设置是画了个圆圈。
    contentView.layer.masksToBounds = YES;//////////////////////////
    //UIButton *btn =[[UIButton alloc] init];
    [cover addSubview:contentView];
    // [contentView release];
    
    
}


-(void)clickLink{
    NSLog(@"Link点击");
    CoverView *cover=[[CoverView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:cover];
    [cover release];
    CopyContentView *contentView=[[[NSBundle mainBundle]loadNibNamed:@"CopyContentView" owner:nil options:nil]lastObject];
   
    contentView.delegate =self;
    contentView.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    //contentView.userInteractionEnabled=NO;
    contentView.center=cover.center;
    contentView.layer.cornerRadius = 50/4;/////////////////////////自己试着改变这个值，看看各个不同的效果。现在的设置是画了个圆圈。
    contentView.layer.masksToBounds = YES;//////////////////////////
    //UIButton *btn =[[UIButton alloc] init];
    [cover addSubview:contentView];
    // [contentView release];
    
    
    
    
}

-(void)showRebate{
    CoverView *cover=[[CoverView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:cover];
    [cover release];
    cover.isDisplay=YES;
    RebateDialog *rebateDialog =[RebateDialog rebate];
   // rebateDialog.width =self.view.width*0.5;
   // rebateDialog.height=self.view.width*0.5;
    //contentView.delegate =self;
    
    rebateDialog.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    //contentView.userInteractionEnabled=NO;
    rebateDialog.centerY=cover.center.y-100;
    rebateDialog.centerX =cover.center.x;
    rebateDialog.width =self.view.width*0.5;
    rebateDialog.height=self.view.width*0.5;
    rebateDialog.layer.cornerRadius = 0;/////////////////////////自己试着改变这个值，看看各个不同的效果。现在的设置是画了个圆圈。
    rebateDialog.layer.masksToBounds = YES;//////////////////////////
    //UIButton *btn =[[UIButton alloc] init];
    [cover addSubview:rebateDialog];
    // [contentView release];
    
    
}

-(void)modifiRemark{
    
    CoverView *cover=[[CoverView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:cover];
    [cover release];
    cover.isDisplay=YES;
    TextFiledDialog *textFiledDialog=[[[NSBundle mainBundle]loadNibNamed:@"TextFiledDialog" owner:nil options:nil]lastObject];
    textFiledDialog.delegate =self;
    textFiledDialog.linkObject =_object;
    [textFiledDialog.textFiled becomeFirstResponder];
    //contentView.delegate =self;
    
    textFiledDialog.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    //contentView.userInteractionEnabled=NO;
    textFiledDialog.centerY=cover.center.y-100;
    textFiledDialog.centerX =cover.center.x;
    textFiledDialog.layer.cornerRadius = 50/4;/////////////////////////自己试着改变这个值，看看各个不同的效果。现在的设置是画了个圆圈。
    textFiledDialog.layer.masksToBounds = YES;//////////////////////////
    //UIButton *btn =[[UIButton alloc] init];
    [cover addSubview:textFiledDialog];
    // [contentView release];
    
    
}



-(void)deleteLink{
    CoverView *cover=[[CoverView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:cover];
    [cover release];
    cover.isDisplay=YES;
    DeleteLinkDialog *deleteDialog=[[[NSBundle mainBundle]loadNibNamed:@"DeleteLinkDialog" owner:nil options:nil]lastObject];
    deleteDialog.delegate =self;
    //contentView.delegate =self;
    
    deleteDialog.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    //contentView.userInteractionEnabled=NO;
    deleteDialog.centerY=cover.center.y-100;
    deleteDialog.centerX =cover.center.x;
    deleteDialog.layer.cornerRadius = 50/4;/////////////////////////自己试着改变这个值，看看各个不同的效果。现在的设置是画了个圆圈。
    deleteDialog.layer.masksToBounds = YES;//////////////////////////
    //UIButton *btn =[[UIButton alloc] init];
    [cover addSubview:deleteDialog];
    // [contentView release];
    
    
}

-(void)tabBarViewBtnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
            
              [self requestData];
         //   [self showRebate];
         //   [self request];
            break;
        case 1:
            [self modifiRemark];
            break;
            
        case 2:
            [self deleteLink];
            break;
            
    }
    
}


#pragma mark - Request

-(void)request{
    RQManualSetting *set =[[RQManualSetting alloc]init];
    set.type =@1;
    [set startPostWithDelegate:self];
}

- (void)requestData{
    RQLinkUsers *request = [[RQLinkUsers alloc] init];
    request.linkId = _object.linkid;
    [request startPostWithDelegate:self];
    self.rq = request;
    [request release];
}

-(void)onRQStart:(RQBase *)rq{
    [HUDView showLoadingToView:[UIApplication sharedApplication].keyWindow msg:@"正在获取数据..." subtitle:nil touchToHide:NO];
}

- (void)onRQComplete:(RQBase *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    RQLinkUsers *request = (RQLinkUsers *)rq;
    // UserListController*vc = [[NSClassFromString(@"UserListController") alloc] initWithNibName:@"UserListController" bundle:nil];
    //    [[AppDelegate shared].nav pushNavigationController:[[NavigationController new:vc] autorelease] animated:YES];
    
    UserListController *vc = [[UserListController alloc]init];
    vc.users =request.users;
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}



- (IBAction)copylinker:(UIButton*)sender
{
    
    
    [self clickLink];
}
-(void)hideSuccessCopyView
{
    _success_copy_view.hidden = YES;
}
-(void)gotodetail:(UIButton*)btn
{
    OADetailVC *v = [[OADetailVC alloc]init];
    v.object = _object;
    [self.navigationController pushViewController:v animated:YES];
    [v release];
}


-(void)CopyViewSubViewClick:(UIButton *)btn{
    [self btnClick:btn];
    
}



-(void)centViewSubViewClick:(UIButton*)sender{
    [self btnClick:sender];
    
    
    
}

-(void)deleteLink:(DeleteLinkDialog *)dialog didBtnClick:(DeleteLinkDialogButtonType)type{
    switch (type) {
        case DeleteLinkDialogButtonTypeSure:{
            HUDShowLoading(@"正在删除链接..", nil);
                       RQDeleteLink *request = [[RQDeleteLink alloc] init];
            request.linkid = _object.linkid;
            [request startPostWithBlock:^(RQBase*rq_, NSError *error_, id rqSender_) {
                RQDeleteLink *q =(RQDeleteLink*)rq_;
                if  ([q.status isEqualToString:@"success"]){
                    HUDHide();

//                    UIAlertView *dg=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"删除链接成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//                    [dg show];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [dg dismissWithClickedButtonIndex:0 animated:YES];
//                        
//                    });
                     [self.navigationController popViewControllerAnimated:YES];
                    [HUDView showLoadingToView:[UIApplication sharedApplication].keyWindow msg:@"删除链接成功" subtitle:nil touchToHide:NO];
                   // self.block(nil);
                }
                
            } sender:nil];
            
            
            
            
            
            
            
            
            
            
            break;
        }
            
        case DeleteLinkDialogButtonTypeCancel:
            
            break;
    }
    
}


-(void)textFiledDialog:(TextFiledDialog *)dialog didButtonClick:(TextFiledDialogButtonType)type{
    switch (type) {
        case TextFiledDialogButtonTypeSure:{
            RQModifyRemark *request = [[RQModifyRemark alloc] init];
            request.linkid = _object.linkid;
            request.remark =dialog.textFiled.text;
            [request startPostWithBlock:^(RQBase*rq_, NSError *error_, id rqSender_) {
                RQDeleteLink *q =(RQDeleteLink*)rq_;
                if  ([q.status isEqualToString:@"success"]){
                    
//                    UIAlertView *dg=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"修改备注成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//                    [dg show];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [dg dismissWithClickedButtonIndex:0 animated:YES];
                    
                //    });
                    self.block(nil);
                    HUDShowMessage(@"修改备注成功", nil);
                    [dialog.superview removeFromSuperview];
                }else{
                    HUDShowMessage(@"服务器异常", nil);
                }
                
            } sender:nil];
            
            
            

            
            
            
            break;
        }
            
    case TextFiledDialogButtonTypeCancel:
            
            break;
    }

}


-(void)btnClick:(UIButton*)sender{
    switch (sender.tag) {
        case 0:
        {
            UIGraphicsBeginImageContext(self.view.bounds.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [self.view.layer renderInContext:context];
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            viewImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(viewImage.CGImage, [UIView convertViewFrame:_qrview toSuperview:self.view])];
            UIGraphicsEndImageContext();
            
            [[GRShareManager sharedInstance]sendLinkContentWithUrl:_object.urlstring withImage:viewImage onScene:WXSceneSession];
        }
            break;
        case 1:
            [[GRShareManager sharedInstance]sendLinkContentWithUrl:_object.urlstring withImage:_qrview.image onScene:WXSceneTimeline];
            
            break;
            
        case 2:
            [[GRShareManager sharedInstance]shareToQQWithImage:_qrview.image];
            break;
        case 3:
            if([sender.superview isKindOfClass:[ContentCenterView class]]){
                HUDShowMessage(@"收藏成功", nil);
                UIImageWriteToSavedPhotosAlbum(_qrview.image, nil, nil, nil);
            }else{
                NSLog(@"copy");
                NSMutableURLRequest *request = [NSMutableURLRequest new];
                [request setURL:[NSURL URLWithString:@"http://dwz.cn/create.php"]];
                [request setHTTPMethod:@"POST"];
                NSMutableData *body = [NSMutableData data];
                NSString *urlStr = _object.urlstring;
                NSString *outputStr = (NSString *)
                CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (CFStringRef)urlStr,
                                                                          NULL,
                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                          kCFStringEncodingUTF8));
                [body appendData:[[NSString stringWithFormat:@"url=%@",outputStr] dataUsingEncoding:NSUTF8StringEncoding]];
                [request setValue:[NSString stringWithFormat:@"%@",@(body.length)] forHTTPHeaderField:@"Content-Length"];
                [request setHTTPBody:body];
                NSURLConnection *con = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
                [con start];
                [NSURLConnection sendAsynchronousRequest:request queue:[[[NSOperationQueue alloc]init] autorelease] completionHandler:^(NSURLResponse * response, NSData * data, NSError * connectionError)
                 {
                     [request release];
                     
                     NSString *tinyurl = _object.urlstring;
                     
                     if(data !=nil)
                     {
                         NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                         Echo(@"%@",resultJSON);
                         
                         if ([[resultJSON objectForKey:@"status"] integerValue]==0) {
                             tinyurl = [resultJSON objectForKey:@"tinyurl"];
                         }
                     }
                     dispatch_async(dispatch_get_main_queue(), ^{
                         UIPasteboard *pb = [UIPasteboard generalPasteboard];
                         pb.string = [NSString stringWithFormat:@"欢迎使用自助开户: %@ (如果链接打开失败，请复制到浏览器内打开)" , tinyurl];
                         _success_copy_view.hidden = NO;
                         [self performSelector:@selector(hideSuccessCopyView) withObject:nil afterDelay:1];
                      //   [_copyLinekBtn setTitle:tinyurl forState:UIControlStateNormal];
                         
                     });
                     /*
                      else
                      {
                      dispatch_async(dispatch_get_main_queue(), ^{
                      HUDShowMessage(NSLocalizedString(@"Network error", nil), nil);
                      });
                      }
                      */
                 }];
                
                
                
                
            }
            break;
            
        default:
            break;
    }
    
    
}
- (IBAction)shareBtn:(UIButton*)sender {
    switch (sender.tag) {
        case 0:
        {
            UIGraphicsBeginImageContext(self.view.bounds.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [self.view.layer renderInContext:context];
            UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
            viewImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(viewImage.CGImage, [UIView convertViewFrame:_qrview toSuperview:self.view])];
            UIGraphicsEndImageContext();
            
            [[GRShareManager sharedInstance]sendLinkContentWithUrl:_object.urlstring withImage:_qrview.image onScene:WXSceneSession];
        }
            break;
        case 1:
            [[GRShareManager sharedInstance]sendLinkContentWithUrl:_object.urlstring withImage:_qrview.image onScene:WXSceneTimeline];
            
            break;
            
        case 2:
            [[GRShareManager sharedInstance]shareToQQWithImage:_qrview.image];
            break;
            
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_qrview release];
    [_success_copy_view release];
    [_copyLinekBtn release];
    [super dealloc];
}
@end
