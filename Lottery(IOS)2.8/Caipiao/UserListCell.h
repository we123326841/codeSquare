//
//  UserListCell.h
//  Caipiao
//
//  Created by 王浩 on 15/11/9.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListModel.h"
@interface UserListCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *sequenceLabel;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong,nonatomic) UserListModel *model;
@end
