//
//  RQPwd.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQPwd.h"

@implementation RQPwd

- (void)dealloc
{
    [super dealloc];
}

- (void)setOldPwd:(NSString *)oldPwd
{
    [_oldPwd release];
    _oldPwd = [oldPwd copy];
    
    switch (_passwordType) {
        case kPasswordTypeSecCreate:
            break;
        case kPasswordTypeSecChange:
        {
            [self setValue:_oldPwd forField:@"oldpass2"];
        }
            break;
        case kPasswordTypeLogin:
        {
            [self setValue:_oldPwd forField:@"oldpass"];
        }
            break;
        default:
            break;
    }
}

- (void)setPwd:(NSString *)pwd
{
    [_pwd release];
    _pwd = [pwd copy];
    
    switch (_passwordType) {
        case kPasswordTypeSecCreate:
        {
            [self setValue:[_pwd dataUsingEncoding:NSUTF8StringEncoding].md5 forField:@"newpass2"];
            [self setValue:[_pwd dataUsingEncoding:NSUTF8StringEncoding].md5 forField:@"confirmNewpass2"];
        }
            break;
        case kPasswordTypeSecChange:
        {
            [self setValue:[_pwd dataUsingEncoding:NSUTF8StringEncoding].md5 forField:@"newpass2"];
            [self setValue:[_pwd dataUsingEncoding:NSUTF8StringEncoding].md5 forField:@"confirmNewpass2"];
        }
            break;
        case kPasswordTypeLogin:
        {
            [self setValue:[_pwd dataUsingEncoding:NSUTF8StringEncoding].md5 forField:@"newpass"];
            [self setValue:[_pwd dataUsingEncoding:NSUTF8StringEncoding].md5 forField:@"confirmNewpass"];
        }
            break;
        default:
            break;
    }
}

- (void)setPasswordType:(PasswordType)passwordType
{
    _passwordType = passwordType;
    switch (_passwordType) {
        case kPasswordTypeSecCreate:
        {
            [self setValue:@"secpass" forField:@"changetype"];
        }
            break;
        case kPasswordTypeSecChange:
        {
            [self setValue:@"secpass" forField:@"changetype"];
        }
            break;
        case kPasswordTypeLogin:
        {
            [self setValue:@"loginpass" forField:@"changetype"];
        }
            break;
        default:
            break;
    }
}

- (void)prepare
{
    switch (_passwordType) {
        case kPasswordTypeSecCreate:
            self.url = kUrlPassWordAddSecPwd;
            break;
        case kPasswordTypeSecChange:
            self.url = kUrlPassWordModifySecPass;
            break;
        case kPasswordTypeLogin:
            self.url = kUrlPassWordModifyLoginPass;
            break;
        default:
            break;
    }
    [super prepare];
}

- (void)parse:(NSDictionary *)result{
    //安全密码
    NSString *status = [result stringForKey:@"status"];
    if ([status isEqualToString:@"success"]){
        if (_passwordType==kPasswordTypeSecCreate) {
            [CDUserInfo user].needSetSecurityPass = [NSNumber numberWithBool:NO];
            [[CDUserInfo user]save];
            
        }
        self.msgType = kMessageTypeCommon;
        self.msgContent = nil;
    }
    
}

@end
