//
//  RQMigrate.m
//  Caipiao
//
//  Created by GroupRich on 14-11-14.
//  Copyright (c) 2014年 yz. All rights reserved.
//资金移转

#import "RQMigrate.h"

@implementation RQMigrate

-(void)prepare
{
    self.url=kUriMigrate;
    
    [self setValue:[CDUserInfo user].userid forField:@"userid"];
    [self setValue:_fundpassword forField:@"fundpassword"];
    [self setValue:[NSNumber numberWithFloat:_amount] forField:@"amount"];

    [super prepare];
}
- (void)parse:(id)result
{
   self.status = [(NSDictionary*)result objectForKey:@"status"];
    self.msg = [(NSDictionary*)result objectForKey:@"content"];
}
@end
