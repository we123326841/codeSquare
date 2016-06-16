//
//  SecuritySettingResultVC.h
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    ResultTypeNO,
    ResultTypeCashSuccess,
    ResultTypeSettingSuccess,
    ResultTypeCardBingSuccess
}ResultType;

typedef void (^ClickedBlock)(NSUInteger index);

@interface SecuritySettingResultVC : BaseViewController
@property (retain, nonatomic) IBOutlet UIImageView *resultV;
@property (retain, nonatomic) IBOutlet UIButton *topBtn;
@property (retain, nonatomic) IBOutlet UIButton *bottomBtn;
@property (assign, nonatomic) ResultType type;
@property (copy, nonatomic) ClickedBlock clicked;
- (IBAction)btnClicked:(id)sender;

@end
