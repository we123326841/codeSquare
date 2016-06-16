//
//  MultipleInputView.m
//  Caipiao
//
//  Created by danal on 13-1-8.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "MultipleInputView.h"

@implementation MultipleInputView
@synthesize textField = _textField;
@synthesize background = _background;
@synthesize tipsLbl = _tipsLbl;

- (void)dealloc{
    [_tipsLbl removeObserver:self forKeyPath:@"text"];
    [_tipsLbl release];
    [_background release];
    [_textField release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = 40.f;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _background = [[UIImageView alloc] initWithFrame:self.bounds];
//        _background.image = [UIImage imageNamed:@"navbg.png"];
        _background.backgroundColor = [UIColor blackColor];
        _background.alpha = .8f;
        [self addSubview:_background];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 60.f, 30.f)];
        _textField.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        _textField.layer.borderColor = kYellowTextColor.CGColor;
        _textField.layer.borderWidth = 1.f;
        _textField.textColor = kYellowTextColor;
        _textField.font = [UIFont boldSystemFontOfSize:17.f];
        _textField.textAlignment = UITextAlignmentCenter;
        _textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_textField];
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:
                         CGRectMake(_textField.frame.origin.x - 20.f - 5.f, 5.f, 20.f, 30.f)];
        lbl1.text = @"投";
        lbl1.textColor = kYellowTextColor;
        lbl1.backgroundColor = [UIColor clearColor];
        lbl1.textColor = kYellowTextColor;
        lbl1.font = [UIFont systemFontOfSize:17.f];
        [self addSubview:lbl1];
        [lbl1 release];
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:
                          CGRectMake(_textField.frame.origin.x + _textField.frame.size.width + 5.f, 5.f, 20.f, 30.f)];
        lbl2.text = @"倍";
        lbl2.backgroundColor = [UIColor clearColor];
        lbl2.textColor = kYellowTextColor;
        lbl2.font = [UIFont systemFontOfSize:17.f];
        [self addSubview:lbl2];
        [lbl2 release];
        
        _tipsLbl = [[UILabel alloc] initWithFrame:
        CGRectMake(frame.size.width - 90.f ,  (frame.size.height - 20.f)/2, 90.f, 20.f)];
        _tipsLbl.backgroundColor = [UIColor clearColor];
        _tipsLbl.font = [UIFont systemFontOfSize:14.f];
        _tipsLbl.textColor = [UIColor redColor];
        [self addSubview:_tipsLbl];
        [_tipsLbl addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)clearText{
    _tipsLbl.text = nil;
    [_timer invalidate];
    _timer = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        //launch a timer
        NSString *text = [change objectForKey:@"new"];
        if ([text isKindOfClass:[NSString class]] &&  [text length] > 0) {
            [_timer invalidate];
           _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(clearText) userInfo:nil repeats:NO];
        }
    }
}

@end
