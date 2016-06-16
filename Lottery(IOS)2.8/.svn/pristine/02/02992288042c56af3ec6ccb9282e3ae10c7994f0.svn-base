//
//  MSUIViewController+Additions.h
//  Musou
//
//  Created by luo danal on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Musou)

+ (UIInterfaceOrientation)statusBarOrientation;

+ (id)sharedApplication;

- (void)postNotificationName:(NSString *)name object:(id)obj;

- (id)viewByTag:(NSInteger)tag;

- (void)flipPopViewControllerWithView:(UIView *)theView;

- (void)flipPushViewController:(UIViewController *)vc withView:(UIView *)theView;

//Keyboard helper
- (void)addKeyboardObserver;
- (void)removeKeyboardObserver;

/**
 * @return The keyboard accessory view
 */
- (UIView *)keyboardAccessoryView;

/**
 *@return The original frame of the keyboard accessory view
 */
- (CGRect)keyboardAccessoryViewOrigFrame;

//Callbacks after keyboard show or hide
- (void)keyboardDidShowComplete:(CGRect)keyboardFrame;
- (void)keyboardDidHideComplete:(CGRect)keyboardFrame;


@end
