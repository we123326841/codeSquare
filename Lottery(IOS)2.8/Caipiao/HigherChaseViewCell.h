//
//  HigherChaseViewCell.h
//  ZhuihaoDemo
//
//  Created by 王浩 on 15/11/30.
//  Copyright © 2015年 王浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HigherChaseViewCell : UITableViewCell
- (IBAction)checkBoxClick:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITextField *textField1;
@property (retain, nonatomic) IBOutlet UITextField *textField11;
@property (retain, nonatomic) IBOutlet UITextField *textField2;
@property (retain, nonatomic) IBOutlet UITextField *textField22;
@property (retain, nonatomic) IBOutlet UITextField *textField3;
@property (retain, nonatomic) IBOutlet UITextField *textField33;
@property (retain, nonatomic) IBOutlet UITextField *textField333;
@property (retain, nonatomic) IBOutlet UITextField *textField4;
@property (retain, nonatomic) IBOutlet UITextField *textField44;
@property (retain, nonatomic) IBOutlet UITextField *textField444;
@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (retain, nonatomic) IBOutlet UIButton *btn4;
@property(nonatomic,strong)NSMutableArray*btns;

@end
