//
//  ZhuiHaoInfoCell.h
//  Caipiao
//
//  Created by GroupRich on 14-11-7.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuiHaoInfoCell : UITableViewCell

@property (assign, nonatomic) IBOutlet UILabel *issueL;//奖期
@property (assign, nonatomic) IBOutlet UILabel *priceL;//金额
@property (assign, nonatomic) IBOutlet UILabel *statusL;//中奖状态
@property (assign, nonatomic) IBOutlet UILabel *codesL;//开奖号码
@property (assign, nonatomic) IBOutlet UILabel *cancelL;//已测单

@end
