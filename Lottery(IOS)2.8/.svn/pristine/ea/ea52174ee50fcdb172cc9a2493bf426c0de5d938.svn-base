//
//  NSHTTPRequestOperation.h
//  Musou
//
//  Created by luo danal on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSHTTPRequest.h"

@interface MSHTTPRequestOperation : NSOperation <MSHTTPRequestDelegate>{
    MSHTTPRequest *_request;
    BOOL _done;
}
@property (assign,nonatomic) NSInteger index;
@property (retain,nonatomic) MSHTTPRequest *request;
@property (copy,nonatomic) NSString *url;

@end
