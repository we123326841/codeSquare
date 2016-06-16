//
//  TouchLabel.m
//  Caipiao
//
//  Created by danal on 13-1-8.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "TouchLabel.h"

@implementation TouchLabel
@synthesize target = _target;
@synthesize selector = _selector;

- (void)dealloc{
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)addTarget:(id)target selector:(SEL)selector{
    self.target = target;
    self.selector = selector;
    self.userInteractionEnabled = YES;
}

#pragma mark - Touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.target && self.selector) {
        [self.target performSelector:self.selector withObject:self];
    }
}

@end
