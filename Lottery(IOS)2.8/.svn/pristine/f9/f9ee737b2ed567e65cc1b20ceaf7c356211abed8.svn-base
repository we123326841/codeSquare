//
//  MyAccountViewController.h
//  Caipiao
//
//  Created by CYRUS on 14-7-23.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "DropDownMenu.h"
#import "MyAccountTableView.h"
#import "SlideSwitchView.h"
#import "PageControl.h"

@interface MyAccountViewController : BaseViewController<DropDownMenuDelegate,SlideSwitchViewDelegate,MyAccountTableViewDelegate>
{
    BOOL _isRefresh;
    BOOL _isLowGame;
}

@property (assign, nonatomic) IBOutlet UIView *wrapView;
@property (assign, nonatomic) IBOutlet UILabel *nameLbl;
@property (assign, nonatomic) IBOutlet UILabel *amountLbl;
@property (assign, nonatomic) IBOutlet UIButton *fundsButton;
@property (assign, nonatomic) IBOutlet DropDownMenu *historyMenu;
@property (assign, nonatomic) IBOutlet DropDownMenu *zhuiHaoMenu;
@property (assign, nonatomic) IBOutlet UIButton *historyButton;
@property (assign, nonatomic) IBOutlet UIButton *zhuiHaoButton;
//@property (assign, nonatomic) IBOutlet MyAccountTableView *tableView;

@property (assign, nonatomic) IBOutlet DropDownMenu *  recordMenu;
@property (assign, nonatomic) IBOutlet SlideSwitchView *slideView;
@property (strong, nonatomic) PageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *isvipView;
@end
