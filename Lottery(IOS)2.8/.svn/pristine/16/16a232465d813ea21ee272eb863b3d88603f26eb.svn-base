//
//  PublicDetailCell.m
//  Caipiao
//
//  Created by CYRUS on 14-8-5.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "PublicDetailCell.h"
#import "PublicBall.h"

#define kBallTagStart 1
#define kBallTagEnd 7

@implementation PublicDetailCell

- (void)awakeFromNib
{
    // Initialization code
#ifdef __IPHONE_7_0
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
#endif
    _issueLbl.textColor = Color(@"PublicCellIssueColor");
    _sum = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCodes:(NSString *)codes{
    [_codes release];
    _codes = [codes copy];
    _sum = 0;
    BOOL isSSQ = NO;
    if ([codes rangeOfString:@"+"].length > 0) isSSQ = YES;
    codes = [codes stringByReplacingOccurrencesOfString:@"+" withString:@","];
    NSArray *nums = [codes publicSplit];
    
    int index = 0;
    for (int tag = kBallTagStart; tag <= kBallTagEnd ; tag++) {
        PublicBall *ball = (PublicBall *)[self viewWithTag:tag];
        ball.hidden = YES;
        if (index < [nums count]){
            ball.hidden = NO;
            ball.number = [nums objectAtIndex:index];
            _sum += ball.number.integerValue;
            if (isSSQ) {
                if (index != kBallTagEnd) ball.image = ResImage(@"ball_bg_red.png");
                else ball.image = ResImage(@"ball_bg_blue.png");
            }
            
             if([self.lotteryName isEqualToString:JSK3])
            {
                NSString *number = [nums objectAtIndex:index];
                NSString *imagename = [NSString stringWithFormat:@"sz%ld.png",(long)[number integerValue]];
                ball.image = ResImage(imagename);
                ball.number = @"";
                
            }
            index++;

        }
    }
}

- (void)setPreCodes:(NSString *)preCodes
{
    [_preCodes release];
    _preCodes = [preCodes copy];
    
    if ([preCodes length] == 0) {
        for (int tag = 11; tag <= 17 ; tag++) {
            UILabel *ball = (UILabel *)[self viewWithTag:tag];
            ball.hidden = YES;
        }
        return;
    }
    
    BOOL isSSQ = NO;
    if ([preCodes rangeOfString:@"+"].length > 0) isSSQ = YES;
    preCodes = [preCodes stringByReplacingOccurrencesOfString:@"+" withString:@","];
    NSArray *nums = [preCodes publicSplit];
    
    int index = 0;
    for (int tag = 11; tag <= 17 ; tag++) {
        UILabel *ball = (UILabel *)[self viewWithTag:tag];
        ball.hidden = YES;
        if (index < [nums count]){
            ball.hidden = NO;
            ball.text = [nums objectAtIndex:index];
            ball.textColor = Color(@"PublicCellNumberColor");
            index++;
            
            if (isSSQ) {
                if (tag != 17) ball.textColor = Color(@"PublicCellRedNumberColor");
                else ball.textColor = Color(@"PublicCellBlueNumberColor");
            }
        }
    }
}

+ (NSString *)numFormatter:(NSString *)codes
{
    codes = [codes stringByReplacingOccurrencesOfString:@"+" withString:@","];
    NSArray *nums = [codes publicSplit];
    NSMutableString *result = [[[NSMutableString alloc] init] autorelease];
    for (NSString *n in nums) {
        [result appendFormat:@" %@",n];
    }
    return result;
}

/*
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //rect = CGRectInset(rect, 1.f, 1.f);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(c, 1.f);
    [[UIColor rgbColorWithHex:@"c5c5c5"] set];
    
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
    CGContextStrokePath(c);
    //CGContextFillPath(c);
}
 */

- (void)dealloc {
    [_sumL release];
    [super dealloc];
}
@end
