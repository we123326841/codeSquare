//
//  IconInputTextField.h
//  Caipiao
//
//  Created by danal on 13-1-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  IconInputTextFieldDelegate;

@interface IconInputTextField : UIView
<UITextFieldDelegate>
{
    UIImageView *_bgView;
    UIImageView *_leftIcon;
    UIButton *_rightIcon;
    UITextField *_textField;
}
@property (assign, nonatomic) id<IconInputTextFieldDelegate> delegate;
@property (strong, nonatomic) UITextField *textField;
@property (assign, nonatomic) UIImage *leftImage;
@property (assign, nonatomic) UIImage *rightImage;
@property (readonly, nonatomic) UIButton *rightIcon;
@end


@protocol IconInputTextFieldDelegate <NSObject>
@optional
- (void)iconInputTextFieldTextChanged:(IconInputTextField *)textField;
@end