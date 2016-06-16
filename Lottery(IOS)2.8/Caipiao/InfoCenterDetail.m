//
//  InfoCenterDetail.m
//  Caipiao
//
//  Created by rod on 13/1/15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "InfoCenterDetail.h"
#import "RCLabel.h"

@interface InfoCenterDetail () <RTLabelDelegate>
{
    UIWebView *_webView;
}
@end

@implementation InfoCenterDetail
@synthesize data;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"公告";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
}

- (void)loadData{
    HUDShowLoading(kStringLoading, nil);
    RQNoticeContent *rq = [[[RQNoticeContent alloc] initWithType:self.type] autorelease];
//    rq.nid = self.noticeId;
    rq.nid = _curItem.nid;
    self.rq  = rq;
    [self.rq startPostWithDelegate:self];
    
}

- (IBAction)prev:(id)sender{
    NSInteger index = [_noticeItems indexOfObject:_curItem];
    if (index > 0){
        _curItem = _noticeItems[index-1];
    }
    [self loadData];
}

- (IBAction)next:(id)sender{
    NSInteger index = [_noticeItems indexOfObject:_curItem];
    if (index < _noticeItems.count-1){
        _curItem = _noticeItems[index+1];
    }
    [self loadData];
}

- (void)layouts{
    for (UIView *v in _wrapView.subviews){
        [v removeFromSuperview];
    }
    
    RQNoticeContent *notice = (RQNoticeContent *)self.rq;
    NSString * title = notice.subject;          //[data objectForKey:@"title"];
    NSString * content = notice.content;        //[data objectForKey:@"content"];
    NSString * dateTime = notice.time;          //[data objectForKey:@"dateTime"];
    NSString * author = [data objectForKey:@"author"];
    int isNew = [[data objectForKey:@"isNew"] intValue];
    
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    {
        scrollView.frame = self.view.bounds;
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
    for (NSInteger i = [matches count] - 1; i >= 0; i--) {
        NSTextCheckingResult *rs = [matches objectAtIndex:i];
        NSString *link = [content substringWithRange:rs.range];
        NSLog(@"%@", link);
        content = [content stringByReplacingCharactersInRange:rs.range withString:[NSString stringWithFormat:@"<a>%@</a>",link]];
    }
    [_wrapView addSubview:scrollView];
    [scrollView release];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(5.f, lbltitle.frame.origin.y + lbltitle.frame.size.height + 30.f, 310.f, self.view.bounds.size.height - 20.f - 20.f - 20.f - 10.f-50)];
    _webView = webView;
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    webView.dataDetectorTypes = UIDataDetectorTypeLink;
    webView.delegate = self;
    webView.scrollView.scrollEnabled=YES;
    [_wrapView addSubview:webView];
    [webView release];
    
    NSString *strBody = @"<body style='background-color: transparent;color: #999999; font-size:14px'>%@</body>";
    strBody = [NSString stringWithFormat:strBody, notice.content];
    
    [webView loadHTMLString:strBody baseURL:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    Echo(@"%s",__func__);
    _webView.delegate = nil;
    [_webView stopLoading];
    [urlLink release];
    [_header release];
    [_textView release];
    [data release];
    self.noticeItems = nil;
    [super dealloc];
}

#pragma mark - RQDelegate
- (void)onRQStart:(RQBase *)rq{
}

- (void)onRQComplete:(RQNoticeContent *)rq error:(NSError *)error{
    HUDHide();
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
//            self.title = rq.subject;
            [self layouts];
        }
    }];
}

#pragma mark  - RCLabelDelegate

- (void)openLink{
    Echo(@"OPEN LINK:%@",urlLink);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlLink]];
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSString *)url{
    //    Echo(@"%s,%@",__func__,url);
    //This method not works
}

- (void)rtLabel:(id)rtLabel didSelectURL:(NSString *)url{
    Echo(@"%s,%@",__func__,url);
    if (urlLink == nil) {
        urlLink = [[NSMutableString alloc] init];
    }
    if ([url hasPrefix:@"http:"]) {
        [urlLink deleteCharactersInRange:NSMakeRange(0, [urlLink length])];
    } else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
    [urlLink appendString:url];
    [self performSelector:@selector(openLink) withObject:nil afterDelay:.2f];
}

#pragma mark - WebView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    if ([url hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}
@end
