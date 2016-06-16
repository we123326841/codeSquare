//
//  SideMenuController.h
//  SideMenuController
//
//  Created by danal on 13-1-3.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuController : UIViewController
<UINavigationControllerDelegate>
{
    BOOL _opened;
    UIView *_leftView;
    UIPanGestureRecognizer *_pan;
    UIView *_rightView;
    UIView *_mask;
}
@property (retain, nonatomic) UIViewController *leftController;
@property (retain, nonatomic) UIViewController *rightController;

- (id)initWithLeftMenuController:(UIViewController *)leftController
          rightDefaultController:(UIViewController *)rightController;

- (void)enablePanGesture:(BOOL)enable;
- (void)slideToDirection:(BOOL)toRight;
//动画打开内容ViewController
- (void)activeViewController:(UIViewController *)viewController;
//静态替换已打开的内容ViewController
- (void)replaceViewController:(UIViewController *)viewController;
//移动到右边挂起
- (void)haltViewController;
- (void)toggle;

@end
