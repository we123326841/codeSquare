//
//  ColorCell.m
//  Caipiao
//
//  Created by danal on 13-8-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "ColorCell.h"

@implementation ColorCell

+ (ColorCell *)blackColorCell:(NSString *)identifier{
    ColorCell *cell = [[[ColorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    cell.tintColor = [UIColor blackColor];
    cell.tintAlpha = .3f;
    return cell;
}

+ (ColorCell *)greenColorCell:(NSString *)identifier{
    ColorCell *cell = [[[ColorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    cell.tintColor = kGreenBGColor;
    cell.tintAlpha = 1.f;
    return cell;
}

- (void)dealloc{
    self.tintColor = nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _tintAlpha = 1.f;
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
    if (_stateDelegate && [_stateDelegate respondsToSelector:@selector(onCellSelected:animated:cell:)]){
        [_stateDelegate onCellSelected:selected animated:animated cell:self];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    if (_stateDelegate && [_stateDelegate respondsToSelector:@selector(onCellHighlighted:animated:cell:)]){
        [_stateDelegate onCellHighlighted:highlighted animated:animated cell:self];
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (self.tintColor) {
        rect = CGRectMake(rect.origin.x - self.edgeInsets.left, rect.origin.y - self.edgeInsets.top,
                          rect.size.width - self.edgeInsets.left - self.edgeInsets.right,
                          rect.size.height - self.edgeInsets.top - self.edgeInsets.bottom);
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextAddRect(c, rect);
        CGContextSetAlpha(c, self.tintAlpha);
        CGContextSetFillColorWithColor(c, self.tintColor.CGColor);
        CGContextFillPath(c);
    }
}

@end
