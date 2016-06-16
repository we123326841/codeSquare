//
//  Person.h
//  跟Swift对比
//
//  Created by 王浩 on 16/4/11.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlowLayout.h"
@protocol PersonDelegate<NSObject>
-(void)personDidFinish;
@end

@protocol PersonDataSource<NSObject>
-(void)personDidDataSource;
@end

@protocol PersonDataSouceFlow <PersonDataSource>
-(void)personDidDataSourceFlow;
@end


@interface Person : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,weak)id<PersonDelegate> delegate;
@property(nonatomic,weak)id<PersonDataSource> dataSource;
@property(nonatomic,strong) Layout*lay;
-(instancetype)initWithType:(Layout*)layout;
-(void)comeShift;
@end
