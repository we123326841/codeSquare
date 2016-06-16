//
//  RQZhuiHaoDetail.m
//  Caipiao
//
//  Created by Cyrus on 13-6-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "RQZhuiHaoDetail.h"
#import "RQGameHistory.h"

@implementation RQZhuiHaoDetail
@synthesize rqId = _rqId;

- (void)dealloc{
    self.taskNo=nil;
    self.issueList=nil;
    self.beginissue=nil;
    self.begintime=nil;
    self.lotteryId=nil;
    self.projectList=nil;
    self.tasks=nil;
    [super dealloc];
}

- (void)prepare
{
    self.url = kUrlZhuihaoDetail;
//    if (_isLowGame) {
//        [self setPostValue:@"1" forField:@"chan_id"];
//    }else {
//        [self setPostValue:@"4" forField:@"chan_id"];
//    }
    [self setPostValue:_rqId forField:@"id"];
    [super prepare];
}

- (void)parse:(id)result{
    Echo(@"result:%@",result);
    
//    if ([result isKindOfClass:[NSArray class]]) {
//        
//        self.issueList = [NSMutableArray array];
//        for (NSDictionary *one in result){
//            ZhuiHaoDetailModel *item = [ZhuiHaoDetailModel parseFromDict:one];
//            [self.issueList addObject:item];
//        }
//        
//    }
    if ([result isKindOfClass:[NSDictionary class]]) {
        
        self.issueList = [NSMutableArray array];
        self.taskNo = [result stringForKey:@"taskNo"];

        self.beginissue = [result stringForKey:@"beginissue"];
        self.begintime = [result stringForKey:@"begintime"];
        self.issuecount = [[result objectForKey:@"issuecount"]integerValue];
        self.finishedcount = [[result objectForKey:@"finishedcount"]integerValue];
        self.finishedmoney = [[result objectForKey:@"finishedmoney"] floatValue];
        self.totalmoney = [[result objectForKey:@"totalmoney"]floatValue];
        self.traceStop = [[result objectForKey:@"traceStop"]integerValue];
        self.bonus = [[result objectForKey:@"bonus"]floatValue];
        self.lotteryId = [result stringForKey:@"lotteryId"];
        self.projectList = [NSMutableArray array];
        for (NSDictionary *one in [result objectForKey:@"projectList"]){
            RecordInfo *item = [RecordInfo parseFromDict:one];
            [self.projectList addObject:item];
        }
        self.tasks = [NSMutableArray array];
        for (NSDictionary *one in [result objectForKey:@"tasks"]){
            ZhuiHaoIssueModel *item = [ZhuiHaoIssueModel parseFromDict:one];
            [self.tasks addObject:item];
        }

    }

}

@end

@implementation ZhuiHaoDetailModel
-(void)dealloc
{
    self.taskDetailId=nil;
    self.issue=nil;
    self.multiple=nil;
    self.status=nil;
    self.canCancel=nil;
    self.taskDetailNo=nil;
    [super dealloc];
}
+ (id)parseFromDict:(NSDictionary *)d{
    ZhuiHaoDetailModel *item = [[ZhuiHaoDetailModel alloc] init];
    item.taskDetailId = [d stringForKey:@"taskdetailid"];
    item.issue = [d stringForKey:@"issue"];
    item.multiple = [d numberiForKey:@"multiple"];
    item.status = [d numberiForKey:@"status"];
    item.canCancel = [d numberiForKey:@"cancancel"];
    item.isSelected = NO;
    
    return [item autorelease];
}

@end


@implementation ZhuiHaoIssueModel
-(void)dealloc
{
    self.taskdetailid=nil;
    self.taskDetailNo=nil;
    self.issue=nil;
    self.issueCode=nil;
    self.opencode=nil;
    self.list=nil;
    [super dealloc];
}
+ (id)parseFromDict:(NSDictionary *)d{
    ZhuiHaoIssueModel *item = [[ZhuiHaoIssueModel alloc] init];
    item.taskdetailid = [d stringForKey:@"taskdetailid"];
    item.taskDetailNo = [d stringForKey:@"taskDetailNo"];
    item.issue = [d stringForKey:@"issue"];
    item.issueCode = [d stringForKey:@"issueCode"];
    item.multiple = [[d objectForKey:@"multiple"]integerValue];
    item.money = [d floatForKey:@"money"];
    item.opencode = [d stringForKey:@"opencode"];

    item.status = [[d objectForKey:@"status"]integerValue];
    item.cancancel = [[d objectForKey:@"cancancel"]integerValue];
    item.bonus = [d floatForKey:@"bonus"];
    item.list = [d objectForKey:@"list"];
    return [item autorelease];
}

@end
