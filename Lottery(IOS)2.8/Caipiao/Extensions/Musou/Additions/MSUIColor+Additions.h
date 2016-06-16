//
//  MSColor+Additions.h
//  Musou
//
//  Created by luo danal on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (Musou)

+ (UIColor *)rgbColorWithHex:(NSString *)str;

+ (UIColor *)rgbColorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b alpha:(CGFloat)alpha;

//RGBA
- (void)getR:(float *)r G:(float *)g B:(float *)b A:(float *)alpha;

+ (UIColor *)randomColor;

@end
