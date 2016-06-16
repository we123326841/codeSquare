//
//  LinkDetailCellView.m
//  Caipiao
//
//  Created by danal-rich on 4/2/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "LinkDetailCellView.h"

@implementation LinkDetailCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    _typeLbl.textColor =
    _point1Lbl.textColor =
    _point2Lbl.textColor = kYellowTextColor;
}

- (void)setPos:(CellPosition)pos{
    _pos = pos;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [kYellowTextColor setStroke];
    switch (_pos) {
        case kCellPositionDefault:
            UIRectFrame(CGRectMake(0, 0, 1, rect.size.height)); //left
            UIRectFrame(CGRectMake(rect.size.width-1, 0, 1, rect.size.height)); //right
            UIRectFrame(CGRectMake(0, 0, rect.size.width, 1));  //top
            break;
        case kCellPositionBottom:
            UIRectFrame(CGRectMake(0, 0, 1, rect.size.height)); //left
            UIRectFrame(CGRectMake(rect.size.width-1, 0, 1, rect.size.height)); //right
            UIRectFrame(CGRectMake(0, 0, rect.size.width-1, 1));  //top
            UIRectFrame(CGRectMake(0, rect.size.height-1, rect.size.width, 1)); //bottom
            break;
        case kCellPositionSingle:
        default:
            UIRectFrame(CGRectInset(rect, 1, 0));
            break;
    }

}

@end
