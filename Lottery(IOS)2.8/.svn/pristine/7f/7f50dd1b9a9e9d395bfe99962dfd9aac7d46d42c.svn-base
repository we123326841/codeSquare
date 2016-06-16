//
//  AppDelegate.h
//  Caipiao
//
//  Created by danal on 13-1-3.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "SideMenuController.h"
#import "Flurry.h"

#define kNotificationDataInitialized @"NotificationDataInitialized"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSTimer *_timer;
    BOOL    _inLoginView;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;
@property (strong, nonatomic) UITabBarController *tab;
@property (strong, nonatomic) LeftViewController *menuController;
@property (strong, nonatomic) SideMenuController *smc;
@property (assign, nonatomic) int timeRemaining;
@property (strong, nonatomic) NSDictionary *colorPool;
@property (strong, nonatomic) NSDictionary *methodList;
@property (copy, nonatomic) NSString *deviceToken;

//CoreData
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)setStrTimeRemaining:(NSString *)time DEPRECATED_ATTRIBUTE;

- (NSString *)timeRemainingStr;

- (void)setStrTimeRemainingFromStart:(NSString *)startTime toEnd:(NSString *)endTime;

- (void)requestInitData;

/* Reqeust balance and save  */
- (void)requestBalance;

/* Push the tabbar controller in */
- (void)pushInTab;

/* Back to login controller*/
- (void)backToLogin;

+ (AppDelegate *)shared;
+ (LeftViewController *)leftMenuController;
+ (SideMenuController *)sideMenuController;
+ (UIColor *)color:(NSString *)colorKey;

@end

static NSString * const kColorPlist = @"_Colors.plist";
