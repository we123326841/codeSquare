//
//  BetCountView.m
//  Caipiao
//
//  Created by danal on 13-1-8.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetCountView.h"

@implementation BetCountView
@synthesize totalCountLbl = _totalCountLbl;
@synthesize totalAmountLbl = _totalAmountLbl;
@synthesize balanceLbl = _balanceLbl;

- (void)dealloc{
    [_totalCountLbl release];
    [_totalAmountLbl release];
    [_balanceLbl release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
/*
         float mar = 10.f;
        _totalCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(mar, mar, frame.size.width/2, 20.f)];
        _totalCountLbl.text = @"总注数:100";
        [self addSubview:_totalCountLbl];
        
        _totalAmountLbl = [[UILabel alloc] initWithFrame:CGRectMake(mar, mar + 20.f, frame.size.width/2, 20.f)];
        _totalAmountLbl.text = @"总金额:100";
        [self addSubview:_totalAmountLbl];
        
        _balanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, (frame.size.height - 20.f)/2,
                                                                frame.size.width/2, 20.f)];
        _balanceLbl.text = @"高频余额:300";
        [self addSubview:_balanceLbl];
*/
        _totalCountLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20.f)];
        _totalCountLbl.text = @" 总注数:100";
        [self addSubview:_totalCountLbl];
        
        _totalAmountLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 20.f)];
        _totalAmountLbl.text = @" 总金额:100";
        [self addSubview:_totalAmountLbl];
        
        _balanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 40,
                                                                frame.size.width*2, 20.f)];
        _balanceLbl.text = @"高频余额:300";
        [self addSubview:_balanceLbl];
        
        for (UIView *view in self.subviews){
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *lbl = (UILabel *)view;
                lbl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                lbl.backgroundColor = [UIColor clearColor];
                lbl.font = [UIFont boldSystemFontOfSize:13.f];
                lbl.textColor = kYellowTextColor;
            }
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextAddRect(c, rect);
    CGContextSetAlpha(c, .5f);
    CGContextFillPath(c);
}
*/

@end
