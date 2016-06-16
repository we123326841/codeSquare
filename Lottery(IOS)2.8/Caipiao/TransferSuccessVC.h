//
//  TransferSuccessVC.h
//  Caipiao
//
//  Created by GroupRich on 14-12-18.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface TransferSuccessVC : BaseViewController

@property(copy ,nonatomic)NSString *transferedText,*remainText;


@property (retain, nonatomic) IBOutlet UILabel *transferedCountL;
@property (retain, nonatomic) IBOutlet UILabel *remainCountL;
- (IBAction)btnclicked:(id)sender;

@end
