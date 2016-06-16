//
//  RQLink.h
//  Caipiao
//  链结管理
//  Created by danal-rich on 4/1/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "RQBase.h"

/**
 * 列表
 */
@interface RQLinkList : RQBase
@property (strong, nonatomic) NSMutableArray *linkList;
@end

/**
 * 详情
 */
@interface RQLinkDetail : RQBase
@property (assign, nonatomic) NSInteger linkId;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (copy, nonatomic) NSString *startTime;    //链结有效开始时间
@property (copy, nonatomic) NSString *endTime;      //链结有效结束时间
@end


@interface LinkItem : NSObject
@property (assign, nonatomic) NSInteger linkId;
@property (assign, nonatomic) NSInteger type;       //类型
@property (copy, nonatomic) NSString *urlString;    //转发的url
@property (copy, nonatomic) NSString *remark;       //备注

@property (copy, nonatomic) NSString *startTime;    //链结有效开始时间
@property (copy, nonatomic) NSString *endTime;      //链结有效结束时间
@property (assign, nonatomic) NSInteger validDay;       //有效天数

@end

/*
 channelid = 4;
 cnname = "\U91cd\U5e86\U65f6\U65f6\U5f69";
 entry = 10144;
 "indefinite_point" = "4.000";
 isclosed = 0;
 limitbonus = "0.0000";
 linkid = 554;
 lotteryid = 1;
 prizegroupid = 8;
 prizegroupname = "CQSSC1800-6.6";
 userid = 167114;
 userpoint = "4.000";
 */

@interface LinkDetailItem : NSObject
@property (assign, nonatomic) NSInteger channelId;
@property (assign, nonatomic) NSInteger lotteryId;
@property (assign, nonatomic) NSInteger itemId;
@property (copy, nonatomic) NSString *userPoint;        //用户返点
@property (copy, nonatomic) NSString *indefinitePoint;  //不定位返点
@property (copy, nonatomic) NSString *cnname;
@property (nonatomic) BOOL hasSecondPoint;          //是否有其它返点栏
@end

@interface LinkDetailHeaderItem : NSObject
@property (copy, nonatomic) NSString *lotteryType;
@property (copy, nonatomic) NSString *point1;
@property (copy, nonatomic) NSString *point2;
@property (nonatomic) BOOL hasSecondPoint;          //是否有其它返点栏
@end