//
//  AuthenticationAlertView.m
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "AuthenticationAlertView.h"

@implementation AuthenticationAlertView



- (IBAction)btnClicked:(id)sender {
    switch ([sender tag]) {
        case 0:
            [self removeFromSuperview];
            break;
        case 1:
            if ([_pwdField.text length] > 0&&[_issueField.text length]>0){
                [HUDView showLoading:self];
                self.completeBlock(self);
            }else {
                NSString *str = @"";
                if (_pwdField.text.length==0) str = @"请输入安全密码";
               else if (_issueField.text.length==0) str = @"请输入安全问题答案";
                [HUDView showMessageToView:KEY_WINDOW msg:str subtitle:nil];

            }
            break;
        default:
            break;
    }
}
- (void)dealloc {
    [_alertL release];
    [_issuseL release];
    [_pwdField release];
    [_issueField release];
    Block_release(_completeBlock);
    [super dealloc];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (void)awakeFromNib
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    
    //Animated show
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 1.f)],
                  nil];
    kfa.duration = .1f;
    kfa.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_contentView.layer addAnimation:kfa forKey:nil];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
