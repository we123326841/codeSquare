//
//  TextFiledDialog.h
//  Caipiao
//
//  Created by 王浩 on 15/10/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RQOpenLinkList.h"
@class TextFiledDialog;
typedef enum{
    TextFiledDialogButtonTypeSure,
    TextFiledDialogButtonTypeCancel
}TextFiledDialogButtonType;

@protocol TextFiledDialogDelegate<NSObject>
-(void)textFiledDialog:(TextFiledDialog*)dialog didButtonClick:(TextFiledDialogButtonType)type;

@end
@interface TextFiledDialog : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (nonatomic,weak)id<TextFiledDialogDelegate> delegate;
@property(nonatomic,strong)OpenLinkObject *linkObject;
@end
