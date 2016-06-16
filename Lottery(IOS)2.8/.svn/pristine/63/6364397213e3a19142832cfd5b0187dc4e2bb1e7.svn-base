//
//  NSHTTPRequestOperation.m
//  Musou
//
//  Created by luo danal on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSHTTPRequestOperation.h"

@implementation MSHTTPRequestOperation
@synthesize index = _index;
@synthesize url = _url;
@synthesize request = _request;

- (void)dealloc{
    [_url release];
    _url = nil;
    [_request release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        _request = [[MSHTTPRequest alloc] initWithDelegate:self];
        _request.enableTraceLog = YES;
    }
    return self;
}

- (void)main{
    [_request start];
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    } while (!_done);
}

- (void)setUrl:(NSString *)url{
    _request.URL = [NSURL URLWithString:url];
}

#pragma mark - MSHTTPRequestDelegate
- (void)requestDidFinishLoading:(MSHTTPRequest *)req{
    _done = YES;
}

- (void)requestDidFailWithError:(NSError *)error{
    _done = YES;
}
@end
