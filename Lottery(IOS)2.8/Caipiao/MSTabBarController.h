//
//  MSTabBarController.h
//  VGirl
//
//  Created by danal-rich on 14-2-20.
//  Copyright (c) 2014年 danal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTabBarItem : UIView
{
    UILabel     *_titleLbl;
    UIImageView *_imageView;
    UIImageView *_badgeView;
}
@property (strong, nonatomic)   UIImage *image;
@property (strong, nonatomic)   UIImage *imageOn;
@property (copy, nonatomic)     NSString *title;
@property (assign, nonatomic)   NSInteger badgeNumber;
@property (nonatomic)           BOOL selected;
/**
 * Special item dose not change a controller
 */
@property (nonatomic) BOOL specialItem;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image imageOn:(UIImage *)imageOn;
+ (id)itemWithTitle:(NSString *)title image:(UIImage *)image imageOn:(UIImage *)imageOn;
@end

#pragma mark -
@interface MSTabBar : UIControl
@property (assign, nonatomic) UIImageView *background;
@property (strong, nonatomic) NSArray *items;               //Array of TabBarItems
@property (assign, nonatomic) NSInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
@end

#pragma mark -
@interface MSTabBarController : UITabBarController
@property (readonly, strong, nonatomic) NSArray *controllers;
@property (readonly, strong, nonatomic) MSTabBar *tab;

+ (void)setTabBarHeight:(CGFloat)height;
+ (CGFloat)tabBarHeight;

- (void)setControllers:(NSArray *)controllers tabBarItems:(NSArray *)items;
- (void)setTabSelectedIndex:(NSInteger)index;

@end