//
//  RQNotice.m
//  Caipiao
//
//  Created by danal on 13-3-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQNotice.h"

@implementation RQNotice
@synthesize noticeItems;

- (void)dealloc{
    RELEASE(noticeItems);
    [super dealloc];
}

- (id)initWithType:(NoticeType)noticeType {
    self = [self init];
    if (self) {
        self.url = kUrlNotice;
        switch (noticeType) {
            case kNoticeTypeBank:
//                [self setPostValue:@0 forField:@"chan_id"];
                break;
            case kNoticeTypeHigh:
//                [self setPostValue:@4 forField:@"chan_id"];
                break;
            case kNoticeTypeLow:
//                [self setPostValue:@1 forField:@"chan_id"];
                break;
            case kNoticeTypeSite:
                self.url = kUrlNoticeSite;
                break;
            default:
                break;
        }
        self.type = noticeType;
    }
    return self;
}

- (void)parse:(id)json{

    self.noticeItems = [NSMutableArray array];
    NSArray *list = json;
    for (NSDictionary *one in list){
        NoticeItem *item = [[NoticeItem alloc] init];
        item.nid = [one intForKey:@"id"];
        if (item.nid < 1){
            item.nid = [one intForKey:@"entry"];
        }
        item.subject = [one stringForKey:@"subject"];
        item.time = [one stringForKey:@"sendtime"];
        item.isShow = [one boolForKey:@"ishow"];
        item.isRead = [one boolForKey:@"isRead"];
        item.isKeep = [one boolForKey:@"iskeep"];
        item.content = [one stringForKey:@"content"];
        item.noticeType =[one stringForKey:@"title"];
        [self.noticeItems addObject:item];
        [item release];
    }
}

@end



@implementation RQNoticeDelete

- (void)dealloc{
    [_noticeIds release];
    [super dealloc];
}

- (BOOL)shouldDirectlyParse{
    return YES;
}

- (void)prepare{
    self.url = kUrlNoticeDelete;
    if (_noticeIds){
        NSMutableString *ids = [NSMutableString string];
        for (NSNumber *itemId in _noticeIds){
            [ids appendFormat:@"%@,",itemId];
        }
        if ([ids length] > 0){
            [ids deleteCharactersInRange:NSMakeRange(ids.length - 1, 1)];
        }
        [self setPostValue:ids forField:@"mid"];
    } else {
        [self setPostValue:MSIntToStr(self.noticeId) forField:@"mid"];
    }
    [super prepare];
}

- (void)parse:(NSDictionary *)result{
    if ([result isKindOfClass:[NSDictionary class]]){
        self.msgType = [result intForKey:@"messagetype"];
        NSString *error = [result stringForKey:@"error"];
        if (![error isEqualToString:@"success"]){
            self.msgContent = error;
        }
    }
}

@end


@implementation NoticeItem
@synthesize nid,subject,time,isShow;

- (void)dealloc{
    RELEASE(subject);
    RELEASE(time);
    RELEASE(_noticeType);
    [super dealloc];
}

@end


@implementation RQNoticeContent
@synthesize nid,subject, content,time;


- (void)dealloc{
    self.subject = nil;
    self.content = nil;
    self.time = nil;
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        self.url = kUrlNoticeContent;
    }
    return self;
}

- (id)initWithType:(NoticeType)noticeContentType {
    self = [self init];
    if (self) {
        switch (noticeContentType) {
            case kNoticeTypeBank:
//                [self setPostValue:@0 forField:@"chan_id"];
                break;
            case kNoticeTypeHigh:
//                [self setPostValue:@4 forField:@"chan_id"];
                break;
            case kNoticeTypeLow:
//                [self setPostValue:@1 forField:@"chan_id"];
                break;
            case kNoticeTypeSite:
                self.url = kUrlNoticeContentSite;
                break;
            default:
                break;
        }
        self.type = noticeContentType;
    }
    return self;
}

- (void)setNid:(NSInteger)nid_{
    nid = nid_;
    if (self.type == kNoticeTypeSite){
        [self setPostValue:MSIntToStr(nid) forField:@"mid"];
    } else {
        [self setPostValue:MSIntToStr(nid) forField:@"nid"];
    }
}

- (void)parse:(NSDictionary *)json{
    self.subject = [json stringForKey:@"subject"];
    self.content = [json stringForKey:@"content"];
    self.nid = [json intForKey:@"id"];
    self.time = [json stringForKey:@"sendtime"];
    self.unread = [json intForKey:@"unread"];
}

@end
