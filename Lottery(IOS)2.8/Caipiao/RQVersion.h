//
//  RQVersion.h
//  Caipiao
//
//  Created by danal on 13-7-2.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

@interface RQVersion : RQBase
@property (strong, nonatomic) NSString *appType;
@property (strong, nonatomic) NSString *version, *downloadUrl;
@property (nonatomic) BOOL mustUpgrade;
@property (nonatomic,copy)NSString*msg;
+ (void)checkVersion;

@end


@interface RQAddDownloadCount : RQBase

@property (assign, nonatomic) NSInteger status;

@end

