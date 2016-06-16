//
//  PublicDetailSectionView.m
//  Caipiao
//
//  Created by CYRUS on 14-8-5.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "PublicDetailSectionView.h"

@implementation PublicDetailSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.clipsToBounds = YES;
    
    UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleAction:)] autorelease];
    [self addGestureRecognizer:tapGesture];
}

- (IBAction)toggleAction:(id)sender
{
	_opened = !_opened;
	
	if (_opened) {
		if ([_delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
			[_delegate sectionHeaderView:self sectionOpened:_section];
		}
	}
	else {
		if ([_delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
			[_delegate sectionHeaderView:self sectionClosed:_section];
		}
	}
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    CGContextRef c = UIGraphicsGetCurrentContext();
//    //CGContextSetAlpha(c, .5f);
//    [[UIColor rgbColorWithHex:@"c5c5c5"] set];
//    float corner = 6.f;
//    if (_opened) {
//        CGRectAddRoundedCornerPath(rect, corner, kRounderCornerPostionTop, c);
////        float x = rect.origin.x, y = rect.origin.y;
////        float w = rect.size.width, h = rect.size.height;
////        CGContextMoveToPoint(c, x, y + h/2);
////        //left-top
////        CGContextAddArcToPoint(c, x, y, x+w/2, y, corner);
////        //right-top
////        CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, corner);
////        //right-bottom
////        CGContextAddLineToPoint(c, x+w, y + h);
////        //left-bottom
////        CGContextAddLineToPoint(c, x, y + h);
////        CGContextClosePath(c);
//    } else{
//        CGRectAddRoundedCornerPath(rect, corner, kRounderCornerPostionAll, c);
//    }
//    
//    CGContextFillPath(c);
//}


@end
