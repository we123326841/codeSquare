//
//  UnderlineLabel.h
//  Caipiao
//
//  Created by danal on 13-6-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnderlineLabel : UILabel
{
    id _target;
    SEL _selector;
}
@property (assign, nonatomic) UIImageView *accessory;

- (void)setClickCallback:(SEL)sel target:(id)target;
@end
