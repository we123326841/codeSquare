//
//  KeyBoardAccess.h
//  Caipiao
//
//  Created by 王浩 on 15/11/19.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KeyBoardAccess;
@protocol  KeyBoardAccessDelegate<NSObject>
-(void)keyBoardAccess:(KeyBoardAccess*)access DidSubBtnClick:(UIButton*)subClick;

-(void)keyBoardAccess:(KeyBoardAccess*)access DidAddBtnClick:(UIButton*)addClick;
@end

@interface KeyBoardAccess : UIView
@property(nonatomic,weak)id<KeyBoardAccessDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *beiTouLimit;
@property (weak, nonatomic) IBOutlet UILabel *methodName;
+(instancetype)keyBoard;
@end
