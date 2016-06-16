//
//  GameHistoryDetailVC.h
//  Caipiao
//
//  Created by CYRUS on 14-8-1.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "GameRecord.h"
#import "RQZhuiHaoDetail.h"
@interface GameHistoryDetailVC : BaseViewController<RQBaseDelegate>

@property (copy, nonatomic) NSString *codes;
@property (copy, nonatomic) NSString *recordId;
@property (assign, nonatomic) NSInteger chan_id;
@property (strong, nonatomic) GameRecord *model;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) void (^updateListBlock) (GameRecord *model,NSInteger index);

@property (strong, nonatomic) RQZhuiHaoDetail *rqZhuiHaoDetail;
@property (strong, nonatomic) ZhuiHaoIssueModel *zhuiHaoIssueModel;
@property (strong, nonatomic) ZhuiHaoInfoItem *zhuiHaoInfoItem;


+ (NSString *)numFormatter:(NSString *)codes;

@end
