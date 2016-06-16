//
//  NavigationController.m
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "NavigationController.h"

@implementation UINavigationBar (Custom)
//
//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    [[UIImage imageNamed:@"navbg.png"] drawInRect:rect];
//}

@end

@implementation NavigationBar

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextAddRect(c, rect);
    [[UIColor blackColor] set];
    CGContextFillPath(c);
    
    CGRectAddRoundedCornerPath(rect, 5.f, kRounderCornerPostionTop, c);
    CGContextClip(c);
    
    rect.size.height += 10.f;
    [[UIImage imageNamed:@"title_bg.png"] drawInRect:rect];
}

@end

@interface NavigationController ()
@property (strong, nonatomic) NavigationBar *navigationBar;
@end

@implementation NavigationController
@dynamic navigationBar;

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
//        self.navigationBar = [[[NavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbg.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.tintColor = [UIColor colorWithRed:249.f/255 green:184.f/255 blue:0.f alpha:1.f];
        
#ifdef __IPHONE_7_0
            self.navigationBar.tintColor = [UIColor colorWithRed:249.f/255 green:184.f/255 blue:0.f alpha:1.f];
#endif

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
