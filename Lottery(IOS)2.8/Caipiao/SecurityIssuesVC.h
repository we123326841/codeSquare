//
//  SecurityIssuesVC.h
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "SecuritySettingResultVC.h"

typedef NS_ENUM(NSUInteger, ComeType) {
    ComeTypeSetting,
    ComeTypeCash,
    ComeTypeEdit,
    ComeTypeVerify,
    ComeTypeCardBing
};

@interface SecurityIssuesVC : BaseViewController
@property (retain, nonatomic) IBOutlet UIImageView *bg;
@property (retain, nonatomic) IBOutlet UIScrollView *scroll;
@property (retain, nonatomic) IBOutlet UITextField *fieldOne;
@property (retain, nonatomic) IBOutlet UITextField *fieldTwo;
@property (retain, nonatomic) IBOutlet UITextField *fieldThird;
@property (assign, nonatomic) ComeType type;
@property (retain, nonatomic) IBOutlet UILabel *quest3L;
@property (retain, nonatomic) IBOutlet UILabel *answer3L;
@property (retain, nonatomic) IBOutlet UIButton *btn3L;
@property (retain, nonatomic)  UILabel *answerAlertLbl;

- (IBAction)selectIsussesAction:(id)sender;

@end
