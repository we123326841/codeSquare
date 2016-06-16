//
//  UserHeadView.h
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHeaderView : UIView {
    UIImageView *_bgView;
    UIActivityIndicatorView *_indicator;
    UIButton *_refreshButton;
}

@property (strong, nonatomic) UILabel *accountLbl;
@property (strong, nonatomic) UILabel *balanceLbl;
@property (strong, nonatomic) UIButton *rechargeButton;
@property (strong, nonatomic) UIButton *cashButton;
@property (strong, nonatomic) UIButton *userAmountButton;
@property (assign, nonatomic) BOOL opened;
@property (copy, nonatomic) void(^openUserAmountListViewBlock)();
@property (copy, nonatomic) void(^closeUserAmountListViewBlock)();

+ (float)height;
- (void)setOpenUserAmountListViewBlock:(void(^)())openBlock closeUserAmountListViewBlock:(void(^)())closeBlock;

@end