//
//  BlockAlertView.m
//  WeiboFun
//
//  Created by luo danal on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSBlockAlertView.h"

@implementation MSBlockAlertView

- (void)dealloc{
    Block_release(_clickBlock);
    self.userData = nil;
    self.delegate = nil;
    [super dealloc];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil];
    if (self){
        va_list arg;
        va_start(arg, otherButtonTitles);
        NSString *buttonTitle = nil;
        while ((buttonTitle = va_arg(arg, NSString*))) {
            [self addButtonWithTitle:buttonTitle];
        }
        va_end(arg);
    }
    return self;
}

#pragma mark - Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (_clickBlock != NULL) {
        _clickBlock(self, buttonIndex);
        self.clickBlock = nil;
    }
}

@end



@implementation MSBlockActionSheet

- (void)dealloc{
    Block_release(_clickBlock);
    self.userData = nil;
    [super dealloc];
}

- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
    
        if (otherButtonTitles != nil) { //Generally in this case
            va_list apList;
            va_start(apList, otherButtonTitles);
            NSString *ttl = nil;
            while ((ttl = va_arg(apList, NSString*))) {
                [self addButtonWithTitle:ttl];
            }
            if (cancelButtonTitle != nil) {
                [self addButtonWithTitle:cancelButtonTitle];
                [self setCancelButtonIndex:self.numberOfButtons - 1];
            }
            va_end(apList);
        }
        self.delegate = self;
    } 
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitleList:(NSArray *)otherTitleList{
    
    self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
    if (self){
        for (NSString *other in otherTitleList) {
            [self addButtonWithTitle:other];
        }
        if (cancelButtonTitle != nil) {
            [self addButtonWithTitle:cancelButtonTitle];
            [self setCancelButtonIndex:self.numberOfButtons - 1];
        }
        self.delegate = self;
    }
    return self;
}

#pragma mark - delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (_clickBlock != NULL) {
        _clickBlock(self,buttonIndex);
        self.clickBlock = nil;
    }
}

@end


@implementation UIAlertView (Musou)

+ (void)alert:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end