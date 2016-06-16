//
//  MSHTTPRequest.h
//  Musou
//
//  Created by luo danal on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  MSHTTPRequestDelegate;

@interface MSHTTPRequest : NSObject {
    NSURLConnection *_conn;
    NSMutableURLRequest *_request;
    BOOL _multipart;
}

//A int mark to identify self
@property (assign,nonatomic) NSInteger mark;
//Delegate
@property (assign,nonatomic) id<MSHTTPRequestDelegate> delegate;
//Url
@property (retain,nonatomic) NSURL *URL;
//Data received
@property (retain,nonatomic) NSMutableData *data;
//Parsed data
@property (retain,nonatomic) id result;
//Whether to parse the received data to json
@property (nonatomic) BOOL parseJson;
//Error info
@property (readonly,nonatomic) NSString *errorInfo;
//Control the start way,default value is NO
//@property (nonatomic) BOOL startManually;

@property (assign,nonatomic) long long expectedLength;
@property (assign,nonatomic) long long receivedLength;
@property (assign,nonatomic) float progress;
@property (assign,nonatomic) int elapsedTime;
@property (assign,nonatomic) float transferRate;
@property (readonly, retain, nonatomic) NSString *rateUnit;

//Set yes to make a post http request
@property (nonatomic) BOOL postMethod;
//Whether to save file to caches
@property (nonatomic) BOOL saveToCaches;
//For debug
@property (nonatomic) BOOL enableTraceLog;

- (id)initWithDelegate:(id<MSHTTPRequestDelegate>)delegate;
//Request in asynchronism
- (void)start;
- (void)cancel;
//Request in synchronism,return NSData object,or JSON dictionary if set parseJson to YES
- (id)startSync:(NSTimeInterval)timeout;
- (void)startSync:(NSTimeInterval)timeout completionBlock:(void (^) (id result))block;

//Using for GET or POST request
- (void)addValue:(NSString *)value forField:(NSString *)field;
//Using when it's a post request
- (void)addPostValue:(NSString *)value forField:(NSString *)field;
- (void)addPostImage:(UIImage *)image forField:(NSString *)field;
- (void)addPostFile:(NSString *)file forField:(NSString *)field;
- (void)removePostField:(NSString *)field;

#pragma mark - Class methods
+ (id)requestWithDelegate:(id<MSHTTPRequestDelegate>)delegate;
+ (id)request;
+ (id)requestWithUrl:(NSString *)url;
+ (id)requestWithDelegate:(id)delegate post:(BOOL)post parseJson:(BOOL)parseJson;
+ (id)requestWithUrl:(NSString *)url post:(BOOL)post parseJson:(BOOL)parseJson;

@end


@protocol MSHTTPRequestDelegate <NSObject>
@optional
- (void)requestDidStartLoading:(MSHTTPRequest *)req;
- (void)requestDidReceiveData:(MSHTTPRequest *)req data:(NSData *)data;
- (void)requestDoesTransferRateUpdate:(MSHTTPRequest *)req;
@required
- (void)requestDidFinishLoading:(MSHTTPRequest *)req;
- (void)requestDidFailWithError:(NSError *)error;
@end