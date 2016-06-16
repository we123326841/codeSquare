//
//  ShareManager.h
//  Caipiao
//
//  Created by GroupRich on 15/8/6.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"



@interface GRShareManager : NSObject <WXApiDelegate>

@property (retain,nonatomic) TencentOAuth *oauth;

-(void)configurationShareEnvironment;
+(instancetype)sharedInstance;

-(void)shareToQQWithText:(NSString*)text;
-(void)shareToQQWithImage:(UIImage*)image;

- (void) sendLinkContentWithUrl:(NSString*)urlString withImage:(UIImage*)image onScene:(int)scene;


@end
