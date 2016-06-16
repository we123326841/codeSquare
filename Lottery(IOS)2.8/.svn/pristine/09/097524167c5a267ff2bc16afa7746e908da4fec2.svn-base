//
//  AppDelegate.m
//  Caipiao
//
//  Created by danal on 13-1-3.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "AppDelegate.h"
#import "HallViewController.h"
#import "LotteryPublicViewController.h"
#import "AddUserViewController.h"
#import "UserListViewController.h"
#import "SignViewController.h"

#import "StoredModel.h"

#import "RQInitData.h"
#import "RQVersion.h"
#import "RQServerTime.h"
#import "RQPublicHistory.h"
#import "RQPush.h"
#import "RQGetAdInfo.h"
#import "IssueItem.h"
#import "IntroView.h"
#import "CDLottery.h"
#import "CDMenuItem.h"
#import "LotteryTimer.h"

#import "GRShareManager.h"
#import "MSTabBarController.h"
//#import "IQKeyboardManager.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIView *cover;
@property (strong, nonatomic) UIImageView *secCover;
@property (strong, nonatomic) NSTimer *serverTimer;
@property (copy, nonatomic) NSString *upgradeUrl;
@property (nonatomic) CoverType coverType;

@end

@implementation AppDelegate

- (void)dealloc
{
    [_deviceToken release];
    [_serverTimer release];
    [_cover release];
    [_secCover release];
    [_nav release];
    [_tab release];
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [_methodList release];
    [_colorPool release];
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    
    
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = NO;

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
        application.statusBarStyle = UIStatusBarStyleBlackOpaque;
#ifdef __IPHONE_7_0
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
#endif
    
    [StoredModel setContext:self.managedObjectContext];
    [SharedModel resetAllMethodTips];
    
    //只会setup数据一次
    [CDLottery setupForApp];
    
    //玩法列表
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MethodList" ofType:@"plist"];
    _methodList = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //色彩
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Resources.bundle" ofType:nil];
    path = [path stringByAppendingPathComponent:kColorPlist];
    _colorPool = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    _nav = [[NavigationController alloc] init];
    _nav.navigationBarHidden = YES;
    self.window.rootViewController = _nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [Flurry startSession:kFlurryAPPKey];
    
    [RQGetAdInfo removeLastRequestTime];
    //Introductions
    NSString *introVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"IntroVersion"];
    if (introVersion == nil || [introVersion compare:[NSBundle appVersion]] != NSOrderedSame) {
       // [CDHotLottery deleteAll];
        [application setStatusBarHidden:YES];
//        NSArray *imageFiles = IPHONE4
//        ? @[Res(@"wt1-960.jpg"),Res(@"wt2-960.jpg"),Res(@"wt3-960.jpg")]
//        : @[Res(@"wt1.jpg"),Res(@"wt2.jpg"),Res(@"wt3.jpg")];
        NSArray *imageFiles = IPHONE4
        ? @[Res(@"wt1-960.jpg"),Res(@"wt2-960.jpg"),Res(@"wt3-960.jpg")]
        : @[Res(@"wt1.jpg"),Res(@"wt2.jpg"),Res(@"wt3.jpg")];
        IntroView *introView = [[IntroView alloc] initWithFrame:_window.bounds];
        introView.comblock=^(void){
            if ([SharedModel userIsSignedin]){
                [[UIApplication sharedApplication]setStatusBarHidden:NO];
                [self pushInTab];
            } else {
                [[UIApplication sharedApplication]setStatusBarHidden:NO];
                SignViewController *sign = [SignViewController new];
                sign.isAutoLogin = [SharedModel userIsSignedin];
                UINavigationController *nav = [[NavigationController alloc] initWithRootViewController:sign];
                [_nav pushNavigationController:nav animated:NO];
                [nav release];
                [sign release];
            }
        };
        [introView setImages:imageFiles];
        [self.window addSubview:introView];
        [introView release];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSBundle appVersion] forKey:@"IntroVersion"];
    }else {
        [[UIApplication sharedApplication]setStatusBarHidden:NO];
        if ([SharedModel userIsSignedin]){
            [self pushInTab];
        } else {
            SignViewController *sign = [SignViewController new];
            sign.isAutoLogin = [SharedModel userIsSignedin];
            UINavigationController *nav = [[NavigationController alloc] initWithRootViewController:sign];
            [_nav pushNavigationController:nav animated:NO];
            [nav release];
            [sign release];
        }
    }
    
    //Launch image
    UIImage *image = IPHONE4 ? [UIImage imageNamed:@"Default@2x.png"] : [UIImage imageNamed:@"Default-568h@2x.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0.f, 0.f, _window.bounds.size.width, _window.bounds.size.height);
    [self.window addSubview:imageView];
    self.cover = imageView;
    [imageView release];
    
    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(removeCover) userInfo:nil repeats:NO];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMdd";
    NSString *strCurrDate = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    
    self.coverType = kCoverTypeNone; //闪屏测试在这里修改，改成另外两个看效果
    if ([strCurrDate intValue] >= 128 && [strCurrDate intValue] <= 211) {
        self.coverType = kCoverTypeChunjie;
    }
    if ([strCurrDate intValue] >= 212 && [strCurrDate intValue] <= 215) {
        self.coverType = kCoverTypeYuanxiao;
    }
    
    if (self.coverType == kCoverTypeChunjie || self.coverType == kCoverTypeYuanxiao) {
        [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(addSecCover) userInfo:nil repeats:NO];
    }
    
    //Push
//    application.applicationIconBadgeNumber = 0;
//    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
#if IPHONE_OS_VERSION_MAX_ALLOWED >= IPHONE_8_0
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    } else {
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        
    }
    
#else
    
    // [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
#endif
    
    
    
    
    
    
    //下载次数接口（记录的版本小于当前软件版本APP_VERSION时调用）
    NSString *recordedVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"UD_FIRSTRUNVERSION"];
    NSString *appVersion = [NSBundle appVersion];
    if ([recordedVersion compare:appVersion] == NSOrderedAscending || [recordedVersion length] == 0) {
        RQAddDownloadCount *rq = [[[RQAddDownloadCount alloc] init] autorelease];
        [rq startPostWithBlock:^(RQAddDownloadCount *rq_, NSError *error_, id rqSender_) {
            if (!rq_.msgContent && rq_.status == 1) {
                [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:@"UD_FIRSTRUNVERSION"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        } sender:nil];
    }
    
    [[GRShareManager sharedInstance]configurationShareEnvironment];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //当期结束提前60秒提醒
    if (self.timeRemaining > 60) {
        //Check settings
        NSInteger startClock = [SharedModel shared].pushEndClock;
        NSInteger endClock = [SharedModel shared].pushEndClock;
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
        df.dateFormat = @"HH";
        int nowHour = [[df stringFromDate:nowDate] intValue];
        Echo(@"NOW:%d|%@",nowHour,nowDate);
        //Alert during these time
        if (nowHour >= startClock && nowHour <= endClock) {
            
            NSString *msg = [NSString stringWithFormat:@"重庆时时彩%@期即将结束，请尽快下单！",[IssueItem current].issueNumber];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:self.timeRemaining - 60];
            UILocalNotification *noti = [[[UILocalNotification alloc] init] autorelease];
            noti.repeatInterval = 0;
            noti.alertBody = msg;
            noti.fireDate = date;
            [application scheduleLocalNotification:noti];
        }
        
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    if ([SharedModel userIsSignedin]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *strLastUpdateDate = [ud stringForKey:kUserDefaultsLastUpdateUserPointDate];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMdd";
        NSString *strCurrDate = [formatter stringFromDate:[NSDate date]];
        [formatter release];
        
        if (![strLastUpdateDate isEqualToString:strCurrDate]) {
            Echo(@"*****Update User Point **********");
            MSNotificationCenterPost(kNotificationUserPointUpdated);
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [application cancelAllLocalNotifications];
//    [RQVersion checkVersion];
    [self requestInitData];
    [self requestBalance];
    [[SimpleLotteryTimer shared] requestServerTime];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@",error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [NSString stringWithFormat:@"%@",deviceToken];
    token = [token stringByReplacingOccurrencesOfString:@"[ <>]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [token length])];    //remove <> and whitespace
    self.deviceToken = token;
    if ([[SharedModel shared] userid]){ //Logined
        
        RQPush *push = [[[RQPush alloc] init] autorelease];
        push.deviceToken = self.deviceToken;
        push.userId = [[SharedModel shared] userid];
        [push startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            
        } sender:nil];
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    application.applicationIconBadgeNumber = 0;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Caipiao" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Caipiao.sqlite"];
    
    NSDictionary *option = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,
                            [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                            nil];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:option error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        
//        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Time

enum {
    kHour = 0,
    kMinute = 1,
    kSecond = 2
};

static int timeComponents[3] = {0,0,0};

- (void)timerSelector{

    self.timeRemaining--;
    if (self.timeRemaining > 0) {
    }
    else {      //time over,request next issue
        [_timer invalidate];
        _timer = nil;
        
        [self requestInitData];
        
    }
}

- (void)fireTimer{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)updateTime{
    //每30秒矫正时间
    if (self.timeRemaining > 30) {
        RQServerTime *rq = [[RQServerTime alloc] init];
        [rq startGetWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            [self.serverTimer invalidate];
            self.serverTimer = [NSTimer scheduledTimerWithTimeInterval:30.f target:self selector:@selector(updateTime) userInfo:nil repeats:NO];
            [rq_ release];
        } sender:nil];
    }
}

- (void)setStrTimeRemaining:(NSString *)time{
    //time format: hh:MM:ss
    NSArray *components = [time componentsSeparatedByString:@":"];
    int index = kHour;
    for (NSString *s in components){
        timeComponents[index] = [s intValue];
        index++;
    }
    
    self.timeRemaining = timeComponents[kHour]*60*60 + timeComponents[kMinute]*60 + timeComponents[kSecond];
    [self fireTimer];
}

- (NSString *)timeRemainingStr{
    int day = self.timeRemaining/(24*3600);
    int hour = self.timeRemaining/3600;
    int minute = self.timeRemaining%3600/60;
    int second = self.timeRemaining%60;
    NSString *s;
    //Deprecated format
    s = day == 0
    ? [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second]
    : [NSString stringWithFormat:@"%d天%02d:%02d:%02d",day, hour,minute,second];
    
    //New format
    s =  hour == 0
    ? [NSString stringWithFormat:@"%02d:%02d",minute,second]
    : [NSString stringWithFormat:@"%d:%02d:%02d",hour,minute,second]
    ;
    return s;
}

- (void)setStrTimeRemainingFromStart:(NSString *)startTime toEnd:(NSString *)endTime{
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    NSDate *startDate = [df dateFromString:startTime];
    NSDate *endDate = [df dateFromString:endTime];
    int timeInterval = [endDate timeIntervalSinceDate:startDate];
    self.timeRemaining = timeInterval;
    [self fireTimer];
    Echo(@"str:%@->%@",startTime,endTime);
}

- (void)requestInitData{
    if ([SharedModel userIsSignedin]) {
        self.timeRemaining = 0;
        
    }
}

- (void)requestBalance{
    [RQGetBalance getBalance:^(RQBase *rq, NSError *error, id sender) {
        if (rq.msgType == kMessageTypeSessionExpired){
            [SharedModel shared].username = nil;
            [SharedModel shared].balance = 0;
            [SharedModel shared].token = nil;
            MSNotificationCenterPost(kNotificationUserInfoUpdated);
            [self.menuController swithToMenuIndex:kMenuIndexSign];
        }
    }];
}

- (void)addSecCover
{
    UIImage *secImage = nil;
    if (self.coverType == kCoverTypeChunjie) {
        secImage = [UIImage imageNamed:@"cover_chunjie.png"];
    }else if (self.coverType == kCoverTypeYuanxiao) {
        secImage = [UIImage imageNamed:@"cover_yuanxiao.png"];
    }
    UIImageView *secImageView = [[UIImageView alloc] initWithImage:secImage];
    secImageView.frame = CGRectMake(0.f, 0.f, secImage.size.width, secImage.size.height);
//    secImageView.center = _window.center;
    [self.window addSubview:secImageView];
    self.secCover = secImageView;
    [secImageView release];
    
    [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(removeSecCover) userInfo:nil repeats:NO];
}

- (void)removeCover{
    [UIView animateWithDuration:.3f animations:^{
        self.cover.alpha = 0.f;
    } completion:^(BOOL finished){
        [self.cover removeFromSuperview];
    }];
}

- (void)removeSecCover{
    [UIView animateWithDuration:.3f animations:^{
        self.secCover.alpha = 0.f;
    } completion:^(BOOL finished){
        [self.secCover removeFromSuperview];
    }];
}

- (void)pushInTab{
    UIViewController *vc1 = [[NSClassFromString(@"HomeViewController") new] autorelease];
    UIViewController *vc2 = [[NSClassFromString(@"HallViewController") new] autorelease];
    UIViewController *vc3 = [[NSClassFromString(@"LotteryPublicViewController") new] autorelease];
    UIViewController *vc4 = [[NSClassFromString(@"MyAccountViewController") new] autorelease];
    MSTabBarController *tab = [[[MSTabBarController alloc] init] autorelease];
    tab.view.backgroundColor = [UIColor whiteColor];
    tab.hidesBottomBarWhenPushed = YES;
    [tab setControllers:@[vc1,
                          [[NavigationController new:vc2] autorelease],
                          [[NavigationController new:vc3] autorelease],
                          vc4,
                          ]
            tabBarItems:@[[MSTabBarItem itemWithTitle:@"精彩推荐" image:ResImage(@"tab-feature-icon") imageOn:nil],
                          [MSTabBarItem itemWithTitle:@"购彩大厅" image:ResImage(@"tab-mall-icon") imageOn:nil],
                          [MSTabBarItem itemWithTitle:@"开奖走势" image:ResImage(@"tab-trend-icon") imageOn:nil],
                          [MSTabBarItem itemWithTitle:@"我的账户" image:ResImage(@"tab-user-icon") imageOn:nil]
                          ]
     ];
    self.tab = tab;
    NSMutableArray *controllers = [_nav.viewControllers mutableCopy];
    [controllers removeAllObjects];
    [controllers addObject:tab];
    [_nav setViewControllers:controllers animated:YES];
    [controllers release];
}

- (void)backToLogin{
//    [[CDUserInfo user] destroy];
    [SharedModel signOut];
    [RQGetAdInfo removeLastRequestTime];
    Echo(@"%@",self.nav.viewControllers);
    UIViewController *root = [self.nav.viewControllers firstObject];
    if (![root isKindOfClass:[UITabBarController class]]){
        return;
    }
    
    self.tab = nil;
    SignViewController *sign = [SignViewController new];
    UINavigationController *nav = [[NavigationController alloc] initWithRootViewController:sign];
    UINavigationController *rootNav = [[NavigationController alloc] init];
    [rootNav pushNavigationController:nav animated:NO];
    
    NSMutableArray *controllers = [self.nav.viewControllers mutableCopy];
    [controllers insertObject:rootNav.topViewController atIndex:0];
    [self.nav setViewControllers:controllers animated:NO];
    [self.nav popToRootViewControllerAnimated:YES];
    [controllers release];
    [rootNav release];
    [nav release];
    [sign release];

}

#pragma mark - Class methods

+ (AppDelegate *)shared{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (LeftViewController *)leftMenuController{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] menuController];
}

+ (SideMenuController *)sideMenuController{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] smc];
}

+ (UIColor *)color:(NSString *)colorKey{
    AppDelegate *dele = (id)[UIApplication sharedApplication].delegate;
    return [UIColor rgbColorWithHex:[dele.colorPool objectForKey:colorKey]];
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.absoluteString hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:[GRShareManager sharedInstance]];
    }else if ([url.absoluteString hasPrefix:@"tencent1104813302"])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
//    else if ([url.absoluteString hasPrefix:@"phlotto"]){
//        if ([url.absoluteString compare:@"phlotto://go_lottolobby"]==NSOrderedSame) {
//            [[self nav] popToRootViewControllerAnimated:YES];
//        }
//    }
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.absoluteString hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:[GRShareManager sharedInstance]];
    }else if ([url.absoluteString hasPrefix:@"tencent1104813302"])
    {
        return [TencentOAuth HandleOpenURL:url];
    }else if ([url.absoluteString hasPrefix:@"phlotto"]){
        if ([url.absoluteString compare:@"phlotto://go_lottolobby"]==NSOrderedSame) {
            [[self nav] popToRootViewControllerAnimated:YES];
        }

    }
    return YES;
}
@end
