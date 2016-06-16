//
//  AutoHideAlertView.m
//  Caipiao
//
//  Created by Cyrus on 13-6-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "AutoHideAlertView.h"
#import <QuartzCore/QuartzCore.h>

static AutoHideAlertView *_currentInstance = nil;

@implementation AutoHideAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dismiss{
    [_timer invalidate];
    _timer = nil;
    self.delegate  = nil;
    [self dismissWithClickedButtonIndex:0 animated:YES];
    _currentInstance = nil;
}

- (void)showMessage:(NSString *)msg delayHides:(float)delay{
    
    _currentInstance = self;
    self.delegate = self;
    [super show];
    
    self.bounds = CGRectMake(0, 0, 300, 100);
    float mar = 20.f;
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.duration = 1.f;
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*2, 0, 0, 1.f)]
                  , nil];
    kfa.repeatCount = 10e6;
    //    [_imageView.layer addAnimation:kfa forKey:@"Rotation"];
    
    CGRect rect = CGRectMake(0, (self.bounds.size.height - 25.f)/2,
                             self.bounds.size.width - 3*mar - 32.f, 25.f);
    rect.origin.x = self.frame.size.width/2-rect.size.width/2;
    
    _textLbl = [[UILabel alloc] initWithFrame:self.bounds];
    _textLbl.backgroundColor = [UIColor clearColor];
    _textLbl.textColor = [UIColor whiteColor];
    _textLbl.textAlignment = NSTextAlignmentCenter;
    _textLbl.text = msg;
    [self addSubview:_textLbl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:delay
                                              target:self
                                            selector:@selector(dismiss)
                                            userInfo:nil
                                             repeats:NO];
    
}

- (void)delayHideShow:(float)delay{
    [self showMessage:NSLocalizedString(@"Loading...",nil) delayHides:delay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

#pragma mark - Delegate

- (void)willPresentAlertView:(UIAlertView *)alertView{
    self.bounds = CGRectMake(0, 0, 300, 100);
}

- (void)didPresentAlertView:(UIAlertView *)alertView{
    self.bounds = CGRectMake(0, 0, 300, 100);
}

#pragma mark - Class methods

+ (void)showLoading{
    [AutoHideAlertView showMessage:NSLocalizedString(@"Loading...",nil) delayHides:10.f];
}

+ (void)showMessage:(NSString *)msg delayHides:(float)delay{
    AutoHideAlertView *alert = [[AutoHideAlertView alloc] initWithTitle:nil
                                                              message:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:nil, nil];
    [alert showMessage:msg delayHides:delay];
    [alert release];
    
}

+ (void)dismissCurrent{
    if (_currentInstance) {
        [_currentInstance dismiss];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
