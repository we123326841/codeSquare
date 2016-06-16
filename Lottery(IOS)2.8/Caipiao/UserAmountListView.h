//
//  UserAmountListView.h
//  Caipiao
//
//  Created by cYrus on 13-10-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserAmountListView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSMutableArray *currBalanceArray DEPRECATED_ATTRIBUTE;
@property (strong, nonatomic) NSMutableArray *userPointArray DEPRECATED_ATTRIBUTE;
@property (strong, nonatomic) NSMutableDictionary *userPointDict;
@property (copy, nonatomic) void(^exitBlock)(UIView *amountListView);

@end
