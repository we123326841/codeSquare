//
//  MSView+Additions.h
//  Musou
//
//  Created by luo danal on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Musou)

- (void)setCorner:(CGFloat)corner;

- (void)removeSubviews;

+ (instancetype)loadFromNib;
+ (instancetype)loadFromNib:(NSString *)nibFile;
                             
+ (CGRect)convertViewFrame:(UIView *)view toSuperview:(UIView *)superview;

@end
