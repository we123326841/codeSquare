//
//  LiuYanPingLunCell.h
//  
//
//  Created by xiaojiaxi on 14-8-5.
//  Copyright (c) 2014年 mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAccountCell.h"
#import "MyAccountTableView.h"
#import "GameRecord.h"
#import "RQZhuiHaoInfo.h"

@class AccountCell;

@protocol AccountCellDelegate<NSObject>

@optional
- (void)cell:(AccountCell *)cell subCell:(MyAccountCell *)subCell indexpath:(NSIndexPath*)indexpath;

@end

@interface AccountCell : UITableViewCell

@property (assign, nonatomic) DataType type;
@property(nonatomic,assign) id <AccountCellDelegate> delegate;

@property(nonatomic,retain)  NSArray *dataList;

-(void)layoutSelfSubview;
@end
