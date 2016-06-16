//
//  LowFooterActionView.h
//  Caipiao
//
//  Created by cYrus_c on 14-3-6.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBox.h"

@interface LowFooterActionView : UIView
@property (assign, nonatomic) IBOutlet UILabel *checkBoxLbl;
@property (assign, nonatomic) IBOutlet CheckBox *checkBox;
@property (assign, nonatomic) IBOutlet UIButton *betButton;

@end
