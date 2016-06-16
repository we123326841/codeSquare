//
//  UIAlertView+Additions.h
//  Caipiao
//
//  Created by danal on 13-6-11.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIAlertView (ButtonAdditions)

//- (UILabel *)titleLabel;
//- (UILabel *)messageLabel;
- (UIButton *)buttonAtIndex:(NSInteger)index;
- (void)setEnabled:(BOOL)enabled forButtonAtIndex:(NSInteger)index;
@end
