//
//  BlockAlertView.h
//  
//
//  Created by danal on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSBlockAlertView : UIAlertView <UIAlertViewDelegate>
@property (assign, nonatomic) id userData;
@property (copy, nonatomic) void(^clickBlock)(MSBlockAlertView *a,NSInteger buttonIndex);
@end

@interface MSBlockActionSheet : UIActionSheet <UIActionSheetDelegate>
@property (assign, nonatomic) id userData;
@property (copy, nonatomic) void(^clickBlock)(MSBlockActionSheet *s,NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title
           delegate:(id<UIActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
otherButtonTitleList:(NSArray *)otherTitleList;

@end

@interface UIAlertView (Musou)
+ (void)alert:(NSString *)msg;
@end