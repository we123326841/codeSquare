//
//  IconTextButton.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNotificationUpdateButtonBadge @"NotificationUpdateButtonBadge"

@interface IconTextButton : UIButton
{
    UIImageView *_badge;
    UILabel *_badgeLbl;
}
@property (assign, nonatomic) int identifier;
@property (assign, nonatomic) int badgeNumber;
@property (nonatomic) BOOL hideBadge;

+ (void)postNumberNotification:(int)number identifier:(int)identifier;

@end
