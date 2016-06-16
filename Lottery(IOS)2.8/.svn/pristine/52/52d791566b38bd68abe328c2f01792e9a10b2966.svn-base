//
//  BettingResultLabel.m
//  Caipiao
//
//  Created by danal on 13-3-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetResultLabel.h"

@implementation BetResultLabel
@synthesize success, fail;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        success = fail = 0;
    }
    return self;
}

- (void)setSuccess:(int)success_{
    success = success_;
    [self setNeedsDisplay];
}

- (void)setFail:(int)fail_{
    fail = fail_;
    [self setNeedsDisplay];
    
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self.textColor set];
    NSString *text = [NSString stringWithFormat:@"投注成功：%d单  失败：%d单",success,fail];
//    [text drawInRect:rect withFont:self.font lineBreakMode:self.lineBreakMode alignment:self.textAlignment];
//    return;
    NSRange range = [text rangeOfString:@"：" options:NSBackwardsSearch];
    CGSize textSize = [text sizeWithFont:self.font constrainedToSize:rect.size];
    float y = (rect.size.height - textSize.height)/2;
    float x = self.textAlignment == NSTextAlignmentCenter ? (rect.size.width - textSize.width)/2 : 0.f;
    for (int i = 0; i < [text length]; i++) {
        NSString *c = [text substringWithRange:NSMakeRange(i, 1)];
        if (range.length > 0 && range.location + 1 == i) {
            [[UIColor redColor] set];
        }
        [c drawAtPoint:CGPointMake(x, y) withFont:self.font];
        CGSize size = [c sizeWithFont:self.font constrainedToSize:rect.size];
        x += size.width;
    }
}


@end
