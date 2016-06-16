//
//  QuickRechargeFAQViewController.m
//  Caipiao
//
//  Created by MDD on 5/26/15.
//  Copyright (c) 2015 yz. All rights reserved.
//

#import "QuickRechargeFAQViewController.h"

@interface QuickRechargeFAQViewController ()

@end

@implementation QuickRechargeFAQViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"快捷支付FAQ";
    _scrollView.contentSize = CGSizeMake(320, 1000);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
