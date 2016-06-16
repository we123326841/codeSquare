//
//  Person.m
//  跟Swift对比
//
//  Created by 王浩 on 16/4/11.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "Person.h"

@implementation Person
//-(void)setTitle:(NSString *)title{
//    NSLog(@"日你的吗的");
//    _title = title ;
//}

-(instancetype)initWithType:(Layout *)layout{
    self = [super init];
    
    if (self) {
        _lay = layout;
    }
    return self;
}

-(NSString *)title{
    NSLog(@"日你的吗的%@",self);
    return _title;
}

-(void)comeShift{
    if([_lay isKindOfClass:[FlowLayout class]]&&[self.dataSource respondsToSelector:@selector(personDidDataSourceFlow)]&&[self.dataSource respondsToSelector:@selector(personDidDataSource)]){
        // id source = self.dataSource;
        //        [source personDidDataSourceFlow];
        [self.dataSource performSelector:@selector(personDidDataSourceFlow)];
        [self.dataSource performSelector:@selector(personDidDataSource)];
    }else{
        if([self.dataSource respondsToSelector:@selector(personDidDataSource)]){
            [self.dataSource performSelector:@selector(personDidDataSource)];
        }
    }
}

@end
