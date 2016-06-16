//
//  DropDownOptionView.h
//  Caipiao
//
//  Created by danal-rich on 13-11-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DropDownOptionView : UIView
{
    id _target;
    SEL _selector;
    UIView *_optionView;
}
@property (nonatomic) BOOL opened;
@property (assign, nonatomic) UILabel *textLbl;
@property (assign, nonatomic) UIImageView *rightView;
@property (strong, nonatomic) NSArray *options; //Options of text
@property (assign, nonatomic) int selectedIndex;

- (void)setCallback:(SEL)callback target:(id)target;
- (void)reloadOptions;

@end
