//
//  Person.h
//  Swift大测试4
//
//  Created by 王浩 on 16/4/11.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property(nonatomic,copy)NSString * str;
-(void)eat:(NSString*)foodName;
-(instancetype)initWithStr:(NSString*)myStr;
@end
