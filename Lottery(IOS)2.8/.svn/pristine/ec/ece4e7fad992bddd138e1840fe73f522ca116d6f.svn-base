//
//  RQModifyRemark.m
//  Caipiao
//
//  Created by 王浩 on 15/10/27.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RQModifyRemark.h"

@implementation RQModifyRemark
-(void)prepare{
    self.url=kurlModifyRemark;
    //    self.url =kUrlPrizeDetail;
    [self setValue:_linkid forField:@"id"];
    [self setValue:_remark forField:@"remark"];
    [super prepare];
    
    
    
}

-(void)parse:(NSDictionary*)result{
    NSLog(@"%@",result);
    self.status =result[@"status"];
}





@end
