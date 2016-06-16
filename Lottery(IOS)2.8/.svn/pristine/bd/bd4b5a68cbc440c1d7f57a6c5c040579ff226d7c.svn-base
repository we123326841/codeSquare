//
//  IconInputTextField.m
//  Caipiao
//
//  Created by danal on 13-1-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "IconInputTextField.h"

#define kIconWidth 28.f

@implementation IconInputTextField
@synthesize delegate = _delegate;
@synthesize textField = _textField;
@synthesize leftImage,rightImage;
@synthesize rightIcon = _rightIcon;

- (void)dealloc{
    [_bgView release];
    [_leftIcon release];
//    [_rightIcon release];
    [_textField release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        float mar = 5.f;
        _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.layer.cornerRadius = 5.f;
        [self addSubview:_bgView];
        
        _leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(mar, (frame.size.height - kIconWidth)/2, kIconWidth, kIconWidth)];
        _leftIcon.contentMode = UIViewContentModeCenter;
        _leftIcon.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_leftIcon];
        
        _rightIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightIcon.frame = CGRectMake(frame.size.width - 2*mar - kIconWidth, (frame.size.height - kIconWidth)/2, kIconWidth, kIconWidth);
        _rightIcon.autoresizingMask = _leftIcon.autoresizingMask;
        [_rightIcon addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_rightIcon];
        _rightIcon.hidden = YES;
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(2*mar + kIconWidth, mar,
                                                                  frame.size.width - 4*mar - 2*kIconWidth,
                                                                  frame.size.height - 2*mar)];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        _textField.font = [UIFont boldSystemFontOfSize:15.f];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.textColor = kYellowTextColor;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
    }
    return self;
}

- (void)setLeftImage:(UIImage *)leftImage_{
    _leftIcon.image = leftImage_;
}

- (void)setRightImage:(UIImage *)rightImage_{
    [_rightIcon setImage:rightImage_ forState:UIControlStateNormal];
}

- (void)rightAction:(id)sender{
    if ([_textField.text length] > 0) {
        _textField.text = @"";  //[_textField.text substringToIndex:[_textField.text length] - 1];
    }
    _rightIcon.hidden = [_textField.text length] == 0;
    if (_delegate && [_delegate respondsToSelector:@selector(iconInputTextFieldTextChanged:)]) {
        [_delegate iconInputTextFieldTextChanged:self];
    }
}
- (void)textChanged:(UITextField *)sender{
    _rightIcon.hidden = [_textField.text length] == 0;
    if (_delegate && [_delegate respondsToSelector:@selector(iconInputTextFieldTextChanged:)]) {
        [_delegate iconInputTextFieldTextChanged:self];
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
#pragma mark - 

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

@end
