//
//  OABonusAlertView.h
//  Caipiao
//
//  Created by GroupRich on 15/8/2.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OABonusAlertView : UIView
@property (copy, nonatomic) void(^clickedBlock)(NSInteger buttonIndex,NSInteger awardid,NSInteger lotteryid ,NSInteger channelid);
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
+(void)addNotiView:(NSArray*)awardGroups withlotteryid:(NSInteger)lotteryid channelid:(NSInteger)channelid;
@property (nonatomic,assign)NSInteger awardid;
@property (nonatomic,assign)NSInteger lotteryid;
@property (nonatomic,assign)NSInteger  channelid;
@end
