//
//  LodingAlertView.h
//  SideMenuController
//
//  Created by danal on 13-1-3.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
@interface LoadingAlertView : UIAlertView <UIAlertViewDelegate>
{
    NSTimer *_timer;
    UIImageView *_imageView;
    UILabel *_textLbl;
}

+ (void)showMessage:(NSString *)msg delayHides:(float)delay;
+ (void)dismissCurrent;

+ (void)showLoading;
- (void)delayHideShow:(float)delay;

@end
*/

@interface HUDView : UIView
{
    NSTimer *_timer;
    UILabel *_textLbl;
    UILabel *_subTextLbl;
    UIImageView *_iconView;
    UIImageView *_imageView;
}

@property (assign, nonatomic) BOOL touchToHide;


/**
 * 延迟消失
 * @param delay 秒
 */
- (void)delayHides:(int)delay;
- (void)hide;

/**
 * 显示一条提示消息
 * @param superview父视图
 * @param msg 消息
 * @param subtitle 消息下方的子标题
 * @return HUDView对象
 */
+ (HUDView *)showMessageToView:(UIView *)superview msg:(NSString *)msg subtitle:(NSString *)subtitle;

/**
 * 显示一条加载消息
 * @param superview父视图
 * @param msg 消息
 * @param subtitle 消息下方的子标题
 * @return HUDView对象
 */
+ (HUDView *)showLoadingToView:(UIView *)superview msg:(NSString *)msg subtitle:(NSString *)subtitle;
/**
 * 显示一条加载消息
 * @param superview父视图
 * @param msg 消息
 * @param subtitle 消息下方的子标题
 * @touchToHide 是否点击任意位置隐藏
 * @return HUDView对象
 */
+ (HUDView *)showLoadingToView:(UIView *)superview msg:(NSString *)msg subtitle:(NSString *)subtitle touchToHide:(BOOL)touchToHide;

/**
 * 显示一条提示为"Loading..."的加载消息
 * @param superview父视图
 * @return HUDView对象
 */
+ (HUDView *)showLoading:(UIView *)superview;

/**
 * 让当前显示的对象消失
 */
+ (void)dismissCurrent;

/**
 * 设置当前HUD是否可以触摸关闭
 */
+ (void)setTouchHide:(BOOL)hide;

@end

//Show message in a controller
#define HUDShowMessage(msg_, subtitle_) [HUDView showMessageToView:self.view msg:msg_ subtitle:subtitle_];
#define HUDShowLoading(msg_, subtitle_) [HUDView showLoadingToView:self.view msg:msg_ subtitle:subtitle_];
#define HUDHide() [HUDView dismissCurrent];
#define HUDShowMessageforView(msg_, subtitle_) [HUDView showMessageToView:self msg:msg_ subtitle:subtitle_];
