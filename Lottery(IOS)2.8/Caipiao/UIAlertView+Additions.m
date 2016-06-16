//
//  UIAlertView+Additions.m
//  Caipiao
//
//  Created by danal on 13-6-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UIAlertView+Additions.h"

@implementation UIAlertView (ButtonAdditions)

//- (UILabel *)titleLabel{
//    for (UIView *v in self.subviews){
//        if ([v isKindOfClass:[UILabel class]]) {
//            return (UILabel *)v;
//        }
//    }
//    return nil;
//}
//
//- (UILabel *)messageLabel{
//    int count = 0;
//    for (UIView *v in self.subviews){
//        if ([v isKindOfClass:[UILabel class]]) {
//            if (count == 1) return (UILabel *)v;
//            count++;
//        }
//    }
//    return nil;
//}

- (UIButton *)buttonAtIndex:(NSInteger)index{
    for (UIView *v in self.subviews){
        if ([v isKindOfClass:NSClassFromString(@"UIAlertButton")]) {
            UIButton *but = (UIButton *)v;
            NSString *title = but.titleLabel.text;
            if ([title isEqualToString:[self buttonTitleAtIndex:index]]) {
                return but;
            }
        }
    }
    return nil;
}

- (void)setEnabled:(BOOL)enabled forButtonAtIndex:(NSInteger)index{
    for (UIView *v in self.subviews){
        if ([v isKindOfClass:NSClassFromString(@"UIAlertButton")]) {
            UIButton *but = (UIButton *)v;
            NSString *title = but.titleLabel.text;
            if ([title isEqualToString:[self buttonTitleAtIndex:index]]) {
                but.enabled = NO;
                break;
            }
        }
    }    
}

@end
