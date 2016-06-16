//
//  RQDeleteLink.m
//  Caipiao
//
//  Created by 王浩 on 15/10/27.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RQDeleteLink.h"

@implementation RQDeleteLink
-(void)prepare{
           self.url=KUrlDeleteLink;
        //    self.url =kUrlPrizeDetail;
        [self setValue:_linkid forField:@"id"];
        [super prepare];
   


}

-(void)parse:(NSDictionary*)result{
    NSLog(@"%@",result);
   self.status =result[@"status"];
}




@end
