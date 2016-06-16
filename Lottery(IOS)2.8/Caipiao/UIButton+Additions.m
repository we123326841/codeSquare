//
//  UIButton+Additions.m
//  Caipiao
//
//  Created by danal on 13-1-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UIButton+Additions.h"

#define TITLE_COLOR [UIColor colorWithRed:0 green:35.f/255 blue:17.f/255 alpha:1.f]

@implementation UIButton (_addtions)

+ (UIButton *)bigButtonWithTitle:(NSString *)title{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    button.titleEdgeInsets = UIEdgeInsetsMake(2, -5, 0, 0);
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.shadowColor = kNavTitleShadowColor;
    [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"button_550.png"];
    [button setBackgroundImage:[UIImage imageNamed:@"button_550.png"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"button_550_down.png"] forState:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return button;
}

+ (UIButton *)middleButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.shadowColor = kNavTitleShadowColor;
//    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"button_350.png"];
    [button setBackgroundImage:[UIImage imageNamed:@"button_350.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"button_350_down.png"] forState:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return button;
}

+ (UIButton *)smallButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.shadowColor = kNavTitleShadowColor;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"button_190.png"];
    [button setBackgroundImage:[UIImage imageNamed:@"button_190.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"button_190_down.png"] forState:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return button;
}

+ (UIButton *)barButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    button.titleLabel.shadowColor = kNavTitleShadowColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 40, 32);
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)toolButtonWithTitle:(NSString *)title{
    UIImage *buttonBg = [UIImage imageNamed:@"button_tool.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    button.titleLabel.shadowColor = kNavTitleShadowColor;
    [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonBg.size.width, buttonBg.size.height);
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:buttonBg forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)w281ButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [button setTitleColor:[UIColor rgbColorWithHex:@"#002F1C"] forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"button_281.png"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return button;
}

+ (UIButton *)borderButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [button setTitleColor:kYellowTextColor forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"button_yellowBorder.png"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return button;
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
