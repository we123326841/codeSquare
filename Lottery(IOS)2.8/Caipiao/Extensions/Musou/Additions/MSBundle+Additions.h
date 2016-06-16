//
//  MSBundle+Additions.h
//  Musou
//
//  Created by luo danal on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@interface NSBundle (Musou)

+ (NSString *)appVersion;

+ (NSString *)pathForRes:(NSString *)res;
+ (NSURL *)URLForRes:(NSString *)res;
+ (NSString *)pathForRes:(NSString *)res inBundle:(NSString *)bundle;
+ (NSURL *)URLForRes:(NSString *)res inBundle:(NSString *)bundle;
+ (NSString *)documentsDirectory;
+ (NSString *)cachesDirectory;
+ (NSString *)pathInDocuments:(NSString *)file;
+ (NSString *)pathInCaches:(NSString *)file;
@end
