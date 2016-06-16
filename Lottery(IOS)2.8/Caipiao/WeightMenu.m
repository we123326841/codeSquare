//
//  WeightMenu.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WeightMenu.h"

@implementation WeightMenu
@synthesize delegate = _delegate;
@synthesize weight = _weight;
@synthesize opened = _opened;
@synthesize selectedOptionIndex = _selectedOptionIndex;

- (void)dealloc{
    [_optionButtons release];    _optionButtons = nil;
    [_weight release];  _weight = nil;
    [_optionView release]; _optionView = nil;
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

- (id)initWithFrame:(CGRect)frame weight:(NSString *)weight parentView:(UIView *)parent{
//    frame.size.width += 10.f;
    frame.size.width = 60.f;
    self = [super initWithFrame:frame];
    if (self) {
        _origFrame = frame;
        self.clipsToBounds = YES;
        self.weight = weight;
        self.selectedOptionIndex = -1;
        _optionButtons = [[NSMutableArray alloc] init];
        
        //Translucent background
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.alpha = 0.7f;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        [bgView release];
        
        //option buttons' container
        _optionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, parent.bounds.size.width, frame.size.height)];
        _optionView.backgroundColor = bgView.backgroundColor;
        [self addSubview:_optionView];
        
        //option buttons
//        NSArray *titles = [NSArray arrayWithObjects:@"清",@"双",@"单",@"小",@"大",@"全", nil];
        NSArray *titles = [NSArray arrayWithObjects:@"清",@"双",@"单",@"全",@"小",@"大", nil];

        float w = 28.f, h = 28.f;
        int tag = kWMTagClear;
        for (int i = 0; i < [titles count]; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = tag;   tag++;
            button.showsTouchWhenHighlighted = YES;
            button.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
            button.frame = CGRectMake(_optionView.bounds.size.width - (i+1.5f)*w, 0, w, h);
            [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:Color(@"BetBallNormalColor") forState:UIControlStateNormal];
            [_optionView addSubview:button];
            [_optionButtons addObject:button];
        }
        
        //weight button
        _weightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _weightButton.frame = CGRectMake(0, 0, 50.f, 30.f);
        _weightButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
        _weightButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_weightButton setTitleColor:kDarkGrayTextColor forState:UIControlStateNormal];
        _weightButton.enabled=NO;
        [_weightButton setTitle:weight forState:UIControlStateNormal];
        [self addSubview:_weightButton];
        
        //Responds to tap action
        [_weightButton addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
        _weightButton.showsTouchWhenHighlighted = YES;
        
////#  Arrow
        UIImage *arrowImage = [UIImage imageNamed:@"ico_game_sj"];//@"ico_game_sj2.png"];
        _arrow = [[UIImageView alloc] initWithImage:arrowImage];
        _arrow.frame = CGRectMake(frame.size.width - arrowImage.size.width - 5.f, (frame.size.height - arrowImage.size.height)/2,
                                  arrowImage.size.width, arrowImage.size.height);
        [self addSubview:_arrow];
        
    }
    return self;
}

- (void)setWeight:(NSString *)weight{
    [_weight release];
    _weight = [weight copy];
    [_weightButton setTitle:weight forState:UIControlStateNormal];
//    _weightButton.titleLabel.adjustsFontSizeToFitWidth =   YES;
    if ([weight length] > 2){
        _weightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
}

- (void)setEnabled:(BOOL)enabled{
    _enabled = enabled;
    _arrow.hidden = !enabled;
    self.userInteractionEnabled = enabled;
}

- (void)open:(BOOL)animated{
    CGRect frame = self.frame;
    frame.size.width = self.superview.bounds.size.width;
    if (animated) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.frame = frame;
        [UIView commitAnimations];
    } else {
        
        self.frame = frame;
    }
    _optionView.backgroundColor = [UIColor clearColor];
    _opened = YES;
    _arrow.transform = CGAffineTransformMakeScale(-1, 1);
}

- (void)close:(BOOL)animated{
    if (animated) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.frame = _origFrame;
        [UIView commitAnimations];
    } else {
        self.frame = _origFrame;
    }
    _opened = NO;
    _optionView.backgroundColor = [UIColor clearColor];
//    _arrow.frame = CGRectMake(self.frame.size.width - _arrow.frame.size.width -5.f, (self.frame.size.height - _arrow.frame.size.height)/2,
//                              _arrow.frame.size.width, _arrow.frame.size.height);
    _arrow.transform = CGAffineTransformMakeScale(1, 1);
}

- (void)toggle:(id)sender{
    if (_opened) {
        [self close:YES];
    } else {
        [self open:YES];
        FLEvent(kFLEventWeightMenu);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(weightMenuDidWeightButtonClick:)]) {
        [_delegate weightMenuDidWeightButtonClick:self];
    }
}

- (void)buttonAction:(UIButton *)sender{
    if (_selectedOptionIndex != -1) {
        UIButton *button = [_optionButtons objectAtIndex:_selectedOptionIndex];
        [button setTitleColor:Color(@"BetBallNormalColor") forState:UIControlStateNormal];
        [button setBackgroundImage:ResImage(@"") forState:UIControlStateNormal];
    }
    [sender setTitleColor:kDarkGrayTextColor forState:UIControlStateNormal];
    [sender setBackgroundImage:ResImage(@"weight_menu_selected.png") forState:UIControlStateNormal];
    self.selectedOptionIndex = sender.tag;
    if (self.delegate) {
        [self.delegate weightMenuDidOptionButtonClick:sender.tag];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    //总是打开
    [self open:NO];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef c = UIGraphicsGetCurrentContext();
//    CGContextAddRect(c, CGRectMake(10, 10, 20, 20));
//    CGContextSetFillColorWithColor(c, [UIColor whiteColor].CGColor);
//    CGContextFillPath(c);
//}


@end
