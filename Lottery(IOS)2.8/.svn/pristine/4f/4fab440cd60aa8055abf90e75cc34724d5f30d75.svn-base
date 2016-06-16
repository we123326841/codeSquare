//
//  AutoHideAlertView.h
//  Caipiao
//
//  Created by Cyrus on 13-6-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoHideAlertView : UIAlertView <UIAlertViewDelegate>
{
    NSTimer *_timer;
    UILabel *_textLbl;
}

+ (void)showMessage:(NSString *)msg delayHides:(float)delay;
+ (void)dismissCurrent;

+ (void)showLoading;
- (void)delayHideShow:(float)delay;

@end
