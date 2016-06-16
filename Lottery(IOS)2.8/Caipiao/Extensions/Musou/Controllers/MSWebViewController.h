//
//  MSWebViewController.h
//  Musou
//
//  Created by luo danal on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@protocol MSWebViewControllerDelegate;

@interface MSWebViewController : BaseViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    UIActivityIndicatorView *_indicator;
}
@property (assign, nonatomic) id<MSWebViewControllerDelegate>delegate;
@property (retain, nonatomic) UIWebView *webView;
@property (retain, nonatomic) NSString *url;

- (void)loadLink:(NSString *)url;

@end


@protocol MSWebViewControllerDelegate <NSObject>

@optional
- (BOOL)mswebView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

- (void)mswebView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end