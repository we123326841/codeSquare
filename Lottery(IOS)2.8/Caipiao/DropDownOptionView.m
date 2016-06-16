//
//  DropDownOptionView.m
//  Caipiao
//
//  Created by danal-rich on 13-11-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "DropDownOptionView.h"

@implementation DropDownOptionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _textLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 15, frame.size.height- 10)];
        _textLbl.textAlignment = UITextAlignmentCenter;
        _textLbl.backgroundColor = [UIColor clearColor];
        _textLbl.font = [UIFont systemFontOfSize:10.f];
        _textLbl.textColor = [UIColor whiteColor];
        [self addSubview:_textLbl];
        [_textLbl release];
        
        _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 15, 5, 10, _textLbl.bounds.size.height)];
        _rightView.contentMode = UIViewContentModeScaleAspectFit;
        _rightView.image = [UIImage imageNamed:@"ico_sj_highyellow.png"];
        [self addSubview:_rightView];
        [_rightView  release];
        
        _selectedIndex = 0;
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

- (void)layoutSubviews{
    [super layoutSubviews];
    [self reloadOptions];
}

- (IBAction)optionSelectAction:(UIButton *)sender{
    int selectedIndex = sender.tag - 10;
    if (_selectedIndex != selectedIndex){
        _selectedIndex = selectedIndex;
        self.textLbl.text  = [self.options objectAtIndex:_selectedIndex];
        [self setOpened:NO];
        
        if (_target && _selector){
            [_target performSelector:_selector withObject:self];
        }
    }
}

#define kRowHeight  32.f

- (void)reloadOptions{
    UIView *parent = self;
    UIView *temp = parent;
    while ((temp = temp.superview)) {
        if ([temp isKindOfClass:[UIWindow class]]){
            break;
        }
        parent = temp;
    }
    CGPoint pos = self.frame.origin;
    pos = [self convertPoint:pos toView:parent];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(pos.x,pos.y + self.bounds.size.height + 0.f,  self.bounds.size.width, kRowHeight * ([self.options count] - 1))];
    view.backgroundColor = kBlackTranslucentColor;
    view.layer.cornerRadius = 2.f;
    [parent addSubview:view];
    [view release];
    _optionView = view;
    _optionView.hidden = YES;
    _optionView.userInteractionEnabled  = NO;
    
    int row = 0;
    for (int i = 0; i < [self.options count]; i++) {
        NSString *title = [self.options objectAtIndex:i];
        if (i == _selectedIndex) {
            self.textLbl.text = title;
            continue;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 10+i;
        button.frame = CGRectMake(0, row*kRowHeight, _optionView.bounds.size.width, kRowHeight);
        button.titleLabel.font = [UIFont systemFontOfSize:10.f];
        button.titleLabel.textColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(optionSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [_optionView addSubview:button];
        row++;
    }
}

- (void)setCallback:(SEL)callback target:(id)target{
    _target = target;
    _selector = callback;
}

static UIView *__mask = NULL;
- (void)setOpened:(BOOL)opened{
    if (_opened == opened) return;
    
    _opened = opened;
    if (!_opened){
        [_optionView removeFromSuperview];
        _optionView = nil;
        if (__mask){
            [__mask removeFromSuperview];
            __mask = NULL;
        }
    } else {
        [self reloadOptions];
        _optionView.hidden = NO;
        _optionView.userInteractionEnabled  = YES;
        UIView *mask = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 2000, 2000)] autorelease];
        [_optionView.superview insertSubview:mask belowSubview:_optionView];
        __mask = mask;
        UIGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [mask addGestureRecognizer:g];
        [g release];
    }

}

- (void)tapAction:(UITapGestureRecognizer *)g{
    [self setOpened:NO];
    for (UIGestureRecognizer *g in __mask.gestureRecognizers){
        [__mask removeGestureRecognizer:g];
    }
    [__mask removeFromSuperview];
    __mask = NULL;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.options count] == 0) return;
    [self setOpened:!_opened];
}

@end


