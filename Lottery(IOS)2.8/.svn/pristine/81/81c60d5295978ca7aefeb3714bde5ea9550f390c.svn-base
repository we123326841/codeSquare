//
//  SiteNoticeDetailViewController.m
//  Caipiao
//
//  Created by danal-rich on 3/28/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "SiteNoticeDetailViewController.h"
#import "RQNotice.h"
#import "CDUserInfo.h"

@interface SiteNoticeDetailViewController ()
{

    IBOutlet UILabel *infoL;
}
@end

@implementation SiteNoticeDetailViewController

- (void)dealloc{
    _webView.delegate = nil;
    [_webView stopLoading];
    Block_release(_onSiteNoticeViewed);
    [infoL release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"站内信";
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = NO;
    _webView.dataDetectorTypes = UIDataDetectorTypeLink;
    _webView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)prev:(id)sender{
    NSInteger index = [self.noticeItems indexOfObject:self.curItem];
    if (index > 0){
        self.curItem = self.noticeItems[index-1];
    }
    [self loadData];
}

- (IBAction)next:(id)sender{
    NSInteger index = [self.noticeItems indexOfObject:self.curItem];
    if (index < self.noticeItems.count-1){
        self.curItem = self.noticeItems[index+1];
    }
    [self loadData];
}


- (void)deleteMsg:(id)sender{
    //删除消息
    RQNoticeDelete *request = [[[RQNoticeDelete alloc] init] autorelease];
    request.noticeId = self.curItem.nid;
    [request startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
        
    } sender:nil];
    _onSiteNoticeViewed(self.curItem.nid, YES);
    [self backAction:nil];
}

- (void)prepareToBack{
    if (!_shouldKeep){
        //删除消息
        RQNoticeDelete *request = [[[RQNoticeDelete alloc] init] autorelease];
        request.noticeId = self.curItem.nid;
        [request startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            
        } sender:nil];
         _onSiteNoticeViewed(self.curItem.nid, YES);
    } else {
        _onSiteNoticeViewed(self.curItem.nid, NO);
    }
}

- (void)loadData{
    _shouldKeep = self.curItem.isKeep;
    RQNoticeContent *rq = [[[RQNoticeContent alloc] initWithType:self.type] autorelease];
    rq.nid = self.curItem.nid;
    self.rq  = rq;
    [self.rq startPostWithDelegate:self];
    HUDShowLoading(kStringLoading, nil);
    
    if (!_shouldKeep){
        //删除消息
        RQNoticeDelete *request = [[[RQNoticeDelete alloc] init] autorelease];
        request.noticeId = self.curItem.nid;
        [request startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            
        } sender:nil];
        _onSiteNoticeViewed(self.curItem.nid, YES);
    } else {
        _onSiteNoticeViewed(self.curItem.nid, NO);
    }
}

/*
- (void)layouts{
    RQNoticeContent *notice = (RQNoticeContent *)self.rq;

    
    NSString *strBody = @"<body style='background-color: transparent;color: #ffffff; font-size:14px'>   \
    <div style='text-align:center; font-size:17px; font-weight:bold; height:40px; line-height:40px;'><font color='#999999'>%@</font></div>   \
    <div style='text-indent:2em;'><font color=#999999>%@</font></div>  \
    </body>";
    strBody = [NSString stringWithFormat:strBody, notice.subject, notice.content];
    
    [_webView loadHTMLString:strBody baseURL:nil];
}
*/

- (void)layouts{
    for (UIView *v in _wrapView.subviews){
        [v removeFromSuperview];
    }
    
    RQNoticeContent *notice = (RQNoticeContent *)self.rq;
    NSString * title = notice.subject;          //[data objectForKey:@"title"];
    NSString * content = notice.content;        //[data objectForKey:@"content"];
    NSString * dateTime = notice.time;          //[data objectForKey:@"dateTime"];
    NSString * author = @"";    //[data objectForKey:@"author"];
    int isNew = 0;              //[[data objectForKey:@"isNew"] intValue];
    
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    {
        scrollView.frame = self.view.bounds;
        scrollView.scrollEnabled = NO;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    
    //title
    UILabel* lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 20.f, 260.f, 20.f)];
    {
        UIFont* titleFont = [UIFont systemFontOfSize:16];
        lbltitle.backgroundColor = [UIColor clearColor];
        lbltitle.textColor = [UIColor darkGrayColor];
        lbltitle.textAlignment = NSTextAlignmentLeft;
        lbltitle.text = title;
        lbltitle.font = titleFont;
        
        CGSize maxSize = CGSizeMake(300.f, 20.f*2);
        CGSize labelSize = [title sizeWithFont:titleFont constrainedToSize:maxSize lineBreakMode: UILineBreakModeCharacterWrap];
        lbltitle.numberOfLines = 0;// 不可少Label属性之一
        lbltitle.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
        
        lbltitle.frame = CGRectMake(10.f, 20.f, labelSize.width, labelSize.height);
        //[_wrapView addSubview:lbltitle];
        [scrollView addSubview:lbltitle];
        [lbltitle release];
        
        float isNew_x = lbltitle.frame.origin.x + lbltitle.frame.size.width;
        if (isNew == 1)
        {
            float isNew_width = 24.f;
            UIImageView* newImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_new.png"]];
            newImageView.frame = CGRectMake(isNew_x + 6.f, 8.f, isNew_width, 10.f);
            //[_wrapView addSubview:newImageView];
            [scrollView addSubview:newImageView];
            [newImageView release];
        }
    }
    
    
    //author datetime
    float author_y = lbltitle.frame.origin.y + lbltitle.frame.size.height;
    {
        float label_author_width = 30.f;
        CGRect frame = CGRectMake(10.f,author_y, label_author_width, 20.f);
        UILabel* label = [[UILabel alloc] initWithFrame:frame];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor yellowColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:11.0];
        label.text = author;
        //[_wrapView addSubview:label];
        [scrollView addSubview:label];
        [label release];
        
        //        float dateTime_x = label.frame.origin.x + label.frame.size.width;
        
        float label_datetime_width = 150.f;
        CGRect dateTimeframe = CGRectMake(10.f, author_y, label_datetime_width, 20.f);
        UILabel* lbldatetime = [[UILabel alloc] initWithFrame:dateTimeframe];
        lbldatetime.backgroundColor = [UIColor clearColor];
        lbldatetime.textColor = [UIColor darkGrayColor];
        lbldatetime.textAlignment = NSTextAlignmentLeft;
        lbldatetime.font = [UIFont systemFontOfSize:11.0];
        lbldatetime.text = dateTime;
        //[_wrapView addSubview:lbldatetime];
        [scrollView addSubview:lbldatetime];
        
        [lbldatetime release];
    }
    
    // line
    float line_y = lbltitle.frame.origin.y + lbltitle.frame.size.height + 25.f;
    {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:ResImage(@"cell_line.png")];
        //[_wrapView addSubview:imageView];
        imageView.frame =CGRectMake(10.f, line_y, 300.f, 1.f);
        [scrollView addSubview:imageView];
        [imageView release];
    }
    
    NSString *pattern = @"http://[0-9a-z\\-\\.]*";
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [reg matchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, [content length])];
    for (int i = [matches count] - 1; i >= 0; i--) {
        NSTextCheckingResult *rs = [matches objectAtIndex:i];
        NSString *link = [content substringWithRange:rs.range];
        NSLog(@"%@", link);
        content = [content stringByReplacingCharactersInRange:rs.range withString:[NSString stringWithFormat:@"<a>%@</a>",link]];
    }
    [_wrapView addSubview:scrollView];
    [scrollView release];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(5.f, lbltitle.frame.origin.y + lbltitle.frame.size.height + 30.f, 310.f, self.view.bounds.size.height - 20.f - 20.f - 20.f - 10.f)];
    _webView = webView;
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    webView.dataDetectorTypes = UIDataDetectorTypeLink;
    webView.delegate = self;
    [_wrapView insertSubview:webView aboveSubview:scrollView];
    [webView release];
    
    NSString *strBody = @"<body style='background-color: transparent; color: #999999; font-size:14px;'><div style='width:%.0fpx; word-break: break-all;'>%@</div></body>";
    strBody = [NSString stringWithFormat:strBody, webView.bounds.size.width-24.f, notice.content];
    
    [webView loadHTMLString:strBody baseURL:nil];
    
    CGRect infoFrame = infoL.frame;
    infoFrame.origin.y = self.view.bounds.size.height - 30;
    infoL.frame = infoFrame;
    
}

#pragma mark - RQDelegate
- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQNoticeContent *)rq error:(NSError *)error{
    HUDHide();
    if (_shouldKeep){
        UIButton *button = [UIButton barButtonWithTitle:@"删除"];
        [button addTarget:self action:@selector(deleteMsg:) forControlEvents:UIControlEventTouchUpInside];
        [self setRightBarButton:button];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    CGRect rect = self.header.frame;
    rect.origin.y = -100.f;
    self.header.state = kPRStateNormal;
    [UIView animateWithDuration:.3f animations:^{
        self.header.frame = rect;
        
    } completion:^(BOOL finished) {
        
        if (error) {
            
        } else if([rq.msgContent length] > 0){
            HUDShowMessage(rq.msgContent, nil);
            
        } else {    //success
//            rq.subject = @"这是标题";
//            rq.content = @"这是内容啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊";
            [self layouts];
            
            CDUserInfo *u = [CDUserInfo user];
            [u setUnread:[NSNumber numberWithInteger:rq.unread]];
            [u save];
            
            MSNotificationCenterPost(kNotificationUserInfoUpdated);
        }
    }];
}

- (void)viewDidUnload {
    [infoL release];
    infoL = nil;
    [super viewDidUnload];
}
@end
