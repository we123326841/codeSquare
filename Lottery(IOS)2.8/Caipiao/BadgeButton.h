//
//  BadgeButton.h
//  Caipiao
//
//  Created by danal on 13-1-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeButton : UIButton
{
    UIImageView *_badge;
    UILabel *_badgeLbl;
}

@property (assign, nonatomic) int badgeNumber;

+ (void)postNumberNotification:(int)number;

@end
