//
//  Switch.m
//  Caipiao
//
//  Created by danal on 13-1-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "Switch.h"

@interface Switch ()
@property (assign, nonatomic) UIView *bgOn;
@property (assign, nonatomic) UIView *bgOff;
@end

@implementation Switch
@synthesize on = _on;
@synthesize style = _style;


- (void)awakeFromNib{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame style:(SwitchStyle)style
{
    //    frame.size = style == kSwitchStyleBall ? CGSizeMake(52.f, 27.f) : CGSizeMake(77.f, 27.f);
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        [self setup];
    }
    return self;
}

- (void)setup{
    SwitchStyle style = self.style;
    CGRect frame = self.frame;
    frame.size = style == kSwitchStyleBall ? CGSizeMake(52.f, 28.f) : CGSizeMake(78.f, 28.f);
    self.frame = frame;
    
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = frame.size.height/2;
    
    _ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:Res(@"switch-ball.png")]];
    _ball.frame = CGRectMake(-1, 2.5, _ball.bounds.size.width, _ball.bounds.size.height);
    
    if (style == kSwitchStyleBall) {
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:Res(@"switch-bg-off.png")]];
        [self insertSubview:bg belowSubview:_ball];
        [bg release];
        UIImageView *bgOn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:Res(@"switch-bg-on.png")]];
        bgOn.frame = CGRectMake(-frame.size.width, 0, frame.size.width, frame.size.height);
        [self insertSubview:bgOn belowSubview:_ball];
        UIImageView *bgOff = [[UIImageView alloc] initWithImage:[UIImage imageNamed:Res(@"switch-bg-off.png")]];
        [self insertSubview:bgOff belowSubview:_ball];
        bgOn.backgroundColor = bgOff.backgroundColor = [UIColor clearColor];
        self.bgOn = bgOn;
        self.bgOff = bgOff;
        [bgOn release];
        [bgOff release];
    }
    else {
        
        float ballWidth = frame.size.height;
        UIImage *onImage = [UIImage imageNamed:@"switch_on.png"];
        _onImageView = [[[UIImageView alloc] initWithImage:onImage] autorelease];
        _onImageView.frame = CGRectMake(ballWidth - frame.size.width, (frame.size.height - onImage.size.height)/2, frame.size.width, frame.size.height);
        [self insertSubview:_onImageView belowSubview:_ball];
        
        UIImage *offImage = [UIImage imageNamed:@"switch_off.png"];
        _offImageView = [[[UIImageView alloc] initWithImage:offImage] autorelease];
        _offImageView.frame = CGRectMake(0, (frame.size.height - offImage.size.height)/2, frame.size.width, frame.size.height);
        [self insertSubview:_offImageView belowSubview:_ball];
    }
    
    [self addSubview:_ball];
    
    _on = YES;
    [self setOn:NO animated:NO];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setOn:self.on animated:NO];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
}

- (void)setOn:(BOOL)on{
    if (_on == on) return;
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated{
    Echo(@"ON:%d",on);
    if (_on == on) return;
    
    _on = on;
    CGRect onRect = _onImageView.frame;
    CGRect offRect = _offImageView.frame;
    CGRect ballFrame = _ball.frame;
    
    float scale = self.transform.a;
    float distance = (self.bounds.size.width - self.bounds.size.height)*scale;
    if (!_on) {  //move left
        onRect.origin.x -= distance;
        offRect.origin.x -= distance;
        ballFrame.origin.x = -1.f;
        
    } else {    //move right
        onRect.origin.x += distance;
        offRect.origin.x += distance;
        ballFrame.origin.x = (self.bounds.size.width*scale - ballFrame.size.width + 2.f);
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animated ? .2f : 0.f];
    _onImageView.frame = onRect;
    _offImageView.frame = offRect;
    
    _ball.frame = ballFrame;
    
    _bgOff.frame = CGRectMake(on ? self.bounds.size.width : 0, 0, self.bounds.size.width, self.bounds.size.height);
    _bgOn.frame = CGRectMake(on ? 0 : -self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    [UIView commitAnimations];
    
}

- (void)tap{
    BOOL on = !self.on;
    [self setOn:on animated:YES];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setLeftLbl:(UILabel *)leftLbl{
    _leftLbl = leftLbl;
    leftLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [leftLbl addGestureRecognizer:g];
}

- (void)setRightLbl:(UILabel *)rightLbl{
    _rightLbl = rightLbl;
    rightLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [rightLbl addGestureRecognizer:g];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 float r = rect.size.height/2;
 [[UIColor orangeColor] set];
 CGContextRef c = UIGraphicsGetCurrentContext();
 CGContextAddArc(c, r, r, r, M_PI_2, 3*M_PI/2, 0);
 CGContextAddArc(c, r, r, r, 0, 2*M_PI, 1);
 CGContextClip(c);
 CGContextFillPath(c);
 }
 */

#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    BOOL on = !self.on;
    //    [self setOn:on animated:YES];
    //    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self tap];
}

@end



@implementation BallSwitch

- (void)awakeFromNib{
    self.style = kSwitchStyleBall;
    [self setup];
}

@end

@implementation OnOffSwitch

- (void)awakeFromNib{
    self.style = kSwitchStyleOnOff;
    [self setup];
}

@end


@implementation ModeSwitch

- (void)setup{
    [super setup];
    UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 28, 20)];
    yuan.text = @"元";
    _yuanLbl = yuan;
    [self addSubview:yuan];
    
    UILabel *jiao = [[UILabel alloc] initWithFrame:CGRectMake(25, 3, 28, 20)];
    jiao.text = @"角";
    _jiaoLbl = jiao;
    [self addSubview:jiao];
    
    [(UIImageView *)self.bgOn setImage:ResImage(@"switch-bg-on.png")];
    [(UIImageView *)self.bgOff setImage:ResImage(@"switch-bg-on.png")];
    
    jiao.font =
    yuan.font = [UIFont systemFontOfSize:12.f];
    jiao.textAlignment =
    yuan.textAlignment = NSTextAlignmentCenter;
    yuan.textColor =
    jiao.textColor = [UIColor whiteColor];
    jiao.backgroundColor =
    yuan.backgroundColor = [UIColor clearColor];
    yuan.highlightedTextColor =
    jiao.highlightedTextColor = [UIColor darkGrayColor];

}

- (void)setOn:(BOOL)on animated:(BOOL)animated{
    Echo(@"ON:%d",on);
    if (_on == on) return;
    
    _on = on;
    CGRect onRect = _onImageView.frame;
    CGRect offRect = _offImageView.frame;
    CGRect ballFrame = _ball.frame;
    
    float scale = self.transform.a;
    float distance = (self.bounds.size.width - self.bounds.size.height)*scale;
    if (_on) {  //move left
        onRect.origin.x -= distance;
        offRect.origin.x -= distance;
        ballFrame.origin.x = -1.f;

    } else {    //move right
        onRect.origin.x += distance;
        offRect.origin.x += distance;
        ballFrame.origin.x = (self.bounds.size.width*scale - ballFrame.size.width + 2.f);
    }
    
    if(animated){
        [UIView animateWithDuration:animated ? .2f : 0.f animations:^{
            _onImageView.frame = onRect;
            _offImageView.frame = offRect;
            _ball.frame = ballFrame;
        } completion:^(BOOL finished) {
            _yuanLbl.highlighted = on;
            _jiaoLbl.highlighted = !on;
        }];
        
    } else {
        _onImageView.frame = onRect;
        _offImageView.frame = offRect;
        _ball.frame = ballFrame;
        _yuanLbl.highlighted = on;
        _jiaoLbl.highlighted = !on;
    }
    
    self.bgOff.frame = CGRectMake(on ? self.bounds.size.width : 0, 0, self.bounds.size.width, self.bounds.size.height);
    self.bgOn.frame = CGRectMake(on ? 0 : -self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    
}

@end