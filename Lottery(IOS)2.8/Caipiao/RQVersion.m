//
//  RQVersion.m
//  Caipiao
//
//  Created by danal on 13-7-2.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQVersion.h"
#import "UpdateView.h"
#import "AppDelegate.h"
@implementation RQVersion

- (void)dealloc{
    [_version release];
    [_downloadUrl release];
    [_msg release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlVersion;
    }
    return self;
}

- (void)setAppType:(NSString *)appType{
//    [self setValue:appType forField:@"app_type"];
}

- (void)parse:(NSDictionary *)result{
    self.version = [result stringForKey:@"version"];
    self.downloadUrl = [result stringForKey:@"downloadUrl"];
    self.mustUpgrade = [result boolForKey:@"must_upgrade"];
    self.msg = [result stringForKey:@"msg"];
}

+ (void)checkVersion
{
    RQVersion *v = [[RQVersion alloc] init];
    [v startPostWithBlock:^(RQVersion* rq_, NSError *error_, id rqSender_) {
        NSString *currentVersion = [NSBundle appVersion];
        if ([rq_.version compare:currentVersion] == NSOrderedDescending) {
            NSString*  msg = rq_.msg;
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[msg dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            UpdateView *alrt = [UpdateView loadFromNib];
            if(rq_.mustUpgrade)
            {
                alrt.leftbtn.enabled = false;
            }
            alrt.alertL.attributedText = attrStr;
            alrt.titleL.text  = [@"更新提示" stringByAppendingString:rq_.version==nil?@"":([NSString stringWithFormat:@"(%@)",rq_.version])];
            alrt.clickedBlock = ^(NSInteger index){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rq_.downloadUrl]];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ShowIntro"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [SharedModel signOut];
                abort();
            };
            [[AppDelegate shared].window addSubview:alrt];

        }

        [rq_ release];
    } sender:nil];
}

@end


@implementation RQAddDownloadCount

- (void)prepare
{
    self.url = kUrlAddDownloadCount;
    self.silent = YES;
    [self setValue:@"1" forField:@"initial"];
    [self setValue:[NSBundle appVersion] forField:@"version"];
    [super prepare];
}

- (void)parse:(NSDictionary *)result
{
    self.status = [result intForKey:@"status"];
}

@end

