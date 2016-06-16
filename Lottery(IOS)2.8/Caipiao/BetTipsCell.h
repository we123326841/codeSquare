//
//  BetTipsCell.h
//  Caipiao
//
//  Created by danal on 13-1-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BetTipsCell : UITableViewCell
@property (copy, nonatomic) NSString *tips;

+ (float)height;
+ (float)heightForTips:(NSString *)tips;
@end
