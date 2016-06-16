//
//  UserHeadView.m
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "UserHeaderView.h"
#import "WithdrawCashVC.h"

@implementation UserHeaderView
@synthesize accountLbl = _accountLbl;
@synthesize balanceLbl = _balanceLbl;

- (void)dealloc{
    MSNotificationCenterRemoveObserver();
    [_accountLbl release];
    [_balanceLbl release];
    [_indicator release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
//        _bgView.image = [UIImage imageNamed:@"gray_tile.png"];
        [self addSubview:_bgView];
        
        float mar = 10.f;
        CGRect rect = CGRectInset(CGRectMake(0, 0, frame.size.width, 70), mar, mar);
        rect.origin = CGPointMake(mar, mar);
        rect.size.height /= 2;
        _accountLbl = [[UILabel alloc] initWithFrame:rect];
        _accountLbl.backgroundColor = self.backgroundColor;
        _accountLbl.font = [UIFont boldSystemFontOfSize:18.f];
        _accountLbl.textColor = [UIColor whiteColor];
        if ([SharedModel shared].username) {
            _accountLbl.text = [NSString stringWithFormat:@"%@(%@)",
                                [SharedModel shared].username, [SharedModel shared].nickname];
        } else {
            _accountLbl.text = @"未登录";
        }
        [self addSubview:_accountLbl];

        rect.origin = CGPointMake(mar, mar + rect.size.height);
        _balanceLbl = [[UILabel alloc] initWithFrame:rect];
        _balanceLbl.backgroundColor = self.backgroundColor;
        _balanceLbl.font = [UIFont boldSystemFontOfSize:13.f];
        _balanceLbl.textColor = [UIColor whiteColor];
        _balanceLbl.text = [NSString stringWithFormat:@"高频余额：%@元",[SharedModel formattedBalance]];
        [self addSubview:_balanceLbl];
        MSNotificationCenterAddObserver(@selector(userInfoUpdated:), kNotificationUserInfoUpdated);

        CGRect refreshRect=CGRectMake(230.f, 18.f, 24.f, 24.f);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = refreshRect;
        [button addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
        [self addSubview:button];
        _refreshButton = button;
        
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicator.frame = refreshRect;
        [self addSubview:_indicator];
        
        float septOri=210;
        UIImageView *sept=[[UIImageView alloc] initWithFrame:CGRectMake(septOri, 0, 1, 70)];
        sept.image=[UIImage imageNamed:@"headview_spt.png"];
        [self addSubview:sept];
        [sept release];
        
        //下拉箭头
        self.userAmountButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.userAmountButton.frame=CGRectMake(0, 0, septOri, 70);
        self.userAmountButton.contentEdgeInsets=UIEdgeInsetsMake(0, 160, 5, 0);
        [self.userAmountButton addTarget:self action:@selector(openAmountListAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.userAmountButton setImage:[UIImage imageNamed:@"arrow_down_yellow.png"] forState:UIControlStateNormal];
        [self addSubview:self.userAmountButton];
        
        self.rechargeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.rechargeButton.frame=CGRectMake(0, self.bounds.size.height-45, 140, 45);
        self.rechargeButton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        [self.rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
        [self.rechargeButton setTitleColor:kYellowTextColor forState:UIControlStateNormal];
        [self.rechargeButton setBackgroundImage:[UIImage imageNamed:@"button_leftmenu_gray.png"] forState:UIControlStateNormal];
        [self.rechargeButton addTarget:self action:@selector(rechargeCash:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rechargeButton];
        
        self.cashButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.cashButton.frame=CGRectMake(140, self.bounds.size.height-45, 140, 45);
        self.cashButton.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        [self.cashButton setTitle:@"提现" forState:UIControlStateNormal];
        [self.cashButton setTitleColor:kYellowTextColor forState:UIControlStateNormal];
        [self.cashButton setBackgroundImage:[UIImage imageNamed:@"button_leftmenu_gray.png"] forState:UIControlStateNormal];
        [self.cashButton addTarget:self action:@selector(withdrawCash:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cashButton];
        
        UIImageView *btnSept=[[UIImageView alloc] initWithFrame:CGRectMake(140, self.bounds.size.height-45, 1, 45)];
        btnSept.image=[UIImage imageNamed:@"headview_spt.png"];
        [self addSubview:btnSept];
        [btnSept release];
        
        UIImageView *bottomSept=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
        bottomSept.image=[UIImage imageNamed:@"home_list_item_line.png"];
        [self addSubview:bottomSept];
        [bottomSept release];
    }
    return self;
}

- (void)rechargeCash:(id)sender
{
    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
    [dele.menuController swithToMenuIndex:kMenuIndexChongzhi];
}

- (void)withdrawCash:(id)sender
{
    AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
    [dele.menuController swithToMenuIndex:kMenuIndexTixian];
}

- (void)setOpenUserAmountListViewBlock:(void(^)())openBlock closeUserAmountListViewBlock:(void(^)())closeBlock
{
    self.openUserAmountListViewBlock=openBlock;
    self.closeUserAmountListViewBlock=closeBlock;
}

- (void)openAmountListAction:(UIButton *)sender
{
    self.opened=!self.opened;
    if (self.opened) {
        [sender setImage:[UIImage imageNamed:@"arrow_up_yellow.png"] forState:UIControlStateNormal];
        self.openUserAmountListViewBlock();
    }else {
        [sender setImage:[UIImage imageNamed:@"arrow_down_yellow.png"] forState:UIControlStateNormal];
        self.closeUserAmountListViewBlock();
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    for (UIView *v in self.subviews){
        v.backgroundColor = backgroundColor;
    }
}

- (void)userInfoUpdated:(id)sender
{
    [_indicator  stopAnimating];
    if ([SharedModel userIsSignedin]) {
        _accountLbl.text = [NSString stringWithFormat:@"%@(%@)",
                            [SharedModel shared].username, [SharedModel shared].nickname];
        _balanceLbl.text = [NSString stringWithFormat:@"高频余额：%@元",[SharedModel formattedBalance]];
    }else {
        _accountLbl.text = @"未登录";
    }
    
}

- (void)updateAction:(id)sender{
    if ([SharedModel userIsSignedin]) {
//        FLEvent(kFLEventRefreshBalacne);
        
        _refreshButton.hidden = YES;
        [_indicator startAnimating];
        
        RQGetBalance *rq = [[RQGetBalance alloc] init];
        [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            [self userInfoUpdated:nil];
            _refreshButton.hidden = NO;
            MSNotificationCenterPost(kNotificationUserPointUpdated);
            [rq_ release];
        } sender:nil];
        /*
        RQBalance *rq = [[RQBalance alloc] init];
        [rq startPostWithBlock:^(RQBase *rq_, NSError *error_, id rqSender_) {
            [self userInfoUpdated:nil];
            _refreshButton.hidden = NO;
            [rq_ release];
        } sender:nil];
         */
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIImage *line = [UIImage imageNamed:@"home_list_item_line.png"];
    [line drawInRect:CGRectMake(0, rect.size.height - line.size.height, rect.size.width, line.size.height)];
}

//#pragma mark - Touches
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
////    [self updateAction:nil];
//}

+ (float)height{
    return 70.f+45.f;
}

@end
