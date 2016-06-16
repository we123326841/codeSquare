//
//  MSUIViewController+Additions.m
//  Musou
//
//  Created by luo danal on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUIViewController+Additions.h"


@implementation UIViewController (Musou)

+ (UIInterfaceOrientation)statusBarOrientation{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

+ (id)sharedApplication{
    return [UIApplication sharedApplication];
}

- (void)postNotificationName:(NSString *)name object:(id)obj{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
}

- (id)viewByTag:(NSInteger)tag{
    return (id)[self.view viewWithTag:tag];
}

#define kFlipDuration 0.7f
- (void)flipPopViewControllerWithView:(UIView *)theView{
    [UIView transitionWithView:theView 
                      duration:kFlipDuration 
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.navigationController popViewControllerAnimated:NO];
                    } 
                    completion:^(BOOL finished){
                    }];
 
}

- (void)flipPushViewController:(UIViewController *)vc withView:(UIView *)theView{
    [UIView transitionWithView:theView 
                      duration:kFlipDuration
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController pushViewController:vc animated:NO];
                    } 
                    completion:^(BOOL finished){
                    }];
}

#pragma mark - Keyboard
- (void)addKeyboardObserver{
    [self removeKeyboardObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (CGRect)keyboardAccessoryViewOrigFrame{
    return CGRectZero;
}

- (UIView *)keyboardAccessoryView{
    return nil;
}

- (void)keyboardDidShowComplete:(CGRect)keyboardFrame{
}

- (void)keyboardDidHideComplete:(CGRect)keyboardFrame{
}

- (void)_keyboardShow:(NSNotification *)noti{
    UIView *kav  = [self keyboardAccessoryView];
    NSValue *value = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    
    CGRect frame = kav.frame;
    frame.origin.y = self.view.bounds.size.height - keyboardRect.size.height - frame.size.height;
    
    [UIView animateWithDuration:.25f animations:^{
        kav.frame = frame;
    } completion:^(BOOL b){
        
        /*        // locate keyboard view
         UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
         UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
         doneButton.frame = CGRectMake(0, tempWindow.bounds.size.height - 53, 106, 53);
         doneButton.tag = 0xf1f1;
         doneButton.adjustsImageWhenHighlighted = NO;
         //        [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
         //        [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
         doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
         [doneButton setTitle:@"完成" forState:UIControlStateNormal];
         [doneButton setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"keyboard_tile.png"]] forState:UIControlStateNormal];
         [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
         [tempWindow addSubview:doneButton];
         */
        
        [self keyboardDidShowComplete:keyboardRect];
        
    }];
    
    
}

- (void)_keyboardHide:(NSNotification *)noti{
    NSValue *value = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    
    UIView *kav  = [self keyboardAccessoryView];
    [UIView animateWithDuration:.25f animations:^{
        kav.frame = [self keyboardAccessoryViewOrigFrame];
    } completion:^(BOOL finished) {
        
        [self keyboardDidHideComplete:keyboardRect];
    }];
    
}

@end
