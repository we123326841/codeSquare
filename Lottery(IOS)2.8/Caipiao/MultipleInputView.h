//
//  MultipleInputView.h
//  Caipiao
//
//  Created by danal on 13-1-8.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleInputView : UIView
{
    UILabel *_tipsLbl;
    NSTimer *_timer;
}
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIImageView *background;
@property (readonly, nonatomic) UILabel *tipsLbl;
@end
