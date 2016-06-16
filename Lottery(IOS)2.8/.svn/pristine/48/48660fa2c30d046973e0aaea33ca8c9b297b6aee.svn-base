//
//  MSNSDictionary+Additions.m
//  Musou
//
//  Created by danal on 13-1-28.
//
//

#import "MSNSDictionary+Additions.h"
#import "MSNull+Additions.h"

@implementation NSDictionary (Musou)

- (NSDictionary *)dictForKey:(NSString *)key{
    id o = [self objectForKey:key];
    if ([o isKindOfClass:[NSDictionary class]]) {
        return o;
    } else {
        return nil;
    }
}

- (NSArray *)arrayForKey:(NSString *)key{
    id o = [self objectForKey:key];
    if ([o isKindOfClass:[NSArray class]]) {
        return o;
    } else {
        return nil;
    }
}

- (NSNumber *)numberiForKey:(NSString *)key{
    id o = [self objectForKey:key];
    if ([o isKindOfClass:[NSNumber class]]) {
        return o;
    } else {
        return [NSNumber numberWithInt:[o intValue]];
    }
    
}

- (NSNumber *)numberfForKey:(NSString *)key{
    id o = [self objectForKey:key];
    if ([o isKindOfClass:[NSNumber class]]) {
        return o;
    } else {
        return [NSNumber numberWithFloat:[o floatValue]];
    }

}

- (NSString *)stringForKey:(NSString *)key{
    id o = [self objectForKey:key];
    if (o == [NSNull null]) {
        return nil;
    }
    if ([o isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",o];
    }
    else {
        return o;
    }
}

- (NSInteger)intForKey:(NSString *)key{
    return [[self objectForKey:key] integerValue];
}

- (CGFloat)floatForKey:(NSString *)key{
    return [[self objectForKey:key] floatValue];
}

- (BOOL)boolForKey:(NSString *)key{
    return [[self objectForKey:key] boolValue];
}

@end
