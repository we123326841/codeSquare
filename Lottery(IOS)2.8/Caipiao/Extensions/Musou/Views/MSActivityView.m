//
//  MSActivityView.m
//  Caipiao
//
//  Created by danal on 13-3-19.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "MSActivityView.h"

@implementation MSActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImage:(UIImage *)image{
    self = [super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_imageView];
        self.hidden = YES;
    }
    return self;
}

- (void)startAnimating{
    self.hidden = NO;
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.duration = .7f;
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*2, 0, 0, 1.f)]
                  , nil];
    kfa.repeatCount = 10e6;
    [_imageView.layer addAnimation:kfa forKey:@"Rotation"];
}

- (void)stopAnimating{
    [_imageView.layer removeAllAnimations];
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
