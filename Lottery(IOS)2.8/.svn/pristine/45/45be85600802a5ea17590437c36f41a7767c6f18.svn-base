//
//  DropDownBox.m
//  Caipiao
//
//  Created by danal on 13-5-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DropDownBox.h"

@implementation DropDownBox
@synthesize titleLbl = _titleLbl;
@synthesize delegate = _delegate;
@synthesize titleList = _titleList;
@synthesize picker = _picker;
@synthesize highlightColor = _highlightColor;
@synthesize background = _background;
@synthesize rightView = _rightView;

- (void)dealloc{
    [_oldTitle release];
    [_highlightColor release];
    [_titleList release];
    [_pickerView release];
    [super dealloc];
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

- (void)setup{
    CGRect frame = self.frame;
//    self.layer.cornerRadius = frame.size.height/2;
//    self.layer.borderWidth = 1.f;
//    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.clipsToBounds = YES;
    
    [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.bounds];
    bg.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self insertSubview:bg atIndex:0];
    self.background = bg;
    [bg release];
    
    self.highlightColor = [UIColor lightGrayColor];
    self.titleList = [NSArray arrayWithObjects:@"row1",@"row2",@"row3", nil];
    
    float mar = 10.f;
    
    UIFont *ft = [UIFont boldSystemFontOfSize:14.f];
    _titleLbl = [[UILabel alloc] initWithFrame:
                 CGRectMake(mar, (frame.size.height - ft.lineHeight)/2 + 1,
                            frame.size.width - 10 - 2*mar, ft.lineHeight)];
    _titleLbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
    _titleLbl.font = ft;
    _titleLbl.backgroundColor = [UIColor clearColor];
    _titleLbl.text = @"DropDownBox";
    [self addSubview:_titleLbl];
    [_titleLbl release];
    
    float w = 10.f;
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 10 - w, (frame.size.height - w)/2, w, w)];
    _rightView.contentMode = UIViewContentModeScaleAspectFit;
    _rightView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    _rightView.image = [UIImage imageNamed:@"arrow_down"];
    [self addSubview:_rightView];
    [_rightView release];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Actions

- (void)adjustToFit{
    CGSize size = [self.titleLbl.text sizeWithFont:self.titleLbl.font];
    
    CGRect frame = self.titleLbl.frame;
//    frame.size.width = size.width;
//    self.titleLbl.frame = frame;
    frame = self.frame;
    frame.size.width = 10*4+size.width;
    self.frame = frame;
}

- (void)prepareFinished{
    [self showPicker];
}

- (IBAction)touchDown:(id)sender{
     [_normalColor release];
//    _normalColor = [[UIColor alloc] initWithCGColor:self.backgroundColor.CGColor];
//    self.backgroundColor = self.highlightColor;
}

- (IBAction)touchUp:(id)sender{
//    self.backgroundColor = _normalColor;
//    [_normalColor release];
//    _normalColor = nil;
    
    //Show picker,if delegate not specified,show the picker
/*    if (_delegate && [_delegate respondsToSelector:@selector(dropDownBoxShouldShowPicker:)]) {
        if([_delegate dropDownBoxShouldShowPicker:self])
            [self showPicker];
    } else {
        [self showPicker];
    }
 */
    //Show picker,if delegate not specified,show the picker
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownBoxShouldShowPicker:)]) {
        if([_delegate dropDownBoxShouldShowPicker:self]){
            if ([_delegate respondsToSelector:@selector(dropDownBoxBeginPrepare:)]) {   //如果实现了些方法，则要调用prepareFinished来显示picker
                [_delegate dropDownBoxBeginPrepare:self];
            } else {
                [self showPicker];
            }
        }
    } else {
        if ([_delegate respondsToSelector:@selector(dropDownBoxBeginPrepare:)]) {   //如果实现了些方法，则要调用prepareFinished来显示picker
            [_delegate dropDownBoxBeginPrepare:self];
        } else {
            [self showPicker];
        }
    }
}

- (void)showPicker{
    if (_pickerView.superview != nil) return;
    
    UIView *parent = [[UIApplication sharedApplication] keyWindow];
    if (_pickerView == nil) {
        _pickerView = [[UIView alloc] initWithFrame:parent.bounds];
        
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, _pickerView.bounds.size.height - 180, 320, 180)];
        picker.showsSelectionIndicator = YES;
        picker.dataSource = self;
        picker.delegate = self;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePicker)];
        [_pickerView addGestureRecognizer:tap];
        [tap release];
        
        [_pickerView addSubview:picker];
        _picker = picker;
        [picker release];
        
        UIImage *image = [UIImage imageNamed:@"green_bar_shadow"];
        UIImageView *toolbar = [[UIImageView alloc] initWithFrame:CGRectMake(0, _pickerView.bounds.size.height - 180 - 44, 320, 44)];
        toolbar.image = image;
        toolbar.userInteractionEnabled = YES;
        [_pickerView addSubview:toolbar];
        [toolbar release];
        
        UIButton *okButton = [UIButton toolButtonWithTitle:@"确定"];
        okButton.frame = CGRectMake(toolbar.bounds.size.width - okButton.bounds.size.width - 20,
                                    (toolbar.bounds.size.height - okButton.bounds.size.height)/2 + 3.f,
                                    okButton.bounds.size.width, okButton.bounds.size.height);
        [okButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:okButton];

    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(dropDownBoxWillShow:)]){
        [_delegate dropDownBoxWillShow:self];
    }
    
    _oldTitle = [self.titleLbl.text copy];
    
    __block CGRect rect = _pickerView.frame;
    rect.origin.y = parent.bounds.size.height;
    _pickerView.frame = rect;
    [parent addSubview:_pickerView];
    
    [UIView animateWithDuration:0.38 animations:^{
        rect.origin.y = 0;
        _pickerView.frame = rect;
    } completion:^(BOOL finished) {
        
        if(_delegate && [_delegate respondsToSelector:@selector(dropDownBoxDidShow:)]){
            [_delegate dropDownBoxDidShow:self];
        }
        
    }];
}

- (void)hidePicker{
    if(_delegate && [_delegate respondsToSelector:@selector(dropDownBoxWillHide:)]){
        [_delegate dropDownBoxWillHide:self];
    }
    
    [_oldTitle release], _oldTitle = nil;
    
    [UIView animateWithDuration:0.38 animations:^{
        CGRect rect = _pickerView.frame;
        rect.origin.y += _pickerView.bounds.size.height;
        _pickerView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        if(_delegate && [_delegate respondsToSelector:@selector(dropDownBoxDidHide:)]){
            [_delegate dropDownBoxDidHide:self];
        }
        
        [_pickerView removeFromSuperview];
    }];
}


- (void)confirm{
    if ([self.titleList count] == 0 ) {
        [self cancel];
        return;
    }
    NSInteger row = [_picker selectedRowInComponent:0];
//    self.titleLbl.text = [self.titleList objectAtIndex:row];
    NSString *title = [self.titleList objectAtIndex:row];
    self.titleLbl.text = title;
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownBox:didSelectTitle:)]) {
        [_delegate dropDownBox:self didSelectTitle:title];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownBox:didSelectAtIndex:)]) {
        [_delegate dropDownBox:self didSelectAtIndex:row];
    }
    [self hidePicker];
}

- (void)cancel{
    self.titleLbl.text = _oldTitle;
    [self hidePicker];
}

#pragma mark - Picker Data & Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    UILabel *myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 30)] autorelease];
    myView.textAlignment = UITextAlignmentCenter;
    myView.text = [self.titleList objectAtIndex:row];
    myView.font = [UIFont boldSystemFontOfSize:14.f];
    myView.backgroundColor = [UIColor clearColor];
    
    return myView;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.titleList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.titleList objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *title = [self.titleList objectAtIndex:row];
    self.titleLbl.text = title;
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownBox:didSelectTitle:)]) {
        [_delegate dropDownBox:self didSelectTitle:title];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownBox:didSelectAtIndex:)]) {
        [_delegate dropDownBox:self didSelectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 300.f;
}

@end



@implementation DropDownBoxBlack

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.titleLbl.textColor = kYellowTextColor;
        self.backgroundColor = [UIColor clearColor];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 31, 1, 31, 28)];
        iv.image = [UIImage imageNamed:@"dropdownbox_element_arrow.png"];
        self.background.image = [UIImage imageNamed:@"input-rect.png"];
        self.rightView.image = iv.image;
        self.rightView.frame = CGRectMake(self.frame.size.width -  self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
        [iv release];
    }
    return self;
}

@end
