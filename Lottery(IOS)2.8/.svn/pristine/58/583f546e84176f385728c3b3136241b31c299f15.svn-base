//
//  DeleteLinkDialog.h
//  Caipiao
//
//  Created by 王浩 on 15/10/19.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DeleteLinkDialog;
typedef enum{
    DeleteLinkDialogButtonTypeSure,
    DeleteLinkDialogButtonTypeCancel
}DeleteLinkDialogButtonType ;
@protocol DeleteLinkDialogDelegate<NSObject>

-(void)deleteLink:(DeleteLinkDialog*)dialog didBtnClick:(DeleteLinkDialogButtonType)type;
@end
@interface DeleteLinkDialog : UIView
@property(nonatomic,assign)id<DeleteLinkDialogDelegate> delegate;
@end
