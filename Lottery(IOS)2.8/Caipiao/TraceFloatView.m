//
//  TraceFloatView.m
//  Caipiao
//
//  Created by danal-rich on 8/13/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "TraceFloatView.h"


@implementation TraceFloatView

- (void)dealloc{
    [_targetView removeObserver:self forKeyPath:@"frame"];
    [super dealloc];
}

- (void)awakeFromNib{
    _checkbox.imageOn = ResImage(@"checkon-2.png");
    _checkbox.imageOff = ResImage(@"checkoff-2.png");
    _textLbl.textColor = Color(@"TraceTextColor");
    self.userInteractionEnabled = YES;
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

- (void)followTarget:(UIView *)targetView{
    _targetView = targetView;
    [_targetView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.frame = CGRectMake(self.frame.origin.x, _targetView.frame.origin.y - self.frame.size.height - 3.f, self.frame.size.width, self.frame.size.height);
}

@end
