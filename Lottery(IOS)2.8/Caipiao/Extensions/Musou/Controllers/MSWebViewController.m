//
//  MSWebViewController.m
//  Musou
//
//  Created by luo danal on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSWebViewController.h"
#import "MSUIColor+Additions.h"
@interface MSWebViewController ()

@end

@implementation MSWebViewController
@synthesize webView = _webView;
@synthesize delegate = _delegate;
@synthesize url = _url;

- (void)dealloc{
    _webView.delegate = nil;
    [_webView release];
    [_indicator release];
    [_url release];
    [super dealloc];
}

- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    [super loadView];
    CGFloat h =0;
    if([self.url containsString:@"slmmc"]){
    self.view.backgroundColor = [UIColor blackColor];
        h=22.0;
    }else{
    self.view.backgroundColor = [UIColor rgbColorWithHex:@"#F1F1F1"];
        h=0;
    }
    CGRect rect = self.view.bounds;
    //CGFloat h = 0;//44.f;
    
    //minus height for navbar & toolbar
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, h, rect.size.width, rect.size.height-h)];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    //_indicator.frame = CGRectMake(10, (h - _indicator.bounds.size.height)/2, _indicator.bounds.size.width, _indicator.bounds.size.height);
    [self.view addSubview:_indicator];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    if (self.url) {
        [self loadLink:self.url];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (void)loadLink:(NSString *)url{
    [self abort:nil];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:req];
    //[self setNavTitle:url];
}

- (IBAction)back:(id)sender{
    if (_webView.canGoBack) {
        [_webView goBack];
    }
}

- (IBAction)forward:(id)sender{
    if (_webView.canGoForward) {
        [_webView goForward];
    }
}

- (IBAction)abort:(id)sender{
    [_webView stopLoading];
}

- (IBAction)done:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - WebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (_delegate && [_delegate respondsToSelector:@selector(mswebView:shouldStartLoadWithRequest:navigationType:)]) {
        return [_delegate mswebView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_indicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_indicator stopAnimating];
    if (_delegate && [_delegate respondsToSelector:@selector(mswebView:didFailLoadWithError:)]) {
        [_delegate mswebView:webView didFailLoadWithError:error];
    }
}

@end
