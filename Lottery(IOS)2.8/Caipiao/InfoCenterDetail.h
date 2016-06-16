//
//  InfoCenterDetail.h
//  Caipiao
//
//  Created by rod on 13/1/15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "RQNotice.h"

@interface InfoCenterDetail : BaseViewController<RQBaseDelegate,UIWebViewDelegate>
{
    UITextView *_textView;
    NSMutableString *urlLink;
    IBOutlet UIView *_wrapView;
}
@property (strong, nonatomic) NSDictionary * data;
@property (strong, nonatomic) NSArray *noticeItems;
@property (assign, nonatomic) NoticeItem *curItem;
@property (assign, nonatomic) NoticeType type;
@property (strong, nonatomic) LoadingView *header;

- (void)loadData;
- (IBAction)prev:(id)sender;
- (IBAction)next:(id)sender;
@end
