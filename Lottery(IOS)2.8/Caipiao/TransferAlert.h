//
//  TransferAlert.h
//  Caipiao
//
//  Created by GroupRich on 14-10-28.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferAlert : UIView
@property (copy, nonatomic) void(^clickedBlock)();
- (IBAction)ikonw:(id)sender;
@end
