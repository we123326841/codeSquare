//
//  BetAccessoryView.m
//  Caipiao
//
//  Created by danal on 13-5-30.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetAccessoryView.h"

@implementation BetAccessoryView

- (void)awakeFromNib{
    
    self.switcher.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.switcher.leftLbl = self.yuanLbl;
    self.switcher.rightLbl = self.jiaoLbl;
    for (UIView *v in self.subviews){
        if ([v isKindOfClass:[UILabel class]]){
            [(UILabel *)v setTextColor:kYellowTextColor];
        } else if ([v isKindOfClass:[UITextField class]]) {
            [(UITextField *)v setTextColor:kYellowTextColor];            
        }
    }
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
