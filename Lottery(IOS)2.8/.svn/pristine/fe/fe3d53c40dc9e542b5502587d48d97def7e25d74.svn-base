//
//  RQPush.m
//  Caipiao
//
//  Created by danal-rich on 4/8/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "RQPush.h"

@implementation RQPush

- (void)dealloc{
    self.userId = nil;
    self.deviceToken = nil;
    [super dealloc];
}

- (BOOL)shouldDirectlyParse{
    return YES;
}

- (void)prepare{
    self.url = kUrlPushRegister;

    [self setValue:self.userId forField:@"userid"];
    [self setValue:self.deviceToken forField:@"deviceid"];
    
    [super prepare];
}

- (void)parse:(id)result{
}

@end



@implementation RQPushSwitchInfo

- (void)dealloc{
    self.userId = nil;
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlPushSwitchInfo;
    
    [self setValue:self.userId forField:@"userid"];
    
    [super prepare];
}

- (BOOL)shouldDirectlyParse{
    return YES;
}

- (void)parse:(id)result{
//    if ([result isKindOfClass:[NSArray class]]){
//        if ([(NSArray *)result count] > 0){
//            NSDictionary *d = [result objectAtIndex:0];
            self.isOpen = [[result objectForKey:@"openstatus"] boolValue];
//        }
//    }
}

@end


@implementation RQPushSwitchSet

- (void)dealloc{
    self.userId = nil;
    [super dealloc];
}

- (BOOL)shouldDirectlyParse{
    return YES;
}

- (void)prepare{
    self.url = kUrlPushSwitchSet;
    
    [self setValue:self.userId forField:@"userid"];
    [self setValue:[NSString stringWithFormat:@"%d",self.isOpen] forField:@"openstatus"];
    [super prepare];
}

- (void)parse:(id)result{
    if ([result isKindOfClass:[NSDictionary class]]){
        self.msgType = [[result objectForKey:@"messagetype"] integerValue];
    }
}

@end