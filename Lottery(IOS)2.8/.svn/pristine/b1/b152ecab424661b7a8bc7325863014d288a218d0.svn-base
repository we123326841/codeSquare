//
//  MSHTTPRequest.m
//  Musou
//
//  Created by luo danal on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSHTTPRequest.h"
#import "JSONKit.h"
#import "MSUtil.h"

static NSString *boundary = @"=======B-o-u-n-d-a-r-y=======";

@interface MSHTTPRequest () 
<
NSURLConnectionDelegate
>
@property (retain,nonatomic) NSURLConnection *conn;
@property (retain,nonatomic) NSMutableURLRequest *request;
@property (retain,nonatomic) NSMutableDictionary *requestFields;
@property (assign, nonatomic) NSTimer *rateTimer;
@property (assign, nonatomic) long long byteMargin;
@end

@implementation MSHTTPRequest
@synthesize conn = _conn;
@synthesize request = _request;
@synthesize mark = _mark;
@synthesize delegate = _delegate;
@synthesize URL = _URL;
@synthesize data = _data;
@synthesize parseJson = _parseJson;
@synthesize result = _result;
@synthesize errorInfo = _errorInfo;
//@synthesize startManually = _startManually;

@synthesize expectedLength = _expectedLength;
@synthesize receivedLength = _receivedLength;
@synthesize progress = _progress;
@synthesize elapsedTime;

@synthesize postMethod = _postMethod;
@synthesize requestFields = _requestFields;
@synthesize saveToCaches = _saveToCaches;
@synthesize enableTraceLog = _enableTraceLog;

@synthesize rateTimer;
@synthesize byteMargin;
@synthesize transferRate;
@synthesize rateUnit = _rateUnit;

- (void)dealloc{

    _delegate = nil;
    [self.rateTimer invalidate];    self.rateTimer = nil;
    [_rateUnit release];    _rateUnit = nil;
    [_requestFields release];  _requestFields = nil;
    [_request release];     _request = nil;
    [_conn release];    _conn = nil;
    [_result release];  _request = nil;
    [_URL release];     _URL = nil;
    [_data release];    _data = nil;
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        _request = [[NSMutableURLRequest alloc] init];
        _requestFields = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithDelegate:(id<MSHTTPRequestDelegate>)delegate{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        _request = [[NSMutableURLRequest alloc] init];
        _requestFields = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - 

- (void)setURL:(NSURL *)URL{
    if (URL != _URL) {
        [_URL release];
        _URL = [URL retain];
        [_request setURL:_URL];  
    }
}

- (void)setRateUnit:(NSString *)rateUnit{
    [_rateUnit release];
    _rateUnit = [rateUnit retain];
}

/*  //====POST ENCODEIND FORMAT====
 NSString *bodyPrefixStr = [NSString stringWithFormat:
 @
 // empty preamble
 "\r\n"
 "--%@\r\n"
 "Content-Disposition: form-data; name=\"fileContents\"; filename=\"%@\"\r\n"
 "Content-Type: %@\r\n"
 "\r\n",
 boundary,
 @"filename",       // +++ very broken for non-ASCII
 @"contentType"
 ];
 
 NSString *bodySuffixStr = [NSString stringWithFormat:
 @
 "\r\n"
 "--%@\r\n"
 "Content-Disposition: form-data; name=\"uploadButton\"\r\n"
 "\r\n"
 "Upload File\r\n"
 "--%@--\r\n"
 "\r\n"
 //empty epilogue
 ,
 boundary,
 boundary
 ];
 */

- (void)buildup{
    
    NSMutableData *body = [NSMutableData data];
    if (self.postMethod) {  //POST

        if ([self.requestFields count] > 0) {
            NSEnumerator *enumerator = [self.requestFields keyEnumerator];
            id key = nil,obj = nil;
            while (key = [enumerator nextObject]) {
                obj = [self.requestFields objectForKey:key];
                
                if ([obj isKindOfClass:[NSString class]]){          //A String
                    NSString *value = obj;
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
                }
                else if ([obj isKindOfClass:[NSData class]]) {      //An Image
                    
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:obj];
                }
                else if ([obj isKindOfClass:[NSDictionary class]]){     //A File
                    NSData *value = [obj objectForKey:@"value"];
                    NSString *filename = [obj objectForKey:@"filename"];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",key,filename] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:value];
                }
            }
        } //End mark
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=\"%@\"",boundary] forHTTPHeaderField:@"Content-Type"];
        
        [_request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
        [_request setHTTPMethod:@"POST"];
        [_request setHTTPBody:body];
        
    } else {    //GET
        
        NSString *baseUrlStr = [self.URL absoluteString];
        NSMutableString *url = nil;
        if ([baseUrlStr rangeOfString:@"?"].length > 0) {
            url = [NSMutableString stringWithFormat:@"%@",baseUrlStr];
        } else {
            url = [NSMutableString stringWithFormat:@"%@?",baseUrlStr];
        }
        if ([[url substringFromIndex:[url length] - 1] isEqualToString:@"&"]) {
            [url deleteCharactersInRange:NSMakeRange([url length] - 1, 1)];
        }
        for (NSString *key in self.requestFields) {
            [url appendFormat:@"&%@=%@",key, [self.requestFields objectForKey:key]];
        }
        [self setURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [_request setHTTPMethod:@"GET"];
    }
    
#ifdef DEBUG
//    if (self.postMethod && !_multipart) {
//        NSString *str = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
//        NSLog(@"\n--------------\n%@:%@ \n[POST BODY]:%@\n--------------\n", _request.HTTPMethod, self.URL, str);
//        [str release];
//    } else {
//        NSLog(@"\n--------------\n%@:%@\n--------------\n", _request.HTTPMethod, self.URL);
//    }
#endif
    body = nil;
}


- (void)start{
    [self buildup];
    [self.request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    self.conn = conn;
    [conn release];
    
    [self.conn start];
    if (_delegate && [_delegate respondsToSelector:@selector(requestDidStartLoading:)]) {
        [_delegate requestDidStartLoading:self];
    }
}

- (id)startSync:(NSTimeInterval)timeout{
    [self buildup];
    [self.request setTimeoutInterval:timeout];
    NSData *data = [NSURLConnection sendSynchronousRequest:self.request returningResponse:nil error:nil];
    if (self.parseJson) {
        JSONDecoder *decoder = [[JSONDecoder alloc] init];
        self.result = [decoder objectWithData:data];
        [decoder release];
        return self.result;
    }
    return data;
}

- (void)startSync:(NSTimeInterval)timeout completionBlock:(void (^)(id))block{
    [self buildup];
    [self.request setTimeoutInterval:timeout];
    [self.request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse *resp = nil;
        NSError *err = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&resp error:&err];
        id result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        if (err) {
            _errorInfo = [err description];
            result = [err description];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                block(result);
            });
            return;
        } else{
            if ([result isKindOfClass:[NSString class]] && [result length] > 0){
                if (self.parseJson) {
                    JSONDecoder *decoder = [[JSONDecoder alloc] init];
                    id obj = [decoder objectWithData:data];
                    [decoder release];
                    if (obj != nil) {
                        result = obj;
                    }
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    block(result);
                });
            }
        }
    });
}

- (void)cancel{
    _delegate = nil;
    
    if (self.rateTimer) {
        [self.rateTimer invalidate];
        self.rateTimer = nil;
    }
    
    [_conn cancel];
}

- (void)updateRate{
    float rate = self.byteMargin;
    NSString *unit = @"B";
    if(self.byteMargin > 1024*1024){
        rate = 1.f*self.byteMargin/1024/1024; 
        unit = @"M";
    }
    else if (self.byteMargin > 1024){
        rate = 1.f*self.byteMargin/1024; 
        unit = @"K";
    }
    
    self.transferRate = rate;
    self.rateUnit = unit;
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestDoesTransferRateUpdate:)]) {
        [self.delegate requestDoesTransferRateUpdate:self];
    }
    self.byteMargin = 0;
    self.elapsedTime += 1;
}

- (void)addValue:(NSString *)value forField:(NSString *)field{
    if (value != nil) {
        [self.requestFields setObject:value forKey:field];
    }
}

- (void)addPostValue:(NSString *)value forField:(NSString *)field{
    if (value != nil) {
        [self.requestFields setObject:value forKey:field];
    }
}

- (void)addPostImage:(UIImage *)image forField:(NSString *)field{
    //TODO
    NSData *data = UIImageJPEGRepresentation(image, .8f);
    [self.requestFields setObject:data forKey:field]; 
    _multipart = YES;
}

- (void)addPostFile:(NSString *)file forField:(NSString *)field{
    NSString *filename = [file lastPathComponent];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSData dataWithContentsOfFile:file],@"value",
                          filename,@"filename",nil];
    [self.requestFields setObject:dict forKey:field];   
    _multipart = YES;
}


- (void)removePostField:(NSString *)field{
    [self.requestFields removeObjectForKey:field];
    _multipart = NO;
    for (id obj in self.requestFields){
        if (![obj isKindOfClass:[NSString class]]) {
            _multipart = YES;
        }
    }
}


#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    _errorInfo = [error description];
    self.data = nil;
    self.result = nil;
    
    if (_delegate && [_delegate respondsToSelector:@selector(requestDidFailWithError:)]) {
        [_delegate requestDidFailWithError:error];
    }
    if (self.enableTraceLog) {
        NSLog(@"%@",error);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSMutableData *data = [[NSMutableData alloc] init];
    self.data = data;
    [data release];
    self.receivedLength = 0;
    self.progress = 0.f;
    self.expectedLength = [response expectedContentLength];

    self.byteMargin = 0;
    self.elapsedTime = 0;
    self.rateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateRate) userInfo:nil repeats:YES];
    [self.rateTimer fire];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.data appendData:data];
    self.receivedLength += [data length];
    self.byteMargin += [data length];
    if (self.expectedLength != NSURLResponseUnknownLength) {
        self.progress = self.receivedLength*1.f/self.expectedLength;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestDidReceiveData:data:)]) {
        [_delegate requestDidReceiveData:self data:data];
    }
    if (self.enableTraceLog) {
        NSLog(@"progress:%f recv:%lld,total:%lld",self.progress,self.receivedLength,self.expectedLength);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (self.parseJson) {
        JSONDecoder *decoder = [[JSONDecoder alloc] init];
        self.result = [decoder objectWithData:self.data];
        [decoder release];
    }
    [self.rateTimer invalidate];
    self.rateTimer = nil;
    self.progress = 1.f;
    self.byteMargin = 0;
    [self updateRate];
    if (self.saveToCaches) {
        NSString *filename = [[self.URL absoluteString] stringByReplacingOccurrencesOfString:@"[:/\\?\\*]" withString:@"-" options:NSRegularExpressionSearch range:NSMakeRange(0, [[self.URL absoluteString] length])];
        NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/%@",NSHomeDirectory(),filename];
        NSLog(@"%@",path);
        [self.data writeToFile:path atomically:YES];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
        [_delegate requestDidFinishLoading:self];
    }
}

#pragma mark - Class methods
+ (id)requestWithDelegate:(id<MSHTTPRequestDelegate>)delegate{
    MSHTTPRequest *req = [[[MSHTTPRequest alloc] initWithDelegate:delegate] autorelease];
    return req;
}

+ (id)request{
    MSHTTPRequest *req = [[[MSHTTPRequest alloc] init] autorelease];
    return req;
}

+ (id)requestWithUrl:(NSString *)url{
    MSHTTPRequest *req = [self request];
    req.URL = [NSURL URLWithString:url];
    return req;
}

+ (id)requestWithUrl:(NSString *)url post:(BOOL)post parseJson:(BOOL)parseJson{
    MSHTTPRequest *req = [self requestWithUrl:url];
    req.parseJson = parseJson;
    req.postMethod = post;
    return req;
}

+ (id)requestWithDelegate:(id)delegate post:(BOOL)post parseJson:(BOOL)parseJson{
    MSHTTPRequest *req = [self requestWithDelegate:delegate];
    req.postMethod = post;
    req.parseJson = parseJson;
    return req;

}

@end
