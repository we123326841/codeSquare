//
//  UnderlineLabel.m
//  Caipiao
//
//  Created by danal on 13-6-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UnderlineLabel.h"

@implementation UnderlineLabel
@synthesize accessory;

- (void)setup{
    self.textColor = kYellowTextColor;
    self.font = [UIFont boldSystemFontOfSize:14.f];
    self.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [UIImage imageNamed:@"ico_sj_yellow"];
    accessory = [[UIImageView alloc] initWithImage:image];
    accessory.contentMode = UIViewContentModeScaleAspectFit;
    accessory.frame = CGRectMake(self.bounds.size.width - 16, (self.bounds.size.height - 16)/2, 16, 16);
    accessory.hidden = YES;
    [self addSubview:accessory];
    [accessory release];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (void)setClickCallback:(SEL)sel target:(id)target{
    _target = target;
    _selector = sel;
    self.userInteractionEnabled = _target&&_selector;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];

    UIImage *line = [UIImage imageNamed:@"line_lbltrans"];
    [line drawAtPoint:CGPointMake(0, rect.size.height - line.size.height)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_target && _selector) {
        [_target performSelector:_selector withObject:self afterDelay:.1f];
    }
}

@end
