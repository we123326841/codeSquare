//
//  BetLowViewController.h
//  Caipiao
//
//  Created by danal-rich on 7/23/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"

@class BetScrollView, MethodView, HistoryView;

@interface BetLowViewController : BaseViewController <UITextFieldDelegate>
{
    IBOutlet UIView         *_wrapView;
    IBOutlet MethodView     *_methodView;
    IBOutlet HistoryView    *_historyView;
    IBOutlet UIView         *_timerView;
    IBOutlet UILabel        *_timerLabel;
    IBOutlet BetScrollView   *_betView;
    IBOutlet UIView         *_multipleView;
    IBOutlet UIView         *_footerView;
    IBOutlet UIImageView    *_footerBG;
    IBOutlet UITextField    *_multipleField;
    IBOutlet UITextField    *_issueField;
    IBOutlet UILabel        *_countLabel;
    IBOutlet UILabel        *_balanceLabel;
    
    IBOutlet UIButton       *_randomButton;
    IBOutlet UILabel        *_touLbl;
    IBOutlet UILabel        *_beiLbl;
    IBOutlet UILabel        *_zhuiLbl;
    IBOutlet UILabel *_currentIssuleL;
    IBOutlet UILabel        *_qiLbl;
}
@property (assign, nonatomic) NSInteger lotteryId, channelId, methodId;

- (IBAction)confirm:(id)sender;
- (IBAction)randomBetting:(id)sender;
- (IBAction)switchMethodPanel:(id)sender;

@end
