//
//  MSView+Additions.m
//  Musou
//
//  Created by luo danal on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUIView+Additions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Musou)

- (void)setCorner:(CGFloat)corner{
    self.layer.cornerRadius = corner;
}

- (void)removeSubviews{
    for (UIView *v in self.subviews){
        [v removeFromSuperview];
    }
}

+ (instancetype)loadFromNib{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    return view;
}

+ (instancetype)loadFromNib:(NSString *)nibFile{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:nibFile owner:nil options:nil];
    for (UIView *v in views){
//        if ([v isKindOfClass:[self class]]){
        if ([NSStringFromClass(v.class) isEqualToString:NSStringFromClass(self.class)]){
            return v;
        }
    }
    return nil;
}

+ (CGRect)convertViewFrame:(UIView *)view toSuperview:(UIView *)superview{
    CGRect rect = view.frame;
    UIView *v = view.superview;
    while (v != superview) {
        rect.origin.x += v.frame.origin.x;
        rect.origin.y += v.frame.origin.y;
        v = v.superview;
    }
    return rect;
}

@end
