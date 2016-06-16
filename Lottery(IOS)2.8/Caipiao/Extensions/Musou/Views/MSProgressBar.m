//
//  MSProgressBar.m
//  Musou
//
//  Created by luo danal on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSProgressBar.h"
#import <QuartzCore/QuartzCore.h>

@implementation MSProgressBar
@synthesize progress = _progress;

+ (id)standardBar{
    return [[[MSProgressBar alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 10.f)] autorelease];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.borderColor = [UIColor colorWithRed:0xe3/255.f green:0xe3/255.f blue:0xe3/255.f alpha:1.f].CGColor;
        self.layer.borderWidth = 1.f;
//        self.backgroundColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGRect paintRect = CGRectMake(0, 0, self.progress*rect.size.width, rect.size.height);
    CGContextAddRect(c, paintRect);
//    CGContextSetFillColorWithColor(c, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(c, self.layer.borderColor);
    CGContextFillPath(c);
}


- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

@end
