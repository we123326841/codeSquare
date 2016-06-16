//
//  NSString+Url.m
//  跟Swift对比
//
//  Created by 王浩 on 16/3/31.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "NSString+Url.h"

@implementation NSString (Url)
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}
@end
