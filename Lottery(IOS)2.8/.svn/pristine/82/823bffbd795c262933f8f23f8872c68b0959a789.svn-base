//
//  BallIndicator.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ball;

@interface BallIndicator : UIImageView
{
    UIImageView *_ball;
}
@property (assign, nonatomic) NSInteger number;
@property (copy, nonatomic) NSString *numberFormat;

+ (id)indicator;
+ (void)dismissCurrent;

- (void)showOnBall:(Ball *)ball atPoint:(CGPoint)point;
- (void)dismiss;
- (void)setText:(NSString *)text;

@end
