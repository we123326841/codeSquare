//
//  MSButton.m
//  Musou
//
//  Created by luo danal on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation MSButton

+ (id)buttonWithStyle:(MSButtonStyle)style{
//    MSButton *button = [self buttonWithType:UIButtonTypeCustom];
    MSButton *button = [[[MSButton alloc] initWithFrame:CGRectZero style:style] autorelease];
    button.layer.cornerRadius = 7.f;
    button.layer.masksToBounds = YES;
    button.showsTouchWhenHighlighted = YES;
    return button;
}

- (id)initWithFrame:(CGRect)frame style:(MSButtonStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient;
    
    if (_style == kButtonStyleSilver) {        
        float components[] = {
            234.f/255, 234.f/255, 234.f/255, 1.f,
            190.f/255, 190.f/255, 190.f/255, 1.f,
            234.f/255, 234.f/255, 234.f/255, 1.f,
        };
        gradient = CGGradientCreateWithColorComponents(space, components, NULL, sizeof(components)/sizeof(float)/4);
    }
    else if (_style == kButtonStyleLeftArrow) {
        float components[] = {
                117.f/255.f, 143.f/255.f, 179.f/255.f, 1.f,
                73.f/255.f, 107.f/255.f, 154.f/255.f, 1.f
        };
        gradient = CGGradientCreateWithColorComponents(space, components, NULL, sizeof(components)/sizeof(float)/4);
        
//        CGContextMoveToPoint(c, 0, rect.size.height/2);
//        CGContextAddLineToPoint(c, 10, 0);
//        CGContextAddLineToPoint(c, rect.size.width, 0);
//        CGContextAddLineToPoint(c, 0, rect.size.height);
//        CGContextFillPath(c);        
    }

    CGContextDrawLinearGradient(c, gradient, CGPointMake(rect.size.width/2, 0), CGPointMake(rect.size.width/2, rect.size.height), kCGGradientDrawsAfterEndLocation);
    CFRelease(gradient);

    CFRelease(space);
}


@end
