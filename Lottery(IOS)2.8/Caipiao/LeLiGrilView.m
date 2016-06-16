//
//  LeLiGrilView.m
//  Caipiao
//
//  Created by GroupRich on 15/1/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "LeLiGrilView.h"

@implementation LeLiGrilView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)know:(id)sender {
    [self removeFromSuperview];
    NSString *str = [NSString stringWithFormat:@"LeLiGrilView%@",[CDUserInfo user].userid];
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:str];
}

@end
