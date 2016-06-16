//
//  BasketViewController.h
//  Caipiao
//
//  Created by danal-rich on 8/4/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface BasketViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView         *_footerView;
    IBOutlet UIView         *_issueView;
    IBOutlet UITextField    *_issueField;
    IBOutlet UILabel        *_countLabel;
    IBOutlet UILabel        *_balanceLabel;
    IBOutlet UITextField    *_multipleField;
    IBOutlet UILabel        *_touLbl;
    IBOutlet UILabel        *_beiLbl;
    
    NSInteger               _issueCount;        //追几期
    NSInteger               _restIssueCount;    //可追几期
    NSInteger               _totalCount;        //总注数
    CGFloat                 _totalAmount;       //总金额
    BOOL                    _isTrace;           //是否追号
    BOOL                    _editing;
    BOOL                    _canSubmit;
}
@property (nonatomic, assign) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (assign, nonatomic) NSInteger currentPlayType;
@property (assign, nonatomic) NSInteger limitTimes;       //限额倍数
@property (nonatomic) BOOL comeFromGame;
@property (nonatomic) BOOL comeFromZhuiHaoInfo;
@property (assign, nonatomic) NSInteger inputedMultiple;
@property (assign, nonatomic) NSInteger maxTraceCount;

@property (assign, nonatomic) NSInteger lotteryId, channelId;
@property (copy, nonatomic) NSString *currentMethodName;
@property (copy, nonatomic) void(^betSuccessBlock)(CGFloat betMoney);

- (void)reload;
- (IBAction)random1:(id)sender;
- (IBAction)random5:(id)sender;
- (IBAction)goonBetting:(id)sender;

+ (instancetype)currentInstace;

@end
