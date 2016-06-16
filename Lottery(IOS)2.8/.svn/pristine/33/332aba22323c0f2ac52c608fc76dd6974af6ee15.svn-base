//
//  TableDataObject.m
//  Caipiao
//
//  Created by danal on 13-9-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "TableDataObject.h"
#import "LeftViewController.h"


NSString * const AddUser = @"增加用户";
NSString * const UserList = @"用户列表";
NSString * const LinkOpen = @"链接开户";
NSString * const TransactionList = @"账变列表";
NSString * const ChannelTransfer = @"频道转账";
NSString * const LotteryHall = @"购彩大厅";
NSString * const LotteryPublic = @"开奖信息";
NSString * const NoticeCenter = @"公告消息";
NSString * const VersionInfo = @"基本设置";
NSString * const TraceInfo = @"追号信息";
NSString * const GameInfo = @"游戏信息" ;
NSString * const AppSetting = @"设置" ;

@interface TableDataObject ()
@property (strong, nonatomic) NSMutableArray *children;
@end

@implementation TableDataObject

- (void)dealloc{
    [_iconName release];
    [_subjectText release];
    [_detailText release];
    [_userInfo release];
    [_children release];
    [_controllerClass release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self){
        _children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)children{
    return _children;
}

- (void)addChild:(TableDataObject *)child{
    child.row = [_children count];
    [_children addObject:child];
}

- (void)removeChild:(TableDataObject *)child{
    [_children removeObject:child];
}

- (void)removeChildAtIndex:(NSInteger)index{
    [_children removeObjectAtIndex:index];
}

- (TableDataObject *)childAtIndex:(NSInteger)index{
    if (index < [_children count]){
        return [_children objectAtIndex:index];
    }
    return nil;
}

+ (TableDataObject *)objectWithIcon:(NSString *)iconName subject:(NSString *)subjectText controller:(NSString *)controllerClass{
    TableDataObject *obj = [[[TableDataObject alloc] init] autorelease] ;
    obj.iconName = iconName;
    obj.subjectText = subjectText;
    obj.controllerClass = controllerClass;
    return obj;
}

+ (NSArray *)tableDataObjectsForUserType:(UserType)userType{
    NSMutableArray *list = [NSMutableArray array];
    switch (userType) {
        case kUserTypeTopAgent:
        {
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"用户管理" controller:nil];
                section.section = 1;
                [list addObject:section];
//                {
//                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:AddUser  controller:@"AddUserViewController"];
//                    child.mark = kMenuIndexAddUser;
//                    [section addChild:child];
//                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:LinkOpen controller:@"OpenLinkViewController"];
                    child.mark = kMenuIndexLinkOpen;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:UserList controller:@"UserListViewController"];
                    child.mark = kMenuIndexUserList;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"账户报表" controller:nil];
                section.section = 2;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:ChannelTransfer controller:@"TransferViewController"];
                    child.mark = kMenuIndexTransfer;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:TransactionList controller:@"TransactionRecordViewController"];
                    child.mark = kMenuIndexTransacation;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"更多" controller:nil];
                section.section = 4;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:NoticeCenter controller:@"InfoCenterViewController"];
                    child.mark = kMenuIndexInfo;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:VersionInfo controller:@"SettingViewController"];
                    child.mark = kMenuIndexSetting;
                    [section addChild:child];
                }
            }

        }
            break;
        case kUserTypeAgent:
        {
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"参与游戏" controller:nil];
                section.section = 3;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:LotteryHall controller:@"HallViewController"];
                    child.mark = kMenuIndexHall;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:LotteryPublic controller:@"LotteryPublicViewController"];
                    child.mark = kMenuIndexPublic;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"用户管理" controller:nil];
                section.section = 1;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:LinkOpen controller:@"OpenLinkViewController"];
                    child.mark = kMenuIndexLinkOpen;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:AddUser controller:@"AddUserViewController"];
                    child.mark = kMenuIndexAddUser;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:UserList controller:@"UserListViewController"];
                    child.mark = kMenuIndexUserList;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"游戏记录" controller:nil];
                section.section = 4;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:TraceInfo controller:@"ZhuiHaoListViewController"];
                    child.mark = kMenuIndexZhuiHao;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:GameInfo controller:@"GameRecordViewController"];
                    child.mark = kMenuIndexGame;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"账户报表" controller:nil];
                section.section = 2;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:ChannelTransfer controller:@"TransferViewController"];
                    child.mark = kMenuIndexTransfer;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:TransactionList controller:@"TransactionRecordViewController"];
                    child.mark = kMenuIndexTransacation;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"更多" controller:nil];
                section.section = 5;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:NoticeCenter controller:@"InfoCenterViewController"];
                    child.mark = kMenuIndexInfo;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:VersionInfo controller:@"SettingViewController"];
                    child.mark = kMenuIndexSetting;
                    [section addChild:child];
                }
            }
            
        }
            break;
        case kUserTypePlayer:
        default:
        {
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"参与游戏" controller:nil];
                section.section = 1;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:LotteryHall controller:@"HallViewController"];
                    child.mark = kMenuIndexHall;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:LotteryPublic controller:@"LotteryPublicViewController"];
                    child.mark = kMenuIndexPublic;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"游戏记录" controller:nil];
                section.section = 2;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:TraceInfo controller:@"ZhuiHaoListViewController"];
                    child.mark = kMenuIndexZhuiHao;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:GameInfo controller:@"GameRecordViewController"];
                    child.mark = kMenuIndexGame;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"账户报表" controller:nil];
                section.section = 3;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:ChannelTransfer controller:@"TransferViewController"];
                    child.mark = kMenuIndexTransfer;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:TransactionList controller:@"TransactionRecordViewController"];
                    child.mark = kMenuIndexTransacation;
                    [section addChild:child];
                }
            }
            {
                TableDataObject *section = [TableDataObject objectWithIcon:nil subject:@"更多" controller:nil];
                section.section = 4;
                [list addObject:section];
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:NoticeCenter controller:@"InfoCenterViewController"];
                    child.mark = kMenuIndexInfo;
                    [section addChild:child];
                }
                {
                    TableDataObject *child = [TableDataObject objectWithIcon:nil subject:VersionInfo controller:@"SettingViewController"];
                    child.mark = kMenuIndexSetting;
                    [section addChild:child];
                }
            }
        }
            break;
    }
    return list;
}

@end
