//
//  TransferResultViewController.m
//  Caipiao
//
//  Created by danal on 13-5-24.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "TransferResultViewController.h"

@interface TransferResultViewController ()

@property (assign, nonatomic) IBOutlet UILabel *tipLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;

@end

@implementation TransferResultViewController

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
	// Do any additional setup after loading the view.
    self.title = @"转账成功";
    _amountLbl.text = [NSString stringWithFormat:@"%@%@元", _descr,[SharedModel formatBalance:_amount]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finish:(id)sender
{
    [self backAction:nil];
}

@end
