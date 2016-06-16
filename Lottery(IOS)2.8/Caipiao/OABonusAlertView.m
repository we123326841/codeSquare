//
//  OABonusAlertView.m
//  Caipiao
//
//  Created by GroupRich on 15/8/2.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "OABonusAlertView.h"
#import "RQAddBonusData.h"
#import "LoadingAlertView.h"
#import "AppDelegate.h"

@implementation OABonusAlertView

+(void)addNotiView:(NSArray*)awardGroups withlotteryid:(NSInteger)lotteryid channelid:(NSInteger)channelid
{
    UIImageView *bg = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bg.image = [UIImage imageNamed:@"Resources.bundle/blacktransparent.png"];
    bg.userInteractionEnabled=YES;

    OABonusAlertView *alertview = [OABonusAlertView loadFromNib];
    alertview.channelid = channelid;
    alertview.lotteryid = lotteryid;
    [alertview.btns enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL *stop) {
        if (idx<awardGroups.count) {
            NSString *awardstring = (NSString*)[awardGroups[idx] objectForKey:@"awardName"];
            obj.hidden = NO;
            [obj setTitle:[awardstring stringByReplacingOccurrencesOfString:@"奖金组" withString:@""] forState:UIControlStateNormal];
            [obj setTitle:[NSString stringWithFormat:@"%@",[awardGroups[idx] objectForKey:@"awardGroupId"]] forState:UIControlStateDisabled];
        }
    }];
    alertview.center = bg.center;
    [bg addSubview:alertview];
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 1.f)],
                  nil];
    kfa.duration = .1f;
    kfa.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [alertview.layer addAnimation:kfa forKey:nil];
    [[AppDelegate shared].window addSubview:bg];
    
    
    [alertview setClickedBlock:^(NSInteger index,NSInteger awardid , NSInteger lotteryid , NSInteger channelid)
    {
        [bg removeFromSuperview];
        
        if (index==0)
        {
            RQAddBonusData *rq = [[RQAddBonusData alloc]init];
            rq.chan_id = channelid;
            rq.lotteryId = lotteryid;
            rq.awardGroupId = awardid;
            [rq startPostWithBlock:^(RQAddBonusData* rq_, NSError *error_, id rqSender_) {
                if ([rq_.status isEqualToString:@"success"]) {
                    
                }else
                {
                 
                }
            } sender:nil];
        }else
        {
            [bg removeFromSuperview];
            [(MSTabBarController*)[AppDelegate shared].tab setTabSelectedIndex:1];
            [[AppDelegate shared].nav popToRootViewControllerAnimated:YES];        }
    }];
    
}


- (IBAction)selectBonus:(UIButton*)sender {
    
    [self.btns enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL *stop) {
        obj.selected = NO;
    }];
    sender.selected = YES;
    self.awardid = [sender titleForState:UIControlStateDisabled].integerValue;
}


- (IBAction)actionBtn:(UIButton*)sender {
    if (_clickedBlock) {
        _clickedBlock(sender.tag,_awardid,_lotteryid,_channelid);
    }
}

- (void)dealloc {
    [_btns release];
    [super dealloc];
}
@end
