//
//  HigherChaseSetting.h
//  Caipiao
//
//  Created by 王浩 on 15/12/1.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMTableViewController.h"
@class HigherChaseSetting;
@class HighChaseNumType;
@protocol HigherChaseSettingDelegate<NSObject>
-(void)higherChase:(HigherChaseSetting*)chaseSetting popFinished:(HighChaseNumType*)numType;

@end
@interface HigherChaseSetting : BaseViewController

@property(nonatomic,weak)id<HigherChaseSettingDelegate> delegate;
@end
