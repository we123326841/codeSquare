//
//  BetListCell.m
//  Caipiao
//
//  Created by danal on 13-1-8.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetListCell.h"

enum LblTag {
    kTagType = 0xff,
    kTagNumber,
    kTagMultiple,
    kTagCount,
    kTagAmount
    };

@implementation BetListCell
@synthesize dataDict = _dataDict;
@synthesize bet = _bet;
@synthesize pos = _pos;
@synthesize typeLbl = _typeLbl;
@synthesize numberLbl = _numberLbl;
@synthesize multipleLbl = _multipleLbl;
@synthesize countLbl = _countLbl;
@synthesize amountLbl = _amountLbl;

- (void)dealloc{
    [_bet release];     _bet = nil;
    [_dataDict release];    _dataDict = nil;
    [_bgView release];
    [_typeLbl release];
    [_numberLbl release];
    [_multipleLbl release];
    [_countLbl release];
    [_amountLbl release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
#ifdef __IPHONE_7_0
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
#endif
        _pos = kCellPositionDefault;

        float mar = 10.f;
        CGRect rect = CGRectMake(mar, mar, 280, 36.f);
        UILabel *numberLbl = [[UILabel alloc] initWithFrame:rect];
        numberLbl.numberOfLines = 2;
        numberLbl.tag = kTagNumber;
        [self.contentView addSubview:numberLbl];
        self.numberLbl = numberLbl;
        [numberLbl release];
        
        rect = CGRectMake(mar, rect.origin.y + rect.size.height + 3, 140.f, 20.f);
        UILabel *typeLbl = [[UILabel alloc] initWithFrame:rect];
        typeLbl.tag = kTagType;
        [self.contentView addSubview:typeLbl];
        [typeLbl release];

        rect.origin.x += rect.size.width;
        rect.size.width = 70.f;
        UILabel *countLbl = [[UILabel alloc] initWithFrame:rect];
        countLbl.tag = kTagCount;
        [self.contentView addSubview:countLbl];
        self.countLbl = countLbl;
        [countLbl release];
        
        rect.origin.x += rect.size.width;
        rect.size.width = 100.f;
        UILabel *multipleLbl = [[UILabel alloc] initWithFrame:rect];
        multipleLbl.tag = kTagMultiple;
        [self.contentView addSubview:multipleLbl];
        self.multipleLbl = multipleLbl;
        [multipleLbl release];
        
        rect.origin.x += rect.size.width;
        rect.size.width = 100.f;
        UILabel *amountLbl = [[UILabel alloc] initWithFrame:rect];
        amountLbl.tag = kTagAmount;
        amountLbl.hidden = YES;
        [self.contentView addSubview:amountLbl];
        self.amountLbl = amountLbl;
        [amountLbl release];
        
        for (UIView *view in self.contentView.subviews){
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *lbl = (UILabel *)view;
                lbl.backgroundColor = [UIColor clearColor];
                lbl.font = [UIFont systemFontOfSize:14.f];
                lbl.textColor = [UIColor whiteColor];
            }
        }
        numberLbl.textColor = kYellowTextColor;
        numberLbl.font = [UIFont systemFontOfSize:15.f];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UILabel *lbl = (id)[self viewWithTag:kTagType];
    lbl.text = [NSString stringWithFormat:@"[%@]", _bet.name];      //_bet.type

    lbl = (id)[self viewWithTag:kTagNumber];
    lbl.text = [_bet numbersForShow];     //@"1,3,67";
        
    lbl = (id)[self viewWithTag:kTagMultiple];
    lbl.text = [NSString stringWithFormat:@"%d倍",[_bet.multiple intValue]];
    
    lbl = (id)[self viewWithTag:kTagCount];
    lbl.text = [NSString stringWithFormat:@"%d注",[_bet.count intValue]];
    
    lbl = (id)[self viewWithTag:kTagAmount];
    lbl.text = [NSString stringWithFormat:@"%.1f元",[_bet.amount floatValue]];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    rect = CGRectInset(rect, 1.f, 1.f);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(c, .5f);
    [[UIColor blackColor] set];

    float corner = 5.f;
    float x = rect.origin.x, y = rect.origin.y;
    float w = rect.size.width, h = rect.size.height;
    
    CGContextMoveToPoint(c, x, y + h/2);
  
    if (self.pos == kCellPositionTop) {
        //left-top
        CGContextAddArcToPoint(c, x, y, x+w/2, y, corner);
        //right-top
        CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, corner);
        //right-bottom
        CGContextAddLineToPoint(c, x + w, y + h);
        //left-bottom
        CGContextAddLineToPoint(c, x, y + h);
    } else if(self.pos == kCellPositionBottom){
        //left-top
        CGContextAddLineToPoint(c, x, y);
        //right-top
        CGContextAddLineToPoint(c, x + w, y);
        //right-bottom
        CGContextAddArcToPoint(c, x+w, y+h, x+w/2, y+h, corner);
        //left-bottom
        CGContextAddArcToPoint(c, x, y+h, x, y, corner);
    } else if(self.pos == (kCellPositionTop|kCellPositionBottom)){
        //left-top
        CGContextAddArcToPoint(c, x, y, x+w/2, y, corner);
        //right-top
        CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, corner);
        //right-bottom
        CGContextAddArcToPoint(c, x+w, y+h, x+w/2, y+h, corner);
        //left-bottom
        CGContextAddArcToPoint(c, x, y+h, x, y, corner);
    } else {
        CGContextAddRect(c, rect);
    }
    CGContextClosePath(c);
    CGContextFillPath(c);
}

@end
