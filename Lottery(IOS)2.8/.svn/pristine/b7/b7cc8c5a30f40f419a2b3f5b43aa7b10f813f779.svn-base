//
//  MenuCell.m
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize iconLblView = _iconLblView;
@synthesize showIndicator = _showIndicator;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _iconLblView  = [[IconLabelView alloc] initWithFrame:self.bounds];
        _iconLblView.textLbl.textColor = kMenuTextColor;
        _iconLblView.textLbl.font = [UIFont boldSystemFontOfSize:15.f];
        _iconLblView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _iconLblView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_iconLblView];
        [_iconLblView release];
        
        _indicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(452.f/2, 10.f, 20.f, 20.f)];
        _indicatorView.contentMode = UIViewContentModeScaleAspectFit;
        _indicatorView.image = [UIImage imageNamed:@"indicator_black.png"];
        [self.contentView addSubview:_indicatorView];
        [_indicatorView release];
        
        _selectedMask = [[UIView alloc] initWithFrame:self.bounds];
        _selectedMask.backgroundColor = [UIColor rgbColorWithHex:@"c09703"];//[UIColor rgbColorWithR:0 G:0 B:0 alpha:.5f];
        [self.contentView insertSubview:_selectedMask atIndex:0];
        [_selectedMask release];
        
        _badgeLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _badgeLbl.frame = CGRectMake(100.f, (self.contentView.bounds.size.height - 14)/2, 16, 16);
        _badgeLbl.backgroundColor = [UIColor redColor];
        _badgeLbl.textColor = [UIColor whiteColor];
        _badgeLbl.font = [UIFont boldSystemFontOfSize:10.f];
        _badgeLbl.textAlignment = NSTextAlignmentCenter;
        _badgeLbl.hidden = YES;
        [self.contentView addSubview:_badgeLbl];
        [_badgeLbl release];
        
#ifdef __IPHONE_7_0
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
#endif
        //        self.selectedBackgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        //        self.selectedBackgroundView.backgroundColor = [UIColor rgbColorWithR:0 G:0 B:0 alpha:.5f];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setShowIndicator:(BOOL)showIndicator{
    _showIndicator = showIndicator;
    _indicatorView.image = _showIndicator ? [UIImage imageNamed:@"indicator.png"] : [UIImage imageNamed:@"indicator_black.png"];
    _iconLblView.textLbl.textColor = _showIndicator ? [UIColor rgbColorWithHex:@"#171717"] : kMenuTextColor;
    _iconLblView.iconView.backgroundColor = _showIndicator ? [UIColor rgbColorWithHex:@"#171717"] : kMenuTextColor;
    _selectedMask.hidden = !_showIndicator;
}

- (void)setBadgeNumber:(NSInteger)badgeNumber{
    _badgeLbl.text = [NSString stringWithFormat:@"%d",badgeNumber];
    _badgeLbl.hidden = badgeNumber == 0;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _indicatorView.center = CGPointMake(_indicatorView.center.x, self.bounds.size.height/2);
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //    [[UIImage imageNamed:@"gray_tile.png"] drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height - 2)];
    //    [[UIColor orangeColor] setFill];
    //    UIRectFrame(CGRectMake(0, rect.size.height - 2.f, rect.size.width, 1.f));
    //    [[UIColor whiteColor] setFill];
    //    UIRectFrame(CGRectMake(0, rect.size.height - 1.f, rect.size.width, 1.f));
    
    UIImage *line = [UIImage imageNamed:@"home_list_item_line.png"];
    [line drawInRect:CGRectMake(0, rect.size.height - 1, rect.size.width, 1)];
}

@end
