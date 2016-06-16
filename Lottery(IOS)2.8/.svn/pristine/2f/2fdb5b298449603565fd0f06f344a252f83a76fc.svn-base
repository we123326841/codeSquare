//
//  BallIndicator.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BallIndicator.h"
#import "Ball.h"

static BallIndicator *_currentIndicator = nil;

@implementation BallIndicator
@synthesize number = _number;
@synthesize numberFormat = _numberFormat;

- (void)dealloc{
    [_numberFormat release];
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

- (id)initWithImage:(UIImage *)image{
    self = [super initWithImage:image];
    if (self) {
        CGRect rect = self.bounds;
        rect.size.height *= .5f;
        rect.size.width *= .99f;
        UILabel *_textLbl = [[UILabel alloc] initWithFrame:rect];
        _textLbl.tag = 0x1010;
        _textLbl.textAlignment = UITextAlignmentCenter;
        _textLbl.textColor = [UIColor whiteColor];
        _textLbl.font = [UIFont fontWithName:kFontProximaNovaBold size:20.f];
        _textLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLbl];
        [_textLbl release];
    }
    return self;
}

- (void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
     UILabel *textLbl = (UILabel *)[self viewWithTag:0x1010];
    CGRect rect = bounds;
    rect.size.height *= .5f;
    rect.size.width *= .99f;
    textLbl.frame = rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setNumber:(NSInteger)number{
    _number = number;
//    _ball.image = [UIImage imageNamed:BallSelectedFile(number)];
    UILabel *textLbl = (UILabel *)[self viewWithTag:0x1010];
    textLbl.text = [NSString stringWithFormat:self.numberFormat, number];
}

- (void)setText:(NSString *)text{
    UILabel *textLbl = (UILabel *)[self viewWithTag:0x1010];
    textLbl.text = text;
}

- (void)showOnBall:(Ball *)ball atPoint:(CGPoint)point{
    CGRect frame = self.frame;
    frame.origin = point;   //CGPointMake(-3.f, -4.f);
    self.frame = frame;
    self.layer.anchorPoint = CGPointMake(0.5, 1.0);
    [ball addSubview:self];
    _currentIndicator = self;
}

- (void)dismiss{
    [self removeFromSuperview];
}

#pragma mark - Class method

+ (id)indicator{
    BallIndicator *indicator = [[BallIndicator alloc] initWithImage:ResImage(@"ball-indicator.png")];
    return [indicator autorelease];
}

+ (void)dismissCurrent{
    if (_currentIndicator) {
        [_currentIndicator removeFromSuperview];
        _currentIndicator = nil;
    }
}

@end
