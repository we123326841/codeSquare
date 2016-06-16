//
//  RQSafe.m
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//
//Safe
//#define kUrlSafeQuestInit kDomain@"security/safeQuestInit"
//#define kUrlSafeQuestSet kDomain@"security/safeQuestSet"
//#define kUrlSafeQuestVerify kDomain@"security/safeQuestVerify"
//#define kUrlSafeQuestEdit kDomain@"security/safeQuestEdit"

#import "RQSafe.h"

@implementation RQSafeQuestInit

- (void)dealloc{
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlSafeQuestInit;
    [super prepare];
}

- (void)parse:(id)result{
    
    [_issues removeAllObjects];
    self.issues = [NSMutableArray array];
    
    if ([result isKindOfClass:[NSArray class]]) {
        NSArray *res = (NSArray*)result;
        for (NSDictionary *dic in res) {
            QuestEntity *q = [[QuestEntity alloc]init];
            q.qid = [dic intForKey:@"qid"];
            q.question = [dic stringForKey:@"question"];
            q.isUsed = [dic intForKey:@"isUsed"];
            [_issues addObject:q];
            [q release];
        }
    }
}


@end

@implementation QuestEntity


@end



@implementation RQSafeQuestSet

- (void)dealloc{
    [super dealloc];
}

- (void)prepare{
   
    self.url = kUrlSafeQuestSet;
    if ([self isKindOfClass:[RQSafeQuestVerify class]]) {
        self.url = kUrlSafeQuestVerify;
    }
    if ([self isKindOfClass:[RQSafeQuestEdit class]]) {
        self.url = kUrlSafeQuestEdit;
    }
    [self setValue:self.quests forField:@"quests"];
//    [self setValue:self.qid forField:@"qid"];//qpwd
//    [self setValue:self.qpwd forField:@"qpwd"];

    [super prepare];
}

- (void)parse:(id)result{
    
    self.status = [(NSDictionary*)result stringForKey:@"status"];
}


@end



@implementation RQSafeQuestVerify

- (void)dealloc{
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlSafeQuestVerify;
    [super prepare];

}

- (void)parse:(id)result{
    self.status = [(NSDictionary*)result stringForKey:@"status"];
}


@end



@implementation RQSafeQuestEdit

- (void)dealloc{
    [super dealloc];
}

- (void)prepare{
    self.url = kUrlSafeQuestEdit;
    [super prepare];

}

- (void)parse:(id)result{
    self.status = [(NSDictionary*)result stringForKey:@"status"];
}


@end