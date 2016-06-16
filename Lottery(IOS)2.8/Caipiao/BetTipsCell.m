//
//  BetTipsCell.m
//  Caipiao
//
//  Created by danal on 13-1-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetTipsCell.h"

@implementation BetTipsCell
@synthesize tips = _tips;

- (void)dealloc{
    [_tips release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
#ifdef __IPHONE_7_0
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
#endif
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTips:(NSString *)tips{
    [_tips release];
    _tips = [tips copy];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    rect = CGRectInset(rect, 10.f, 4.f);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(c, .5f);
    CGRectAddRoundedCornerPath(rect, 5.f, kRounderCornerPostionAll, c);
    CGContextFillPath(c);

    CGContextSetAlpha(c, 1.f);
    float mar = 5.f, w = 16.f;
    float x = rect.origin.x + mar, y = (rect.size.height - w)/2 + rect.origin.y;
    UIImage *ico = [UIImage imageWithResFile:@"ico_game_tip.png"];
    [ico drawInRect:CGRectMake(x, y, w, w)];
    UIImage *close = [UIImage imageWithResFile:@"ico_close_white.png"];
    w = 14.f;
    y = (rect.size.height - w)/2 + rect.origin.y;
    [close drawInRect:CGRectMake(rect.size.width - w, y, w, w)];
    UIFont *font = [UIFont boldSystemFontOfSize:13.f];
    [[UIColor whiteColor] set];
    rect = CGRectInset(rect, w + 2*mar, 4.f);
//    rect.size.height = 50;  //font.lineHeight;
    [self.tips drawInRect:rect withFont:font];
}

+ (float)height{
    return 34.f;
}

+ (float)heightForTips:(NSString *)tips{
    float h = [self height], mar = 8.f;
    UIFont *font = [UIFont boldSystemFontOfSize:13.f];
    CGSize size = CGSizeMake(252 , NSIntegerMax);
    size = [tips sizeWithFont:font];
    int line = ceil(size.width/252);
    h = line*font.lineHeight + 2*mar;
    return MAX(h, [self height]);
}

@end
