//
//  RQBase.m
//  Caipiao
//
//  Created by danal on 13-2-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "SharedModel.h"
#import "Reachability.h"
#import "LoadingAlertView.h"
#import "AppDelegate.h"


static NSString *aesKey = nil;
static NSString *aesIV = nil;
static NSString *app_id = @"9";


@interface RQBase ()
@property (strong, nonatomic) MSHTTPRequest *request;
@property (nonatomic) BOOL finished;
@end

@implementation RQBase
@synthesize request = _request;
@synthesize url = _url;
@synthesize requestParams = _requestParams;
@synthesize delegate = _delegate;
@synthesize completeBlock = _completeBlock;
@synthesize requestSender = _requestSender;
@synthesize debug = _debug;
@synthesize silent = _silent;

@synthesize msgType = _msgType;
@synthesize msgContent = _msgContent;

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"-[%@ dealloc]", NSStringFromClass([self class]));
#endif
    _request.delegate = nil;
    [_request cancel];
    self.request = nil;
    
    self.completeBlock = NULL;
    self.requestSender = nil;
    self.requestParams = nil;
    self.msgContent = nil;
    
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        _request = [[MSHTTPRequest alloc] initWithDelegate:self];
        _requestParams = [[NSMutableDictionary alloc] init];
        _request.parseJson = NO;
        self.msgContent = nil;
    }
    return self;
}

- (void)prepare{
    //Url
    _request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.url,app_id]];
    //    _request.URL = [NSURL URLWithString:self.url];
    
    //New api
    aesKey = kAESKey;   //[[@"a" dataUsingEncoding:NSUTF8StringEncoding] md5];
    aesIV = kAESIV;
    
    //已登录时要带入token
    if ([[SharedModel shared].token length] > 0) {
        [self.requestParams setObject:[SharedModel shared].token forKey:@"CGISESSID"];
    }
    //把所有参数放入dictionay,并转换成Json
    NSData *postData = [NSJSONSerialization dataWithJSONObject:self.requestParams options:NSJSONWritingPrettyPrinted error:nil];
    NSString *reqStr =[[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding]autorelease];
    NSData *reqData = [reqStr dataUsingEncoding:NSUTF8StringEncoding];
    //加密
    NSData *reqDataAES = [reqData AES128EncryptWithKey:aesKey AndIV:aesIV];
    //传入到content字段
    [_request addValue:[reqDataAES hexadecimalString] forField:@"content"];
    
    NSHTTPCookieStorage *st = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *ck in st.cookies){
        [st deleteCookie:ck];
    }
#ifdef DEBUG
    NSLog(@"\nStart %@ [%@]\n%@\n\n",[self class], _request.URL, self.requestParams);
#endif
}

- (void)setValue:(id)value forField:(NSString *)field{
    [self setPostValue:value forField:field];
}

- (void)setPostValue:(id)value forField:(NSString *)field{
    if (value == nil || [value isKindOfClass:[NSError class]]) {
        value = @"";
    }
    [self.requestParams setObject:value forKey:field];
}

- (void)setGetValue:(id)value forField:(NSString *)field{
    NSString *param = [NSString stringWithFormat:@"%@=%@",field,value];
    if ([self.url rangeOfString:param].length > 0) {
        //param exists, ignore it
        return;
    }
    
    NSMutableString *url = [NSMutableString stringWithString:self.url];
    if ([url rangeOfString:@"?"].length == 0) {
        [url appendString:@"?"];
    }
    [url appendFormat:@"&%@",param];
    self.url = url;
}

- (void)setDebug:(BOOL)debug{
    _debug = debug;
    if ([self.url length] > 0) {
        NSString *url = [NSString stringWithString:self.url];
        NSRange range = [self.url rangeOfString:@"debug=1"];
        if (debug) {
            if (range.length == 0) {
                url = [url stringByAppendingString:@"&debug=1"];
                self.url = url;
            }
        } else {
            if (range.length > 0) {
                url = [url stringByReplacingOccurrencesOfString:@"debug=1" withString:@""];
                self.url = url;
            }
        }
    }
}

- (void)loop{
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    } while (!_finished);
}

- (void)startRequest:(BOOL)post{
    self.msgType = -1;
    self.msgContent = nil;
    [self prepare];
    _request.postMethod = post;
    [_request start];
    
    [self performSelectorInBackground:@selector(loop) withObject:nil];
}

- (NSInteger)startGetWithDelegate:(id<RQBaseDelegate>)delegate{
    self.mark = (NSInteger)self;
    self.delegate = delegate;
    [self startRequest:NO];
    return self.mark;
}

- (NSInteger)startPostWithDelegate:(id<RQBaseDelegate>)delegate{
    self.mark = (NSInteger)self;
    self.delegate = delegate;
    [self startRequest:YES];
    return self.mark;
}

- (void)startGetWithBlock:(void (^)(id, NSError *, id))block sender:(id)rqSender{
    self.completeBlock = block;
    [self startRequest:NO];
}

- (void)startPostWithBlock:(void (^)(id, NSError *, id))block sender:(id)rqSender{
    self.completeBlock = block;
    [self startRequest:YES];
}

- (void)cancel{
    self.request.delegate = nil;
    [self.request cancel];
}

- (BOOL)shouldDirectlyParse{
    return NO;
}

- (void)parse:(id)result{
    Echo(@"Override this method %s to parse the result data", __func__);
}

+ (BOOL)networkIsOK{
    if (![[Reachability reachabilityForInternetConnection] isReachable]) {
        [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:NSLocalizedString(@"Network error", nil) subtitle:nil];
        return NO;
    }
    return YES;
}

#pragma mark - MSHTTPRequestDelegate

- (void)requestDidStartLoading:(MSHTTPRequest *)req{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRQStart:)]) {
        [self.delegate onRQStart:self];
    }
}

- (void)requestDidFailWithError:(NSError *)error{
#ifdef DEBUG
    NSLog(@"%@",error);
#endif
    self.msgContent = NSLocalizedString(@"Network error", nil);
    if (!_silent) {
        [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:NSLocalizedString(@"Network error", nil) subtitle:nil];
    }
    //Using delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRQComplete:error:)]) {
        [self.delegate onRQComplete:self error:error];
    }
    //Using block
    else if (_completeBlock != NULL) {
        _completeBlock(self, error, _requestSender);
    }
    
    _finished = YES;
}

- (void)requestDidFinishLoading:(MSHTTPRequest *)req{
    id json = nil;
    NSError *error = nil;
    
    NSString *resDataAES = [[NSString alloc] initWithData:req.data encoding:NSUTF8StringEncoding];
    @try {
        NSData *resData = [[NSData dataWithHexString:resDataAES] AES128DecryptWithKey:aesKey AndIV:aesIV];
        NSString *str1 = [[NSString alloc] initWithData:resData encoding:NSUTF8StringEncoding];
        NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"\0" withString:@""];
        NSData *resData2 = [str2 dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:resData2 options:kNilOptions error:&error];
        json = resultJSON;
    }
    @catch (NSException *exception) {
        error = [NSError errorWithDomain:NSCocoaErrorDomain
                                    code:-2
                                userInfo:@{@"error":exception.description}];
        json = [[NSString alloc] initWithData:req.data encoding:NSUTF8StringEncoding];
    }
    @finally {
        
    }
    
#ifdef DEBUG
    NSLog(@"\n\n%@ | %@\n\n", self.class, json);
#endif
    
    if ([self shouldDirectlyParse]){
        [self parse:json];
    }
    else if ([json isKindOfClass:[NSDictionary class]] ||
             [json isKindOfClass:[NSArray class]]) {
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            //Parse message content
            NSString *msgType = [json objectForKey:@"messagetype"];
            NSString *msgContent = [json objectForKey:@"content"];
            if (msgType && msgContent) {
                self.msgType = [msgType intValue];
                self.msgContent = msgContent;
                Echo(@"%@",msgContent);
                if (self.msgType == kMessageTypeSessionExpired){
                    //Back to login view
                    [[AppDelegate shared] backToLogin];
                }
                
            } else {
                //Parse the result
                [self parse:json];
            }
        }
        else {  //Parse as array
            [self parse:json];
        }
        
    }
    else {    //Non-dictionay or Non-array
        error = [NSError errorWithDomain:NSCocoaErrorDomain
                                    code:-1
                                userInfo:@{@"error":@"Bad Json data!"}];
    }
    
#ifdef DEBUG
    //    if (error) {
    //        NSString *str = [[[NSString alloc] initWithData:req.data encoding:NSUTF8StringEncoding] autorelease_];
    //        Echo(@"ERROR on %@: %@",[self class], str);
    //    }
#endif
    
    //Using delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(onRQComplete:error:)]) {
        [self.delegate onRQComplete:self error:error];
    }
    
    //Using block
    else if (_completeBlock != NULL) {
        _completeBlock(self, error, _requestSender);
    }
    self.completeBlock = nil;
    _finished = YES;
}

@end
