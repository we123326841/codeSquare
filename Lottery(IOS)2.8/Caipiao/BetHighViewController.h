//
//  BetHighViewController.h
//  Caipiao
//
//  Created by danal-rich on 7/23/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"

@class BetScrollView, MethodView, HistoryView;

@interface BetHighViewController : BaseViewController <UITextFieldDelegate>
{
    IBOutlet UIView         *_wrapView;
    IBOutlet HistoryView    *_historyView;
    IBOutlet MethodView     *_methodView;
    IBOutlet UIView         *_timerView;
    IBOutlet UILabel        *_timerLabel;
    IBOutlet BetScrollView   *_betView;
    IBOutlet UIView         *_multipleView;
    IBOutlet UIView         *_footerView;
    IBOutlet UIImageView    *_footerBG;
    IBOutlet UITextField    *_multipleField;
    IBOutlet UILabel        *_countLabel;
    IBOutlet UILabel        *_balanceLabel; //Deprecated
    IBOutlet UILabel        *_tipsLabel;
    
    IBOutlet BadgeIconButton    *_basketButton;
    IBOutlet UIButton       *_addButton;
    IBOutlet UIButton       *_randomButton;
    IBOutlet UILabel        *_touLbl;
    IBOutlet UILabel        *_beiLbl;
    
    IBOutlet UILabel *_currentIssuleL;
    
}
@property (assign, nonatomic) NSInteger lotteryId, channelId, methodId;

- (IBAction)addToBasket:(id)sender;
- (IBAction)gotoBasket:(id)sender;
- (IBAction)randomBetting:(id)sender;
- (IBAction)switchMethodPanel:(id)sender;

@end

#import "BasketViewController.h"
#import "CDBetList.h"
#import "HistoryView.h"
#import "RQPublicHistory.h"