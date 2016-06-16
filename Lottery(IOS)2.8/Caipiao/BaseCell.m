//
//  BaseCell.m
//  Caipiao
//
//  Created by danal on 13-1-22.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseCell.h"

@interface BaseCell ()
@property (copy, nonatomic) NSString *reuseIdentifier;
@end

@implementation BaseCell
@synthesize row = _row;
@synthesize numberOfRows = _numberOfRows;
@synthesize pos = _pos;
@synthesize reuseIdentifier = _reuseIdentifier;

- (void)awakeFromNib{
    UIView *bg = [[UIView alloc] initWithFrame:CGRectZero];
    bg.backgroundColor = Color(@"CellSelectedBGColor");
    self.selectedBackgroundView = bg;
    [bg release];
    
//    for (UIView *v in self.contentView.subviews){
//        if ([v isKindOfClass:[UILabel class]]){
//            [(UILabel *)v setHighlightedTextColor:Color(@"CellSelectedTextColor")];
//        }
//        v.backgroundColor = [UIColor clearColor];
//    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIdentifier:(NSString *)identifier{
    self.reuseIdentifier = identifier;
}

@end

