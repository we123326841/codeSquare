//
//  IconTextButton.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "IconTextButton.h"

@implementation IconTextButton
@synthesize identifier = _identifier;
@synthesize badgeNumber = _badgeNumber;
@synthesize hideBadge = _hideBadge;

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
        MSNotificationCenterAddObserver(@selector(updateNumber:), kNotificationUpdateButtonBadge);
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
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 10.f, 0, 0);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    self.titleLabel.shadowColor = [UIColor blackColor];
    [self setTitleColor:kYellowTextColor forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlEventTouchDown];
    
    if (_badge == nil) {
        UIImage *image = [UIImage imageWithResFile:@"badge.png"];
//        image  = [image resizableImageWithLeftCap:10 topCap:0 width:10 height:image.size.height];
        image =[image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10,
                                                                   image.size.height - 10 -1 , image.size.width - 10 - 1)];
        _badge = [[UIImageView alloc] initWithImage:image];
        CGRect rect = _badge.bounds;
        rect.size.width -= 3.f;
        rect.size.height -= 3.f;
        rect.origin.y -= 1.f;
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
    _badge.frame = CGRectMake(frame.size.width/2 + 20.f,
                              -_badge.bounds.size.height/2,
                               _badge.bounds.size.width, _badge.bounds.size.height);
}

- (void)setBadgeNumber:(int)badgeNumber{
    _badge.hidden = badgeNumber == 0;
    NSString *text = badgeNumber < 100 ? @(badgeNumber).stringValue : @"99+";
    CGFloat w = _badge.bounds.size.width;
    if ([text length] > 2) {
        w = 36.f;
    }
    _badge.bounds = CGRectMake(0, 0, w, _badge.bounds.size.height);
    CGRect rect = _badge.bounds;
    rect.size.width -= 3.f;
    rect.size.height -= 3.f;
    rect.origin = CGPointMake(1.f, -1.f);
    _badgeLbl.frame = rect;
    _badgeLbl.text = text;
}

- (void)updateNumber:(NSNotification *)noti{
    if (_hideBadge) {
        [self setBadgeNumber:0];
        return;
    }
    NSNumber *identifier  = [noti.userInfo objectForKey:@"Identifier"];
    if ([identifier intValue] == self.identifier) {
        NSNumber *n = [noti.userInfo objectForKey:@"Number"];
        [self setBadgeNumber:[n intValue]];
    }
}

+ (void)postNumberNotification:(int)number identifier:(int)identifier{
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObject:
                          [NSNumber numberWithInt:number] forKey:@"Number"];
    [info setObject:[NSNumber numberWithInt:identifier] forKey:@"Identifier"];
    MSNotificationCenterPostUserInfo(kNotificationUpdateButtonBadge, info);
}

@end
