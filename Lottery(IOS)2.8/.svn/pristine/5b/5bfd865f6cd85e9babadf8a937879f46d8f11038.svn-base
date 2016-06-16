//
//  MQueueRequest.h
//  Fun
//
//  Created by luo danal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNotificationTaskCompleted @"kNotificationTaskCompleted"

@interface MTask : NSObject
@property (assign, nonatomic) NSInteger tid;
@property (copy, nonatomic) NSString *url;
@property (assign, nonatomic) id target;

+ (id)taskWithTid:(NSInteger)tid url:(NSString *)url target:(id)target;

@end

#pragma mark -

@interface MTaskQueue : NSObject {
    void (^_taskBlock)(MTask *task);
    void (^_taskPauseBlock)(MTask *task);
    NSInteger _runningTaskCount;
    NSInteger _taskCount;
    NSInteger _taskIndex;
    BOOL _running;
    BOOL _paused;
}
@property (assign, nonatomic) NSInteger tag;
@property (assign, nonatomic) NSInteger maxConcurrent;
@property (retain, nonatomic) NSMutableArray *tasks;
@property (retain, nonatomic) NSMutableDictionary *queues;
@property (nonatomic, readonly) BOOL running;
@property (nonatomic, readonly) BOOL paused;

+ (id)sharedQueue;

+ (id)queueWithTag:(NSInteger)tag;

- (void)addTaskWithTid:(NSInteger)tid url:(NSString *)url target:(id)target;

- (void)addTask:(MTask *)task;

- (void)setTaskBlock:(void (^)(MTask *task))blcok;

- (void)setTaskPauseBlock:(void (^)(MTask *task))block;

- (void)run;

- (void)pause;

- (void)resume;

- (void)abort;

- (void)reset;

@end
