//
//  MSNSString+Additions.m
//  Musou
//
//  Created by danal on 13-2-1.
//
//

#import "MSNSString+Additions.h"

@implementation NSString (Musou)

- (id)objectForKey:(NSString *)key{
    return nil;
}

- (NSArray *)split{
    NSMutableArray *components = [NSMutableArray array];
    for (int i = 0; i < [self length]; i++) {
        NSString *c = [self substringWithRange:NSMakeRange(i, 1)];
        [components addObject:c];
    }
    return components;
}

- (NSArray *)publicSplit{
    NSMutableArray *components = [NSMutableArray array];
    
    NSString *codes = self;
    //双色球，蓝球以+分隔
    codes = [codes stringByReplacingOccurrencesOfString:@"+" withString:@","];
    
    //11选5的格式，号码以空格间隔
    NSArray *numbers = [codes componentsSeparatedByString:@","];
    if ([numbers count] > 1) {
        [components addObjectsFromArray:numbers];
        return components;
    }
    
    //时时彩号码格式
    for (int i = 0; i < [codes length]; i++) {
        NSString *c = [codes substringWithRange:NSMakeRange(i, 1)];
        [components addObject:c];
    }
    return components;
}

- (NSString *)separateWithString:(NSString *)separator{
    if (self != nil && [self length] > 0) {
        NSString *str = self;
        NSMutableString *result = [NSMutableString string];
//        for (int i = 0; i < [self length]; i++) {
//            [result appendFormat:@"%c%@",[self characterAtIndex:i],separator];
//        }
        NSArray *segs = [str componentsSeparatedByString:@" "];
        NSInteger count = [segs count];
        for (NSInteger i = 0; i < count; i++) {
            [result appendFormat:@"%@%@",[segs objectAtIndex:i],separator];
        }
        [result deleteCharactersInRange:NSMakeRange([result length] - 1, 1)];
        return result;
    }
    return self;
}

@end
