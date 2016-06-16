//
//  AlertHUD.h
//  Caipiao
//
//  Created by danal on 13-3-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View+Factory.h"
#import "RCLabel.h"


@interface AlertHUD : UIAlertView
{
    NSTimer *_timer;
}

+ (void)showMessage:(NSString *)message;

@end

@interface AlertView : WhiteAlertView
@property (assign, nonatomic) UIButton *okButton;
@property (copy, nonatomic) void(^completeBlock)(AlertView *alertView, bool okay);

- (id)initWithTitle:(NSString *)title msg:(NSString *)msg okButton:(NSString *)okTitle cancelButton:(NSString *)cancelTitle;
@end


@interface WhiteAlert : UIView {
    UIView *_mask;
}
@property (assign, nonatomic) IBOutlet UIImageView *background;
@property (assign, nonatomic) IBOutlet UILabel *titleLbl;
@property (assign, nonatomic) IBOutlet UILabel *msgLbl;
@property (assign, nonatomic) IBOutlet UILabel *detailLbl;
@property (assign, nonatomic) IBOutlet UILabel *detailLbl1;
@property (assign, nonatomic) IBOutlet UIButton *button;
@property (assign, nonatomic) IBOutlet UIButton *button1;
@property (copy, nonatomic) void(^completeBlock)(WhiteAlert *a, NSInteger buttonIndex);

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)msg detail:(NSString *)detail buttons:(NSString *)button0Title,...;
- (void)show;
- (void)dismiss;
@end

@interface BettingAlert : WhiteAlert 
{
    IBOutlet UIButton   *_feeButton;
    IBOutlet UIButton   *_infoButton;
    IBOutlet UIView     *_limitView;
    IBOutlet UILabel    *_limitLbl;
}

/* 注单确认, 没有的参数传入nil */
+ (instancetype)alertWithTitle:(NSString *)title
                       lottery:(NSString *)lottname     //彩种
                        amount:(CGFloat)amount          //投注金额
                   minusAmount:(CGFloat)minusAmount     //减少金额
                         issue:(NSString *)issue        //期号
                       toIssue:(NSString *)toIssue      //至x期
                    issueCount:(NSInteger)issueCount    //期数
                        detail:(NSString *)detail       //详情
                         limit:(NSString *)limit       //限制
                           fee:(CGFloat)fee            //手续费
                            buttons:(NSString *)button0Title,...;

@end


@interface OverMultipleAlert : WhiteAlert
+ (instancetype)alertWithTitle:(NSString *)title
                           msg:(NSString *)msg
                       details:(NSArray *)details
                        button:(NSString *)buttonTitle;
@end


@interface HighChaseNumAlert : WhiteAlert

@end

@interface IssueChangeAlert :WhiteAlert
@end

