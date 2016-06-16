//
//  BadgeButton.m
//  Caipiao
//
//  Created by danal on 13-1-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BadgeButton.h"

#define kNotificationName @"BadgeButton"

@implementation BadgeButton
@synthesize badgeNumber = _badgeNumber;

- (void)dealloc{
    MSNotificationCenterRemoveObserver();
    [_badge release];
    [_badgeLbl release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        MSNotificationCenterAddObserver(@selector(updateNumber:), kNotificationName);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (_badge == nil) {
        _badge = [[UIImageView alloc] initWithImage:[UIImage imageWithResFile:@"ico_game_number_tip.png"]];
        CGRect rect = _badge.bounds;
        rect.size.width -= 3.f;
        rect.size.height -= 3.f;
        _badgeLbl = [[UILabel alloc] initWithFrame:rect];
        _badgeLbl.backgroundColor = [UIColor clearColor];
        _badgeLbl.font = [UIFont boldSystemFontOfSize:12.f];
        _badgeLbl.textColor = [UIColor whiteColor];
        _badgeLbl.textAlignment = UITextAlignmentCenter;
        [_badge addSubview:_badgeLbl];
        [self addSubview:_badge];
        _badge.hidden = YES;
    }
    _badge.frame = CGRectMake(frame.size.width - _badge.bounds.size.width, -_badge.bounds.size.height/2,
                              _badge.bounds.size.width, _badge.bounds.size.height);
}

- (void)setBadgeNumber:(int)badgeNumber{
    _badgeLbl.text = badgeNumber < 100 ? MSIntToStr(badgeNumber) : @"99+";
    _badge.hidden = badgeNumber == 0;
}

- (void)updateNumber:(NSNotification *)noti{
    NSNumber *n = [noti.userInfo objectForKey:@"Number"];
    [self setBadgeNumber:[n intValue]];
}

+ (void)postNumberNotification:(int)number{
    NSDictionary *info = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:number] forKey:@"Number"];
    MSNotificationCenterPostUserInfo(kNotificationName, info);
}

@end
