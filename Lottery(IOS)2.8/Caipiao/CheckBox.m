//
//  CheckBox.m
//  Caipiao
//
//  Created by danal on 13-5-30.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "CheckBox.h"

@implementation CheckBox
@synthesize checked;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup{
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.imageOff = ResImage(@"checkoff.png");
    self.imageOn = ResImage(@"checkon.png");
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setup];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImage *image = checked ? self.imageOn : self.imageOff;
    if (self.contentMode == UIViewContentModeScaleAspectFit){
        CGFloat wh = MIN(rect.size.width, rect.size.height);
        [image drawInRect:CGRectMake((rect.size.width-wh)/2, (rect.size.height-wh)/2, wh, wh)];
    } else {
        [image drawInRect:rect];
    }

}

- (void)setChecked:(BOOL)checked_{
    checked = checked_;
    [self setNeedsDisplay];
    if (_onStateChanged){
        _onStateChanged(self);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.checked = !self.checked;
}

- (void)dealloc{
    self.onStateChanged = nil;
    [super dealloc];
}
@end
