//
//  BetListAccessoryView.m
//  Caipiao
//
//  Created by danal on 13-5-30.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetListAccessoryView.h"

@implementation BetListAccessoryView

- (void)awakeFromNib{
    self.dropDownBox.backgroundColor = [UIColor clearColor];
    self.dropDownBox.rightView.image = [UIImage imageNamed:@"ico_sj_highyellow"];
    self.dropDownBox.titleLbl.textColor = kYellowTextColor;
    self.dropDownBox.titleLbl.text = @"132904847";
    self.dropDownBox.titleLbl.font = [UIFont boldSystemFontOfSize:11];
    for (UIView *v in self.subviews){
        if ([v isKindOfClass:[UILabel class]]){
            [(UILabel *)v setTextColor:kYellowTextColor];
            [(UILabel *)v setAdjustsFontSizeToFitWidth:YES];
        } else if ([v isKindOfClass:[UITextField class]]) {
            [(UITextField *)v setTextColor:kYellowTextColor];
        }
    }
    
    self.tipsLbl.textColor = [UIColor redColor];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
