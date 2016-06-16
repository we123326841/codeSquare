//
//  NewsCell.m
//  oschina
//
//  Created by wangjun on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameRecordCell.h"

@implementation GameRecordCell
@synthesize lotteryTypeLbl, lblTitle;
@synthesize qiNumber,kaijiang,money,openDate;

-(void)dealloc
{
    [lotteryTypeLbl release];
    [lblTitle release];
    [qiNumber release];
    [qiNumber release];
    [kaijiang release];
    [money release];
    [openDate release];
    [super dealloc];
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


@end
