//
//  RQGetAdInfo.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"
#import "AdInfoModel.h"
#import "WebImageView.h"
#define kAdInfoCachePath [NSString stringWithFormat:@"%@/Library/Caches/AdInfo.plist",NSHomeDirectory()]

@interface RQGetAdInfo : RQBase

//response
@property (strong, nonatomic) NSMutableArray *dataList;

+ (NSMutableArray *)getParsedAdInfo;
+ (NSArray *)cachedAdInfo;
+ (void)clearCache;
+(void)saveCurrentRequestTime;
+(BOOL)needRequestAdinfoAgain;
+(void)removeLastRequestTime;
@end
