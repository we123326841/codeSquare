//
//  InfoCenterCell.m
//  Caipiao
//
//  Created by rod on 13/1/15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "InfoCenterCell.h"

@implementation InfoCenterCell
@synthesize lblContent,imageView,lblTitle,lblDateTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    /*
    UIImageView *acc = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator_black.png"]];
    self.accessoryView = acc;
    [acc release];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_list_selected_.png"]];
    self.selectedBackgroundView = bg;
    [bg release];
     */
    for (UIView *v in self.contentView.subviews){
        if ([v isKindOfClass:[UILabel class]]){
            UILabel *l = (UILabel *)v;
            l.enabled = NO;
        }
    }
}

- (void)setNoticeType:(NoticeType)noticeType{
    switch (noticeType) {
        case kNoticeTypeBank:
            self.lblType.text = @"银行";
            break;
        case kNoticeTypeLow:
            self.lblType.text = @"低频";
            break;
        case kNoticeTypeHigh:
            self.lblType.text = @"高频";
            break;
        case kNoticeTypeSite:
            break;
        default:
            break;
    }
}

@end


@implementation TypeLabel

- (void)dealloc{
    [_bgColor release];
    [super dealloc];
}

- (void)setBgColor:(UIColor *)bgColor{
    if (_bgColor != bgColor){
        [_bgColor release];
        _bgColor = [bgColor retain];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect{
    if (!_bgColor) _bgColor = [UIColor whiteColor];
    [_bgColor set];
    UIRectFill(rect);
    [super drawRect:rect];
}

@end
