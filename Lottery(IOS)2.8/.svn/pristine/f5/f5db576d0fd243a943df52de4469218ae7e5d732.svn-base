//
//  VideoAlert.m
//  Caipiao
//
//  Created by GroupRich on 15/1/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "VideoAlert.h"

@implementation VideoAlert


- (IBAction)btnClicked:(id)sender {
    switch ([sender tag]) {
        case 0:
            [self removeFromSuperview];
            break;
        case 1:
        {
            if (_clickedBlock) {
                _clickedBlock(1);
            }
            [self removeFromSuperview];

        }
            break;
        default:
            break;
    }
}
- (void)dealloc {
    [_alertL release];
    Block_release(_clickedBlock);
    [_contentView release];
    [_leftbtn release];
    [_rightbtn release];
    [_titleL release];
    [super dealloc];
}


- (void)awakeFromNib
{
    //Animated show
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 1.f)],
                  nil];
    kfa.duration = .1f;
    kfa.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_contentView.layer addAnimation:kfa forKey:nil];
}

@end
