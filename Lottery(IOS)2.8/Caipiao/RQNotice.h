//
//  RQNotice.h
//  Caipiao
//
//  Created by danal on 13-3-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQBase.h"

typedef enum {
    kNoticeTypeBank,
    kNoticeTypeHigh,
    kNoticeTypeLow,
    kNoticeTypeSite,    //站内信
} NoticeType;

@interface RQNotice : RQBase
PSTRONG NSMutableArray *noticeItems;
@property (nonatomic) NoticeType type;

- (id)initWithType:(NoticeType)noticeType;

@end


@interface RQNoticeDelete : RQBase
@property (assign, nonatomic) NSInteger noticeId;
@property (strong, nonatomic) NSArray *noticeIds;    //1,2,3...
@end




@interface NoticeItem : NSObject
PASSIGN NSInteger nid;
PCOPY NSString *subject;
PCOPY NSString *time;
PCOPY NSString *content;
PASSIGN BOOL isShow;
PASSIGN BOOL isKeep;
PASSIGN BOOL isRead;
PASSIGN BOOL checked;
PCOPY NSString *noticeType;
@end



@interface RQNoticeContent : RQBase
PASSIGN NSInteger nid;
PASSIGN NSInteger unread;
PCOPY NSString *subject;
PCOPY NSString *content;
PCOPY NSString *time;
@property (nonatomic) NoticeType type;

- (id)initWithType:(NoticeType)noticeType;

@end

