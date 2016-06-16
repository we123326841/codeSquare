//
//  MSNSDictionary+Additions.h
//  Musou
//
//  Created by danal on 13-1-28.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Musou)

- (NSDictionary *)dictForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
- (NSNumber *)numberiForKey:(NSString *)key;
- (NSNumber *)numberfForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSInteger)intForKey:(NSString *)key;
- (CGFloat)floatForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;

@end
