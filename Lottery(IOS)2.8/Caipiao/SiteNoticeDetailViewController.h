//
//  SiteNoticeDetailViewController.h
//  Caipiao
//
//  Created by danal-rich on 3/28/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "InfoCenterDetail.h"

@interface SiteNoticeDetailViewController : InfoCenterDetail
{
    IBOutlet UIWebView *_webView;
}
@property (copy, nonatomic) void(^onSiteNoticeViewed)(NSInteger noticeId, BOOL deleted);
@property (nonatomic) BOOL shouldKeep;

- (IBAction)prev:(id)sender;
- (IBAction)next:(id)sender;

@end
