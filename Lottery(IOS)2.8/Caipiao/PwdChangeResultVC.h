//
//  PwdChangeResultVC.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface PwdChangeResultVC : BaseViewController {
    NSTimer *_timer;
    int _count;
}

@property (assign, nonatomic) PasswordType passwordType;

@end
