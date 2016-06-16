//
//  MSBundle+Additions.m
//  Musou
//
//  Created by luo danal on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSBundle+Additions.h"

@implementation NSBundle (Musou)

+ (NSString *)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


+ (NSString *)pathForRes:(NSString *)res{
    return [[NSBundle mainBundle] pathForResource:res ofType:nil];
}

+ (NSURL *)URLForRes:(NSString *)res{
    return [[NSBundle mainBundle] URLForResource:res withExtension:nil];
}

+ (NSString *)pathForRes:(NSString *)res inBundle:(NSString *)bundle{
    return [[[NSBundle mainBundle] pathForResource:bundle ofType:nil] stringByAppendingPathComponent:res];
}

+ (NSURL *)URLForRes:(NSString *)res inBundle:(NSString *)bundle{
    NSString *path = [NSBundle pathForRes:res inBundle:bundle];
    return [NSURL URLWithString:path];
}

+ (NSString *)documentsDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)cachesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)pathInDocuments:(NSString *)file{
    return [[self documentsDirectory] stringByAppendingPathComponent:file];
}

+ (NSString *)pathInCaches:(NSString *)file{
    return [[self cachesDirectory] stringByAppendingPathComponent:file];
}

@end
