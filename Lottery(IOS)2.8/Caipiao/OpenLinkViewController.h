//
//  OpenLinkViewController.h
//  Caipiao
//  链接管理
//  Created by danal-rich on 4/1/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"
@class LinkTabBar;

@interface OpenLinkViewController : BaseViewController <UITextViewDelegate>
{
    IBOutlet LinkTabBar *_bar;
    IBOutlet UITextView *_textView;
    IBOutlet UIButton *_checkButton;
    IBOutlet UIButton *_forwardButton;
}

- (IBAction)checkLinkAction:(id)sender;
- (IBAction)forwardActionl:(id)sender;
@end
