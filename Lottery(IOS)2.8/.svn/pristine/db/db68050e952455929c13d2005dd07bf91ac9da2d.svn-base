//
//  MSUtil.h
//  Musou
//
//  Created by luo danal on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Functions
 */

void MSTransitionPushViewController(id navigationController, id controller);

void MSTransitionPopViewController(id navigationController);

BOOL MSIsIPad();

void MSShowMessage(NSString *msg);

void MSShowAlertMessage(NSString *title, NSString *msg);

void MSShowAlert(NSString *msg, NSString *title, NSString *okButtonTitle);

typedef enum {
    MSHUDTypeOK = 1,
    MSHUDTypeFailed = 2,
    MSHUDTypeWarning = 3
} MSHUDType;

void MSShowHUDMessage(NSString *msg,UIView *toView,MSHUDType type);

BOOL MSIsCacheExpired(NSString *typeKey);

void MSUpdateCacheDate(NSDate *date, NSString *typeKey);

NSString *MSDateStrFormatted(NSString *dateStr);

void MSSetIntForKey(NSInteger ival,NSString *key);

NSInteger MSIntForKey(NSString *key);

void MSSetStrForKey(NSString *str,NSString *key);

NSString *MSStrForKey(NSString *key);

NSString *MSResPath(NSString *file);

void PlayEffect(NSString *file);

//void CGRectAddRoundedCornerPath(CGRect rect, float corner, CGContextRef c);
typedef enum {
    kRounderCornerPostionAll = 0,
    kRounderCornerPostionTop,
    kRounderCornerPostionLeft,
    kRounderCornerPostionBottom,
    kRounderCornerPostionRight,
} RounedCornerPosition;

void CGRectAddRoundedCornerPath(CGRect rect, float corner, RounedCornerPosition position, CGContextRef c);

//Tags

enum {
    kTagAlert1 = 10000,
    kTagAlert2,
    kTagButton1,
    kTagButton2,
    kTagSheet1,
    kTagSheet2,
    kTagView1,
    kTagView2,
};

/*
 * Marcos
 */

//Common
#define NilRelease(o) [o release]; o = nil;

//Debug
#ifdef DEBUG
#define MSLog(obj) NSLog(@"%@ | %s | line:%d",obj,__func__,__LINE__)
#define Echo(...) NSLog(__VA_ARGS__)
#else
#define MSLog(obj)
#define Echo(...)
#endif

//Shortcut
#define MSIntToStr(i) [NSString stringWithFormat:@"%ld",(long)i]
#define MSIntToNumber(i) [NSNumber numberWithInt:i]
#define MSIntegerToNumber(i) [NSNumber numberWithInteger:i]
#define MSFloatToStr(f) [NSString stringWithFormat:@"%f",f]

//Notification
#define MSNotificationCenterAddObserver(selector_,name_) [[NSNotificationCenter defaultCenter] addObserver:self selector:selector_ name:name_ object:nil]

#define MSNotificationCenterRemoveObserver() [[NSNotificationCenter defaultCenter] removeObserver:self]

#define MSNotificationCenterPost(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil]
#define MSNotificationCenterPostUserInfo(name, info) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:info]
