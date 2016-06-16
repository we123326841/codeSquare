//
//  LowBetAccessoryView.m
//  Caipiao
//
//  Created by cYrus_c on 14-3-6.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "LowBetAccessoryView.h"

@interface LowBetAccessoryView ()<UITextFieldDelegate>

@end

@implementation LowBetAccessoryView

- (void)dealloc{
    self.numberChangeHandler = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib{
//    [_issueReduceButton addTarget:self action:@selector(reduceIssue:) forControlEvents:UIControlEventTouchUpInside];
//    [_issueIncreaseButton addTarget:self action:@selector(increaseIssue:) forControlEvents:UIControlEventTouchUpInside];
//    [_multipleReduceButton addTarget:self action:@selector(reduceMultiple:) forControlEvents:UIControlEventTouchUpInside];
//    [_multipleIncreaseButton addTarget:self action:@selector(increaseMultiple:) forControlEvents:UIControlEventTouchUpInside];
    _issueTextfield.delegate =
    _multipleTextfield.delegate = self;
    [_issueTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_multipleTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)reduceIssue:(id)sender
{
    int number = [_issueTextfield.text intValue];
    number--;
    _issueTextfield.text = [NSString stringWithFormat:@"%d",number <= 0 ? 0 : number];
}

- (void)increaseIssue:(id)sender
{
    int number = [_issueTextfield.text intValue];
    number++;
    _issueTextfield.text = [NSString stringWithFormat:@"%d",number];
}

- (void)reduceMultiple:(id)sender
{
    int number = [_multipleTextfield.text intValue];
    _multipleTextfield.text = [NSString stringWithFormat:@"%d",number <= 0 ? 1 : number];
}

- (void)increaseMultiple:(id)sender
{
    int number = [_multipleTextfield.text intValue];
    number++;
    _multipleTextfield.text = [NSString stringWithFormat:@"%d",number];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)multiplePlus:(id)sender{
    _multipleTextfield.text = [NSString stringWithFormat:@"%d",[_multipleTextfield.text intValue]+1];
    _numberChangeHandler(self);
}

- (IBAction)multipleMinus:(id)sender{
    _multipleTextfield.text = [NSString stringWithFormat:@"%d",MAX(1, [_multipleTextfield.text intValue]-1)];
    _numberChangeHandler(self);
}

- (IBAction)issuePlus:(id)sender{
    _issueTextfield.text = [NSString stringWithFormat:@"%d",[_issueTextfield.text intValue]+1];
    _numberChangeHandler(self);
}

- (IBAction)issueMinus:(id)sender{
    _issueTextfield.text = [NSString stringWithFormat:@"%d",MAX(0, [_issueTextfield.text intValue]-1)];
    _numberChangeHandler(self);
}


#pragma mark - Text
- (void)textFieldDidChange:(UITextField *)textField{
    _numberChangeHandler(self);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@"0"]) {
        textField.text = nil;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text length] == 0) {
        textField.text = @"1";
    }
}

@end
