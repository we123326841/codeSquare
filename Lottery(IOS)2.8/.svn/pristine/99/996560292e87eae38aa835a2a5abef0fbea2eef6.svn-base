//
//  RQLinkUsers.m
//  Caipiao
//
//  Created by 王浩 on 15/10/23.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RQLinkUsers.h"

@implementation RQLinkUsers
-(void)prepare
{
   
    self.url =KUrlOpenLinkUsers;
    //[self setValue:_linkid forField:@"id"];
    [self setValue:_linkId forField:@"id"];
    [super prepare];
}
- (void)parse:(NSArray*)result
{
    
    NSLog(@"%@",result);
    _users =result;
   
   
}

- (void)dealloc
{
    [super dealloc];
    [_linkId release];
   // [_users release];
}

@end
