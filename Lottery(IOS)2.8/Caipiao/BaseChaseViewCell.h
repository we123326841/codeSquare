//
//  BaseChaseViewCell.h
//  ZhuihaoDemo
//
//  Created by 王浩 on 15/11/30.
//  Copyright © 2015年 王浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseChaseViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *sub;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIButton *sub1;
@property (weak, nonatomic) IBOutlet UIButton *add1;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel1;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
- (IBAction)justSwitch:(UISwitch *)sender;
- (IBAction)addAndSubClick:(id)sender;

@end
