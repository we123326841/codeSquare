//
//  UserAmountListCell.m
//  Caipiao
//
//  Created by cYrus on 13-10-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UserAmountListCell.h"

@implementation UserAmountListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
#ifdef __IPHONE_7_0
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
#endif
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIImage *line = [UIImage imageNamed:@"home_list_item_line.png"];
    [line drawInRect:CGRectMake(0, rect.size.height - 1, rect.size.width, 1)];
}

@end
