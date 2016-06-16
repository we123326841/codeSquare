//
//  SheetPicker.m
//  
//
//  Created by danal.luo on 7/12/14.
//  Copyright (c) 2014 danal. All rights reserved.
//

#import "SheetPicker.h"

@implementation SheetPicker

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

- (IBAction)confirm{
    if (_confirmBlock){
        _confirmBlock(self, _curRow);
    }
    [self cancel];
}

- (IBAction)cancel{
    [_mask removeFromSuperview];
    CGRect frame = self.frame;
    frame.origin.y = self.superview.bounds.size.height + 64.f;
    [UIView animateWithDuration:.2f animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)parent{
    _curRow = 0;
    
    UIButton *mask = [UIButton buttonWithType:UIButtonTypeCustom];
    [mask addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    mask.frame = parent.bounds;
    mask.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2f];
    [parent addSubview:mask];
    _mask = mask;
    
    CGRect frame = self.frame;
    frame.origin.y = parent.bounds.size.height + 64.f;
    self.frame = frame;
    [parent addSubview:self];
    
    frame.origin.y = parent.bounds.size.height - frame.size.height;
    [UIView animateWithDuration:.2f animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
    [_picker reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.titles.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.titles[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = nil;
    if (view){
        label = (UILabel *)view;
    } else {
        UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40.f)] autorelease];
        lbl.textColor = [UIColor darkGrayColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:17.f];
        label = lbl;
    }
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _curRow = row;
}

@end
