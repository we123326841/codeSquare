//
//  ZhuiHaoInfoVC.h
//  Caipiao
//
//  Created by Cyrus on 13-6-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "RQZhuiHaoInfo.h"

@interface ZhuiHaoInfoVC : BaseViewController{
    
}

@property (assign, nonatomic) BOOL isLowGame;
@property (strong, nonatomic) ZhuiHaoInfoItem *model;
@property (assign, nonatomic) IBOutlet UILabel *lotteryNameLbl;//彩票名
@property (assign, nonatomic) IBOutlet UILabel *stopAfterWinL;// 中奖后停止
@property (assign, nonatomic) IBOutlet UILabel *finishIssueLbl;//已追几期
@property (assign, nonatomic) IBOutlet UILabel *numberLbl;//方案编号
@property (assign, nonatomic) IBOutlet UILabel *dateLbl;//购买时间
@property (assign, nonatomic) IBOutlet UILabel *amountStatusLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;//中奖金额
@property (assign, nonatomic) IBOutlet UILabel *statusLbl;//状态
@property (assign, nonatomic) IBOutlet UIView *topView;
//@property (assign, nonatomic) IBOutlet UIButton *detailButton;
@property (assign, nonatomic) IBOutlet UIImageView *lotteryIcon;
//@property (assign, nonatomic) IBOutlet UILabel *amountTagLbl;
//@property (assign, nonatomic) IBOutlet UILabel *finishIssueTagLbl;
//@property (assign, nonatomic) IBOutlet UILabel *betStatusTagLbl;
//@property (assign, nonatomic) IBOutlet UILabel *betTimeTagLbl;
//@property (assign, nonatomic) IBOutlet UILabel *numberTagLbl;
@property (assign, nonatomic) IBOutlet UITableView *tableview;
@end
