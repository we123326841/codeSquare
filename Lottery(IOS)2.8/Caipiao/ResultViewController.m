//
//  ResultViewController.m
//  Caipiao
//
//  Created by danal-rich on 8/11/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property (assign, nonatomic) IBOutlet UIImageView *lotIcon;
//@property (assign, nonatomic) IBOutlet UILabel *lotLbl;
//@property (assign, nonatomic) IBOutlet UILabel *lotDetailLbl;
@property (assign, nonatomic) u_int32_t randomNmber;
@end

@implementation ResultViewController

- (void)dealloc{
    self.onViewDidLoad = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"投注结果";
    _scroll.contentSize = CGSizeMake(self.view.bounds.size.width, 548.f);
    _titleLbl.textColor = Color(@"ResultTextColor");
    _detailLbl.textColor = Color(@"ResultDetailColor");
    for (UILabel *l in _lbl6s){
        l.textColor = Color(@"ResultTitleColor");
    }
    for (UILabel *l in _lbl9s){
        l.textColor = Color(@"ResultDetailColor");
    }
    
    _randomNmber = arc4random()%4+1;
    CDLottery *lot = [self randomLottery];
    _leli1Lbl.textColor = Color(@"ResultLeliColor");
    _leli2Lbl.textColor = Color(@"ResultLeliDetailColor");
    
    _lotIcon.image = ResImage(lot.logo);
    _leli1Lbl.text = lot.name;
    NSDictionary *introduction = [NSDictionary dictionaryWithContentsOfFile:
                         [[NSBundle mainBundle] pathForResource:@"Introduction.plist" ofType:nil]
                         ];
    _leli2Lbl.text = [introduction objectForKey:lot.name];
 
    
    if (_onViewDidLoad){
        _onViewDidLoad(self);
        self.onViewDidLoad = nil;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction:(id)sender{
    [(MSTabBarController*)[AppDelegate shared].tab setTabSelectedIndex:1];
    [[AppDelegate shared].nav popToRootViewControllerAnimated:YES];
}

- (IBAction)gotoHistory:(id)sender{
    [[AppDelegate shared].nav popToRootViewControllerAnimated:NO];
    MSTabBarController *tab = (id)[AppDelegate shared].tab;
    [tab setTabSelectedIndex:3];
}

- (IBAction)gotoBetting:(id)sender{
    if (_channelId == kChannelLow){
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        NSMutableArray *controllers = [[self.navigationController viewControllers] mutableCopy];
        [controllers removeLastObject];
        [controllers removeLastObject];
        [self.navigationController setViewControllers:controllers animated:YES];
        [controllers release];
    }
}

- (IBAction)random1:(id)sender{
    //目前固定为乐利11选5
    CDLottery *lot = [self randomLottery];
    [HallViewController generate1RandomIn:self.navigationController lottery:lot];
    
}

-(CDLottery*)randomLottery
{
    NSString *lotteryName = nil;
    switch (_randomNmber) {
        case 1:
            lotteryName = LL11X5;
            break;
        case 2:
            lotteryName = JLFFC;
            break;
        case  3:
            lotteryName = LLSSC;
            break;
        case 4:
            lotteryName = SHMMC;
        default:
            break;
    }
    CDLottery *lot = [CDLottery findLotteryByName:lotteryName];
    return lot;
}

@end
