//
//  NSArray+Log.m
//  打印中文
//
//  Created by allen on 15/4/2.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)
-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"%lu (",(unsigned long)self.count];
    for (NSObject *obj in self) {
        [str appendFormat:@"\t%@,\n",obj];
    }
    [str appendString:@")"];
    return str;
}
@end
