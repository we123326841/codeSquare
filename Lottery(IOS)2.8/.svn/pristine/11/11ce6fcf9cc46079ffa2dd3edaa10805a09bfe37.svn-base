//
//  MSColor+Additions.m
//  Musou
//
//  Created by luo danal on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUIColor+Additions.h"

@implementation UIColor (Musou)

+ (UIColor *)rgbColorWithHex:(NSString *)str{
    unsigned int r = 0, g = 0, b = 0;
    NSInteger length = [str length];
    if (length%3 == 1) {        //With # prefix
        str = [str substringFromIndex:1];
        length = [str length];
    }
    NSInteger segment = length/3;
    if (length == 6 || length == 3) {          //EFEFEF | CCC
        NSScanner *scanner = nil;
        NSString *s = [str substringWithRange:NSMakeRange(0, segment)];
        scanner = [NSScanner scannerWithString:s];
        [scanner scanHexInt:&r];
        s = [str substringWithRange:NSMakeRange(segment, segment)];
        scanner = [NSScanner scannerWithString:s];
        [scanner scanHexInt:&g];
        s = [str substringWithRange:NSMakeRange(segment*2, segment)];
        scanner = [NSScanner scannerWithString:s];
        [scanner scanHexInt:&b];
    }
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f];
}

+ (UIColor *)rgbColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:alpha];
}

- (void)getR:(float *)r G:(float *)g B:(float *)b A:(float *)alpha{
    const CGFloat *components;
    components = CGColorGetComponents(self.CGColor);
//    for (int i = 0; i < CGColorGetNumberOfComponents(self.CGColor); i++) {
//        NSLog(@"%f",components[i]);
//    }
    *r = components[0];
    *g = components[1];
    *b = components[2];
    *alpha = components[3];
}

+ (UIColor *)randomColor{
    int r,g,b;
//    r = arc4random()%255;
//    g = arc4random()%255;
//    b = arc4random()%255;
    r = rand()%255;
    g = rand()%255;
    b = rand()%255;
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f];
}
@end
