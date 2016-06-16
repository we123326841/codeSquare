//
//  ZhuiHaoCell.m
//  Caipiao
//
//  Created by Cyrus on 13-6-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "ZhuiHaoCell.h"

@implementation ZhuiHaoCell
@synthesize typeLbl = _typeLbl;
@synthesize numberLbl= _numberLbl;
@synthesize multipleLbl= _multipleLbl;
@synthesize dateLbl= _dateLbl;
@synthesize zhuiHaoLbl= _zhuiHaoLbl;
@synthesize amountLbl= _amountLbl;
@synthesize statusLbl= _statusLbl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *acc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator_black.png"]];
    self.accessoryView = acc;
    [acc release];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_list_selected_.png"]];
    self.selectedBackgroundView = bg;
    [bg release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        UIImageView *acc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator.png"]];
        self.accessoryView = acc;
        [acc release];
    }else {
        UIImageView *acc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator_black.png"]];
        self.accessoryView = acc;
        [acc release];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        UIImageView *acc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator.png"]];
        self.accessoryView = acc;
        [acc release];
    }else {
        UIImageView *acc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator_black.png"]];
        self.accessoryView = acc;
        [acc release];
    }
    
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
