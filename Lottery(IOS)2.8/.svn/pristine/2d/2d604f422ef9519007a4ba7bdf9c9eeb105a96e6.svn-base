//
//  RQBase.h
//  Wrapping For HTTP Request
//  Caipiao
//
//  Created by danal on 13-2-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "MSHTTPRequest.h"

#define PSTRONG @property (strong , nonatomic)
#define PCOPY @property (copy , nonatomic)
#define PASSIGN @property (assign , nonatomic)
#define PREADONLY @property (readonly , nonatomic)
#define RELEASE(o) [o release]; o = nil;

typedef enum {
   kMessageTypePop = 0,
    kMessageTypeCommon = 1,
    kMessageTypeError = 2,
    kMessageTypeAsk = 3,
    kMessageTypeSessionExpired = 7,
    kMessageTypeCardNotBinded = 8,
} MessageType;

@protocol RQBaseDelegate;

@interface RQBase : NSObject <MSHTTPRequestDelegate>
//Use a integer mark to identify a RQBase instance
@property (assign, nonatomic) NSInteger mark;
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) NSMutableDictionary *requestParams;
@property (assign, nonatomic) id<RQBaseDelegate> delegate;
@property (assign, nonatomic) id requestSender;
@property (copy, nonatomic) void (^completeBlock)(RQBase *, NSError *, id);
@property (nonatomic) BOOL debug;
@property (nonatomic) BOOL echoSourceResultInConsole;
@property (nonatomic) BOOL silent;  //Donot alert network error

//Message
@property (assign, nonatomic) NSInteger msgType;
@property (copy, nonatomic) NSString *msgContent;
//@property (copy, nonatomic) NSString *jumpAction;

//If you want to custom fill post parametes, override this method
- (void)prepare;

//Set request parameter
//Post
- (void)setValue:(id)value forField:(NSString *)field;
- (void)setPostValue:(id)value forField:(NSString *)field;

//Get
- (void)setGetValue:(id)value forField:(NSString *)field;

//Using Delegate, return an integer value to identify itself
- (NSInteger)startGetWithDelegate:(id<RQBaseDelegate>)delegate;
- (NSInteger)startPostWithDelegate:(id<RQBaseDelegate>)delegate;

//Using Block
- (void)startGetWithBlock:(void(^)(id rq_, NSError *error_, id rqSender_))block sender:(id)rqSender;
- (void)startPostWithBlock:(void(^)(id rq_, NSError *error_, id rqSender_))block sender:(id)rqSender;

//Cancel
- (void)cancel;

//Override this method to parse the result data
- (void)parse:(id)result;
//Directly pass the result to the parse: method without checking
- (BOOL)shouldDirectlyParse;

+ (BOOL)networkIsOK;

@end


@protocol RQBaseDelegate <NSObject>
@optional
- (void)onRQStart:(RQBase *)rq;
- (void)onRQComplete:(RQBase *)rq error:(NSError *)error;

@end

#import "URLs.h"
