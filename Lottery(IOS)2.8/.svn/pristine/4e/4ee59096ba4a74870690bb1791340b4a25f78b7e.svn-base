//
//  SideMenuController.m
//  SideMenuController
//
//  Created by danal on 13-1-3.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SideMenuController.h"

#define kRightPositionXRatio (1.f-41.f/320.f)   //(3.f/4)
#define kContentViewTag 0xff

static float _edgePositionX = 0.f;

@interface SideMenuController ()
@property (retain, nonatomic) UIView *leftView;
@property (retain, nonatomic) UIView *rightView;

- (void)enablePanGesture:(BOOL)enable;
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan;
@end


@implementation SideMenuController
@synthesize leftController = _leftController;
@synthesize rightController = _rightController;

@synthesize leftView = _leftView;
@synthesize rightView = _rightView;


- (void)dealloc{
    [_leftView release];
    [_rightView release];
    [_leftController release];
    [_rightController release];
    [super dealloc];
}

- (id)initWithLeftMenuController:(UIViewController *)leftController
               rightDefaultController:(UIViewController *)rightController{
    self = [super init];
    if (self) {
        self.leftController = leftController;
        self.rightController = rightController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect rect = self.view.bounds;
    _edgePositionX = rect.size.width/2;
    
    _leftView = [[UIView alloc] initWithFrame:rect];
    _leftView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_leftView];
    
    rect.origin.x = rect.size.width*kRightPositionXRatio;
    _rightView = [[UIView alloc] initWithFrame:rect];
    _rightView.backgroundColor = [UIColor blackColor];
    _rightView.layer.shadowColor = [UIColor blackColor].CGColor;
    _rightView.layer.shadowOpacity = 0.3f;
    _rightView.layer.shadowOffset = CGSizeMake(-2.f, 0.f);
    _rightView.layer.cornerRadius = 4.f;
//    _rightView.clipsToBounds = YES;   //!!!加了这行会引起奇怪的alertView被遮挡问题
    [self.view addSubview:_rightView];
    
    {
        [[self.leftView viewWithTag:kContentViewTag] removeFromSuperview];
        UIView *view = self.leftController.view;
        view.tag = kContentViewTag;
        view.frame = self.rightView.bounds;
        [self.leftView addSubview:view];
    }
    {
        [[self.rightView viewWithTag:kContentViewTag] removeFromSuperview];
        UIView *view = self.rightController.view;
        view.tag = kContentViewTag;
        view.frame = self.rightView.bounds;
        [self.rightView addSubview:view];
        
        _mask = [[UIView alloc] initWithFrame:
                 CGRectMake(0, 44.f, self.rightView.bounds.size.width, self.rightView.bounds.size.height)];
        [self.rightView insertSubview:_mask atIndex:NSIntegerMax];
        
        if (_opened) {
            [_mask removeFromSuperview];
        } else{
        }
    
    }
    [self enablePanGesture:YES];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    self.leftView = nil;
    self.rightView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations{
#ifdef __IPHONE_6_0
    return UIInterfaceOrientationMaskPortrait;
#endif
}

- (BOOL)shouldAutorotate{
    return NO;
}

#pragma mark - Actions

- (void)setRightController:(UIViewController *)rightController{
    if (_rightController != rightController) {
        //Dismiss modalViewController if has
        if (_rightController.modalViewController) {
            [_rightController dismissModalViewControllerAnimated:NO];
        }
        
        //Remove older view,and release older controller
        [_rightController.view removeFromSuperview];
        [_rightController release];
        
        //Set net controller
        _rightController = [rightController retain];
        if ([_rightController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)_rightController setDelegate:self];
        }
    }
}

- (void)activeViewController:(UIViewController *)viewController{
    __block CGRect rect = self.rightView.frame;
    CALayer *layer = self.rightView.layer;
    layer.shouldRasterize = YES;
    [UIView animateWithDuration:.2f
                          delay:0.f
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         //Move to the most right
                         rect.origin.x = rect.size.width;
                         self.rightView.frame = rect;
    } completion:^(BOOL completed){
         //Move to the most left
        self.rightController = viewController;
        layer.shouldRasterize = NO;
        [[self.rightView viewWithTag:kContentViewTag] removeFromSuperview];
        UIView *view = self.rightController.view;
        view.tag = kContentViewTag;
        view.frame = self.rightView.bounds;
        [self.rightView addSubview:view];

        [self slideToDirection:NO];
    }];

}

- (void)replaceViewController:(UIViewController *)viewController{
    self.rightController = viewController;
    [[self.rightView viewWithTag:kContentViewTag] removeFromSuperview];
    UIView *view = self.rightController.view;
    view.tag = kContentViewTag;
    view.frame = self.rightView.bounds;
    [self.rightView addSubview:view];
}

- (void)haltViewController{
    [self slideToDirection:YES];
}

- (void)toggle{
    if (_opened) {
        [self slideToDirection:YES];
    } else {
        [self slideToDirection:NO];
    }
}

- (void)enablePanGesture:(BOOL)enable{
    return;
    
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    }
    if (enable) {
        [self.rightView addGestureRecognizer:_pan];
    } else {
        [self.rightView removeGestureRecognizer:_pan];
    }
}

- (void)slideToDirection:(BOOL)toRight{
    float x = 0.f;
    if (toRight) {
        x = self.view.bounds.size.width*kRightPositionXRatio;
        _opened = NO;
    } else {    //to Left
        x = 0.f;
        _opened = YES;
    }
    
    if (_opened) {
        [_mask removeFromSuperview];
    } else {
        [self.rightView insertSubview:_mask atIndex:NSIntegerMax];
    }
    
    CGRect rect = self.view.frame;
    rect.origin = CGPointMake(x, 0.f);
    
    CALayer *layer = self.rightView.layer;
    layer.shouldRasterize = YES;
    [UIView animateWithDuration:.2f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.rightView.frame = rect;
                     }
                     completion:^(BOOL completed){
                         layer.shouldRasterize = NO;
                     }];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan{
//    CGPoint loc = [pan locationInView:pan.view];
    CGRect rect = self.rightView.frame;
    CGPoint translate = [pan translationInView:pan.view];
    CGPoint loc = rect.origin;
    
    switch (pan.state) {
        case UIGestureRecognizerStateEnded:{
            if (loc.x > _edgePositionX) {   //slide to right
                [self slideToDirection:YES];
            } else {    //slide to left
                [self slideToDirection:NO];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        default:{   //Just move
            rect.origin = CGPointMake(rect.origin.x + translate.x, 0.f);
            if (rect.origin.x <= 0.f) {
                rect.origin = CGPointZero;
            }
            self.rightView.frame = rect;
            [pan setTranslation:CGPointZero inView:pan.view];
        }
            break;
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if ([navigationController.viewControllers count] > 1){
        [self enablePanGesture:NO];
        CGRect rect = self.rightView.frame;
        if (rect.origin.x > _edgePositionX) {
            [self slideToDirection:NO];
        }
    } else {
        [self enablePanGesture:YES];
    }
}

@end
