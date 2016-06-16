//
//  TableDataObject.h
//  Caipiao
//
//  Created by danal on 13-9-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RQLogin.h"

extern NSString * const AddUser;
extern NSString * const UserList;
extern NSString * const TransactionList;
extern NSString * const ChannelTransfer;
extern NSString * const LotteryHall;
extern NSString * const LotteryPublic;
extern NSString * const NoticeCenter;
extern NSString * const VersionInfo;
extern NSString * const TraceInfo;
extern NSString * const GameInfo;
extern NSString * const AppSetting;

@interface TableDataObject : NSObject
@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;
@property (assign, nonatomic) NSInteger mark;
@property (assign, nonatomic) NSInteger badgeNumber;
@property (copy, nonatomic) NSString *iconName;
@property (copy, nonatomic) NSString *subjectText;
@property (copy, nonatomic) NSString *detailText;
@property (copy, nonatomic) NSString *controllerClass;
@property (strong, nonatomic) id userInfo;

- (NSArray *)children;

- (void)addChild:(TableDataObject *)child;
- (void)removeChild:(TableDataObject *)child;
- (void)removeChildAtIndex:(NSInteger)index;
- (TableDataObject *)childAtIndex:(NSInteger)index;

+ (TableDataObject *)objectWithIcon:(NSString *)iconName subject:(NSString *)subjectText controller:(NSString *)controllerClass;
+ (NSArray *)tableDataObjectsForUserType:(UserType)userType;

@end

