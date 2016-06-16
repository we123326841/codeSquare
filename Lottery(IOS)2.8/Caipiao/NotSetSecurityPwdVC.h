//
//  NotSetSecurityPwdVC.h
//  Caipiao
//
//  Created by GroupRich on 14-11-17.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"

@class  NotSetSecurityPwdVC;

typedef void (^BtnClickedBlock)(NotSetSecurityPwdVC *vc);


@interface NotSetSecurityPwdVC : BaseViewController

PCOPY BtnClickedBlock clickedBlock;

- (IBAction)settingPwd:(id)sender;

@end
