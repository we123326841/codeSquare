//
//  Person.m
//  Swift大测试4
//
//  Created by 王浩 on 16/4/11.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "Person.h"
#import "Swift大测试4-swift.h"
@implementation Person
-(void)eat:(NSString *)foodName{
    NSLog(@"%@在吃%@",self,foodName);
   Cat * cat = [[Cat alloc] init];
}

-(instancetype)initWithStr:(NSString *)myStr{
    self = [super init];
    if (self) {
        
        _str = myStr;
    }
    
    return  self;
    
}
@end
