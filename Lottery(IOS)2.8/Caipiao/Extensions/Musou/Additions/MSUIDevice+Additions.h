//
//  MSDevice+Additions.h
//  Musou
//
//  Created by luo danal on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDevice (Musou)

+ (BOOL)isPhone;

+ (BOOL)isPad;

+ (NSString *)MACAddress;

+ (NSInteger)bigVersion;

@end
