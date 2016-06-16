//
//  RQGetAdInfo.m
//  Caipiao
//
//  Created by cYrus_c on 13-11-15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQGetAdInfo.h"
#import "SSKeychain.h"

@implementation RQGetAdInfo

- (void)dealloc
{
    RELEASE(_dataList);
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self){
        self.url = kUrlGetAdInfo;
        _dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parse:(NSArray *)result
{
    if ([result isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary *dict in result) {
            BOOL enabled = [dict boolForKey:@"enabled"];
            if (!enabled) continue;
            
            AdInfoModel *model = [[AdInfoModel alloc] init];
            model.content = [dict stringForKey:@"content"];
            model.imageUrl = [dict stringForKey:@"img_url"];
            model.jumpUrl = [dict stringForKey:@"act_url"];
            
            NSString *userid =[[CDUserInfo user]userid];
//            NSData *userIdData = [userid dataUsingEncoding:NSUTF8StringEncoding];
//            NSData *userIdDataAES = [userIdData AES128EncryptWithKey:kAdInfoAESKey AndIV:kAESIV];
//            NSString *useridAesStr = [userIdDataAES hexadecimalString];
            model.jumpUrl = [model.jumpUrl stringByAppendingString:[NSString stringWithFormat:@"&userId=%@",userid]];
            model.jumpUrl = [model.jumpUrl stringByAppendingString:[NSString stringWithFormat:@"&uuid=%@",[self uuid]]];
            
            [_dataList addObject:model];
            [model release];
        }
        
        [[NSFileManager defaultManager] removeItemAtPath:kAdInfoCachePath error:nil];
        [NSKeyedArchiver archiveRootObject:result toFile:kAdInfoCachePath];
    }
}
-(NSString*) uuid
{
    NSString *uuid = [SSKeychain passwordForService:@"com.enjoy.Lottery"account:@"lottery_uuid"];
    if (uuid)
    {
        return uuid;
    }
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    [SSKeychain setPassword:result
                 forService:@"com.enjoy.Lottery"account:@"lottery_uuid"];
    return result;
    
}
+ (NSMutableArray *)getParsedAdInfo
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kAdInfoCachePath]) {
        
        NSArray *dataList = [NSKeyedUnarchiver unarchiveObjectWithFile:kAdInfoCachePath];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in dataList) {
            AdInfoModel *model = [[AdInfoModel alloc] init];
            model.content = [dict stringForKey:@"content"];
            model.imageUrl = [dict stringForKey:@"img_url"];
            model.jumpUrl = [dict stringForKey:@"act_url"];
            
     
            
            [result addObject:model];
            [model release];
        }
        
        return [result autorelease];
    }
    return nil;
}

+ (NSArray *)cachedAdInfo
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kAdInfoCachePath]) {
        NSArray *dataList = [NSKeyedUnarchiver unarchiveObjectWithFile:kAdInfoCachePath];
        return dataList;
    }
    return nil;
}

+ (void)clearCache
{
    [[NSFileManager defaultManager] removeItemAtPath:kAdInfoCachePath error:nil];
}

+(void)saveCurrentRequestTime
{
      [[NSUserDefaults standardUserDefaults]setObject:[NSDate date]forKey:@"kAdInfo"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(void)removeLastRequestTime
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"kAdInfo"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}
+(BOOL)needRequestAdinfoAgain
{
    NSDate *lasttime = [[NSUserDefaults standardUserDefaults]objectForKey:@"kAdInfo"];
    if (!lasttime) {
        return YES;
    }else
    {
        NSDate *nowtime = [NSDate date];
        NSTimeInterval interval = [nowtime timeIntervalSinceDate:lasttime];
        NSLog(@"*****nowTimeInterval:%f",interval);

        if (interval>=2.0*60*60) {
            return YES;
        }else
            return NO;
    }
}
@end
