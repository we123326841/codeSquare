//
//  ShareManager.m
//  Caipiao
//
//  Created by GroupRich on 15/8/6.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "GRShareManager.h"
#import "Defines.h"
@interface GRShareManager ()<TencentSessionDelegate>

@end

@implementation GRShareManager

+(instancetype)sharedInstance
{
    static GRShareManager *gr_instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        gr_instance = [[GRShareManager alloc]init];
    });
    return gr_instance;
}

-(void)configurationShareEnvironment
{
    [WXApi registerApp:kWXAppID];
    _oauth = [[TencentOAuth alloc]initWithAppId:kQQAPPID andDelegate:self];
}

-(void)shareToQQWithText:(NSString*)text
{
    QQApiTextObject* txtObj = [QQApiTextObject objectWithText:text];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:txtObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}
-(void)shareToQQWithImage:(UIImage*)image
{
    NSData *imgData = UIImagePNGRepresentation(image);
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imgData
                                               previewImageData:imgData
                                                          title:@"二维码分享"
                                                    description:@"二维码分享"];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    //将内容分享到qq
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            /*
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            */
            
            //install
            /*
            NSString *installerUrl = [QQApiInterface getQQInstallUrl];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:installerUrl]];
            */
            
            //alert
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"未安装QQ。请在安装后分享" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            
            
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            [msgbox release];
            
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void) sendLinkContentWithUrl:(NSString*)urlString withImage:(UIImage*)image onScene:(int)scene
{
//    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = @"彩票二维码分享";
//    message.description = @"代理开户链接分享";
//    [message setThumbImage:image];
//    
//    WXImageObject *ext = [WXImageObject object];
//    ext.imageData = UIImagePNGRepresentation(image);
//    
//    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
//    req.bText = NO;
//    req.message = message;
//    req.scene = scene;
//    
//    [WXApi sendReq:req];
    
    bool isappinstalled = [WXApi isWXAppInstalled];
    
    if(!isappinstalled)
    {
        //install
        /*
        NSString *installerUrl = [WXApi getWXAppInstallUrl];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:installerUrl]];
        */
        
        //alert
       
         UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"未安装微信。请在安装后分享" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [msgbox show];
         [msgbox release];
      
    }
    else
    {
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:image];
    
        WXImageObject *ext = [WXImageObject object];
        ext.imageData = UIImagePNGRepresentation(image);
    
        message.mediaObject = ext;
    
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = NO;
        req.message = message;
        req.scene = scene;
    
        [WXApi sendReq:req];
    }
}


//朋友圈
+ (void) sendTextContentFiend:(NSString*)nsText
{
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = YES;
    req.text = nsText;
    //微信朋友
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
    
}


//回话圈
+ (void) sendTextContentSection:(NSString*)nsText
{
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = YES;
    req.text = nsText;
    //微信朋友
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

-(void) onReq:(BaseReq*)req
{
    
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
//        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
    }
}

@end
