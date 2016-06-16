//
//  ResultViewController.h
//  Caipiao
//
//  Created by danal-rich on 8/11/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface ResultViewController : BaseViewController
{
    IBOutlet UILabel *_titleLbl;
    IBOutlet UILabel *_detailLbl;
    IBOutlet UILabel *_lotnameLbl;
    IBOutlet UILabel *_leli1Lbl;
    IBOutlet UILabel *_leli2Lbl;
    IBOutletCollection(UILabel) NSArray *_lbl6s;
    IBOutletCollection(UILabel) NSArray *_lbl9s;
    IBOutlet UIScrollView *_scroll;
}
@property (copy, nonatomic) void(^onViewDidLoad)(ResultViewController *c);
@property (assign, nonatomic) IBOutlet UILabel *detailLbl;
@property (assign, nonatomic) IBOutlet UILabel *lotteryNameLbl;
@property (assign, nonatomic) IBOutlet UILabel *issueLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;

@property (assign, nonatomic) NSInteger channelId;

- (IBAction)gotoHistory:(id)sender;
- (IBAction)gotoBetting:(id)sender;

@end

#import "MethodMenuItem.h"
#import "BetManager.h"
#import "BetHighViewController.h"
#import "HallViewController.h"
