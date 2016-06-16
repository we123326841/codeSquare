//
//  Switch.h
//  Caipiao
//
//  Created by danal on 13-1-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  enum {
    kSwitchStyleBall = 0,
    kSwitchStyleOnOff,
} SwitchStyle;

@interface Switch : UIControl
{
    BOOL        _on;
    UIImageView *_onImageView;
    UIImageView *_offImageView;
    UIImageView *_ball;
}
@property (nonatomic) BOOL on;
@property (nonatomic) SwitchStyle style;
@property (assign, nonatomic) UILabel *leftLbl, *rightLbl;

- (id)initWithFrame:(CGRect)frame style:(SwitchStyle)style;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end

@interface BallSwitch : Switch

@end

@interface OnOffSwitch : Switch

@end

@interface ModeSwitch : Switch
{
    UILabel *_yuanLbl;
    UILabel *_jiaoLbl;
}
@end
