//
//  PopMenu.h
//  Caipiao
//  下拉弹出框
//  Created by danal on 13-1-7.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kPopNavbarPositionLeft = 0 ,
    kPopNavbarPositionMiddle,
    kPopNavbarPositionRight
} PopNavbarPosition;

@interface PopMenu : UIView
{
    UIView *_bgView;
    CGPoint _offset;
    CGRect _origFrame;
    id _target;
    SEL _selector;
}
@property (strong, nonatomic) NSArray *titles;
@property (assign, nonatomic) int selectedIndex;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
- (void)setTarget:(id)target selector:(SEL)selector;
- (void)showInView:(UIView *)view atAnchor:(CGPoint)anchor;
- (void)showAtBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)showBelowNavbar:(UINavigationBar *)navbar position:(PopNavbarPosition)pos;
/**
 * Show a pop menu below the specified view,and aligned with the alignframe
 */
- (void)showBelowView:(UIView *)view alignFrame:(CGRect)alignFrame;
- (void)dismiss;

+ (void)dismissCurrent;

@end
