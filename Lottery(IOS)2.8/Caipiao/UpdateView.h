//
//  VideoAlert.h
//  Caipiao
//
//  Created by GroupRich on 15/1/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpdateView;
typedef void (^ClickedBlock)(NSInteger index);

@interface UpdateView : UIView

PCOPY ClickedBlock clickedBlock;
- (IBAction)btnClicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *alertL;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIButton *leftbtn;
@property (retain, nonatomic) IBOutlet UIButton *rightbtn;
@property (retain, nonatomic) IBOutlet UILabel *titleL;

@end





