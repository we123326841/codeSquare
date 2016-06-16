//
//  BallItem.m
//  Caipiao
//
//  Created by danal-rich on 14-2-10.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BallItem.h"

@implementation BallItem

- (void)dealloc{
    self.text = nil;
    self.value = nil;
    self.numberFormat = nil;
    [super dealloc];
}

- (id)initWithStyle:(BallStyle)style text:(NSString *)text value:(NSString *)value{
    self = [super init];
    if (self){
        self.style = style;
        self.text = text;
        self.value = value;
        self.frameSize = kDefaultSize;
    }
    return self;
}

@end
