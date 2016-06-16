//
//  MSUtil.m
//  Musou
//
//  Created by luo danal on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUtil.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import <AudioToolbox/AudioToolbox.h>
void MSTransitionPushViewController(UINavigationController *navigationController, id controller){
    
    CATransition *t = [[CATransition alloc] init];
    t.type = kCATransitionPush,
    t.subtype = kCATransitionFromTop;
    t.duration = .4f;
    t.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [navigationController.view.layer addAnimation:t forKey:@"TRAN_PUSH"];
    [navigationController pushViewController:controller animated:NO];
    [t release];
    
}

void MSTransitionPopViewController(UINavigationController *navigationController){
    
    CATransition *t = [[CATransition alloc] init];
    t.type = kCATransitionPush,
    t.subtype = kCATransitionFromBottom;
    t.duration = .4f;
    t.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [navigationController.view.layer addAnimation:t forKey:@"TRAN_POP"];
    [navigationController popViewControllerAnimated:NO];
    [t release];
    
}

BOOL MSIsIPad(){
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

void MSShowMessage(NSString *msg){
    MSShowAlert(msg, nil, NSLocalizedString(@"OK", nil));
}

void MSShowAlertMessage(NSString *title, NSString *msg){
    MSShowAlert(msg, title, NSLocalizedString(@"OK", nil));
}

void MSShowAlert(NSString *msg, NSString *title, NSString *okButtonTitle){
    {   //Dismiss first if exisits
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *win in windows){
            for (UIView *view in win.subviews){
                if ([view isKindOfClass:[UIAlertView class]]) {
                    [(UIAlertView *)view dismissWithClickedButtonIndex:0 animated:NO];
                    break;
                }
            }
        }
    }
    
    if (okButtonTitle == nil) {
        okButtonTitle = NSLocalizedString(@"OK", nil);
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:okButtonTitle
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

void MSShowHUDMessage(NSString *msg,UIView *toView, MSHUDType type){
    UIFont *ft = [UIFont boldSystemFontOfSize:20.f];
    float w = 37, h = 37;
    NSString *title = @"√";
    if (type == MSHUDTypeFailed) {
        title = @"×";
    } else if (type == MSHUDTypeWarning) {
        title = msg;//@"!";
        ft = [UIFont boldSystemFontOfSize:16.f];
        CGSize size = CGSizeMake(160, 100);
        size = [msg sizeWithFont:ft constrainedToSize:size];
        w = size.width;
        h = size.height;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.numberOfLines = 0;
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = ft;
    label.text = title;
    hud.customView = label;
    [label release];
    hud.mode = MBProgressHUDModeCustomView;
    if (type != MSHUDTypeWarning) {
        hud.labelText = msg;
    }
    [hud show:YES];
    [hud hide:YES afterDelay:1.f];
    
}

//BOOL MSIsCacheExpired(NSString *typeKey){
//    NSString *strDate = [[NSUserDefaults standardUserDefaults] objectForKey:typeKey];
//    if (strDate != nil) {
//        NSDateFormatter *df = [[NSDateFormatter alloc] init];
//        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSDate *date = [df dateFromString:strDate];
//        int timeinterval = [[NSDate date] timeIntervalSinceDate:date];
//        [df release];
//        if (timeinterval >= kMSCacheExpiredTimeInterval) {
//            return YES;
//        } else {
//            return NO;
//        }
//    }
//    return YES;
//}

void MSUpdateCacheDate(NSDate *date, NSString *typeKey){
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [df stringFromDate:date];
    [[NSUserDefaults standardUserDefaults] setObject:strDate forKey:typeKey];
    [df release];
}

NSString *MSDateStrFormatted(NSString *dateStr){
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [df dateFromString:dateStr];
    int timeinterval = [now timeIntervalSinceDate:date];    //seconds
    NSString *str = nil;
    int hours = timeinterval/3600;   //hours
    int minutes = timeinterval/60;    //minutes
    if (timeinterval < 60) {
        str = @"刚刚";
    }
    else if (hours > 0 && hours < 24 ) {
        str = [NSString stringWithFormat:@"%d小时前", hours];
    } 
    else if (minutes > 0 && minutes < 60) {
        str = [NSString stringWithFormat:@"%d分钟前", minutes];
    } else {
        [df setDateFormat:@"MM-dd HH:mm"];
        str = [df stringFromDate:date];
    }
    [df release];
    return str;
}

void MSSetIntForKey(NSInteger ival,NSString *key){
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:ival] forKey:key];
}

NSInteger MSIntForKey(NSString *key){
    NSNumber *num = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return [num  integerValue];
}

void MSSetStrForKey(NSString *str,NSString *key){
    if ([str isEqual:[NSNull null]]) {
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:str forKey:key];
    }
}

NSString *MSStrForKey(NSString *key){
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

NSString *MSResPath(NSString *file){
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Musou" ofType:@"bundle"];
    return [path stringByAppendingPathComponent:file];
}

void PlayEffect(NSString *file){
    SystemSoundID soundID;
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:nil];  //caf,wav
    CFStringRef strRef = CFStringCreateWithCString(NULL, [path cStringUsingEncoding:NSUTF8StringEncoding], kCFStringEncodingUTF8);
    CFURLRef fileURL = CFURLCreateWithString(NULL, strRef, NULL);
    AudioServicesCreateSystemSoundID(fileURL,&soundID);
    CFRelease(fileURL);
    AudioServicesPlaySystemSound(soundID);
}

//void CGRectAddRoundedCornerPath(CGRect rect, float corner, CGContextRef c){
//    float x = rect.origin.x, y = rect.origin.y;
//    float w = rect.size.width, h = rect.size.height;
//    CGContextMoveToPoint(c, x, y + h/2);
//    //left-top
//    CGContextAddArcToPoint(c, x, y, x+w/2, y, corner);
//    //right-top
//    CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, corner);
//    //right-bottom
//    CGContextAddArcToPoint(c, x+w, y+h, x+w/2, y+h, corner);
//    //left-bottom
//    CGContextAddArcToPoint(c, x, y+h, x, y, corner);
//    CGContextClosePath(c);
//}

void CGRectAddRoundedCornerPath(CGRect rect, float corner, RounedCornerPosition position, CGContextRef c){
    float x = rect.origin.x, y = rect.origin.y;
    float w = rect.size.width, h = rect.size.height;
    CGContextMoveToPoint(c, x, y + h/2);
    
    switch (position) {
        case kRounderCornerPostionAll:
        {
            //left-top
            CGContextAddArcToPoint(c, x, y, x+w/2, y, corner);
            //right-top
            CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, corner);
            //right-bottom
            CGContextAddArcToPoint(c, x+w, y+h, x+w/2, y+h, corner);
            //left-bottom
            CGContextAddArcToPoint(c, x, y+h, x, y, corner);
        }
            break;
        case kRounderCornerPostionTop:
        {
            //left-top
            CGContextAddArcToPoint(c, x, y, x+w/2, y, corner);
            //right-top
            CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, corner);
            //right-bottom
            CGContextAddLineToPoint(c, x + w, y + h);
            //left-bottom
            CGContextAddLineToPoint(c, x, y + h);
        }
            break;
        case kRounderCornerPostionLeft:
        {
            //left-top
            CGContextAddArcToPoint(c, x, y, x+w/2, y, corner);
            //right-top
            CGContextAddLineToPoint(c, x + w, y);
            //right-bottom
            CGContextAddLineToPoint(c, x + w, y + h);
            //left-bottom
            CGContextAddArcToPoint(c, x, y+h, x, y, corner);
        }
            break;
        case kRounderCornerPostionBottom:
        {
            //left-top
            CGContextAddLineToPoint(c, x, y);
            //right-top
            CGContextAddLineToPoint(c, x + w, y);
            //right-bottom
            CGContextAddArcToPoint(c, x+w, y+h, x+w/2, y+h, corner);
            //left-bottom
            CGContextAddArcToPoint(c, x, y+h, x, y, corner);
        }
            break;
        case kRounderCornerPostionRight:
        {
            //left-top
            CGContextAddLineToPoint(c, x, y);
            //right-top
            CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, corner);
            //right-bottom
            CGContextAddArcToPoint(c, x+w, y+h, x+w/2, y+h, corner);
            //left-bottom
            CGContextAddLineToPoint(c, x, y + h);
        }
            break;
        default:
            break;
    }
    CGContextClosePath(c);
}